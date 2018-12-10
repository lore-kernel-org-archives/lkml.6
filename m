Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DFEC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B309420672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="i9fLMhyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B309420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbeLJQSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:18:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43179 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbeLJQSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:18:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so11077915wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSLZfhqj5LlgFfpYLOueILNrvF0k+OKE5voNHu/WFJA=;
        b=i9fLMhyMg+YgyHOHTvKZAa3yzDcRG1Q+CVmwCSS+wetlWyhZPoviQ01kR/cMaG/n0D
         IZGL21eOSqxq7ZGokDjFL49h8G1pVkrDlEBRNteA4xK/ccY3XEX5C8RJFe8I1+IV6Ioy
         DDl7QG6mkfm+zSMch6J4RPgbkjNMpLKbhBQ+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSLZfhqj5LlgFfpYLOueILNrvF0k+OKE5voNHu/WFJA=;
        b=r977XgJDVi9OPay9MzmVFQlX6mskv8Ve+g+AnSoAEzls2Dijngsj0oFtL5iKjKe4nL
         vR3LwHTAhg53MNcU0fhXq9WFVxXiSF9Wnm+ZWWuoXs3a7K2n795UkDda2u9/56ZuTrMZ
         l5AIS0dRg448+07jzipY+iMPWDIA1cFrLYoDdyyQbEMmKOgX8hmq2MzPpG2h3SFvhRdo
         JQAcSmN2l8cBH3A9bQu7ONSwkxs8xSpCeuNdCRP+QRelIfI2cy2T4m0TqSyuDNmUuT2M
         A2+mLyTuNDORF+yApVzrcg7pHYx8Vd6Rm1ZI0rqvSRzJXzkuenSdfoKC9jV2n5kWk9fs
         C6KQ==
X-Gm-Message-State: AA+aEWa0VFDX4GbK5o6+OOJR+Znjlka0EvlbHgNxjK2wSuPHrf06CdOS
        svhdeoAnExKrLuC2i9Kw+Ix8Eg==
X-Google-Smtp-Source: AFSGD/UG8pTrHfDIEcjUTcTwXDbLv36fj4jWRUX42zMKoNQDG4BaPOHeJx6GzE5YfiHqXFAEts88IQ==
X-Received: by 2002:a5d:570c:: with SMTP id a12mr9992101wrv.161.1544458691718;
        Mon, 10 Dec 2018 08:18:11 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:18:11 -0800 (PST)
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
Subject: [PATCH v5 16/17] dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/ A31 fallback)
Date:   Mon, 10 Dec 2018 21:47:28 +0530
Message-Id: <20181210161729.29720-17-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI PHY HDMI controller on Allwinner A64 is similar
on the one on A31.

Add A64 compatible and append A31 compatible as fallback.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index adc7cdf129dd..08f1f57abff5 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -40,6 +40,7 @@ D-PHY
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun6i-a31-mipi-dphy
+    * "allwinner,sun50i-a64-mipi-dphy", "allwinner,sun6i-a31-mipi-dphy"
   - reg: base address and size of memory-mapped region
   - clocks: phandles to the clocks feeding the DSI encoder
     * bus: the DSI interface clock
-- 
2.18.0.321.gffc6fa0e3

