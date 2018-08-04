Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4EEC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEAF21777
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3tc1dwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CEAF21777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbeHDC12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 22:27:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39934 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731986AbeHDC12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 22:27:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so4059010pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 17:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qw8IHGM/V3Ya7KcgKXAKGaDV+Bhj+ZJbxWNdtmMN10w=;
        b=h3tc1dwnVoThTVbBKkLFlpF5grqz18S4Jnf8dTFLQab8ZnOqmZz3maFueLF6C8VrQM
         57LHGjpUisEetVLZng3lWJHuimU0XfQHizgiGtTUnWX8bJWScw5PEc3fHntV5oDqnlgO
         GDPY1FhWlA3ueS3RrD25ajKHooQrWTQ1iYzpLDUM9vr08qZJfErIJlhBwTROPAq7H1vw
         Euvt2WBhil989IaKv16ZrfBRptxF9c7ugv8uyej1r/Oe4VmY0OA/CXgDEqWpwpgS0bRQ
         nSFVUdZdZS8edlZU/Ibh8+VOCtNbA0hgKE6X17fith5ySXsr5OtSFiFcStrs44fv+S/3
         5EgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qw8IHGM/V3Ya7KcgKXAKGaDV+Bhj+ZJbxWNdtmMN10w=;
        b=dzEM+bu+QNJZwIsGc0pL9DMPR7sX9m9IoccnADJczoasTbWi1GGPpAdIvTWMl/52/G
         pZqoPu3JMBtkW2/S5kEGt7/WQuzXLgnfGKvTQpKDCt/5zSGOgUutlUgs0xZTd6nO/U5y
         Yq1/oQWutxPe9AQ/O/nssh2gT6SpTZtCdjuRa+fcJ31Fo1h+Dq3W5HRJRnDjxbqQ2d5k
         FEMTSYEsc3JbAaMLq9XlM8tXrYLuDMv2PErTyWRl0QuZCfV3W7M1fLzN/UuF/YzY45sb
         wDYeCvDiBOfz4OB+O6rPbI3yENp0pAhMYxEdMCshU/mYzo/WXcIPuBALLqLt7iFlHP7U
         uaCg==
X-Gm-Message-State: AOUpUlEbUCHt87FAQTPbdOI620G9240crvKWdNENwiSjYOK3WP8Yhinx
        7CE9o63AbeVDZcK8vzUGP2fcWPW4
X-Google-Smtp-Source: AAOMgpcGE8r9xBQIL7LkY33xraDYCouuVlXLgMvXrM4+BoGtomEdbTdxTQubhekxu0Z2sU2o6w3rrg==
X-Received: by 2002:a63:d74f:: with SMTP id w15-v6mr5774971pgi.306.1533342534600;
        Fri, 03 Aug 2018 17:28:54 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:80c0:93b4:a4e2:6d2f])
        by smtp.gmail.com with ESMTPSA id p26-v6sm10110338pfi.183.2018.08.03.17.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 17:28:54 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     bskeggs@redhat.com, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: nouveau: nvkm: nv40: Replace mdelay() with msleep() in nv40_sensor_setup()
Date:   Sat,  4 Aug 2018 08:28:45 +0800
Message-Id: <20180804002845.18557-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nv40_sensor_setup() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv40.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv40.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv40.c
index 2c92ffb5f9d0..36c4b8865083 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv40.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv40.c
@@ -59,11 +59,11 @@ nv40_sensor_setup(struct nvkm_therm *therm)
 	if (style == NEW_STYLE) {
 		nvkm_mask(device, 0x15b8, 0x80000000, 0);
 		nvkm_wr32(device, 0x15b0, 0x80003fff);
-		mdelay(20); /* wait for the temperature to stabilize */
+		msleep(20); /* wait for the temperature to stabilize */
 		return nvkm_rd32(device, 0x15b4) & 0x3fff;
 	} else if (style == OLD_STYLE) {
 		nvkm_wr32(device, 0x15b0, 0xff);
-		mdelay(20); /* wait for the temperature to stabilize */
+		msleep(20); /* wait for the temperature to stabilize */
 		return nvkm_rd32(device, 0x15b4) & 0xff;
 	} else
 		return -ENODEV;
-- 
2.17.0

