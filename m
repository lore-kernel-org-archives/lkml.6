Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11A7C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65215208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65215208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbeIXRjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:39:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50424 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeIXRjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:39:39 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D12F61065;
        Mon, 24 Sep 2018 11:37:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tan Hu <tan.hu@zte.com.cn>,
        Jiang Biao <jiang.biao2@zte.com.cn>,
        Julian Anastasov <ja@ssi.bg>,
        Simon Horman <horms@verge.net.au>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 009/105] ipvs: fix race between ip_vs_conn_new() and ip_vs_del_dest()
Date:   Mon, 24 Sep 2018 13:32:55 +0200
Message-Id: <20180924113114.240920035@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tan Hu <tan.hu@zte.com.cn>

[ Upstream commit a53b42c11815d2357e31a9403ae3950517525894 ]

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
Acked-by: Julian Anastasov <ja@ssi.bg>
Acked-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/ipvs/ip_vs_core.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -1692,13 +1692,20 @@ ip_vs_in(unsigned int hooknum, struct sk
 	if (cp->dest && !(cp->dest->flags & IP_VS_DEST_F_AVAILABLE)) {
 		/* the destination server is not available */
 
-		if (sysctl_expire_nodest_conn(ipvs)) {
+		__u32 flags = cp->flags;
+
+		/* when timer already started, silently drop the packet.*/
+		if (timer_pending(&cp->timer))
+			__ip_vs_conn_put(cp);
+		else
+			ip_vs_conn_put(cp);
+
+		if (sysctl_expire_nodest_conn(ipvs) &&
+		    !(flags & IP_VS_CONN_F_ONE_PACKET)) {
 			/* try to expire the connection immediately */
 			ip_vs_conn_expire_now(cp);
 		}
-		/* don't restart its timer, and silently
-		   drop the packet. */
-		__ip_vs_conn_put(cp);
+
 		return NF_DROP;
 	}
 


