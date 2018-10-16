Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C31C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBB420658
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUmWeCrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBB420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbeJQBPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:15:37 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DD1A20658;
        Tue, 16 Oct 2018 17:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710651;
        bh=noOdfN5qsnPzzSqHUHAnb7nvaPK3MXGoTyFsX/rICSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GUmWeCrBpoay45VU96RS6QSADHkE4QPZq/1UgK99VXA8ZcLXUU7g2yPDsQPRMRF5S
         Yvc7crPytn55EAnOVLjTeWZ4BLzRFl/KbiaZIieecHZT6hlm96oRXkEEDxP8+0UzE1
         ikeFkYh0iI3VpiXwGVaHQLuIkkcB7xDqDhthI14Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 40/71] rtnl: limit IFLA_NUM_TX_QUEUES and IFLA_NUM_RX_QUEUES to 4096
Date:   Tue, 16 Oct 2018 19:09:37 +0200
Message-Id: <20181016170541.388868189@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 0e1d6eca5113858ed2caea61a5adc03c595f6096 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/rtnetlink.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2368,6 +2368,12 @@ struct net_device *rtnl_create_link(stru
 	else if (ops->get_num_rx_queues)
 		num_rx_queues = ops->get_num_rx_queues();
 
+	if (num_tx_queues < 1 || num_tx_queues > 4096)
+		return ERR_PTR(-EINVAL);
+
+	if (num_rx_queues < 1 || num_rx_queues > 4096)
+		return ERR_PTR(-EINVAL);
+
 	err = -ENOMEM;
 	dev = alloc_netdev_mqs(ops->priv_size, ifname, name_assign_type,
 			       ops->setup, num_tx_queues, num_rx_queues);


