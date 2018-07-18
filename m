Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0010ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3992086A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YD/JEuQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3992086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbeGRLdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:33:05 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35235 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbeGRLdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:33:05 -0400
Received: by mail-pf0-f196.google.com with SMTP id q7-v6so2029070pff.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+VUMExjCvct4u8/NzMEZiOuEgIVX8IE1yYpHRdYqEgo=;
        b=YD/JEuQWgYHPZcJFKec5WSWEK1gdIGZ90d7hHUwGgjF+azpidYSn/8Pkf5IpYJzCO/
         OzmRdMeh+dwkRwpCROWDZTJ3Ox/wYaaEzISbC1S0gVn+xZTDWcGx41yJP9l1XXiunYLI
         V4hvQrJQHv1gt+UCKAYzNt0daUUYZ1te7GNew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+VUMExjCvct4u8/NzMEZiOuEgIVX8IE1yYpHRdYqEgo=;
        b=U84TSunlwfDlSTqaD48ewwgMwBcRdDkf6MbjWYTGgIw59gaijdMbS9RPKoW5DN6YrW
         JWrJNavrltESGvRAunYAwJ9xj6H52PRPxw9KD0550TohztdPsdUnsg/yIOTJIxP9ZNdU
         hDG/tKxPau+8Nt+m5r3ysd04MI20IlKNRX5hFPhoRxmZd9YI3cEaHCavBJzSKuSMMVGp
         YqCoqcmvBJr4F+VlsYE9bzL6n/PBN85H0AvQ4V3p1tn3ZCAU8QVo3+IAJ/apJB7Qajhk
         dvOgoeeoBPqBCL0tEP3AZzLYPDhyQMld25cb7LWKqf6RZSpxUz80qIFEVugGUAmpfiGj
         gi7w==
X-Gm-Message-State: AOUpUlENaQ4qebDFnj3+qBZDLPLUqOO4WsnnqAmGq0b7/XCTvs9C/Yph
        nmVF64jcuq0hsb77FGPn/nxx4w==
X-Google-Smtp-Source: AAOMgpelEE5culIIfmSTDOM3jk1/YQTATZLhD9iTCnpgAuTxHaA9si08BHifGhCOVzgPlfcIvGXi5Q==
X-Received: by 2002:a63:8e41:: with SMTP id k62-v6mr5197697pge.187.1531911344838;
        Wed, 18 Jul 2018 03:55:44 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id x25-v6sm4644452pgv.63.2018.07.18.03.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:55:44 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 05/18] dt-bindings: display: Add compatible for A64 HDMI
Date:   Wed, 18 Jul 2018 16:24:45 +0530
Message-Id: <20180718105458.22304-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HDMI on Allwinner A64 has similar like H3/H5/A83T.

Add compatible a64 and update A83T compatible as fallback.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v3:
- collect Rob r-w-b tag
Changes for v2:
- Add fallback compatible

 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 3594378fbe72..10b3c77833c2 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -78,6 +78,7 @@ Required properties:
 
   - compatible: value must be one of:
     * "allwinner,sun8i-a83t-dw-hdmi"
+    * "allwinner,sun50i-a64-dw-hdmi", "allwinner,sun8i-a83t-dw-hdmi"
   - reg: base address and size of memory-mapped region
   - reg-io-width: See dw_hdmi.txt. Shall be 1.
   - interrupts: HDMI interrupt number
-- 
2.17.1

