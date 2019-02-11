Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8C0C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C914321B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898428;
	bh=I7oYyZsSmhGbUZU0jdoSbrCNKyL5h4t09x9rquEpGiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tVEhAKwrA3RXb259m19hUK1fWkdwPHWL4r+yIovkYkQ+R4NNL9JJaEcXKqJJdoHG3
	 OpijxfQ3QSAWxU9A2QPNicogOxiYHcF1UEjnu8locFWOZUm81gK1j1dXXjI4eRQIvR
	 iPLVZexk5+HVtY9f0BDADoU91KLbUOx4TpJnD5dE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390959AbfBKPFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:05:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390943AbfBKPFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:05:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD46C222AD;
        Mon, 11 Feb 2019 15:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897514;
        bh=I7oYyZsSmhGbUZU0jdoSbrCNKyL5h4t09x9rquEpGiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NALzJNhnvmr7MbtgO+TrNSlFJA2ISigBi5f4CPaEuQVTXG8HxdWr715sqNVh8q2VW
         FQVAUFWxQC3JFNEWgK3YqKULI31ypXIhgs2gF39AL3MzRgi9GIaNGAoXzt++Aymron
         nt+LI9pA5c+J6ZDLyS3p8JLBFgr6DsHyguzVX45s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 023/137] media: adv*/tc358743/ths8200: fill in min width/height/pixelclock
Date:   Mon, 11 Feb 2019 15:18:24 +0100
Message-Id: <20190211141814.135450913@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2912289a518077ddb8214e05336700148e97e235 ]

The v4l2_dv_timings_cap struct is used to do sanity checks when setting and
enumerating DV timings, ensuring that only valid timings as per the HW
capabilities are allowed.

However, many drivers just filled in 0 for the minimum width, height or
pixelclock frequency. This can cause timings with e.g. 0 as width and height
to be accepted, which will in turn lead to a potential division by zero.

Fill in proper values are minimum boundaries. 640x350 was chosen since it is
the smallest resolution in v4l2-dv-timings.h. Same for 13 MHz as the lowest
pixelclock frequency (it's slightly below the minimum of 13.5 MHz in the
v4l2-dv-timings.h header).

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ad9389b.c  | 2 +-
 drivers/media/i2c/adv7511.c  | 2 +-
 drivers/media/i2c/adv7604.c  | 4 ++--
 drivers/media/i2c/adv7842.c  | 4 ++--
 drivers/media/i2c/tc358743.c | 2 +-
 drivers/media/i2c/ths8200.c  | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/ad9389b.c b/drivers/media/i2c/ad9389b.c
