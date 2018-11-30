Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E04C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F42B20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MK3iAAUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F42B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeK3XCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:02:44 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40553 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeK3XCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:02:44 -0500
Received: by mail-ed1-f65.google.com with SMTP id d3so4602764edx.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 03:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H33ktSuQAG7GnDXaINaiGeybXobaVgyReSvlLCj+Svk=;
        b=MK3iAAUwCpLs0IyUtgYRFCNiAZfG67KkpPnu5eeRM719lQ6P51rlHBdFMwBOiZTIqj
         ZkeStjmQwT5v+lEKfxf0tSn4GztCMAUgbodMDFrmJr1T3J+0Ct6TlA+4/Y0w6rm6r8bI
         IxQl9PyxCko/F3gir0G5khaMBJMd4TheppFR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H33ktSuQAG7GnDXaINaiGeybXobaVgyReSvlLCj+Svk=;
        b=f+T3BIldE9G1GYhLrRP6gWwFPlWLoqk6tYOAicZpV7jVouaZFX4Uf2LpLPtx/73t8A
         MA+8kJAsEdxrdM3JV1SpD72NIzTDCpPzVH4dvQCZmh1jZrSoDDN31F0SB+pJnSHHTZfg
         klIFuNSUspSxOPAggj3d5wGtSKF12Ol3wbn3xKXMXgLuUjUCmP8oGm9pKvTlyuC8HXEX
         SyQsAQjqNENgQ3aJ+nuOFlnsNsw15yLFszICVH2EH77MybGxymPqZm5lOo39vLot2gDF
         n3xR7w3xPcrTuat1+lk5Xh96/hsqwMsPmT1BbQ+GQfGy2EVAPBBR8tOlJTpVVKclN1tg
         8C8Q==
X-Gm-Message-State: AA+aEWbANQc53f3SPstW1htmjWMZ8k37yR4a88hw/mVMvtRh6e9OnWju
        Wes+aliOwr4F6C+bw4bT8R1BHw==
X-Google-Smtp-Source: AFSGD/VEZhDAVG+VQ3he9VuiLhhCUJ1lvj/ITrZhDROSjdS3tAsFtYSpmaKtMJDaGoOSY6oR9c9phg==
X-Received: by 2002:a50:d94a:: with SMTP id u10mr4975083edj.214.1543578820710;
        Fri, 30 Nov 2018 03:53:40 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t10-v6sm767932ejg.41.2018.11.30.03.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 03:53:40 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/6] nvmem: meson-efuse: bindings: add peripheral clock
Date:   Fri, 30 Nov 2018 11:53:22 +0000
Message-Id: <20181130115325.16539-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130115325.16539-1-srinivas.kandagatla@linaro.org>
References: <20181130115325.16539-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

The efuse found in gx SoC requires a peripheral clock to properly operate.
We have been able to work without it until now because the clock was on by
default, and left on by the CCF. Soon, it will not be the case anymore, so
the device needs to claim the clock it needs

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt b/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
index e3298e18de26..2e0723ab3384 100644
--- a/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
+++ b/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
@@ -2,6 +2,8 @@
 
 Required properties:
 - compatible: should be "amlogic,meson-gxbb-efuse"
+- clocks: phandle to the efuse peripheral clock provided by the
+	  clock controller.
 
 = Data cells =
 Are child nodes of eFuse, bindings of which as described in
@@ -11,6 +13,7 @@ Example:
 
 	efuse: efuse {
 		compatible = "amlogic,meson-gxbb-efuse";
+		clocks = <&clkc CLKID_EFUSE>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-- 
2.19.2

