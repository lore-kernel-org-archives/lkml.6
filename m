Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69441C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6B120661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6B120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbeLIWXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:23:38 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35070 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbeLIVzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:18 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0002if-Pf; Sun, 09 Dec 2018 21:55:16 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0003SA-Q8; Sun, 09 Dec 2018 21:55:12 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Sabrina Dubroca" <sd@queasysnail.net>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.271758364@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 173/328] ipv6: fix cleanup ordering for pingv6
 registration
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

From: Sabrina Dubroca <sd@queasysnail.net>

commit a03dc36bdca6b614651fedfcd8559cf914d2d21d upstream.

Commit 6d0bfe226116 ("net: ipv6: Add IPv6 support to the ping socket.")
contains an error in the cleanup path of inet6_init(): when
proto_register(&pingv6_prot, 1) fails, we try to unregister
&pingv6_prot. When rawv6_init() fails, we skip unregistering
&pingv6_prot.

Example of panic (triggered by faking a failure of
 proto_register(&pingv6_prot, 1)):

    general protection fault: 0000 [#1] PREEMPT SMP KASAN PTI
    [...]
    RIP: 0010:__list_del_entry_valid+0x79/0x160
    [...]
    Call Trace:
     proto_unregister+0xbb/0x550
     ? trace_preempt_on+0x6f0/0x6f0
     ? sock_no_shutdown+0x10/0x10
     inet6_init+0x153/0x1b8

Fixes: 6d0bfe226116 ("net: ipv6: Add IPv6 support to the ping socket.")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv6/af_inet6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -860,14 +860,14 @@ static int __init inet6_init(void)
 
 	err = proto_register(&pingv6_prot, 1);
 	if (err)
-		goto out_unregister_ping_proto;
+		goto out_unregister_raw_proto;
 
 	/* We MUST register RAW sockets before we create the ICMP6,
 	 * IGMP6, or NDISC control sockets.
 	 */
 	err = rawv6_init();
 	if (err)
-		goto out_unregister_raw_proto;
+		goto out_unregister_ping_proto;
 
 	/* Register the family here so that the init calls below will
 	 * be able to create sockets. (?? is this dangerous ??)

