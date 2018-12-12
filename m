Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479ECC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CF920839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bC5J8Cb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CF920839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeLLKSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:18:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52253 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeLLKSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:18:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so4521688wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 02:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5cPT9GpxXrgDMs3kw5IDizeavtp1cLxDs1ZTvdIZdz4=;
        b=bC5J8Cb/CQucoJwy3nYWtDtVnsvSvrifYaIhS1dLDnGFpVqL/Xpq8U8+HdeLSEqQkZ
         buGQucrJJmkzZh2gEclTLhfNg7kXCaHDQmVADNVB4B6pLuTg9y6gGEqH6zUvdOtTyss2
         ZQC+bT6P/batiWMnLymqHBc+cij6WYQ3YXeEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5cPT9GpxXrgDMs3kw5IDizeavtp1cLxDs1ZTvdIZdz4=;
        b=iek5F0tskN3IFyTSzrSiMyEUlD8sYR67ystAdRk7maojaksNk8lHI29HYM9DW9pjz+
         /pTG1p4ull08QEVm2bV32Zc5bCx5E3uWByop/zfw72IeFHsS31aH8BSCZcQjY7r+KOsf
         uX2QCf9DIcBaNONLN/liG5iR0PHsK1am9j8weGRm+jT9yLbFMTCOGe4DkLKGJxEVqAwT
         dSpeZ+oP6DxSy0LYR+gS106tOKHX6fUZ4Sl9ZM2pBUrhrkdDpIHwo4DGYoH5RjM1XjID
         O9viDDeULVaW9pruevV2wOJyhrPREKVi2z6709oTCCJ2e1koeiVfj6WdF9mIIm8PuQxT
         RFkA==
X-Gm-Message-State: AA+aEWajffPD2nvMcODkD7l099zEN3gyUbp1jYRtVwTMJBDuJT4Bv4+d
        bkBSKGz7td2kk/TiTvLT8ZBLUQoxRmE=
X-Google-Smtp-Source: AFSGD/UE8kG8OHJ8N2Z4IRtb/u/nc5vLhFfgVyupf1J0TIGrt149TfXziZHVlyLWL6DodLiM1KyC5Q==
X-Received: by 2002:a1c:a84f:: with SMTP id r76mr5826388wme.16.1544609882818;
        Wed, 12 Dec 2018 02:18:02 -0800 (PST)
Received: from localhost ([49.248.93.253])
        by smtp.gmail.com with ESMTPSA id n17sm2179384wmc.5.2018.12.12.02.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 02:18:02 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        andy.gross@linaro.org, mka@chromium.org,
        khasim.mohammed@linaro.org, devicetree@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
Subject: [PATCH v1 0/2] Expose thermal information for pms405 PMIC
Date:   Wed, 12 Dec 2018 15:47:53 +0530
Message-Id: <cover.1544599950.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the on-die temperature sensor on the pms405 PMIC through the
spmi-temp-alarm driver.

This series applies on top of the qcs404 DT series by Vinod[1]

[1] https://patchwork.kernel.org/cover/10675575/

Amit Kucheria (2):
  dt-bindings: iio: adc: Add binding for ADC on pms405 PMIC
  arm64: dts: pms405: Export PMIC temperature to thermal framework

 .../bindings/iio/adc/qcom,spmi-vadc.txt       |  1 +
 arch/arm64/boot/dts/qcom/pms405.dtsi          | 79 +++++++++++++++++++
 2 files changed, 80 insertions(+)

-- 
2.17.1

