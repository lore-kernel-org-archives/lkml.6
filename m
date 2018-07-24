Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2A8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE8320875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE8320875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388771AbeGXJY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:24:28 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:45054 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388461AbeGXJY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:24:27 -0400
X-Greylist: delayed 952 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jul 2018 05:24:24 EDT
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 65BD4AC1A946A228560F;
        Tue, 24 Jul 2018 16:03:16 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6O83BA6059513;
        Tue, 24 Jul 2018 16:03:11 +0800 (GMT-8)
        (envelope-from tan.hu@zte.com.cn)
Received: from localhost.localdomain ([10.75.9.60])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018072416031519-1499306 ;
          Tue, 24 Jul 2018 16:03:15 +0800 
From:   Tan Hu <tan.hu@zte.com.cn>
To:     wensong@linux-vs.org, horms@verge.net.au, ja@ssi.bg,
        pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        jiang.biao2@zte.com.cn
Subject: [PATCH] ipvs: fix race between ip_vs_conn_new() and ip_vs_del_dest()
Date:   Tue, 24 Jul 2018 16:12:33 +0800
Message-Id: <1532419953-5517-1-git-send-email-tan.hu@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-24 16:03:15,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-24 16:03:07,
        Serialize complete at 2018-07-24 16:03:07
X-MAIL: mse01.zte.com.cn w6O83BA6059513
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We came across infinite loop in ipvs when using ipvs in docker
env.

When ipvs receives new packets and cannot find an ipvs connection,
it will create a new connection, then if the dest is unavailable
(i.e. IP_VS_DEST_F_AVAILABLE), the packet will be dropped sliently.

But if the dropped packet is the first packet of this connection,
the connection control timer never has a chance to start and the
ipvs connection cannot be released. This will lead to memory leak, or
infinite loop in cleanup_net() when net namespace is released like
this:

    ip_vs_conn_net_cleanup at ffffffffa0a9f31a [ip_vs]
    __ip_vs_cleanup at ffffffffa0a9f60a [ip_vs]
    ops_exit_list at ffffffff81567a49
    cleanup_net at ffffffff81568b40
    process_one_work at ffffffff810a851b
    worker_thread at ffffffff810a9356
    kthread at ffffffff810b0b6f
    ret_from_fork at ffffffff81697a18

race condition:
    CPU1                           CPU2
    ip_vs_in()
      ip_vs_conn_new()
                                   ip_vs_del_dest()
                                     __ip_vs_unlink_dest()
                                       ~IP_VS_DEST_F_AVAILABLE
      cp->dest && !IP_VS_DEST_F_AVAILABLE
      __ip_vs_conn_put
      ...
      cleanup_net  ---> infinite looping

Fix this by checking whether the timer already started.

Signed-off-by: Tan Hu <tan.hu@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 net/netfilter/ipvs/ip_vs_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index 0679dd1..ca9e7cc 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -1972,13 +1972,17 @@ static int ip_vs_in_icmp_v6(struct netns_ipvs *ipvs, struct sk_buff *skb,
 	if (cp->dest && !(cp->dest->flags & IP_VS_DEST_F_AVAILABLE)) {
 		/* the destination server is not available */
 
+		/* when timer already started, silently drop the packet.*/
+		if (timer_pending(&cp->timer))
+			__ip_vs_conn_put(cp);
+		else
+			ip_vs_conn_put(cp);
+
 		if (sysctl_expire_nodest_conn(ipvs)) {
 			/* try to expire the connection immediately */
 			ip_vs_conn_expire_now(cp);
 		}
-		/* don't restart its timer, and silently
-		   drop the packet. */
-		__ip_vs_conn_put(cp);
+
 		return NF_DROP;
 	}
 
-- 
1.8.3.1

