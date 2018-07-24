Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E546ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAFE20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xe13MkQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAFE20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388518AbeGXSxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:53:18 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37939 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388422AbeGXSxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:53:17 -0400
Received: by mail-pl0-f68.google.com with SMTP id b1-v6so2085569pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tJ9dT91UDxLGVOSgSork0AZoNnUpxD+LreZR1rQyDUw=;
        b=Xe13MkQK//EYAUtbKsmCVHyAEWIgYiRuLi6TGcqtdChtNsWAYGLO+ee7jFzRArp69U
         /Pm5wJr4NSwn11m9yJdccwJ+yYYdQJb7BSkFDX5+h6BdsoaYuV6yyd52N9zyLUWOVXL3
         BpSXT70o6gJkXr792IBVo1k1PHlP5jf44yBsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tJ9dT91UDxLGVOSgSork0AZoNnUpxD+LreZR1rQyDUw=;
        b=OPKEp+adNUrvvc2NvSNxL6iPJ7r6ZEGXO1SA3vWJlJDmP4ttaLXnAkaIfMEMnWs7lr
         CI8XvDhcA43o8WGP/Zmd5qaXTExUq4swKh/nK3lyrZXtg+xLauYE/lA+40S5ZhM8d4gN
         qFW6q5zglcWr5f8BNc0rrfRadN6fXO0mR3EBAIPbqtnI5Lebr63P5ktOp3S6Cy8Bb+Zj
         3R7XXmRZX7PBNs8LnQ4Q9oVCbogTOEo+LKJXpbwK3buUSwXJ/zsUebPJbqG49xyA81N3
         pxZw7rvvvt1st9PoLe3QsV23+R4tXRB3F+h35a1Oi4RBi3eYe2Kd1hTUg/EzrsT7Kv7N
         7TKg==
X-Gm-Message-State: AOUpUlEkqTdmy9d1TRiwXOmN5UUq8jVHCMw7p1K0KL2hXEmcM8/LrC9s
        koGYMfHKy+D6N4KIKjM8DGcy+g==
X-Google-Smtp-Source: AAOMgpeEGFweG7X8KyZajrgRy3R1tQfvhvroMcWQDnpiIQ/89/IdH1y+bZTLxO01/nW1FmJCjqbTsw==
X-Received: by 2002:a17:902:530a:: with SMTP id b10-v6mr18197538pli.316.1532454342229;
        Tue, 24 Jul 2018 10:45:42 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id b62-v6sm34278653pfm.97.2018.07.24.10.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 10:45:41 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     sboyd@kernel.org, andy.gross@linaro.org
Cc:     tdas@codeaurora.org, girishm@codeaurora.org,
        linux-arm-msm@vger.kernel.org, anischal@codeaurora.org,
        bjorn.andersson@linaro.org, grahamr@codeaurora.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 1/2] clk: qcom: Add qspi (Quad SPI) clock defines for sdm845 to header
Date:   Tue, 24 Jul 2018 10:45:12 -0700
Message-Id: <20180724174513.174018-2-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180724174513.174018-1-dianders@chromium.org>
References: <20180724174513.174018-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These clocks will need to be defined in the clock driver and
referenced in device tree files.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3: None
Changes in v2: None

 include/dt-bindings/clock/qcom,gcc-sdm845.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-sdm845.h b/include/dt-bindings/clock/qcom,gcc-sdm845.h
index f96fc2dbf60e..b8eae5a76503 100644
--- a/include/dt-bindings/clock/qcom,gcc-sdm845.h
+++ b/include/dt-bindings/clock/qcom,gcc-sdm845.h
@@ -194,6 +194,9 @@
 #define GPLL4							184
 #define GCC_CPUSS_DVM_BUS_CLK					185
 #define GCC_CPUSS_GNOC_CLK					186
+#define GCC_QSPI_CORE_CLK_SRC					187
+#define GCC_QSPI_CORE_CLK					188
+#define GCC_QSPI_CNOC_PERIPH_AHB_CLK				189
 
 /* GCC Resets */
 #define GCC_MMSS_BCR						0
-- 
2.18.0.233.g985f88cf7e-goog

