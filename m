Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D47C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC60421104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC54ThXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC60421104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbeK3B07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:26:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730438AbeK3B05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:26:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A6DA20868;
        Thu, 29 Nov 2018 14:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501286;
        bh=GZEnoRflET6CSsmOyCQAeqv2jTWvEkZb4sdMVTqRb6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FC54ThXd9mzbugtgl980t6svvEwZD/XhrhxT8eYkq1gChMgQpDcJx/UT+G8UNhSwJ
         kLdyHcv+BXA58OKRMxyQNbN6zFTz0g1IDtpqUKDh9syDJpU0MYziixiNl+HJukyGfF
         akczuglQmgPJ/687yrQic6c6lP0OCNlDHk5nRXxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.9 21/92] can: dev: __can_get_echo_skb(): replace struct can_frame by canfd_frame to access frame length
Date:   Thu, 29 Nov 2018 15:11:50 +0100
Message-Id: <20181129140108.080939391@linuxfoundation.org>
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

From: Marc Kleine-Budde <mkl@pengutronix.de>

commit 200f5c49f7a2cd694436bfc6cb0662b794c96736 upstream.

This patch replaces the use of "struct can_frame::can_dlc" by "struct
canfd_frame::len" to access the frame's length. As it is ensured that
both structures have a compatible memory layout for this member this is
no functional change. Futher, this compatibility is documented in a
comment.

Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/dev.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -460,11 +460,14 @@ struct sk_buff *__can_get_echo_skb(struc
 	BUG_ON(idx >= priv->echo_skb_max);
 
 	if (priv->echo_skb[idx]) {
+		/* Using "struct canfd_frame::len" for the frame
+		 * length is supported on both CAN and CANFD frames.
+		 */
 		struct sk_buff *skb = priv->echo_skb[idx];
-		struct can_frame *cf = (struct can_frame *)skb->data;
-		u8 dlc = cf->can_dlc;
+		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+		u8 len = cf->len;
 
-		*len_ptr = dlc;
+		*len_ptr = len;
 		priv->echo_skb[idx] = NULL;
 
 		return skb;


