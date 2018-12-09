Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6478C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B220C20837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B220C20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeLIVzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:55:39 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35340 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbeLIVzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:23 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72n-0002ib-9y; Sun, 09 Dec 2018 21:55:21 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72k-0003dy-Ck; Sun, 09 Dec 2018 21:55:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "syzbot" <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.178902176@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 290/328] rtnl: limit IFLA_NUM_TX_QUEUES and
 IFLA_NUM_RX_QUEUES to 4096
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 0e1d6eca5113858ed2caea61a5adc03c595f6096 upstream.

We have an impressive number of syzkaller bugs that are linked
to the fact that syzbot was able to create a networking device
with millions of TX (or RX) queues.

Let's limit the number of RX/TX queues to 4096, this really should
cover all known cases.

A separate patch will add various cond_resched() in the loops
handling sysfs entries at device creation and dismantle.

Tested:

lpaa6:~# ip link add gre-4097 numtxqueues 4097 numrxqueues 4097 type ip6gretap
RTNETLINK answers: Invalid argument

lpaa6:~# time ip link add gre-4096 numtxqueues 4096 numrxqueues 4096 type ip6gretap

real	0m0.180s
user	0m0.000s
sys	0m0.107s

Fixes: 76ff5cc91935 ("rtnl: allow to specify number of rx and tx queues on device creation")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/core/rtnetlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1831,6 +1831,12 @@ struct net_device *rtnl_create_link(stru
 	else if (ops->get_num_rx_queues)
 		num_rx_queues = ops->get_num_rx_queues();
 
+	if (num_tx_queues < 1 || num_tx_queues > 4096)
+		return ERR_PTR(-EINVAL);
+
+	if (num_rx_queues < 1 || num_rx_queues > 4096)
+		return ERR_PTR(-EINVAL);
+
 	err = -ENOMEM;
 	dev = alloc_netdev_mqs(ops->priv_size, ifname, ops->setup,
 			       num_tx_queues, num_rx_queues);

