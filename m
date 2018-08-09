Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6156DC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180F121DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2CoElr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180F121DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbeHIO5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:57:38 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37006 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731399AbeHIO5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:57:37 -0400
Received: by mail-pl0-f68.google.com with SMTP id d5-v6so2513245pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 05:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MGYrx0uZNDgVFHPX1cqi8GQIfy0CW578H1zRnv2sLks=;
        b=O2CoElr2tyWllOC9VwoU7wUpp+y8qZRFuhoZv/TCXA0fNCE773DM9VV4fJZY5ZG0Y4
         TmwigVpo/QVrAgGgHszkG1skLqxWmjOXdOSyt4JLewtZQcKFHoXS7vlJG0UtfuFK23mj
         EGiHzD1Z47oYqeIFWnr4ygZN8aUhuV5tjO0uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MGYrx0uZNDgVFHPX1cqi8GQIfy0CW578H1zRnv2sLks=;
        b=V9bLJilfIaFEAw7MyI1OriALICF+iI8xuC3xnw3w1wAnphCu8PtyLCh9iD+ZkmxELS
         rhx1Ij0vY8mYvVOa1iycFQrARSdBci5p5Rf9U2Vwz5WBRmlU6VtR0pt0pH/jJN4kHJVM
         lKUqvZ4JszrpslkCJu14waa18aRXty9ab0aARsNrjHpmH7BGx0U71+PomsDUsa6HM6v2
         w5qc5uEN6sNMitN98kR1ozyUZRAWlN1ppdck8IYZR0w/6haTdC2Oq30Zih3PTrH6sekU
         bXInXP3sfFZiNszAaiQ9MKw7v4SI+9UpLJ4bCo8U2vP72ZhS6WQrCsRo/thUaxboaCVg
         M5Bg==
X-Gm-Message-State: AOUpUlEQM6GJu2aMDE/aZ7MgDsOtXDZCkgWe/QLmxzHT+QN5hYclnIDH
        ze1+Qwu2fjOjN5CsEQPvkDCH3IWU0Fk=
X-Google-Smtp-Source: AA+uWPwvZuz6w8Pf9SiG/wD2DOQDLubUtHxP6r1TPVLRsFDZFHpAiYR0yB+l2wuQL7cmXZAdEvxK+Q==
X-Received: by 2002:a17:902:7793:: with SMTP id o19-v6mr1975430pll.306.1533817975531;
        Thu, 09 Aug 2018 05:32:55 -0700 (PDT)
Received: from localhost ([45.113.251.134])
        by smtp.gmail.com with ESMTPSA id u69-v6sm8979964pgd.43.2018.08.09.05.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:32:54 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [PATCH v1 00/10] Another round of tsens cleanups
Date:   Thu,  9 Aug 2018 18:02:32 +0530
Message-Id: <cover.1533815718.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another series of tsens cleanups before we add interrupt support.
This applies on top of the earlier two series[1][2] that have already been
accepted for 4.19.

In this series, we have the following:
- splitup 8916 and 8974 register address spaces for SROT and TM
- cleanups: move to spdx, dead code removal, removal of id field
- Add support to map the SROT address space for DTs that list it separately
- Check if TSENS IP is enabled in firmware by querying the SROT space
- Add reg-names property to get more readable outputs in /proc/iomem
- Add myself as maintainer of tsens

Regards,
Amit

[1] https://lore.kernel.org/lkml/cover.1531895128.git.amit.kucheria@linaro.org/
[2] https://lore.kernel.org/lkml/cover.1532600791.git.amit.kucheria@linaro.org/


Amit Kucheria (10):
  arm/arm64: dts: msm8974/msm8916: thermal: Split address space into two
  dt-bindings: thermal: Fix a typo in documentation
  thermal: tsens: Add SPDX license identifiers
  thermal: tsens: Get rid of dead code
  thermal: tsens: Rename map field in order to add a second address map
  thermal: tsens: Add the SROT address map
  thermal: tsens: Check if the IP is correctly enabled by firmware
  thermal: tsens: Get rid of 'id' field
  arm64: dts: qcom: Add reg-names for all tsens nodes
  MAINTAINERS: Add entry for Qualcomm TSENS thermal drivers

 .../devicetree/bindings/thermal/thermal.txt   |  2 +-
 MAINTAINERS                                   |  7 +++
 arch/arm/boot/dts/qcom-msm8974.dtsi           |  7 ++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  7 ++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  2 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  2 +
 drivers/thermal/qcom/tsens-8916.c             | 11 +---
 drivers/thermal/qcom/tsens-8960.c             | 41 +++++-------
 drivers/thermal/qcom/tsens-8974.c             | 11 +---
 drivers/thermal/qcom/tsens-common.c           | 62 ++++++++++++-------
 drivers/thermal/qcom/tsens-v2.c               |  6 +-
 drivers/thermal/qcom/tsens.c                  | 21 +------
 drivers/thermal/qcom/tsens.h                  | 24 +++----
 13 files changed, 99 insertions(+), 104 deletions(-)

-- 
2.17.1

