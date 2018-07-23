Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7028CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277C720854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fGSZrT35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277C720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbeGWW5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:57:46 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42923 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388195AbeGWW5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:57:46 -0400
Received: by mail-pl0-f67.google.com with SMTP id z7-v6so778581plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yHjcMeWjIXb+XNJ7Y0tJv9fLmrvdbb1BsOBg+XyW09U=;
        b=fGSZrT35m1YvmilAJMwfdm18VyIXvYm0+7SwdWFni/CDUQW1iebdDboiKisX+31q/2
         CEihUxXmw2WiHaSkfpDvrw5hRDHyhX2ZeN31Frg+BJOJ2s0dIubAiKGs9dLzoL87NgRf
         GLwfcHrFwXcRpV5ep8KL/jdGfhBbCiKlV/VcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yHjcMeWjIXb+XNJ7Y0tJv9fLmrvdbb1BsOBg+XyW09U=;
        b=NDIj4nDGEgzpZjAxh9X6zHE4eaTLbMeDDYU+UIGLz9gDJQnzuMUwrlW+RjCVL3yJva
         wzMfmRL33G+qpW+rOiDlf1bSAWycyIBxXDOhPDEgrgDFytU+LZr1bBe1tOwIgmJNPPFh
         TgGpDoXv1OauGL89iextzgq8MmzQajZXy1pJF6BYdkNiwuoy2N+nXwKPEonPMxeUvdes
         nertyBCZtNLxK7Efk2QDiILUuKFo1OcTlF979tnFM+6pJfvCjYALed7/pqEI8C1bE6xK
         Z36SjBIr5bZs6MGjz1yA4cfge6IS2KIrOE8xJjOh//dPHKYPcKem2AnByR5qFt0UOyEy
         O8Nw==
X-Gm-Message-State: AOUpUlGITRznjmb4V7idOeWFC/S6KI2O5Rc7g/eb5z3O0QNylN1pm1ze
        tK3q3XexzkHyfHtDHOOSILoTHQ==
X-Google-Smtp-Source: AAOMgpdzxpsPjE6bzuhBa0n5uydEndT1O/SJ8aGn3fIEWDw3T/Wp5wkWukHoeIk8b8gJeBEzVK83Yg==
X-Received: by 2002:a17:902:8a92:: with SMTP id p18-v6mr14582690plo.148.1532382873008;
        Mon, 23 Jul 2018 14:54:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id n26-v6sm5927629pgv.78.2018.07.23.14.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 14:54:32 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     sboyd@kernel.org, andy.gross@linaro.org
Cc:     tdas@codeaurora.org, grahamr@codeaurora.org,
        girishm@codeaurora.org, anischal@codeaurora.org,
        bjorn.andersson@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 1/2] clk: qcom: Add qspi (Quad SPI) clock defines for sdm845 to header
Date:   Mon, 23 Jul 2018 14:54:03 -0700
Message-Id: <20180723215404.74296-2-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180723215404.74296-1-dianders@chromium.org>
References: <20180723215404.74296-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These clocks will need to be defined in the clock driver and
referenced in device tree files.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

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

