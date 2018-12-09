Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58440C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CAE2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CAE2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeLIW0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:26:43 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34728 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbeLIVzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:12 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0002ih-LD; Sun, 09 Dec 2018 21:55:09 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Y-0003Dq-JE; Sun, 09 Dec 2018 21:55:06 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        "Sylwester Nawrocki" <s.nawrocki@samsung.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.95153042@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 022/328] media: exynos4-is: Prevent NULL pointer
 dereference in __isp_video_try_fmt()
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

commit 7c1b9a5aeed91bef98988ac0fcf38c8c1f4f9a3a upstream.

This patch fixes potential NULL pointer dereference as indicated
by the following static checker warning:

drivers/media/platform/exynos4-is/fimc-isp-video.c:408 isp_video_try_fmt_mplane()
error: NULL dereference inside function '__isp_video_try_fmt(isp, &f->fmt.pix_mp, (0))()'.

Fixes: 34947b8aebe3: ("[media] exynos4-is: Add the FIMC-IS ISP capture DMA driver")

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/platform/exynos4-is/fimc-isp-video.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/media/platform/exynos4-is/fimc-isp-video.c
+++ b/drivers/media/platform/exynos4-is/fimc-isp-video.c
@@ -390,12 +390,17 @@ static void __isp_video_try_fmt(struct f
 				struct v4l2_pix_format_mplane *pixm,
 				const struct fimc_fmt **fmt)
 {
-	*fmt = fimc_isp_find_format(&pixm->pixelformat, NULL, 2);
+	const struct fimc_fmt *__fmt;
+
+	__fmt = fimc_isp_find_format(&pixm->pixelformat, NULL, 2);
+
+	if (fmt)
+		*fmt = __fmt;
 
 	pixm->colorspace = V4L2_COLORSPACE_SRGB;
 	pixm->field = V4L2_FIELD_NONE;
-	pixm->num_planes = (*fmt)->memplanes;
-	pixm->pixelformat = (*fmt)->fourcc;
+	pixm->num_planes = __fmt->memplanes;
+	pixm->pixelformat = __fmt->fourcc;
 	/*
 	 * TODO: double check with the docmentation these width/height
 	 * constraints are correct.

