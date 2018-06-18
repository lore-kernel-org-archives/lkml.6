Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2EBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9ADF20874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9ADF20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933517AbeFRIPL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:15:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52692 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933118AbeFRIPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:15:07 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 604B6C50;
        Mon, 18 Jun 2018 08:15:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pieter Jansen van Vuuren 
        <pieter.jansenvanvuuren@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 010/279] nfp: flower: split and limit cmsg skb lists
Date:   Mon, 18 Jun 2018 10:09:55 +0200
Message-Id: <20180618080609.256898556@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>

[ Upstream commit cf2cbadc20f5651c3dde9f5ac2ee52fb43aa4ddd ]

Introduce a second skb list for handling control messages and limit the
number of allowed messages. Some control messages are considered more
crucial than others, resulting in the need for a second skb list. By
splitting the list into a separate high and low priority list we can
ensure that messages on the high list get added to the head of the list
that gets processed, this however has no functional impact. Previously
there was no limit on the number of messages allowed on the queue, this
could result in the queue growing boundlessly and eventually the host
running out of memory.

Fixes: b985f870a5f0 ("nfp: process control messages in workqueue in flower app")
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/flower/cmsg.c |   38 ++++++++++++++++++++---
 drivers/net/ethernet/netronome/nfp/flower/cmsg.h |    2 +
 drivers/net/ethernet/netronome/nfp/flower/main.c |    6 ++-
 drivers/net/ethernet/netronome/nfp/flower/main.h |    8 +++-
 4 files changed, 46 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/flower/cmsg.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/cmsg.c
@@ -242,18 +242,49 @@ out:
 
 void nfp_flower_cmsg_process_rx(struct work_struct *work)
 {
+	struct sk_buff_head cmsg_joined;
 	struct nfp_flower_priv *priv;
 	struct sk_buff *skb;
 
 	priv = container_of(work, struct nfp_flower_priv, cmsg_work);
+	skb_queue_head_init(&cmsg_joined);
 
-	while ((skb = skb_dequeue(&priv->cmsg_skbs)))
+	spin_lock_bh(&priv->cmsg_skbs_high.lock);
+	skb_queue_splice_tail_init(&priv->cmsg_skbs_high, &cmsg_joined);
+	spin_unlock_bh(&priv->cmsg_skbs_high.lock);
+
+	spin_lock_bh(&priv->cmsg_skbs_low.lock);
+	skb_queue_splice_tail_init(&priv->cmsg_skbs_low, &cmsg_joined);
+	spin_unlock_bh(&priv->cmsg_skbs_low.lock);
+
+	while ((skb = __skb_dequeue(&cmsg_joined)))
 		nfp_flower_cmsg_process_one_rx(priv->app, skb);
 }
 
-void nfp_flower_cmsg_rx(struct nfp_app *app, struct sk_buff *skb)
+static void
+nfp_flower_queue_ctl_msg(struct nfp_app *app, struct sk_buff *skb, int type)
 {
 	struct nfp_flower_priv *priv = app->priv;
+	struct sk_buff_head *skb_head;
+
+	if (type == NFP_FLOWER_CMSG_TYPE_PORT_REIFY ||
+	    type == NFP_FLOWER_CMSG_TYPE_PORT_MOD)
+		skb_head = &priv->cmsg_skbs_high;
+	else
+		skb_head = &priv->cmsg_skbs_low;
+
+	if (skb_queue_len(skb_head) >= NFP_FLOWER_WORKQ_MAX_SKBS) {
+		nfp_flower_cmsg_warn(app, "Dropping queued control messages\n");
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
+	skb_queue_tail(skb_head, skb);
+	schedule_work(&priv->cmsg_work);
+}
+
+void nfp_flower_cmsg_rx(struct nfp_app *app, struct sk_buff *skb)
+{
 	struct nfp_flower_cmsg_hdr *cmsg_hdr;
 
 	cmsg_hdr = nfp_flower_cmsg_get_hdr(skb);
@@ -270,7 +301,6 @@ void nfp_flower_cmsg_rx(struct nfp_app *
 		nfp_flower_rx_flow_stats(app, skb);
 		dev_consume_skb_any(skb);
 	} else {
-		skb_queue_tail(&priv->cmsg_skbs, skb);
-		schedule_work(&priv->cmsg_work);
+		nfp_flower_queue_ctl_msg(app, skb, cmsg_hdr->type);
 	}
 }
--- a/drivers/net/ethernet/netronome/nfp/flower/cmsg.h
+++ b/drivers/net/ethernet/netronome/nfp/flower/cmsg.h
@@ -98,6 +98,8 @@
 #define NFP_FL_IPV4_TUNNEL_TYPE		GENMASK(7, 4)
 #define NFP_FL_IPV4_PRE_TUN_INDEX	GENMASK(2, 0)
 
+#define NFP_FLOWER_WORKQ_MAX_SKBS	30000
+
 #define nfp_flower_cmsg_warn(app, fmt, args...)                         \
 	do {                                                            \
 		if (net_ratelimit())                                    \
--- a/drivers/net/ethernet/netronome/nfp/flower/main.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/main.c
@@ -517,7 +517,8 @@ static int nfp_flower_init(struct nfp_ap
 
 	app->priv = app_priv;
 	app_priv->app = app;
-	skb_queue_head_init(&app_priv->cmsg_skbs);
+	skb_queue_head_init(&app_priv->cmsg_skbs_high);
+	skb_queue_head_init(&app_priv->cmsg_skbs_low);
 	INIT_WORK(&app_priv->cmsg_work, nfp_flower_cmsg_process_rx);
 	init_waitqueue_head(&app_priv->reify_wait_queue);
 
@@ -544,7 +545,8 @@ static void nfp_flower_clean(struct nfp_
 {
 	struct nfp_flower_priv *app_priv = app->priv;
 
-	skb_queue_purge(&app_priv->cmsg_skbs);
+	skb_queue_purge(&app_priv->cmsg_skbs_high);
+	skb_queue_purge(&app_priv->cmsg_skbs_low);
 	flush_work(&app_priv->cmsg_work);
 
 	nfp_flower_metadata_cleanup(app);
--- a/drivers/net/ethernet/netronome/nfp/flower/main.h
+++ b/drivers/net/ethernet/netronome/nfp/flower/main.h
@@ -89,7 +89,10 @@ struct nfp_fl_stats_id {
  * @mask_table:		Hash table used to store masks
  * @flow_table:		Hash table used to store flower rules
  * @cmsg_work:		Workqueue for control messages processing
- * @cmsg_skbs:		List of skbs for control message processing
+ * @cmsg_skbs_high:	List of higher priority skbs for control message
+ *			processing
+ * @cmsg_skbs_low:	List of lower priority skbs for control message
+ *			processing
  * @nfp_mac_off_list:	List of MAC addresses to offload
  * @nfp_mac_index_list:	List of unique 8-bit indexes for non NFP netdevs
  * @nfp_ipv4_off_list:	List of IPv4 addresses to offload
@@ -117,7 +120,8 @@ struct nfp_flower_priv {
 	DECLARE_HASHTABLE(mask_table, NFP_FLOWER_MASK_HASH_BITS);
 	DECLARE_HASHTABLE(flow_table, NFP_FLOWER_HASH_BITS);
 	struct work_struct cmsg_work;
-	struct sk_buff_head cmsg_skbs;
+	struct sk_buff_head cmsg_skbs_high;
+	struct sk_buff_head cmsg_skbs_low;
 	struct list_head nfp_mac_off_list;
 	struct list_head nfp_mac_index_list;
 	struct list_head nfp_ipv4_off_list;


