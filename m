Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755429AbeCSJci (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:32:38 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45150 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755393AbeCSJcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:32:35 -0400
X-Google-Smtp-Source: AG47ELs8povAKv1aw2hrG4ebjPveFBORtFCFTb7NCQpb03qu9pceIK5Fuk2P9U6Eq8WwLi4/LyWQZQ==
From: Alexandre Courbot <acourbot@chromium.org>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v2] venus: vdec: fix format enumeration
Date: Mon, 19 Mar 2018 18:32:29 +0900
Message-Id: <20180319093229.76253-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_format_by_index() stops enumerating formats as soon as the index
matches, and returns NULL if venus_helper_check_codec() finds out that
the format is not supported. This prevents formats to be properly
enumerated if a non-supported format is present, as the enumeration will
end with it.

Fix this by moving the call to venus_helper_check_codec() into the loop,
and keep enumerating when it fails.

Fixes: 29f0133ec6 media: venus: use helper function to check supported codecs

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 13 +++++++------
 drivers/media/platform/qcom/venus/venc.c | 13 +++++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index c9e9576bb08a..49bbd1861d3a 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -135,20 +135,21 @@ find_format_by_index(struct venus_inst *inst, unsigned int index, u32 type)
 		return NULL;
 
 	for (i = 0; i < size; i++) {
+		bool valid;
+
 		if (fmt[i].type != type)
 			continue;
-		if (k == index)
+		valid = type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE ||
+			venus_helper_check_codec(inst, fmt[i].pixfmt);
+		if (k == index && valid)
 			break;
-		k++;
+		if (valid)
+			k++;
 	}
 
 	if (i == size)
 		return NULL;
 
-	if (type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE &&
-	    !venus_helper_check_codec(inst, fmt[i].pixfmt))
-		return NULL;
-
 	return &fmt[i];
 }
 
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index e3a10a852cad..6b2ce479584e 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -120,20 +120,21 @@ find_format_by_index(struct venus_inst *inst, unsigned int index, u32 type)
 		return NULL;
 
 	for (i = 0; i < size; i++) {
+		bool valid;
+
 		if (fmt[i].type != type)
 			continue;
-		if (k == index)
+		valid = type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE ||
+			venus_helper_check_codec(inst, fmt[i].pixfmt);
+		if (k == index && valid)
 			break;
-		k++;
+		if (valid)
+			k++;
 	}
 
 	if (i == size)
 		return NULL;
 
-	if (type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE &&
-	    !venus_helper_check_codec(inst, fmt[i].pixfmt))
-		return NULL;
-
 	return &fmt[i];
 }
 
-- 
2.16.2.804.g6dcf76e118-goog
