Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002E4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A6B20989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FHZOP6yf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A6B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeK1UCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:02:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42077 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeK1UCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:02:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id x21-v6so17053800pln.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4mgb/onAr98Zp+HQOGZfPEtTRj6NtMnv3HBwE0KuWAw=;
        b=FHZOP6yfjv/1aN+klAGWOIfqI4ZZrKNlF/gncHnRxrapfezGDlW3eBfikbCz/Fy46a
         t1IwwF66dfkkFtFQqEx0k5xLMi4VUQgCb0jljIQxBFS7s+Oc4VMXJ+vulfZMCnN+eC9e
         VXJ/j18FlbceSIVFnYwwOx4pfotIkWIylzfTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4mgb/onAr98Zp+HQOGZfPEtTRj6NtMnv3HBwE0KuWAw=;
        b=cAUmquKYXxaZz6zyYUbBPHxm1fijMgbw+vk5a6g9JQg8TvtutCyHQi/5x/B+79iVoA
         L/HB+vuCqk+5e3Q9+qQ/IpW1Dstyx+6YQRTQPK7FbylkNHU075+L2C9PXFYfKXrbXrBo
         pnGmVjmDiYRQMotoDJVBuI8JbcQC2Gat49pzIeHXoazf/uRxNC3fz+YnzVT1XTyA2aGe
         kIL4ClbIhvcD+Zepkw50Kl9UTUbg4BTMCN5S6yLceoSP6aVqxFnQPd1iaG+kDFFpMUBI
         0KwmZrRsp+loetFNtQugGYpp/yE+lQPheGTqe6047+o0NJYF+7ic4LrRIdYvUoy/jJT9
         rcgw==
X-Gm-Message-State: AA+aEWbpfdPoQLoH8wAcGgplpJJlUAnDJ9VtGy+bEGYzboVeEfN5dqll
        FuLJq69WMMxdYorKMTTd/UrQ1Y7O3Sg=
X-Google-Smtp-Source: AFSGD/UdR8jr51W9aDnD0bPddU8RgUxUok8+X5uxCF3ab7j/GnwFSG9kf5f9hT3NtNiBMyknUmmXoA==
X-Received: by 2002:a17:902:728c:: with SMTP id d12mr20791215pll.284.1543395669427;
        Wed, 28 Nov 2018 01:01:09 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id i72sm11568607pfe.181.2018.11.28.01.01.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 01:01:08 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v2 5/5] ASoC: qcom: Kconfig: select config for codec
Date:   Wed, 28 Nov 2018 17:00:37 +0800
Message-Id: <20181128090037.257359-5-cychiang@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181128090037.257359-1-cychiang@chromium.org>
References: <20181128090037.257359-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select SND_SOC_RT5663 and SND_SOC_MAX98927 for SND_SOC_SDM845.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/qcom/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 2a4c912d1e484..3528c4279cbae 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -100,6 +100,8 @@ config SND_SOC_SDM845
 	depends on QCOM_APR
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
+	select SND_SOC_RT5663
+	select SND_SOC_MAX98927
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
 	  SDM845 SoC-based systems.
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

