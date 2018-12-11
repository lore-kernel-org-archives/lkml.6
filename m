Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB1BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EFC20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fiycD/LE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EFC20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeLKJNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:13:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34304 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeLKJNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:13:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id 17so6362875pgg.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LQZrLz1FZpjiBQ4p0of1aJNeNKSIKiMbtxR/pc+1xGM=;
        b=fiycD/LEo3SAOWUM2YGHQuxHMRV161UNsWkibPIwdp9QfQ+FQ72ihqYCn6v6WVakQH
         BvFtTYnv0iIplLmbG1v6J5p8wTbpFFXg/g1Q58FU1SoD8Zlv1xuOLty4CMq5B0eTeFqq
         szoVuHFb7us00ExwjhwwmhXxmva017sDc8DwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LQZrLz1FZpjiBQ4p0of1aJNeNKSIKiMbtxR/pc+1xGM=;
        b=cOIMW7lA15rYW0Uos55vxy8w88an3b+vKun2npb+j6qSB6bCQDbLXqi7v4Gc5NvGAw
         v8d9nV3JThoQAw4aeK113hd8jdxn6DcvPqwdB1/qWDGJSvaaIvI3GfCkvJqEBTdZeF0n
         IUANonTdhIDrEuGKtc5lvTK9xy6a87S0Rpeco4V8kuYdi8BkJ/FovQ/5iHjeiiUkcZRG
         V7DwVg+inzhSDjHVuwB1JEPkWigEE+iAy8zSMi019rg8IFwZ7L+qo6Z5aBtghAiLtGnX
         0VzxDbToBziUa1hGjL+8iXRdIENsKxkjy5RuoZFU8zCtgfliuu2p6ET/LK0xNrTbzG3y
         R7uw==
X-Gm-Message-State: AA+aEWY6WFdho0r9wPlM2sq20BlbWc/VUhAIUnAs345qu+9iZRn9EnxJ
        i1QTngsj3uBpxMPSEXvJACLj7w==
X-Google-Smtp-Source: AFSGD/XGjRWTfFqVH8pOkwDa2v6/7VYIKjGyvvD05M2AGCX9SWH+EWdirg7hwGOJvaqyeBAWn2s4Yw==
X-Received: by 2002:a65:6392:: with SMTP id h18mr14117649pgv.107.1544519599779;
        Tue, 11 Dec 2018 01:13:19 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id a90sm27202214pfj.109.2018.12.11.01.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Dec 2018 01:13:19 -0800 (PST)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V4 3/3] dt-bindings: sdhci-omap: Add example for using external dma
Date:   Tue, 11 Dec 2018 17:12:52 +0800
Message-Id: <1544519572-21921-4-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544519572-21921-1-git-send-email-zhang.chunyan@linaro.org>
References: <1544519572-21921-1-git-send-email-zhang.chunyan@linaro.org>
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

