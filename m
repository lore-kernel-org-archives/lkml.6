Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B6CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDA92087A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tyYMzBdN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDA92087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732751AbeKNXTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:19:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42098 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbeKNXTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:19:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id u5-v6so11963332wrn.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 05:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pgKVcQTS0Dv7S1Mc2VdYYbFDx3oeYWl2gIMRZsO6SZU=;
        b=tyYMzBdNX5cR36EE6Ssr7Rf0mFGRktykuDw4WKKZFBGppoL31FRPe5JEj9cr4aAMgL
         5YofpuCEK+mFP7Gbec5c2t4jA+GpuuKOctnaiV6HBhNs9IeTVOHc50DE/v3rFrm6ngWR
         hfdFlDvmIhgPKKFAU0ghXcQAz7qha4Y3MUvnXH1P9shZRQZcfGbxVYPVha6u5xuGS226
         4OYrTUMUaJe022D4xAOvrzEtJicqgRcGXbLivCBOYG4PZt8N65r3pQ9TCjeKVwcqMdbt
         hQuJqBVbBYBkDluK3k3kUwyUjlpnkSmTJC223uZShuUHpPoaj9FbGmcz6y+3+akVv5s3
         tRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pgKVcQTS0Dv7S1Mc2VdYYbFDx3oeYWl2gIMRZsO6SZU=;
        b=Bl9/aXkcr5v4Xu0fzlEBJ/KMCtC6xoY6UUojtmeU50/WNLCrr9AVVwz2Jd8EaIf7xd
         7D+NNFo5/lYRGtiVofVlOpcwaxAV0FxhtGs2Nfe4nnBmSiEc79VGN4OFXGjViwMAIteX
         eR4VHDL7fApBTVQGnzeDKXx3AtJNGoxDInB0Ly0CwdhnJtzhW0mmPmnDNTClsRmOMB2s
         72JcZ+i+kUygYW34OTGMS71dxGNc7nsuI3CSF9O57OEwcHddjZ/Q0RuPGdD7muVGSEQc
         vZtfmVK+cDz69ZgwJr4Ptn2xwpgzcc4xJWsh3EcyUamxW4wYQN6EixHq3KeT2rrowhJw
         iBVA==
X-Gm-Message-State: AGRZ1gKKhTxbPnjEZ7Sj8+uoNkBl2aFRu+XkVwhWPT7Jcuh4St1DBVkO
        mkqRg06NCO25RtWP+ugzi6nTtw==
X-Google-Smtp-Source: AJdET5cnSxLlH4PclEF/AfKHG6Khgq8cXN3ywZMP6uGg+MWK3EidmaKjSq9r7b5UAPsSldMUQBEGBA==
X-Received: by 2002:a5d:69ce:: with SMTP id s14-v6mr2035025wrw.177.1542201390632;
        Wed, 14 Nov 2018 05:16:30 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z7-v6sm22715225wrv.21.2018.11.14.05.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 05:16:30 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: amlogic: Add Internal Clock Measurer bindings
Date:   Wed, 14 Nov 2018 14:16:25 +0100
Message-Id: <20181114131627.17766-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114131627.17766-1-narmstrong@baylibre.com>
References: <20181114131627.17766-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
clock paths frequencies.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/soc/amlogic/clk-measure.txt          | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt

diff --git a/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
new file mode 100644
index 000000000000..ba9183a42032
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
@@ -0,0 +1,15 @@
+Amlogic Internal Clock Measurer
+===============================
+
+The Amlogic SoCs contains an IP to measure the internal clocks.
+The precision is multiple of MHz, useful to debug the clock states.
+
+Required properties:
+- compatible: Shall contain "amlogic,meson-gx-clk-measure"
+- reg: base address and size of the Clock Measurer register space.
+
+Example:
+	clock-measure@8758 {
+		compatible = "amlogic,meson-gx-clk-measure";
+		reg = <0x0 0x8758 0x0 0x10>;
+	};
-- 
2.19.1

