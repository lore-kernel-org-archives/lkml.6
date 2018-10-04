Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6182C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E0D21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sc/LtEY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E0D21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeJEBtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:49:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37403 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbeJEBtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:49:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id 185-v6so10094888wmt.2;
        Thu, 04 Oct 2018 11:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8MaU8NQFxEUE29tP9PrWB4sLEqL2BmIlI4makvn9aq4=;
        b=sc/LtEY27RUlvpSw/3y23lO7QeZlyKjsDLyJtbD6YC9q11e69qjFFA5Hh0wgbM3w4l
         brKeBPIOQufGG6P8n+sxjr9i5FPeqhJ7u21BuKkW2jsiHG1bawd+2mtpFws1KEXfPPsb
         jJ0rHXVIWC9tJG/HJlRxWlS52scStc6sJrbFtCAqKTPZnmOi7COfIuU2M/XVKcv63IWk
         1CSFB7Bw07fcbbrUVJKhbbDvKxt6TMFhQKz0E5HztjCcmQfpqoaLZGruu0ypIW/tbT0i
         L3n7mVY4TJ4+7v/VvLKpoUQNR1hQzIeOz+yttZKfN8rZyW8HjjbLh3apkTbq+N5o4MRy
         dFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8MaU8NQFxEUE29tP9PrWB4sLEqL2BmIlI4makvn9aq4=;
        b=kR/ocQMb3MEc+lmNYR1FblQOAnbb630azZQ9Kg8RTNiAgURP3826PuMK++n6OeSjhA
         mOa7SaXSwYhhsQ2R6b94dH7R+RsnuTC41RA4xucnpH1GnEebRceFQ+pjvwdMB6tpOmQB
         KCwDI0NyurwjSs7MU+i/i0kHPqUJy3rOaNEanTK57mrGNPYupyEyyA8Mw2TDtl73TK7/
         CoHkf2/MO12ntZABeQTUegIOSD96ZISg25Ljop8HCPkxNHbg1wJ9oDgU7z7gbl1y4i3j
         BANtPFZrDYhnXRGxyAxSxxY2KvhLOg0jCWrQGBHNaGglCISnaNJxabo2prhj8s8H90Ap
         LIJQ==
X-Gm-Message-State: ABuFfogOZ99kFv/mDrppsiWrUHDi9+AKjYTKvSTuoGsw31FM8ffUsxv/
        i+QcerM0xtyJunJ8/Fp/1cUCQ1WM
X-Google-Smtp-Source: ACcGV62PObjuzp7ZQ8PXr+x05/hq2vnnOkvamcKF+fi4SjvMEjriE8mIC2Eb/HjYY+ogVkjPWFN/ag==
X-Received: by 2002:a1c:3c4:: with SMTP id 187-v6mr5223630wmd.90.1538679270830;
        Thu, 04 Oct 2018 11:54:30 -0700 (PDT)
Received: from mappy.world.mentorg.com (nat-wv.mentorg.com. [192.94.38.34])
        by smtp.gmail.com with ESMTPSA id h78-v6sm8706877wmd.4.2018.10.04.11.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 11:54:30 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 07/11] media: imx-csi: Allow skipping odd chroma rows for YVU420
Date:   Thu,  4 Oct 2018 11:53:57 -0700
Message-Id: <20181004185401.15751-8-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004185401.15751-1-slongerbeam@gmail.com>
References: <20181004185401.15751-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip writing U/V components to odd rows for YVU420 in addition to
YUV420 and NV12.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/media/imx/imx-media-csi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 4b075bc949de..6dd53a8e35d2 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -452,6 +452,7 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 		passthrough_bits = 16;
 		break;
 	case V4L2_PIX_FMT_YUV420:
+	case V4L2_PIX_FMT_YVU420:
 	case V4L2_PIX_FMT_NV12:
 		burst_size = (image.pix.width & 0x3f) ?
 			     ((image.pix.width & 0x1f) ?
-- 
2.17.1

