Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5641C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FCA20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762047;
	bh=ltjX6XTuv2d16MfnrKM+s5Yw1loQ0T+aOEfCi+utm80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I5HnDIiTgXwQlSjL36Ju+e4qRHUVBvnmDPt9T6bZF71wKqSUoVsHiYaC2/IY0CUM8
	 BP+vCqz2B773BQ5NGqiyFWGIN00xweUEEz0Y8iOkzbBacn2JdxfCQeTE4ZSdJ5xb6K
	 L/dL/8SMb6faJX0FhWFe1TphP+bA8iwnsQJlSQV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfA2Lkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:40:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729098AbfA2Lkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:40:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 514642183F;
        Tue, 29 Jan 2019 11:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762038;
        bh=ltjX6XTuv2d16MfnrKM+s5Yw1loQ0T+aOEfCi+utm80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZNv8kkUY/FyOFz3utP3w8E6RBi1jPvo5uWvXdDdgPifj1tebvrUQLOjkClDgw/D8i
         BHBKweVqxRm/ni2ho3u1bf2cfFeED0+RMbRqFtjvn2C0SIxoAjytyRZuJORVu6nJxk
         NUuVA5Yk5E10XZ8b7KX+OUWFG1WtYbA3fRWtRBi4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.20 087/117] can: dev: __can_get_echo_skb(): fix bogous check for non-existing skb by removing it
Date:   Tue, 29 Jan 2019 12:35:38 +0100
Message-Id: <20190129113211.745605523@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>

commit 7b12c8189a3dc50638e7d53714c88007268d47ef upstream.

This patch revert commit 7da11ba5c506
("can: dev: __can_get_echo_skb(): print error message, if trying to echo non existing skb")

After introduction of this change we encountered following new error
message on various i.MX plattforms (flexcan):

| flexcan 53fc8000.can can0: __can_get_echo_skb: BUG! Trying to echo non
| existing skb: can_priv::echo_skb[0]

The introduction of the message was a mistake because
priv->echo_skb[idx] = NULL is a perfectly valid in following case: If
CAN_RAW_LOOPBACK is disabled (setsockopt) in applications, the pkt_type
of the tx skb's given to can_put_echo_skb is set to PACKET_LOOPBACK. In
this case can_put_echo_skb will not set priv->echo_skb[idx]. It is
therefore kept NULL.

As additional argument for revert: The order of check and usage of idx
was changed. idx is used to access an array element before checking it's
boundaries.

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Fixes: 7da11ba5c506 ("can: dev: __can_get_echo_skb(): print error message, if trying to echo non existing skb")
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/dev.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -480,8 +480,6 @@ EXPORT_SYMBOL_GPL(can_put_echo_skb);
 struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr)
 {
 	struct can_priv *priv = netdev_priv(dev);
-	struct sk_buff *skb = priv->echo_skb[idx];
-	struct canfd_frame *cf;
 
 	if (idx >= priv->echo_skb_max) {
 		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
@@ -489,20 +487,21 @@ struct sk_buff *__can_get_echo_skb(struc
 		return NULL;
 	}
 
-	if (!skb) {
-		netdev_err(dev, "%s: BUG! Trying to echo non existing skb: can_priv::echo_skb[%u]\n",
-			   __func__, idx);
-		return NULL;
-	}
+	if (priv->echo_skb[idx]) {
+		/* Using "struct canfd_frame::len" for the frame
+		 * length is supported on both CAN and CANFD frames.
+		 */
+		struct sk_buff *skb = priv->echo_skb[idx];
+		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+		u8 len = cf->len;
 
-	/* Using "struct canfd_frame::len" for the frame
-	 * length is supported on both CAN and CANFD frames.
-	 */
-	cf = (struct canfd_frame *)skb->data;
-	*len_ptr = cf->len;
-	priv->echo_skb[idx] = NULL;
+		*len_ptr = len;
+		priv->echo_skb[idx] = NULL;
+
+		return skb;
+	}
 
-	return skb;
+	return NULL;
 }
 
 /*


