Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E95C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE002133F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejawPvOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE002133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733084AbeK3BbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:31:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731628AbeK3BbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:31:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A6062133F;
        Thu, 29 Nov 2018 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501542;
        bh=Fl8QC35nLKL01udSNtNrrlaSAYp2kj0ueKcq2izToEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejawPvOBxoOaZNNkLEY9iiFDLn3X+f+SatyMomBl903WzdoI/zRXzKw1LRKIjRZOP
         dEVp1lM1E0sqyn+NDWA8XHVPFP4i1NsWxMYQfjJ3PKkswBf4wcB5N2L1UPZMzG5K6Z
         hE7vNhqPgPldRQrzrAXwQFIl0ulQH71VFvKQyCLs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.14 039/100] can: dev: __can_get_echo_skb(): print error message, if trying to echo non existing skb
Date:   Thu, 29 Nov 2018 15:12:09 +0100
Message-Id: <20181129140102.139885270@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Kleine-Budde <mkl@pengutronix.de>

commit 7da11ba5c5066dadc2e96835a6233d56d7b7764a upstream.

Prior to echoing a successfully transmitted CAN frame (by calling
can_get_echo_skb()), CAN drivers have to put the CAN frame (by calling
can_put_echo_skb() in the transmit function). These put and get function
take an index as parameter, which is used to identify the CAN frame.

A driver calling can_get_echo_skb() with a index not pointing to a skb
is a BUG, so add an appropriate error message.

Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/dev.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -479,6 +479,8 @@ EXPORT_SYMBOL_GPL(can_put_echo_skb);
 struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr)
 {
 	struct can_priv *priv = netdev_priv(dev);
+	struct sk_buff *skb = priv->echo_skb[idx];
+	struct canfd_frame *cf;
 
 	if (idx >= priv->echo_skb_max) {
 		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
@@ -486,21 +488,20 @@ struct sk_buff *__can_get_echo_skb(struc
 		return NULL;
 	}
 
-	if (priv->echo_skb[idx]) {
-		/* Using "struct canfd_frame::len" for the frame
-		 * length is supported on both CAN and CANFD frames.
-		 */
-		struct sk_buff *skb = priv->echo_skb[idx];
-		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
-		u8 len = cf->len;
-
-		*len_ptr = len;
-		priv->echo_skb[idx] = NULL;
-
-		return skb;
+	if (!skb) {
+		netdev_err(dev, "%s: BUG! Trying to echo non existing skb: can_priv::echo_skb[%u]\n",
+			   __func__, idx);
+		return NULL;
 	}
 
-	return NULL;
+	/* Using "struct canfd_frame::len" for the frame
+	 * length is supported on both CAN and CANFD frames.
+	 */
+	cf = (struct canfd_frame *)skb->data;
+	*len_ptr = cf->len;
+	priv->echo_skb[idx] = NULL;
+
+	return skb;
 }
 
 /*


