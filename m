Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B76BC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21634206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgQjIV1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21634206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeI2P0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 11:26:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43590 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbeI2P0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 11:26:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id q19-v6so6093227pgn.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 01:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=53IsQQyZE5DfsCNDxP+Gosi4AGUy+9JSWFnR+jYkryA=;
        b=FgQjIV1FEuEck3drWkgUKakoOAnTz31xSupc8feJ8SsoRjGFqkJp4IP63qpNd0vwAq
         yZ+0RI40FjU/gI21kfqkHBkic+ghA4AuaDRYQoijT8vhqxVKjlXic8F3xFezsnfsr2lp
         LJ/ZMqO8dHYF0WOg3NFQBS1h+MjoGOb49DEWhIySbYFKY/+Y0FKsK5+0tuSt5zTIgTwC
         sdBcyCOLOqmjOGvXVJEOu+6n4CqwgnHNnVblOOF5sGguA36hhMLMF33DkwaogNoWMTIc
         x4gjGFOdhukW4mjjJGzburPRo4jxvL9B6OLcjlws05cOfTBtUkq+wjDUGk2fRdUIO8bD
         INLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=53IsQQyZE5DfsCNDxP+Gosi4AGUy+9JSWFnR+jYkryA=;
        b=mK6i+GuElGIkChsev4fbP20EGbp06CbF9ibs99TajaA4FF1AJZv+v5mWn+QONmGk1q
         1Ya+bsiEIYCYm9B/miCAZ6y5AwAHwdP6FU+xUpphTFlT9+3Zf/JZ9NWXmChJPkaIk2JI
         eGrFCo1KxM/EZW1tOD8bv8C/xgqoL227Odis1mU61TRu3F+/cr/Fl4V6hiK9uk16OQ/G
         +fznoDpxuxdyHg8K3M8uAixFwGRiSKSheflsuIqzey4pcUuWHeCpdmvauwW9f3fVgjTG
         Y/ygrcnldvOr6lWCMv7x0VnErIUtX4vaD+7gLsIEvwziqKXBokIZEuR6ZD2Is+Bg66/K
         6HZw==
X-Gm-Message-State: ABuFfoht58r3may/d+RJhgzXL7vlqvjuWgUBd+vGLInDh9pgJIW7EC2O
        AIMoohK6j60gYUFSwUcShexQGXr1y6qJLg==
X-Google-Smtp-Source: ACcGV60Uhq/q330alvv91bKK8IkZ88Fe47fHHqmiNqqNlhwOOybU4z/0FiOSaNzYdKjb0FBGVfUbEg==
X-Received: by 2002:a63:a902:: with SMTP id u2-v6mr2081239pge.207.1538211543016;
        Sat, 29 Sep 2018 01:59:03 -0700 (PDT)
Received: from Sherlock.localdomain ([14.139.38.159])
        by smtp.gmail.com with ESMTPSA id y128-v6sm10550206pfb.56.2018.09.29.01.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 01:59:01 -0700 (PDT)
From:   Shubham Singh <dhoni.singh094@gmail.com>
To:     forest@alittletooquite.net
Cc:     gregkh@linuxfoundation.org, devel@driver.osuosl.org,
        linux-kernel@vger.kernel.org, shubhsherl <dhoni.singh094@gmail.com>
Subject: [PATCH] Staging: vt6656: baseband.c: fixed unnecessary paranthesis
Date:   Sat, 29 Sep 2018 14:28:54 +0530
Message-Id: <20180929085854.15880-1-dhoni.singh094@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: shubhsherl <dhoni.singh094@gmail.com>

Fixed a coding line issue.

Signed-off-by: shubhsherl <dhoni.singh094@gmail.com>
---
 drivers/staging/vt6656/baseband.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/baseband.c
index b29ba237fa29..540cc9eafd07 100644
--- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -382,8 +382,8 @@ int vnt_vt3184_init(struct vnt_private *priv)
 
 	dev_dbg(&priv->usb->dev, "RF Type %d\n", priv->rf_type);
 
-	if ((priv->rf_type == RF_AL2230) ||
-	    (priv->rf_type == RF_AL2230S)) {
+	if (priv->rf_type == RF_AL2230 ||
+	    priv->rf_type == RF_AL2230S) {
 		priv->bb_rx_conf = vnt_vt3184_al2230[10];
 		length = sizeof(vnt_vt3184_al2230);
 		addr = vnt_vt3184_al2230;
@@ -454,8 +454,8 @@ int vnt_vt3184_init(struct vnt_private *priv)
 	vnt_control_out(priv, MESSAGE_TYPE_WRITE, 0,
 			MESSAGE_REQUEST_BBAGC, length_agc, array);
 
-	if ((priv->rf_type == RF_VT3226) ||
-	    (priv->rf_type == RF_VT3342A0)) {
+	if (priv->rf_type == RF_VT3226 ||
+	    priv->rf_type == RF_VT3342A0) {
 		vnt_control_out_u8(priv, MESSAGE_REQUEST_MACREG,
 				   MAC_REG_ITRTMSET, 0x23);
 		vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY, 0x01);
-- 
2.18.0

