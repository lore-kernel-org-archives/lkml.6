Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5DBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B8E2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l++Ie3M4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B8E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbeK3Bfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:35:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732139AbeK3Bfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:35:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 136F521479;
        Thu, 29 Nov 2018 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501810;
        bh=rNvzwF+Nfid700TlN2G7Gg+px+5pNkVlGA9p/RKJWJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l++Ie3M4MW63aVy2OErMM2Dq+XMbjIOZMWy+cZTk/TB4vAI+9SvmhXL0cbBTcrrTt
         RRoIKjDv0Ihpe8zcBTDmSlt3TbltZoxSxYFNsJsx4CUUtjQuG1suQ5UdvC3wkgz3/U
         mUKQlVg/9hcDF0EGOvpdKMe0KgfL3Fsz/f9n/JS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.19 049/110] can: dev: can_get_echo_skb(): factor out non sending code to __can_get_echo_skb()
Date:   Thu, 29 Nov 2018 15:12:20 +0100
Message-Id: <20181129135923.246097593@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Kleine-Budde <mkl@pengutronix.de>

commit a4310fa2f24687888ce80fdb0e88583561a23700 upstream.

This patch factors out all non sending parts of can_get_echo_skb() into
a seperate function __can_get_echo_skb(), so that it can be re-used in
an upcoming patch.

Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/dev.c   |   36 +++++++++++++++++++++++++-----------
 include/linux/can/dev.h |    1 +
 2 files changed, 26 insertions(+), 11 deletions(-)

--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -477,14 +477,7 @@ void can_put_echo_skb(struct sk_buff *sk
 }
 EXPORT_SYMBOL_GPL(can_put_echo_skb);
 
-/*
- * Get the skb from the stack and loop it back locally
- *
- * The function is typically called when the TX done interrupt
- * is handled in the device driver. The driver must protect
- * access to priv->echo_skb, if necessary.
- */
-unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
+struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr)
 {
 	struct can_priv *priv = netdev_priv(dev);
 
@@ -495,13 +488,34 @@ unsigned int can_get_echo_skb(struct net
 		struct can_frame *cf = (struct can_frame *)skb->data;
 		u8 dlc = cf->can_dlc;
 
-		netif_rx(priv->echo_skb[idx]);
+		*len_ptr = dlc;
 		priv->echo_skb[idx] = NULL;
 
-		return dlc;
+		return skb;
 	}
 
-	return 0;
+	return NULL;
+}
+
+/*
+ * Get the skb from the stack and loop it back locally
+ *
+ * The function is typically called when the TX done interrupt
+ * is handled in the device driver. The driver must protect
+ * access to priv->echo_skb, if necessary.
+ */
+unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
+{
+	struct sk_buff *skb;
+	u8 len;
+
+	skb = __can_get_echo_skb(dev, idx, &len);
+	if (!skb)
+		return 0;
+
+	netif_rx(skb);
+
+	return len;
 }
 EXPORT_SYMBOL_GPL(can_get_echo_skb);
 
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -169,6 +169,7 @@ void can_change_state(struct net_device
 
 void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		      unsigned int idx);
+struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr);
 unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx);
 void can_free_echo_skb(struct net_device *dev, unsigned int idx);
 


