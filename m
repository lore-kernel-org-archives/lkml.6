Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5809C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DB1218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF8Zf8Vw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbeLZVFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 16:05:14 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41037 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbeLZVEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 16:04:41 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so11513480lfj.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 13:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VdeDdyogVLBFon8h3UNQyuscXKoXRi/BGyhqSDbu6NQ=;
        b=LF8Zf8VwIWq/biHm1hKaclJK9mjHARbyZ2Bt8MlWAhdmCN7R3TUpUF/cDE/FdGJ27Z
         zIyOPk3T77ccaK6GydnfZTPOoWKocqAQ3Mjce1ls/7m78AwmFnd9vgl2B5Fb+1lkxLAQ
         v2vrdGhywZSrguF3kEEKZRmYkLVdM3j/EnSXM1XhLsi4yMxBD0oTHxtz7S3j9VhVAfZN
         dmKtu1dchzvqqe0Ht3S/MipwMusA/1L5R04YaXOxNLYKySeIdDDeaoUt3kx85r79qqrp
         fPAh6BHEoQ3LFxCvYlfMzb4tg4l5Nj73VLuTiMltylmvAYle472vEDBvq9tjGf49G6Qf
         LQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=VdeDdyogVLBFon8h3UNQyuscXKoXRi/BGyhqSDbu6NQ=;
        b=g1yhJ/B//1II3Z6BL4BT9rZ7NVOsmo5Wb8Pp+Hv9Obe7ial/C5Hk41AuSRyUNBRLL4
         H0Ln+55ZFh58xM23/qD3h6HCPDlpy0Qc5sjuvp3gtO9W6gyERwLb/+zEx9jjdVe/EPcL
         1i//7N5QEMH9kT2/YU30rUP/lyMN7ygrWPckbtXKNXVomVVbhe++Aazv3SrOiYQS9kdU
         1xTfJ13WoEUdIqe2HVFDvGpvVuTWwTB1Cul9XUAlgwjNqMebHZ61gNsmTXVbJ92v98lj
         wzoVibulj2H+3HzlR8Qys0NVTYr/jvzTWk5HB6VUkrKMvGO5cLTtNcJTs/lZrFApY23U
         /5RA==
X-Gm-Message-State: AA+aEWaDQBicH6eDhw7dEw4zU1L/xnWIQen0mJEKe6+LbfhIzDoEJbyV
        2rJrkdZtdprdzKabJdOUuMo=
X-Google-Smtp-Source: AFSGD/Uok1jRpIBLuRQYsNiCvC1/7Uy90f9ghNbNvyrmqROb9+zPzQVZu8GieUZIv2vernj0rn2C+Q==
X-Received: by 2002:a19:980f:: with SMTP id a15mr11334427lfe.103.1545858280122;
        Wed, 26 Dec 2018 13:04:40 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id g70-v6sm7768124ljg.92.2018.12.26.13.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 13:04:39 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 5/7] drm: remove include of drmP.h from drm_encoder_slave.h
Date:   Wed, 26 Dec 2018 22:03:51 +0100
Message-Id: <20181226210353.13993-5-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20181226210215.GA27610@ravnborg.org>
References: <20181226210215.GA27610@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No further changes required.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 include/drm/drm_encoder_slave.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/drm/drm_encoder_slave.h b/include/drm/drm_encoder_slave.h
index 1107b4b1c599..a09864f6d684 100644
--- a/include/drm/drm_encoder_slave.h
+++ b/include/drm/drm_encoder_slave.h
@@ -27,7 +27,6 @@
 #ifndef __DRM_ENCODER_SLAVE_H__
 #define __DRM_ENCODER_SLAVE_H__
 
-#include <drm/drmP.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_encoder.h>
 
-- 
2.12.0

