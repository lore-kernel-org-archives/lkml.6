Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B6FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984832080D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU1XEht9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984832080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ribalda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeKJBGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:06:55 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40953 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbeKJBGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:06:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id v5so1602352lfe.7;
        Fri, 09 Nov 2018 07:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cw0AdYQQybMv3cci9V3jxy6lDeZ8NKyGR4FtNOpoFAk=;
        b=EU1XEht9h0EhbfOutL2rK+HJ3+ZEDCI1sUyYtR41m2/vOCr0NO6wPVBM1REFhc+VoV
         29cAtRNeTxVw84OL2gelaRl6MGVcO8IJc7AhpTNhytT6/3rEIDvxZ1wjGjbopA7KKkEj
         ZpNbA6AB8RaK53K+2JkI0On4VGQRKfmFOetMQ2Ldbk/5HOt7sCJ9piUWBuS4hspc1X+P
         umOKGTWrfqkSkXqn+BTvIuL3NeJZ7U9nRhNf13fp1m+GR38AP6IUxghvG9LTIAhwe1wU
         kUUfGZhusoUNbnSRW6zU3emzE9BiaKPKBy+Co/EDeTubh3bHGeMp882zcl9w7ko1FxSq
         Ix+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=cw0AdYQQybMv3cci9V3jxy6lDeZ8NKyGR4FtNOpoFAk=;
        b=NLhPPnsYrqxvByWFuoNObnjLx1ejiN8pSa1Qb+hMJ+iAResJVOzrzjbwOGBocLKB2U
         6CdwZXuDnQJhkDfCGWufD+k2Aqj0WxlhrW673SGvgpe5DAh9MGjgFvt1FNfYDtuNVqBN
         MjsWZIMiTprurBkBw/v+gTNM+4dNA+0HknrQu481dVt7Q6eanzWKyyZe2SlDF0DficXx
         8+bj6Z/zze5oKz0pcXjuM8jxVokK4Zp+2YYgcU61ajOmxPtoQGur/69uWGLStMLlKdXG
         OV70uVGcps1gJ0R8j0APe5GHR9N0gzhLTYsPZhSfUu+KQgMh2k1bmrbYaoOxu6oePq6q
         XnYA==
X-Gm-Message-State: AGRZ1gJPOmM1xKL/30k+Jxu8MqKqxpC/Aqfj/S8GTqIyoV+7mCeaizG3
        T0RxMnuNaOUX76rbBStQuoP5HlU7Rk4=
X-Google-Smtp-Source: AJdET5d9iHaQllD6T/j+KsC0M8qoHbJddX+PWcz8/dI4i97clji9QkDvuwKQWKqGOT7DA1kryHkMEg==
X-Received: by 2002:a19:5186:: with SMTP id g6mr5531255lfl.143.1541777150555;
        Fri, 09 Nov 2018 07:25:50 -0800 (PST)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id m1sm1336696lfb.56.2018.11.09.07.25.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 07:25:49 -0800 (PST)
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
Subject: [PATCH] media: doc-rst: Fix broken references
Date:   Fri,  9 Nov 2018 16:25:41 +0100
Message-Id: <20181109152541.8972-1-ricardo@ribalda.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation and code was linking the old documentation at:
http://v4l2spec.bytesex.org/spec/x1904.htm

Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
---
 Documentation/media/v4l-drivers/sh_mobile_ceu_camera.rst | 2 +-
 drivers/media/platform/sh_vou.c                          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/media/v4l-drivers/sh_mobile_ceu_camera.rst b/Documentation/media/v4l-drivers/sh_mobile_ceu_camera.rst
index e40ffea7708c..9b1e1c5a23f0 100644
--- a/Documentation/media/v4l-drivers/sh_mobile_ceu_camera.rst
+++ b/Documentation/media/v4l-drivers/sh_mobile_ceu_camera.rst
@@ -114,7 +114,7 @@ window:
 S_CROP
 ------
 
-The API at http://v4l2spec.bytesex.org/spec/x1904.htm says:
+The :ref:`V4L2 crop API <crop-scale>` says:
 
 "...specification does not define an origin or units. However by convention
 drivers should horizontally count unscaled samples relative to 0H."
diff --git a/drivers/media/platform/sh_vou.c b/drivers/media/platform/sh_vou.c
index cee58b125548..5799aa4b9323 100644
--- a/drivers/media/platform/sh_vou.c
+++ b/drivers/media/platform/sh_vou.c
@@ -1007,7 +1007,7 @@ static int sh_vou_s_selection(struct file *file, void *fh,
 
 	/*
 	 * No down-scaling. According to the API, current call has precedence:
-	 * http://v4l2spec.bytesex.org/spec/x1904.htm#AEN1954 paragraph two.
+	 * https://linuxtv.org/downloads/v4l-dvb-apis/uapi/v4l/crop.html#cropping-structures
 	 */
 	vou_adjust_input(&geo, vou_dev->std);
 
-- 
2.19.1

