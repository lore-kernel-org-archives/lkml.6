Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6364FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E75924001
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f5ooQJad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E75924001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933475AbeGFNIP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:08:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52370 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932995AbeGFNIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:08:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id w16-v6so14778686wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 06:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ftq1080aXc/JhiteENcbMRqIZL2weLRpnJHeOh+TPpo=;
        b=f5ooQJadafYSWjE6Fl3I2XvZB/H2WuZPFJMgvw7abXRrFNcxH4TK9CJmR/jg/YYigU
         Q8Na+zHl0fVER680wafm2bZbW/VEOepqNO1Gv7zoVIhKVDipHY9PbCcmQHs2llXRDivJ
         AUlVFMoCX2qZ5c2onW2OxjIdYW7tdvPgGCzns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ftq1080aXc/JhiteENcbMRqIZL2weLRpnJHeOh+TPpo=;
        b=DLiBOoXDSZLiEguRHF9cTjkew6Ba5pScfaq63q0+U2UBlNmMZsgUWAsjivUa+hBcsv
         RFxAZG/ZumWV+i8LO0mFm3E7MoKucHMN6qg8ZagDlvW2mlLVxDpyLU21ln7FkL6yZvzQ
         NL4mbJZOf9p3cTK/CJwkqoVeIWvNRWGMwTQetUMTVxJFo1Pje3ANkas1BIZBmPoz1lyB
         mkZX11V2nehzUl5Aq1ljj8gujSSbX4Dzw1853OEzr2O9TBtkpu/ye4V433gaq6yA5T1a
         sMUq2pDmiC/c/FEQybYqPng49hM2gBs/7F5nfyWlRNDOiu5W6ZL/ivxk11G1S1fuoBJm
         bbVw==
X-Gm-Message-State: APt69E0aOZVnU2hTNdn6L7wZw3saMHroVEQ+hqgn1mSTdS1aaFFtjzu9
        33v4/YMUZ+b5qZdB6fJ1kunz3g==
X-Google-Smtp-Source: AAOMgpfgVHPDRGuy19PyrLaibJAgfk2A+YXVBXcVermlk3qhxcwubwcUX+6rezyRn6Xwb9xup2G62g==
X-Received: by 2002:a1c:d812:: with SMTP id p18-v6mr6910776wmg.92.1530882492535;
        Fri, 06 Jul 2018 06:08:12 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([80.214.65.221])
        by smtp.gmail.com with ESMTPSA id l17-v6sm14266704wrh.45.2018.07.06.06.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jul 2018 06:08:12 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] watchdog: stm32: replace "%p" with "%pK"
Date:   Fri,  6 Jul 2018 15:08:08 +0200
Message-Id: <20180706130808.22466-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The format specifier "%p" can leak kernel addresses.
Use "%pK" instead.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/watchdog/stm32_iwdg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index c97ad5619cb0..740f74a98644 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -172,7 +172,7 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-		dev_err(&pdev->dev, "Unable to prepare clock %p\n", clk);
+		dev_err(&pdev->dev, "Unable to prepare clock %pK\n", clk);
 		return ret;
 	}
 
-- 
2.15.0

