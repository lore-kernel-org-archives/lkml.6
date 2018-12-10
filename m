Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FFFC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2753520672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YF3sJk2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2753520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbeLJQSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:18:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38391 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbeLJQSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:18:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so11928335wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0A16quYt+swrquBMzw4Px8WMyAYxU03soI2v/Bfgb1A=;
        b=YF3sJk2rubhEazU2ITO1ZU+iTOrr+E5kT9wdu2ixC/aNx3jRrsdVG/2WpQLVD7SFv9
         x06odRqVx9/4OBPP6uv8S0TTYoO80v57K8Ubf7WIXDiFtUq7zLE442UUdgNRoSeCDlJV
         YbmTAWm+nTXXDjGe30+BwZV3cxtoLv/Erft5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0A16quYt+swrquBMzw4Px8WMyAYxU03soI2v/Bfgb1A=;
        b=Vu0yTNwWS595doGUHeHnuwAbXAkGN+7yzAWmdmQyoo9+9Jl61CV4yvmPXJXa+RpTNX
         OIAjFQtfTKC8ntugjrq1ia8i+zWjCj4v9GJ+S84sbga4bwancAJhs1har+vzKpynxAXd
         hBVKpyLcxvGmr9ou4q/bimdpaPB1R0b0vaQJnMqa1pYWzZsOHNHzUDG60zs0PF9id56g
         VF3MbQQz/IwXSsI0Ww2EN/3ymSHTw1L9xR+oJK/UF81AQj7dMEAy75BVC437Yyn8a+g5
         H+IJwGTgiNO//z07gAPny2Q+y+BK/cy7G0VuLTHZ6oEfazKDwO82NlIx73Ju0WjJIrkF
         Dv8g==
X-Gm-Message-State: AA+aEWZ4kWUYipvPH9ZktfC2abBsNcOKE28irmO6t6z5HEZjQVPLXu8l
        1YbOepj/2SKS0rBWrHbtuMYABA==
X-Google-Smtp-Source: AFSGD/X4P2P8IWz19Jw4ghafGW1XCdsWJRT1xawLts5BHe68/7lQ0SenyM2uKUJlIk2b3q5hqzzE8A==
X-Received: by 2002:a1c:1707:: with SMTP id 7mr11448132wmx.150.1544458688215;
        Mon, 10 Dec 2018 08:18:08 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:18:07 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 14/17] dt-bindings: sun6i-dsi: Add VCC-DSI supply property
Date:   Mon, 10 Dec 2018 21:47:26 +0530
Message-Id: <20181210161729.29720-15-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the Allwinner MIPI DSI controllers are supply with
VCC-DSI pin. which need to supply for some of the boards to
trigger the power.

So, document the supply property so-that the required board
can eable it via device tree.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index 9fa6e7a758ad..adc7cdf129dd 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -28,6 +28,9 @@ Required properties:
     first port should be the input endpoint, usually coming from the
     associated TCON.
 
+Optional properties:
+  - vcc-dsi-supply: the VCC-DSI power supply of the DSI encoder
+
 Any MIPI-DSI device attached to this should be described according to
 the bindings defined in ../mipi-dsi-bus.txt
 
-- 
2.18.0.321.gffc6fa0e3

