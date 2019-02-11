Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872A6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512FC20675
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895527;
	bh=vDx21TKmpDy7Zlhu78bfDT2cMm98FW2guYuOuI8cYf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JrBSTO6SHUFxfXt4X75qzZ7Qm7/4QL4S3y0TzGcKfmj/UGgHRhvVMyfl9tzNvsw+Q
	 GWJVNGsdfOdq57hmlnv4ayk4H1VtLT/zPHuwyn94Pb8OajSy3fOsngOJhMSHL+hQNQ
	 NrRVMSgPp5JvDIr3zBe06tz4SjN8RANrSDTDneX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbfBKOcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:32:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:39222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730410AbfBKOcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:32:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6473120675;
        Mon, 11 Feb 2019 14:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895521;
        bh=vDx21TKmpDy7Zlhu78bfDT2cMm98FW2guYuOuI8cYf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=URQcOQHXB4kPom48cU2bEXZfQnzxCdEwHnhFOjSegLAsJen+3anoJMb0QHN5zUz9I
         oi4xlUbU4/LVRKb7xv/Oi/tUZgXxWaRxVDx7ahguBbYwz+OPRzfNTuGX6PqjxBPNCD
         0Pbfz3de9SLVt4l8oGPsa4Lm/Y6Vk8/42ZjoAqTc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Alexander Shiyan <shc_work@mail.ru>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 232/352] video: clps711x-fb: release disp device node in probe()
Date:   Mon, 11 Feb 2019 15:17:39 +0100
Message-Id: <20190211141901.970850703@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit fdac751355cd76e049f628afe6acb8ff4b1399f7 ]

clps711x_fb_probe() increments refcnt of disp device node by
of_parse_phandle() and leaves it undecremented on both
successful and error paths.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/clps711x-fb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clps711x-fb.c
index ff561073ee4e..42f909618f04 100644
--- a/drivers/video/fbdev/clps711x-fb.c
+++ b/drivers/video/fbdev/clps711x-fb.c
@@ -287,14 +287,17 @@ static int clps711x_fb_probe(struct platform_device *pdev)
 	}
 
 	ret = of_get_fb_videomode(disp, &cfb->mode, OF_USE_NATIVE_MODE);
-	if (ret)
+	if (ret) {
+		of_node_put(disp);
 		goto out_fb_release;
+	}
 
 	of_property_read_u32(disp, "ac-prescale", &cfb->ac_prescale);
 	cfb->cmap_invert = of_property_read_bool(disp, "cmap-invert");
 
 	ret = of_property_read_u32(disp, "bits-per-pixel",
 				   &info->var.bits_per_pixel);
+	of_node_put(disp);
 	if (ret)
 		goto out_fb_release;
 
-- 
2.19.1



