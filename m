Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC7FC32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672EE2082A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="juK4sSuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672EE2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbeKEMek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 07:34:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37500 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbeKEMek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 07:34:40 -0500
Received: by mail-pg1-f193.google.com with SMTP id c10-v6so3538812pgq.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 19:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MHt2HL1hPxLUZSU8tjk/yq874I7NV4UEGg3K2dqYbuQ=;
        b=juK4sSuciGH3p7UyCKmk/sHoO1J/IiWYZbwQfBYDWg/eZVH3viQ6O6QnMJ3R+jKcpG
         vH4ZqO4q0mrMlhqiDAy1JaLbeC9AISX9kQAjKe/pp7WB/CaqQCgS6PngvtcOYLNWLacp
         QVEUg2kzbiRD/QSTdF8bSFtvq/AGe16kdLzuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MHt2HL1hPxLUZSU8tjk/yq874I7NV4UEGg3K2dqYbuQ=;
        b=BhBANiJLNn/Lor3haLyVwrqG0WIQkzdbM98I9OdyMKhJLeGTcVvMSdeScXor3Tw/GR
         nDXPvoqQw4DFNKo49uiWRguASfYuAEOngcKj2Y25zVeNL1LCp9ORuVT5GGo5aUjOyE1y
         q9hVSyQxWjp6WTtEx5jGOWC9GQFPcBjOMq1XmUYswhLyStOnkd5KOqW+7VeQgg93miKA
         MdVB+P6ixv5IcWgbNaiXXyecleS7/eqlkwS6xoAhL3MAB4pAhgXnGryArdhVEDk+KRTF
         iXNnriewR5ikBPh4910Pl04Sf5KQaxbkRhk+ZoOyjSmphHTJMAq6pfXaXY6xLQOUcauR
         9VIg==
X-Gm-Message-State: AGRZ1gLLE7EDErGgh/yY05AsJBPxTkEGUklb3NyWMJLRvWHVlL6uZQny
        kpcN4NFaTkR/R+OdvJFSegwIw4qF8MNudw==
X-Google-Smtp-Source: AJdET5dlRsdvkPkjUWj6YEWtrhlqOU6vbQaVvURWfABWwImtHKSrnG9Ub3j//hH5sX+bNj/g6ZYjaw==
X-Received: by 2002:a65:610e:: with SMTP id z14-v6mr18683200pgu.138.1541387831678;
        Sun, 04 Nov 2018 19:17:11 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id f10-v6sm40182773pgp.72.2018.11.04.19.17.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Nov 2018 19:17:10 -0800 (PST)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH RFC 3/3] dt-bindings: sdhci-omap: Add example for using dmaengine
Date:   Mon,  5 Nov 2018 11:16:50 +0800
Message-Id: <1541387810-24867-4-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541387810-24867-1-git-send-email-zhang.chunyan@linaro.org>
References: <1541387810-24867-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdhci-omap can support both external dma controllers via dmaengine
framework as well as ADMA in which the controller acts as DMA master.

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

