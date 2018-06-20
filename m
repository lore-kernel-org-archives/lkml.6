Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDF7C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E2820883
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UEAtzkKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E2820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754672AbeFTS0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:26:51 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42388 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbeFTS0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:26:50 -0400
Received: by mail-pg0-f65.google.com with SMTP id c10-v6so195142pgu.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 11:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=KXKGqRAvoURXRmZZE/dyZtiU2AEYNgmdjV7lghU2Gkg=;
        b=UEAtzkKsi5xZQxS/cFfjFMhIH9ronPekzZeVBMeW5gXW4NzXZC+97pJHFAw6PqVr7z
         kNUf6dMjcnbhUK/NHf1gTKMDkw9ZE8CdAmO12c02I29zW1KHrRDVQSuVeEEmwFIr/x7G
         NNJ0rK1jisWycbmC/g/u3B49GwL03xtzl3M0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KXKGqRAvoURXRmZZE/dyZtiU2AEYNgmdjV7lghU2Gkg=;
        b=bPrPexglBtJYnd635ntstc5SVuXR7Medcy8XGhoiHzW7Hp8x3Et4PTbnX21IuprZZL
         MXFDrsb5UES6LyZCWSY263TSvOm1ZLqKSAq2bWEyzUuyWIwEZ7c8Hk8vf+Dd/h4kBGFZ
         2+kJ+GYPdjBAw4aXUwVxpPO+qChogsR3HmtGAp4RHj9jiH+iFu80HgA2tSCpUx3Cz10Y
         WOc8ZaU/8BvGLvYnsJDGxBhKVegph9fZALVBdw55uGr/apuVuGabWogdedVpqMDZwySb
         hp2I2pBNEXyWywXDVpHidyyqY4pTW1H8C+WsFEu5ttqzsKdnImidFjJFy30XDuM1dl6l
         tMvw==
X-Gm-Message-State: APt69E3dSV9F/AF7rc/cDGfBDznvtNfYtphXgWA7zjpF3TsKR9tE1UdT
        EN54o1NN2cckXqVpz/mD6BlsVw==
X-Google-Smtp-Source: ADUXVKILrhNm93BNhf8nvrx3HnGLdCREhE4JnWeAVZgg95sv73mcXg1O8HSOc4HvpNmkhXq3td+3Kg==
X-Received: by 2002:a62:ec5b:: with SMTP id k88-v6mr23504882pfh.85.1529519209787;
        Wed, 20 Jun 2018 11:26:49 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h9-v6sm8494122pfj.77.2018.06.20.11.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 11:26:48 -0700 (PDT)
Date:   Wed, 20 Jun 2018 11:26:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/pm: Remove VLA usage
Message-ID: <20180620182647.GA24405@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
uses the maximum sane buffer size and removes copy/paste code.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 100 +++++++++++--------------
 1 file changed, 42 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index b455da487782..5eb98cde22ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -593,40 +593,59 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
 		return snprintf(buf, PAGE_SIZE, "\n");
 }
 
-static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t count)
+/*
+ * Worst case: 32 bits individually specified, in octal at 12 characters
+ * per line (+1 for \n).
+ */
+#define AMDGPU_MASK_BUF_MAX	(32 * 13)
+
+static ssize_t amdgpu_read_mask(const char *buf, size_t count, uint32_t *mask)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
 	int ret;
 	long level;
-	uint32_t mask = 0;
 	char *sub_str = NULL;
 	char *tmp;
-	char buf_cpy[count];
+	char buf_cpy[AMDGPU_MASK_BUF_MAX + 1];
 	const char delimiter[3] = {' ', '\n', '\0'};
+	size_t bytes;
 
-	memcpy(buf_cpy, buf, count+1);
+	*mask = 0;
+
+	bytes = min(count, sizeof(buf_cpy) - 1);
+	memcpy(buf_cpy, buf, bytes);
+	buf_cpy[bytes] = '\0';
 	tmp = buf_cpy;
 	while (tmp[0]) {
-		sub_str =  strsep(&tmp, delimiter);
+		sub_str = strsep(&tmp, delimiter);
 		if (strlen(sub_str)) {
 			ret = kstrtol(sub_str, 0, &level);
-
-			if (ret) {
-				count = -EINVAL;
-				goto fail;
-			}
-			mask |= 1 << level;
+			if (ret)
+				return -EINVAL;
+			*mask |= 1 << level;
 		} else
 			break;
 	}
+
+	return 0;
+}
+
+static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = ddev->dev_private;
+	int ret;
+	uint32_t mask = 0;
+
+	ret = amdgpu_read_mask(buf, count, &mask);
+	if (ret)
+		return ret;
+
 	if (adev->powerplay.pp_funcs->force_clock_level)
 		amdgpu_dpm_force_clock_level(adev, PP_SCLK, mask);
 
-fail:
 	return count;
 }
 
@@ -651,32 +670,15 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 	int ret;
-	long level;
 	uint32_t mask = 0;
-	char *sub_str = NULL;
-	char *tmp;
-	char buf_cpy[count];
-	const char delimiter[3] = {' ', '\n', '\0'};
 
-	memcpy(buf_cpy, buf, count+1);
-	tmp = buf_cpy;
-	while (tmp[0]) {
-		sub_str =  strsep(&tmp, delimiter);
-		if (strlen(sub_str)) {
-			ret = kstrtol(sub_str, 0, &level);
+	ret = amdgpu_read_mask(buf, count, &mask);
+	if (ret)
+		return ret;
 
-			if (ret) {
-				count = -EINVAL;
-				goto fail;
-			}
-			mask |= 1 << level;
-		} else
-			break;
-	}
 	if (adev->powerplay.pp_funcs->force_clock_level)
 		amdgpu_dpm_force_clock_level(adev, PP_MCLK, mask);
 
-fail:
 	return count;
 }
 
@@ -701,33 +703,15 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 	int ret;
-	long level;
 	uint32_t mask = 0;
-	char *sub_str = NULL;
-	char *tmp;
-	char buf_cpy[count];
-	const char delimiter[3] = {' ', '\n', '\0'};
-
-	memcpy(buf_cpy, buf, count+1);
-	tmp = buf_cpy;
 
-	while (tmp[0]) {
-		sub_str =  strsep(&tmp, delimiter);
-		if (strlen(sub_str)) {
-			ret = kstrtol(sub_str, 0, &level);
+	ret = amdgpu_read_mask(buf, count, &mask);
+	if (ret)
+		return ret;
 
-			if (ret) {
-				count = -EINVAL;
-				goto fail;
-			}
-			mask |= 1 << level;
-		} else
-			break;
-	}
 	if (adev->powerplay.pp_funcs->force_clock_level)
 		amdgpu_dpm_force_clock_level(adev, PP_PCIE, mask);
 
-fail:
 	return count;
 }
 
-- 
2.17.1


-- 
Kees Cook
Pixel Security
