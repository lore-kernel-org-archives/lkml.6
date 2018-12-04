Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927A8C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF3320834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cfx/OrHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF3320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbeLDHYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:24:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43904 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeLDHYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:24:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so6958759pgk.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 23:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LQZrLz1FZpjiBQ4p0of1aJNeNKSIKiMbtxR/pc+1xGM=;
        b=Cfx/OrHJmJY/gni8I11JPMZQkB4joknXX6ZKDemahHhk+GQfa+yOJfssUtQSde+fre
         MEktSRcutu8WMz1obz0hVtjcds2Oh3i8HSvzw7Nrhh2k7JGhU8kXTidLeKrweDdjvyHK
         Pc5oYzWOgTpm9SU8aKwHvma8LNWy8w1gxNvp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LQZrLz1FZpjiBQ4p0of1aJNeNKSIKiMbtxR/pc+1xGM=;
        b=ERWnklzuJxrNulupWrDh+cYC6Tdjo8wNSOEHgz3KfgW2ntZRYjICbDOjTD3CwwC4oA
         5IweuaUs5RZY7wXGEVQOdqV+tylvNvooI6ZLjr9dFG8o9dV6YU+61w/z0lexMgcZZoCy
         iy0xOpMk/0dDYJRsYofsT9zJZ3PgY+mil831SW0ZnlfqC7kvgwLhZq7X4nZxS/FRPkQq
         9d5v3wpqSUtFBogIcwI+8xrwQoHyI3aa08/LlZOC8rMT1k2ojxUgpymNi60hM9Lmz/F5
         gp9Q54AHGeW2ARDBQXQp/e/LZGhgsa0ZNJc3vSrx5SVIstdx+v5UjaEyxGn6EokSX63S
         o9bQ==
X-Gm-Message-State: AA+aEWbBre5zx74sIKHiFGSr2WDqf2FzJyS5mOQlcSsyrsX0rAZ/SdXo
        Fdi3aCPbJfEHu/1LcPRTU3oq1A==
X-Google-Smtp-Source: AFSGD/UzvyBLHSOZg2yhAsD39/R5xgUP9v0cCSVEnAxu7wgXkuSSf1TpE25U+rwshDDfSlgVdr/XQw==
X-Received: by 2002:a62:ca05:: with SMTP id n5mr19039448pfg.154.1543908290262;
        Mon, 03 Dec 2018 23:24:50 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id g136sm22705943pfb.154.2018.12.03.23.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Dec 2018 23:24:49 -0800 (PST)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V3 3/3] dt-bindings: sdhci-omap: Add example for using external dma
Date:   Tue,  4 Dec 2018 15:24:30 +0800
Message-Id: <1543908270-13953-4-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543908270-13953-1-git-send-email-zhang.chunyan@linaro.org>
References: <1543908270-13953-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdhci-omap can support both external dma controller via dmaengine
framework as well as ADMA which standard SD host controller
provides.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
index 393848c..c73fd47 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
@@ -12,6 +12,11 @@ Required properties:
 		 "ddr_1_8v-rev11", "ddr_1_8v" or "ddr_3_3v", "hs200_1_8v-rev11",
 		 "hs200_1_8v",
 - pinctrl-<n> : Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
+- dmas:		List of DMA specifiers with the controller specific format as described
+		in the generic DMA client binding. A tx and rx specifier is required.
+- dma-names:	List of DMA request names. These strings correspond 1:1 with the
+		DMA specifiers listed in dmas. The string naming is to be "rx"
+		and "tx" for RX and TX DMA requests, respectively.
 
 Example:
 	mmc1: mmc@4809c000 {
@@ -20,4 +25,6 @@ Example:
 		ti,hwmods = "mmc1";
 		bus-width = <4>;
 		vmmc-supply = <&vmmc>; /* phandle to regulator node */
+		dmas = <&sdma 61 &sdma 62>;
+		dma-names = "tx", "rx";
 	};
-- 
2.7.4

