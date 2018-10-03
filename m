Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C22EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BFD21476
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QVa16tsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BFD21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJCNyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:54:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43265 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeJCNyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:54:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id 80-v6so1113627pgh.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 00:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L4Qc0CALP1RkFVbalnzq2/EzAfTuUelm706tDhlpe7o=;
        b=QVa16tsqX6UunwOzQdSAithVgVfbGsz57QzaFQ/qao8UWNctYlvni8jGH1WzAsCFJZ
         q4tdKwuXcd+Ye+A3w6AtpEJV7KclhvH1C5JWeso8ytdjOmQREfSUIq6CYsA5TpJ0cM93
         aHlufnqpnrz470xdSaW4OVG3WIZF2Hyke8bBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L4Qc0CALP1RkFVbalnzq2/EzAfTuUelm706tDhlpe7o=;
        b=cKjuHXWWXF+/ePFWAh1yJb0am+LgnsD5lvoK3Ln+klAJx2lGQ4aNrObDAIrMykOx9l
         eo/jv6Iw+LgnMG/+yrP/B59o8DpS6rjYqlQEvSQgy9KIARks0G2cfLAHSofps+RGEWVd
         P8BrdW8+jl8fPCYMeXR4SB1CI35SGxkfEx8hBt6CmVRFTf9+NNcPmPZ7U1bWjcAasDQd
         4a5Kf0HR9CPazAJcqaLbvWBoi5FW4ZGVnTNhpn7xjolPXi/PKMmzvaiOGRLCU19NDT2G
         FVwqas505jlTRjFjnXkF2CO0m4fvmab6pECv8p+dm7j5GbyeOKkt2AoOErUeNsKY5VzO
         WTBg==
X-Gm-Message-State: ABuFfoiWVmt207wiFIIiYzKvehA0m5otQKNwPKAEXzHSjTDCULVG5mec
        RFSv7FhJSjcuHqX9xoEH5/XZCA==
X-Google-Smtp-Source: ACcGV63npfxk8jti2pKZnkMyLAPmvu6v6CpVlNiXJWmio4a4SnsBtuqIsb86WlQ8b+xrwxsK0c9i6Q==
X-Received: by 2002:a62:8c93:: with SMTP id m141-v6mr177186pfd.16.1538550425774;
        Wed, 03 Oct 2018 00:07:05 -0700 (PDT)
Received: from keiichiw1.tok.corp.google.com ([2401:fa00:4:4:968c:de0d:27a3:4bef])
        by smtp.gmail.com with ESMTPSA id y1-v6sm992520pfy.89.2018.10.03.00.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 00:07:04 -0700 (PDT)
From:   Keiichi Watanabe <keiichiw@chromium.org>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, tfiga@chromium.org,
        jcliang@chromium.org, shik@chromium.org, keiichiw@chromium.org
Subject: [PATCH] media: vivid: Support 480p for webcam capture
Date:   Wed,  3 Oct 2018 16:06:56 +0900
Message-Id: <20181003070656.193854-1-keiichiw@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support 640x480 as a frame size for video input devices of vivid.

Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
---
 drivers/media/platform/vivid/vivid-vid-cap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/vivid/vivid-vid-cap.c b/drivers/media/platform/vivid/vivid-vid-cap.c
index 58e14dd1dcd3..da80bf4bc365 100644
--- a/drivers/media/platform/vivid/vivid-vid-cap.c
+++ b/drivers/media/platform/vivid/vivid-vid-cap.c
@@ -51,7 +51,7 @@ static const struct vivid_fmt formats_ovl[] = {
 };
 
 /* The number of discrete webcam framesizes */
-#define VIVID_WEBCAM_SIZES 5
+#define VIVID_WEBCAM_SIZES 6
 /* The number of discrete webcam frameintervals */
 #define VIVID_WEBCAM_IVALS (VIVID_WEBCAM_SIZES * 2)
 
@@ -59,6 +59,7 @@ static const struct vivid_fmt formats_ovl[] = {
 static const struct v4l2_frmsize_discrete webcam_sizes[VIVID_WEBCAM_SIZES] = {
 	{  320, 180 },
 	{  640, 360 },
+	{  640, 480 },
 	{ 1280, 720 },
 	{ 1920, 1080 },
 	{ 3840, 2160 },
@@ -75,6 +76,8 @@ static const struct v4l2_fract webcam_intervals[VIVID_WEBCAM_IVALS] = {
 	{  1, 5 },
 	{  1, 10 },
 	{  1, 15 },
+	{  1, 15 },
+	{  1, 25 },
 	{  1, 25 },
 	{  1, 30 },
 	{  1, 50 },
-- 
2.19.0.605.g01d371f741-goog

