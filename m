Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0126C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D3E21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiL5Rnae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D3E21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbeK3B2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:28:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:54616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731487AbeK3B2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:28:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 907F2205C9;
        Thu, 29 Nov 2018 14:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501395;
        bh=GvjjXOnQNqE7YOtOXUcmGNTt9pZzkjlucW0iwPA2H2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QiL5Rnae9+3oBjDbIHzVV3tE8uZfOKOc07TlVeuJ5mU405x2/8aP+1Bko1cMI5ns/
         e8yKMeo5vXkaa9REdzDuh/PMml487inajBiufyGCZBT8IiKK4Sp2/ac5jVsoZxFGiO
         Bcp34uRgFSVtJxGxytbbrTF/iNWYHho2pTeyjzX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amitkumar Karwar <akarwar@marvell.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 73/92] mwifiex: Fix NULL pointer dereference in skb_dequeue()
Date:   Thu, 29 Nov 2018 15:12:42 +0100
Message-Id: <20181129140112.299718305@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
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

From: Amitkumar Karwar <akarwar@marvell.com>

commit c44c040300d7afd79294710313a4989683e2afb1 upstream.

At couple of places in cleanup path, we are just going through the
skb queue and freeing them without unlinking. This leads to a crash
when other thread tries to do skb_dequeue() and use already freed node.

The problem is freed by unlinking skb before freeing it.

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c |    4 +++-
 drivers/net/wireless/marvell/mwifiex/wmm.c      |   12 +++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3079,8 +3079,10 @@ int mwifiex_del_virtual_intf(struct wiph
 
 	mwifiex_stop_net_dev_queue(priv->netdev, adapter);
 
-	skb_queue_walk_safe(&priv->bypass_txq, skb, tmp)
+	skb_queue_walk_safe(&priv->bypass_txq, skb, tmp) {
+		skb_unlink(skb, &priv->bypass_txq);
 		mwifiex_write_data_complete(priv->adapter, skb, 0, -1);
+	}
 
 	if (netif_carrier_ok(priv->netdev))
 		netif_carrier_off(priv->netdev);
--- a/drivers/net/wireless/marvell/mwifiex/wmm.c
+++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
@@ -503,8 +503,10 @@ mwifiex_wmm_del_pkts_in_ralist_node(stru
 	struct mwifiex_adapter *adapter = priv->adapter;
 	struct sk_buff *skb, *tmp;
 
-	skb_queue_walk_safe(&ra_list->skb_head, skb, tmp)
+	skb_queue_walk_safe(&ra_list->skb_head, skb, tmp) {
+		skb_unlink(skb, &ra_list->skb_head);
 		mwifiex_write_data_complete(adapter, skb, 0, -1);
+	}
 }
 
 /*
@@ -600,11 +602,15 @@ mwifiex_clean_txrx(struct mwifiex_privat
 		priv->adapter->if_ops.clean_pcie_ring(priv->adapter);
 	spin_unlock_irqrestore(&priv->wmm.ra_list_spinlock, flags);
 
-	skb_queue_walk_safe(&priv->tdls_txq, skb, tmp)
+	skb_queue_walk_safe(&priv->tdls_txq, skb, tmp) {
+		skb_unlink(skb, &priv->tdls_txq);
 		mwifiex_write_data_complete(priv->adapter, skb, 0, -1);
+	}
 
-	skb_queue_walk_safe(&priv->bypass_txq, skb, tmp)
+	skb_queue_walk_safe(&priv->bypass_txq, skb, tmp) {
+		skb_unlink(skb, &priv->bypass_txq);
 		mwifiex_write_data_complete(priv->adapter, skb, 0, -1);
+	}
 	atomic_set(&priv->adapter->bypass_tx_pending, 0);
 
 	idr_for_each(&priv->ack_status_frames, mwifiex_free_ack_frame, NULL);


