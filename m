Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C262C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FA72145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRw4ZF3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FA72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeJIBp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbeJIBpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:45:55 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 737502087D;
        Mon,  8 Oct 2018 18:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023573;
        bh=8mGZehM15BNl1Au521wrOx+8SghNECH4F3OGzkPqWRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRw4ZF3JqATmPjIYF9w9UMPdyJivvrpthImoK3dprBIBYupWSaZiaqjBaGdbVn3wK
         KcfHVRO+bNuOyOUHl8rzgfkARKoOR+Tu7r5xGVTKmdo6Y9CySgDMfPXpFU8///xbSC
         pvB/gxGhQIBY9lkdTVcdl0wOozfzw56g2thea6BI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 012/113] media: exynos4-is: Prevent NULL pointer dereference in __isp_video_try_fmt()
Date:   Mon,  8 Oct 2018 20:30:13 +0200
Message-Id: <20181008175531.449874734@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

[ Upstream commit 7c1b9a5aeed91bef98988ac0fcf38c8c1f4f9a3a ]

This patch fixes potential NULL pointer dereference as indicated
by the following static checker warning:

drivers/media/platform/exynos4-is/fimc-isp-video.c:408 isp_video_try_fmt_mplane()
error: NULL dereference inside function '__isp_video_try_fmt(isp, &f->fmt.pix_mp, (0))()'.

Fixes: 34947b8aebe3: ("[media] exynos4-is: Add the FIMC-IS ISP capture DMA driver")

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/exynos4-is/fimc-isp-video.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/media/platform/exynos4-is/fimc-isp-video.c
+++ b/drivers/media/platform/exynos4-is/fimc-isp-video.c
@@ -391,12 +391,17 @@ static void __isp_video_try_fmt(struct f
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


