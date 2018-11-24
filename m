Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E34C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EC92086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d0ARx8A+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EC92086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbeKXV6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 16:58:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41712 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeKXV6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 16:58:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so4389982pfi.8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 03:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4mgb/onAr98Zp+HQOGZfPEtTRj6NtMnv3HBwE0KuWAw=;
        b=d0ARx8A+WX1e42Uh5lWN7otbm+NH7eyQ0Bda1t74BSmfXhYUvUOXIyTqd1PwMdgg4P
         HcyhE8YNV0z70pZQ87kuNzN1sf7522YuFRHQ0HaAgHvghFrQKmr28SCAw5OX320XQ+G5
         a/8HdGj+6+KmFVH7jaB9SRMIo1jA8CNSiQwoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4mgb/onAr98Zp+HQOGZfPEtTRj6NtMnv3HBwE0KuWAw=;
        b=sObl6RFnDIva0EGJoKNIXeI9Llajf1vYJvqR0N+XJ/rkLgOp7cz92ogGkS8SyMBxQ4
         RZVpxA5n+FWPNGC7iYQckT5cyp4b3G/uOZhAKcQzn+Sa16OO86GmTkSNgLM4M9JzHl+5
         7O7tjl70WsQXhJgkMQUYXSfm90DX1V9jH7/NNVgbzva3jVm09zXS0t2QCc1ZXIZeZZBC
         Rs8lm5RflPEyb5HOH1i0EvETCV5aS62o45aJ2M1mr76Mlw2T5OM5pF+OKlZYCspeIIA/
         vArcKlzaVgodbnO25ndwjrlZ2CjiBf12ULt2f/HejffML6BXyTSvNojz+E4wi4e1boPN
         mSsA==
X-Gm-Message-State: AGRZ1gLs+NpR+7pBLPrZyayt3AgO6W08XxRyet67HBcuhV/WG+7YbohR
        uE1LSsbRfdrdORmC6JVCpCEVSjbDAfg=
X-Google-Smtp-Source: AFSGD/XBpOsg7FAeqnnTg4Umo0/e1Ur0FQOQnxyH+zoJG7ylKD0blCzEdRCXXg0yKIkLHUoWTLl+Gg==
X-Received: by 2002:a63:3d03:: with SMTP id k3mr17504778pga.191.1543057827561;
        Sat, 24 Nov 2018 03:10:27 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id v124-v6sm25098580pfb.182.2018.11.24.03.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 03:10:26 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, oder_chiou@realtek.com,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 4/4] ASoC: qcom: Kconfig: select config for codec
Date:   Sat, 24 Nov 2018 19:09:48 +0800
Message-Id: <20181124110948.209019-4-cychiang@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181124110948.209019-1-cychiang@chromium.org>
References: <20181124110948.209019-1-cychiang@chromium.org>
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

