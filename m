Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB82BECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C91020854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QpQ1qfM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C91020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbeGRLcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:32:54 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46832 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbeGRLcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:32:53 -0400
Received: by mail-pl0-f67.google.com with SMTP id 30-v6so1864055pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zfumCh0/Uk7Wjj3xqkPVckZX5supz0gcySl1C1YpwX0=;
        b=QpQ1qfM6Z3szhMJNSFRAL40mx6C6MAZPIO/bu5/xG8dpzO/chztAdwB6TaMR2z4yVJ
         1LT5GVDqQHzn/DQcmSI6pPfSdlsSC4d/aroeDIMLBFJCfA7FAup5k1bbgo1cvZaXpWYP
         alucHLTJCeoGMSVrmygxBrrxztw7r7LfUo9Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zfumCh0/Uk7Wjj3xqkPVckZX5supz0gcySl1C1YpwX0=;
        b=kxadtBxvbROerilEvk+uFdAKeB7jbAAnd7VEx0BP1gqybY0PV2ROSrAGbsjEKlLB4v
         SULZ2IX97k3eWD4BeFmvEZAaPnxcU9EXS1uzoJIfkJhUPTE7ncgiqb/J9GMRL1ft7kgy
         nMwlnOx9AbEh+DFDoKd2ma0VeI99PP34SWqhpTuv6iDIncmD43TYuMJoD3Ti0H3CaA+6
         uIOf18MlIe9XWEJT7dgXZrJOvlAXfqElYrMPgQ0fDe5e9asCLx9dz+dmiPf0dXKSVgWM
         CLfkQLVUz6tWVcQ8204SYYrRg3e9tUAir64Lzrkr39yGeh7Zf0ESE1EOUYWY2p7RuZF6
         9Z1g==
X-Gm-Message-State: AOUpUlGP6La7Ozyv52rQyXwuu/0zO+MCoqckV7Vf1Bp1UWrBWDzlJ88Q
        TIi8Xsr6JGeHrLPSDJma1+EgIQ==
X-Google-Smtp-Source: AAOMgpeNe1l17mtEZt1hMZcHXajODIwQIZqWOtHbJByJzgkZkpYqb8JMCfSTwULJUc8Gck+TdH6HQg==
X-Received: by 2002:a17:902:9689:: with SMTP id n9-v6mr5515226plp.128.1531911333840;
        Wed, 18 Jul 2018 03:55:33 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id x25-v6sm4644452pgv.63.2018.07.18.03.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:55:33 -0700 (PDT)
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
Subject: [PATCH v3 03/18] dt-bindings: display: Add compatible for A64 DE2 tcon1 blocks
Date:   Wed, 18 Jul 2018 16:24:43 +0530
Message-Id: <20180718105458.22304-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 has DE2 pipeline with tcon0 and tcon1 block
which is similar Allwinner A83T.

This patch adds dt-binding documentation for A64 DE2 tcon1 blocks.

Mixer1 has different configuration for A64 so use separate compatible
but tcon1 has similar behaviour with A83T so add fallback compatible.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v3:
- collect Rob r-w-b tag
Changes for v2:
- Add fallback compatible for tcon1
- Add separate compatible for mixer1 

 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index f8773ecb7525..3594378fbe72 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -151,6 +151,7 @@ Required properties:
    * allwinner,sun8i-v3s-tcon
    * allwinner,sun9i-a80-tcon-lcd
    * allwinner,sun9i-a80-tcon-tv
+   * "allwinner,sun50i-a64-tcon-tv", "allwinner,sun8i-a83t-tcon-tv"
  - reg: base address and size of memory-mapped region
  - interrupts: interrupt associated to this IP
  - clocks: phandles to the clocks feeding the TCON.
@@ -370,6 +371,7 @@ Required properties:
     * allwinner,sun8i-a83t-de2-mixer-1
     * allwinner,sun8i-h3-de2-mixer-0
     * allwinner,sun8i-v3s-de2-mixer
+    * allwinner,sun50i-a64-de2-mixer-1"
   - reg: base address and size of the memory-mapped region.
   - clocks: phandles to the clocks feeding the mixer
     * bus: the mixer interface clock
@@ -403,6 +405,7 @@ Required properties:
     * allwinner,sun8i-r40-display-engine
     * allwinner,sun8i-v3s-display-engine
     * allwinner,sun9i-a80-display-engine
+    * allwinner,sun50i-a64-display-engine
 
   - allwinner,pipelines: list of phandle to the display engine
     frontends (DE 1.0) or mixers (DE 2.0) available.
-- 
2.17.1

