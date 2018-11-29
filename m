Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32836C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25512146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQMtJacR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25512146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388722AbeK3Bft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:35:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728991AbeK3Bfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:35:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAB742145D;
        Thu, 29 Nov 2018 14:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501815;
        bh=TSwb8zSIliG8pquJ1Dd+e9phszGWfwYwsbHJ7oEF+Mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQMtJacRAGTWXUKb/B6sQnMsUW8VD7pVoCAhy0ajV+anxoAU0WYzJpRllWy5nYIEM
         kfeERBLV9mXojp7lStPW/gbKjPtSnQggPD+KgruHS4yAW4HOjt9SBTcE+yVK4+nmgf
         Napcpow04Wxjabel00+yvl//2ZqGBKauNDjqAZ5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.19 051/110] can: dev: __can_get_echo_skb(): Dont crash the kernel if can_priv::echo_skb is accessed out of bounds
Date:   Thu, 29 Nov 2018 15:12:22 +0100
Message-Id: <20181129135923.326981375@linuxfoundation.org>
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

commit e7a6994d043a1e31d5b17706a22ce33d2a3e4cdc upstream.

If the "struct can_priv::echo_skb" is accessed out of bounds would lead
to a kernel crash. Better print a sensible warning message instead and
try to recover.

Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/dev.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -481,7 +481,11 @@ struct sk_buff *__can_get_echo_skb(struc
 {
 	struct can_priv *priv = netdev_priv(dev);
 
-	BUG_ON(idx >= priv->echo_skb_max);
+	if (idx >= priv->echo_skb_max) {
+		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
+			   __func__, idx, priv->echo_skb_max);
+		return NULL;
+	}
 
 	if (priv->echo_skb[idx]) {
 		/* Using "struct canfd_frame::len" for the frame


