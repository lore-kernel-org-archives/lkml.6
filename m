Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /3Q5CFBYGVu2fwAAmS7hNA
	; Thu, 07 Jun 2018 16:07:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3B3C06089E; Thu,  7 Jun 2018 16:07:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9E09F6074D;
	Thu,  7 Jun 2018 16:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E09F6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935894AbeFGQFK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:05:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39250 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933013AbeFGOJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:04 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0005Zp-AA; Thu, 07 Jun 2018 15:09:02 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb0-0002oE-Sd; Thu, 07 Jun 2018 15:08:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Sylwester Nawrocki" <s.nawrocki@samsung.com>,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        "Arnd Bergmann" <arnd@arndb.de>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.535439802@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 087/410] media: exynos4-is: properly initialize frame
 format
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 97913bcbe6da3957af27d9fdd76b3d97b99e6d6a upstream.

We copy the subdev frame format from a partially initialized
structure, which is not entirely well-defined. Older compilers
like gcc-4.4 can copy uninitialized stack data here and warn
about it:

drivers/media/platform/exynos4-is/fimc-isp.c: In function 'fimc_isp_subdev_open':
drivers/media/platform/exynos4-is/fimc-isp.c:379: error: 'fmt.reserved[10u]' may be used uninitialized in this function
drivers/media/platform/exynos4-is/fimc-isp.c:379: error: 'fmt.reserved[9u]' may be used uninitialized in this function
...
drivers/media/platform/exynos4-is/fimc-isp.c:379: error: 'fmt.reserved[0u]' may be used uninitialized in this function
drivers/media/platform/exynos4-is/fimc-isp.c:379: error: 'fmt.xfer_func' may be used uninitialized in this function

On newer compilers, only the initialized fields get copied, but
we should not rely on that, so this changes the code to zero-out
the remaining fields first.

Fixes: 9a761e436843 ("[media] exynos4-is: Add Exynos4x12 FIMC-IS driver")

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/platform/exynos4-is/fimc-isp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/media/platform/exynos4-is/fimc-isp.c
+++ b/drivers/media/platform/exynos4-is/fimc-isp.c
@@ -366,16 +366,16 @@ static int fimc_isp_subdev_s_power(struc
 static int fimc_isp_subdev_open(struct v4l2_subdev *sd,
 				struct v4l2_subdev_fh *fh)
 {
-	struct v4l2_mbus_framefmt fmt;
 	struct v4l2_mbus_framefmt *format;
+	struct v4l2_mbus_framefmt fmt = {
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.code = fimc_isp_formats[0].mbus_code,
+		.width = DEFAULT_PREVIEW_STILL_WIDTH + FIMC_ISP_CAC_MARGIN_WIDTH,
+		.height = DEFAULT_PREVIEW_STILL_HEIGHT + FIMC_ISP_CAC_MARGIN_HEIGHT,
+		.field = V4L2_FIELD_NONE,
+	};
 
 	format = v4l2_subdev_get_try_format(fh, FIMC_ISP_SD_PAD_SINK);
-
-	fmt.colorspace = V4L2_COLORSPACE_SRGB;
-	fmt.code = fimc_isp_formats[0].mbus_code;
-	fmt.width = DEFAULT_PREVIEW_STILL_WIDTH + FIMC_ISP_CAC_MARGIN_WIDTH;
-	fmt.height = DEFAULT_PREVIEW_STILL_HEIGHT + FIMC_ISP_CAC_MARGIN_HEIGHT;
-	fmt.field = V4L2_FIELD_NONE;
 	*format = fmt;
 
 	format = v4l2_subdev_get_try_format(fh, FIMC_ISP_SD_PAD_SRC_FIFO);