index 50f354144ee7..2abbbc6392c0 100644
--- a/drivers/media/i2c/ad9389b.c
+++ b/drivers/media/i2c/ad9389b.c
@@ -590,7 +590,7 @@ static const struct v4l2_dv_timings_cap ad9389b_timings_cap = {
 	.type = V4L2_DV_BT_656_1120,
 	/* keep this initialization for compatibility with GCC < 4.4.6 */
 	.reserved = { 0 },
-	V4L2_INIT_BT_TIMINGS(0, 1920, 0, 1200, 25000000, 170000000,
+	V4L2_INIT_BT_TIMINGS(640, 1920, 350, 1200, 25000000, 170000000,
 		V4L2_DV_BT_STD_CEA861 | V4L2_DV_BT_STD_DMT |
 			V4L2_DV_BT_STD_GTF | V4L2_DV_BT_STD_CVT,
 		V4L2_DV_BT_CAP_PROGRESSIVE | V4L2_DV_BT_CAP_REDUCED_BLANKING |
diff --git a/drivers/media/i2c/adv7511.c b/drivers/media/i2c/adv7511.c
index 5ba0f21bcfe4..5f1c8ee8a50e 100644
--- a/drivers/media/i2c/adv7511.c
+++ b/drivers/media/i2c/adv7511.c
@@ -142,7 +142,7 @@ static const struct v4l2_dv_timings_cap adv7511_timings_cap = {
 	.type = V4L2_DV_BT_656_1120,
 	/* keep this initialization for compatibility with GCC < 4.4.6 */
 	.reserved = { 0 },
-	V4L2_INIT_BT_TIMINGS(0, ADV7511_MAX_WIDTH, 0, ADV7511_MAX_HEIGHT,
+	V4L2_INIT_BT_TIMINGS(640, ADV7511_MAX_WIDTH, 350, ADV7511_MAX_HEIGHT,
 		ADV7511_MIN_PIXELCLOCK, ADV7511_MAX_PIXELCLOCK,
 		V4L2_DV_BT_STD_CEA861 | V4L2_DV_BT_STD_DMT |
 			V4L2_DV_BT_STD_GTF | V4L2_DV_BT_STD_CVT,
diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
index 7b1935ab03c8..ce6f93074ae0 100644
--- a/drivers/media/i2c/adv7604.c
+++ b/drivers/media/i2c/adv7604.c
@@ -777,7 +777,7 @@ static const struct v4l2_dv_timings_cap adv7604_timings_cap_analog = {
 	.type = V4L2_DV_BT_656_1120,
 	/* keep this initialization for compatibility with GCC < 4.4.6 */
 	.reserved = { 0 },
-	V4L2_INIT_BT_TIMINGS(0, 1920, 0, 1200, 25000000, 170000000,
+	V4L2_INIT_BT_TIMINGS(640, 1920, 350, 1200, 25000000, 170000000,
 		V4L2_DV_BT_STD_CEA861 | V4L2_DV_BT_STD_DMT |
 			V4L2_DV_BT_STD_GTF | V4L2_DV_BT_STD_CVT,
 		V4L2_DV_BT_CAP_PROGRESSIVE | V4L2_DV_BT_CAP_REDUCED_BLANKING |
@@ -788,7 +788,7 @@ static const struct v4l2_dv_timings_cap adv76xx_timings_cap_digital = {
 	.type = V4L2_DV_BT_656_1120,
 	/* keep this initialization for compatibility with GCC < 4.4.6 */
 	.reserved = { 0 },
-	V4L2_INIT_BT_TIMINGS(0, 1920, 0, 1200, 25000000, 225000000,
+	V4L2_INIT_BT_TIMINGS(640, 1920, 350, 1200, 25000000, 225000000,
 		V4L2_DV_BT_STD_CEA861 | V4L2_DV_BT_STD_DMT |
 			V4L2_DV_BT_STD_GTF | V4L2_DV_BT_STD_CVT,
 		V4L2_DV_BT_CAP_PROGRESSIVE | V4L2_DV_BT_CAP_REDUCED_BLANKING |
diff --git a/drivers/media/i2c/adv7842.c b/drivers/media/i2c/adv7842.c
index 8c2a52e280af..cf3b42c9417e 100644
--- a/drivers/media/i2c/adv7842.c
+++ b/drivers/media/i2c/adv7842.c
@@ -676,7 +676,7 @@ static const struct v4l2_dv_timings_cap adv7842_timings_cap_analog = {
 	.type = V4L2_DV_BT_656_1120,
 	/* keep this initialization for compatibility with GCC < 4.4.6 */
 	.reserved = { 0 },
-	V4L2_INIT_BT_TIMINGS(0, 1920, 0, 1200, 25000000, 170000000,
+	V4L2_INIT_BT_TIMINGS(640, 1920, 350, 1200, 25000000, 170000000,
 		V4L2_DV_BT_STD_CEA861 | V4L2_DV_BT_STD_DMT |
 			V4L2_DV_BT_STD_GTF | V4L2_DV_BT_STD_CVT,
 		V4L2_DV_BT_CAP_PROGRESSIVE | V4L2_DV_BT_CAP_REDUCED_BLANKING |
@@ -687,7 +687,7 @@ static const struct v4l2_dv_timings_cap adv7842_timings_cap_digital = {
 	.type = V4L2_DV_BT_656_1120,
 	/* keep this initialization for compatibility with GCC < 4.4.6 */
 	.reserved = { 0 },
-	V4L2_INIT_BT_TIMINGS(0, 1920, 0, 1200, 25000000, 225000000,
+	V4L2_INIT_BT_TIMINGS(640, 1920, 350, 1200, 25000000, 225000000,
 		V4L2_DV_BT_STD_CEA861 | V4L2_DV_BT_STD_DMT |
 			V4L2_DV_BT_STD_GTF | V4L2_DV_BT_STD_CVT,
 		V4L2_DV_BT_CAP_PROGRESSIVE | V4L2_DV_BT_CAP_REDUCED_BLANKING |
diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index 0f572bff64f5..7ebcb9473956 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -66,7 +66,7 @@ static const struct v4l2_dv_timings_cap tc358743_timings_cap = {
 	/* keep this initialization for compatibility with GCC < 4.4.6 */
 	.reserved = { 0 },
 	/* Pixel clock from REF_01 p. 20. Min/max height/width are unknown */
-	V4L2_INIT_BT_TIMINGS(1, 10000, 1, 10000, 0, 165000000,
+	V4L2_INIT_BT_TIMINGS(640, 1920, 350, 1200, 13000000, 165000000,
 			V4L2_DV_BT_STD_CEA861 | V4L2_DV_BT_STD_DMT |
 			V4L2_DV_BT_STD_GTF | V4L2_DV_BT_STD_CVT,
 			V4L2_DV_BT_CAP_PROGRESSIVE |
diff --git a/drivers/media/i2c/ths8200.c b/drivers/media/i2c/ths8200.c
index 42340e364cea..e06e2de87f90 100644
--- a/drivers/media/i2c/ths8200.c
+++ b/drivers/media/i2c/ths8200.c
@@ -49,7 +49,7 @@ static const struct v4l2_dv_timings_cap ths8200_timings_cap = {
 	.type = V4L2_DV_BT_656_1120,
 	/* keep this initialization for compatibility with GCC < 4.4.6 */
 	.reserved = { 0 },
-	V4L2_INIT_BT_TIMINGS(0, 1920, 0, 1080, 25000000, 148500000,
+	V4L2_INIT_BT_TIMINGS(640, 1920, 350, 1080, 25000000, 148500000,
 		V4L2_DV_BT_STD_CEA861, V4L2_DV_BT_CAP_PROGRESSIVE)
 };
 
-- 
2.19.1



