Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeERWr5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 18:47:57 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41736 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeERWrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 18:47:53 -0400
X-Google-Smtp-Source: AB8JxZoq90QFTXmafx0muHbPiZLeGEZqbZT/mLa5d0wGTRNLQNuv7wLBnl+hDF4SMqdwIL9Ki39pSw==
From: Stephen Boyd <swboyd@chromium.org>
To: Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
Subject: [PATCH] soc: qcom: geni: Make version macros simpler
Date: Fri, 18 May 2018 15:47:50 -0700
Message-Id: <20180518224750.232742-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro doesn't work, because it hides a local variable inside of the
macro to hold the version and that variable name is called 'ver' and
'version' sometimes.

Let's change this to be more explicit. Introduce three macros for the
major, minor, and step of the version, and require callers to pass the
version in to get the part of the version out. This way we don't hide
local variables inside macros and things are less evil overall.

Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: Sagar Dharia <sdharia@codeaurora.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/qcom-geni-se.h | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index 5d6144977828..3bcd67fd5548 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -225,19 +225,14 @@ struct geni_se {
 #define HW_VER_MINOR_SHFT		16
 #define HW_VER_STEP_MASK		GENMASK(15, 0)
 
+#define GENI_SE_VERSION_MAJOR(ver) ((ver & HW_VER_MAJOR_MASK) >> HW_VER_MAJOR_SHFT)
+#define GENI_SE_VERSION_MINOR(ver) ((ver & HW_VER_MINOR_MASK) >> HW_VER_MINOR_SHFT)
+#define GENI_SE_VERSION_STEP(ver) (ver & HW_VER_STEP_MASK)
+
 #if IS_ENABLED(CONFIG_QCOM_GENI_SE)
 
 u32 geni_se_get_qup_hw_version(struct geni_se *se);
 
-#define geni_se_get_wrapper_version(se, major, minor, step) do { \
-	u32 ver; \
-\
-	ver = geni_se_get_qup_hw_version(se); \
-	major = (ver & HW_VER_MAJOR_MASK) >> HW_VER_MAJOR_SHFT; \
-	minor = (ver & HW_VER_MINOR_MASK) >> HW_VER_MINOR_SHFT; \
-	step = version & HW_VER_STEP_MASK; \
-} while (0)
-
 /**
  * geni_se_read_proto() - Read the protocol configured for a serial engine
  * @se:		Pointer to the concerned serial engine.
-- 
Sent by a computer through tubes
