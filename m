Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD04C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 09:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DFB2081F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 09:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="bnkIYbS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DFB2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeKCTKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 15:10:37 -0400
Received: from plaes.org ([188.166.43.21]:34628 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbeKCTKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 15:10:36 -0400
Received: from localhost (85.253.196.132.cable.starman.ee [85.253.196.132])
        by plaes.org (Postfix) with ESMTPSA id B149640AC7
        for <linux-kernel@vger.kernel.org>; Sat,  3 Nov 2018 09:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1541239188; bh=/Yb7PyLhZEOeHePfimBc+VjwaiJ5iBQJt7c37vTCurg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bnkIYbS8WKaoh1BvnxgLtwIdFyQithmelFwboE739pO2FLyxYbITlE7ZkSfqV4Knn
         IulTnojjH3W8kuQ4ytq5vOIT9aOB8ShW66y5rTDX46sR58Eb7SGPSJdEAU1Ilj/tlW
         LIu/SkC5+XejLfFIHhqqhoY+6q71szuVTsaeDtlcqLve2ycWqJPwnKU5Bc8G76SegT
         wODNweq8yLU8kFBp1pB0XxAJSaS4f0xldBCw1W/csPwKE+KQVtQcJJpVo4pZZfGCOx
         HkzC/lOYyH4YNUNss1lVobBvge8w6VxOxaL2jkkigq1NP0HbDvra8piKurm25PJxdC
         UcUqWEk1r7FkQ==
From:   Priit Laes <plaes@plaes.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] lib: cordic: Move cordic macros and defines to header file
Date:   Sat,  3 Nov 2018 11:59:40 +0200
Message-Id: <d9a6fe71c3d682d3b85b971deb65a5f35208f40b.1541238842.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.f21c8e62e188620d586edb3f77514e6237122c4c.1541238842.git-series.plaes@plaes.org>
References: <cover.f21c8e62e188620d586edb3f77514e6237122c4c.1541238842.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also append CORDIC_ prefix to nonprefixed macros.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 include/linux/cordic.h |  9 +++++++++
 lib/cordic.c           | 23 +++++++----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/cordic.h b/include/linux/cordic.h
index cf68ca4..3d656f5 100644
--- a/include/linux/cordic.h
+++ b/include/linux/cordic.h
@@ -18,6 +18,15 @@
 
 #include <linux/types.h>
 
+#define CORDIC_ANGLE_GEN	39797
+#define CORDIC_PRECISION_SHIFT	16
+#define CORDIC_NUM_ITER	(CORDIC_PRECISION_SHIFT + 2)
+
+#define CORDIC_FIXED(X)	((s32)((X) << CORDIC_PRECISION_SHIFT))
+#define CORDIC_FLOAT(X)	(((X) >= 0) \
+		? ((((X) >> (CORDIC_PRECISION_SHIFT - 1)) + 1) >> 1) \
+		: -((((-(X)) >> (CORDIC_PRECISION_SHIFT - 1)) + 1) >> 1))
+
 /**
  * struct cordic_iq - i/q coordinate.
  *
diff --git a/lib/cordic.c b/lib/cordic.c
index 6cf4778..8ef27c1 100644
--- a/lib/cordic.c
+++ b/lib/cordic.c
@@ -16,15 +16,6 @@
 #include <linux/module.h>
 #include <linux/cordic.h>
 
-#define CORDIC_ANGLE_GEN	39797
-#define CORDIC_PRECISION_SHIFT	16
-#define	CORDIC_NUM_ITER		(CORDIC_PRECISION_SHIFT + 2)
-
-#define	FIXED(X)	((s32)((X) << CORDIC_PRECISION_SHIFT))
-#define	FLOAT(X)	(((X) >= 0) \
-		? ((((X) >> (CORDIC_PRECISION_SHIFT - 1)) + 1) >> 1) \
-		: -((((-(X)) >> (CORDIC_PRECISION_SHIFT - 1)) + 1) >> 1))
-
 static const s32 arctan_table[] = {
 	2949120,
 	1740967,
@@ -64,16 +55,16 @@ struct cordic_iq cordic_calc_iq(s32 theta)
 	coord.q = 0;
 	angle = 0;
 
-	theta = FIXED(theta);
+	theta = CORDIC_FIXED(theta);
 	signtheta = (theta < 0) ? -1 : 1;
-	theta = ((theta + FIXED(180) * signtheta) % FIXED(360)) -
-		FIXED(180) * signtheta;
+	theta = ((theta + CORDIC_FIXED(180) * signtheta) % CORDIC_FIXED(360)) -
+		CORDIC_FIXED(180) * signtheta;
 
-	if (FLOAT(theta) > 90) {
-		theta -= FIXED(180);
+	if (CORDIC_FLOAT(theta) > 90) {
+		theta -= CORDIC_FIXED(180);
 		signx = -1;
-	} else if (FLOAT(theta) < -90) {
-		theta += FIXED(180);
+	} else if (CORDIC_FLOAT(theta) < -90) {
+		theta += CORDIC_FIXED(180);
 		signx = -1;
 	}
 
-- 
git-series 0.9.1
