Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4F3F4C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B96208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ap5TyBb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B96208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755226AbeFNLND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:13:03 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41552 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755062AbeFNLMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:12:48 -0400
Received: by mail-lf0-f67.google.com with SMTP id d24-v6so8783234lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 04:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yo2Ap/RDsjAzMdg9ZpEHBe5MsaFSkeWR6QiB2zES2f0=;
        b=Ap5TyBb+OPsij6FmY9fNOZvSkDWVspRuwB1z0XWWx7oUsdEn3vnaCgNQ9AP47RU561
         Y4rKC7HKus2bly7eFolGUNX7xplDMptJl3Wk0enq+G+kDWQFh/Zl9YGQoUUNTYEr3qyg
         IIgD0exlgnyk5jyEt30/t09xlCcwkGcB/cjnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yo2Ap/RDsjAzMdg9ZpEHBe5MsaFSkeWR6QiB2zES2f0=;
        b=dGNGA/8D+6UR+Q2mOkxpdvwRyv7mPXtEYXKGI0B0mR7+2WK7bL6PwBMc8RAknfzwY5
         Ug+n7i2ej14++XLe46dZEQKSQUEV7QXvZ4IHgggz7GmFotN9iE+E6z9FLcxHbHVF5Qx3
         8M2msETQ4uBF8d8IvpgAIbNODvkgJb6mGeZaqZr9pyh6ZBIcZTjQcdKuzoGSepm2Y7iN
         i1HpNF6+Fnf4DFfN1pEA3/Ap23Dy9XC/GRnFWe0M8kfSD1WmMmsjS1yx4VDPP1p+0MWR
         GdWQMFHMkoLW9KRPulydNinqQ+ox7U3vKDLeyV/xdbMxms6trEtFps+iF+OPxwlWgQZL
         JXWA==
X-Gm-Message-State: APt69E0cORf7IfsHmujgEKAqdT86wwcCgJT6S3pwXgZSoLI0+kbp4kia
        7+22mhMNSSEX4b/FUlRJEyghtg==
X-Google-Smtp-Source: ADUXVKJ6UtzldJPP+k1Aa6jQfOY/YID3B3VOjfMNd/8qB5QBHhw3GQEyPoEAHDXGUGJ9jWM8C2L02w==
X-Received: by 2002:a19:8f1d:: with SMTP id r29-v6mr5965451lfd.88.1528974766790;
        Thu, 14 Jun 2018 04:12:46 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id y13-v6sm1030434lfk.37.2018.06.14.04.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 04:12:46 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     andy.gross@linaro.org, Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] ASoC: qdsp6: Add depends on OF
Date:   Thu, 14 Jun 2018 13:11:36 +0200
Message-Id: <20180614111138.8923-6-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614111138.8923-1-niklas.cassel@linaro.org>
References: <20180614111138.8923-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_platform_device_destroy is only defined when building
with CONFIG_OF=y. Add a depends on OF.

sound/soc/qcom/qdsp6/q6afe.o: In function `q6afe_remove':
q6afe.c:(.text+0x363): undefined reference to `of_platform_device_destroy'
sound/soc/qcom/qdsp6/q6adm.o: In function `q6adm_remove':
q6adm.c:(.text+0x216): undefined reference to `of_platform_device_destroy'
sound/soc/qcom/qdsp6/q6asm.o: In function `q6asm_remove':
q6asm.c:(.text+0x723): undefined reference to `of_platform_device_destroy'

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 sound/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 87838fa27997..3989ec856441 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -67,7 +67,7 @@ config SND_SOC_QDSP6_ASM_DAI
 
 config SND_SOC_QDSP6
 	tristate "SoC ALSA audio driver for QDSP6"
-	depends on QCOM_APR && HAS_DMA
+	depends on QCOM_APR && HAS_DMA && OF
 	select SND_SOC_QDSP6_COMMON
 	select SND_SOC_QDSP6_CORE
 	select SND_SOC_QDSP6_AFE
-- 
2.17.1

