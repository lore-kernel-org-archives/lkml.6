Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC77ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D89020850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fs/QrGeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D89020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeGRSo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:44:27 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38489 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeGRSo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:44:26 -0400
Received: by mail-pf0-f196.google.com with SMTP id v15-v6so2567863pff.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TqLlim3U/xp/T1ATc0cTr67A6AFXw3gP0Wz3kqwA4Kk=;
        b=fs/QrGeO4VsoZXGnu7E9tolylZg/6g4i53/7zvXOOfCifZ1YQ8dCawaWEXrgNkGH2y
         BzZORgDQZ8il7QEw6S2L/gNyKHjli9LqPuZHoqJCgazf2JATVNCCRx/LvcppZEa7pbYv
         JjHZvG7K/oGn6C1vyp6nFh1Mh9xIOBy3brOLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TqLlim3U/xp/T1ATc0cTr67A6AFXw3gP0Wz3kqwA4Kk=;
        b=QffJfWsOdXp/q7O44+enuu74a61JHkWJlwCx7EA594oS2caCHKtr0IPsEUyYzN4GwQ
         ebIlMP6owqakntyAjVHxrvx/skGvHqG+vJ3jTKvnRLxtCqvMgQeeSwiEJEKjt64zS0zp
         NURdy0ZnJTAkEd1FtchM8iyeR0103GhHYBulzS3PjYLxIzDTsybu8f+fXlh3XZopVZu9
         ucgZ59ycbSm62t9mj1/nuh6TaoxFjuCxdoJ9i9LmDq9Cobw0BYMQ22NoIs7PMnE+S1lT
         MGaqS9CBKv/uze3xOJfS/I2F7xwX5b7hSWR2VaYmNhtgS+MM7PTTa83emC3bGkrf/YF1
         nwHQ==
X-Gm-Message-State: AOUpUlG+p685mFsls20OK0B1qi31EzrPpB9rWHccz3WJLKeokWlmIBbL
        h5JwE6Bxto8XLQhiGBDK3nEQ4zKyhEI=
X-Google-Smtp-Source: AAOMgpeffqTrO6hT59oEyGjZ6g44kCfVQwlLJa/SlrOmlrouecMjinqYw+elSp4khcT9hXYZs1ZvNw==
X-Received: by 2002:a63:1a49:: with SMTP id a9-v6mr6884320pgm.423.1531937124401;
        Wed, 18 Jul 2018 11:05:24 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id f5-v6sm12818857pga.58.2018.07.18.11.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 11:05:23 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     sboyd@kernel.org, andy.gross@linaro.org
Cc:     tdas@codeaurora.org, girishm@codeaurora.org,
        anischal@codeaurora.org, bjorn.andersson@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH 1/2] clk: qcom: Add qspi (Quad SPI) clock defines for sdm845 to header
Date:   Wed, 18 Jul 2018 11:04:29 -0700
Message-Id: <20180718180431.48580-2-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180718180431.48580-1-dianders@chromium.org>
References: <20180718180431.48580-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These clocks will need to be defined in the clock driver and
referenced in device tree files.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

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

