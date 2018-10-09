Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD6FC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9382086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GNrs8w0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9382086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeJIVAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:00:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47085 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbeJIVAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:00:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id r64-v6so856615pfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 06:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v0tKwxus/drX5kV0Dku9xw8w+RqBKDes35458ovCeko=;
        b=GNrs8w0TnmS4AmZ9kO0oufL04s14JZVCall9swho5QWJdXZbJ/tSyCDFdkQuucu6h0
         tR35EKE/9wOWbPxQlczIc7/y2QS8HUTd+u3ydSd5Rd9zso4KKv3LOVOMmiyTn+w2x11w
         6Spq6jLevOTUcUHBhbcfzzT5WRa37gfa7QOi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v0tKwxus/drX5kV0Dku9xw8w+RqBKDes35458ovCeko=;
        b=rGhsirVihqm4lwv7tDfiM3yQ+3mNu5EfmHrsLWY86LERaYbZ85qtKKfBPkz7lUxuc0
         cCrF9X7ka0NuPljf+dOsqAoczYSsWINxPxkXJ558fQNJxOZV0b+HY2gYbE1AzzjVtOs+
         7+4x2sA/eNVR9hgQgqbfmbjSzZ5UNdg5oFgdkl93Ph93WOEqMRBES+97yYdh5QD9btIE
         MbjikXqcMRWr9LdGwQNXCa4I8F5ZAxtZO6QDE0Xs8/aBrnMG3v/6bmi/9sMtswbtYvnZ
         GVMY5lR8gC7MM8DT60cOkCrJUa50j1mHnvPkYkoEwMP0sY1OWE5XeEq4bepnMywpO9QD
         zC6g==
X-Gm-Message-State: ABuFfoglVqv1aoTNpzWFne8AUvqibbxiJStiF8yX4XxZifaP69s7W2yL
        TE1ZDO7ovP8FrqIxC5k1BApDJA6yo4c=
X-Google-Smtp-Source: ACcGV62uLqMHR1tagdzZnIm92fx9JV6+OP+aW09uSrzRukfIdvbL5NkhY/zvoDKTIWPP7wqyuF259w==
X-Received: by 2002:a63:b409:: with SMTP id s9-v6mr25409528pgf.437.1539092629720;
        Tue, 09 Oct 2018 06:43:49 -0700 (PDT)
Received: from keiichiw1.tok.corp.google.com ([2401:fa00:4:4:968c:de0d:27a3:4bef])
        by smtp.gmail.com with ESMTPSA id f83-v6sm29850828pfa.109.2018.10.09.06.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 06:43:48 -0700 (PDT)
From:   Keiichi Watanabe <keiichiw@chromium.org>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, kieran.bingham@ideasonboard.com,
        tfiga@chromium.org, jcliang@chromium.org, shik@chromium.org,
        Keiichi Watanabe <keiichiw@chromium.org>
Subject: [PATCH v2] media: vivid: Support 480p for webcam capture
Date:   Tue,  9 Oct 2018 22:43:39 +0900
Message-Id: <20181009134339.233238-1-keiichiw@chromium.org>
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
index 58e14dd1dcd3..6cf910a60ecf 100644
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
@@ -74,9 +75,11 @@ static const struct v4l2_fract webcam_intervals[VIVID_WEBCAM_IVALS] = {
 	{  1, 4 },
 	{  1, 5 },
 	{  1, 10 },
+	{  2, 25 },
 	{  1, 15 },
 	{  1, 25 },
 	{  1, 30 },
+	{  1, 40 },
 	{  1, 50 },
 	{  1, 60 },
 };
-- 
2.19.0.605.g01d371f741-goog

