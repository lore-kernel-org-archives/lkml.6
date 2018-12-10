Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED81C67839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E83D20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="O+e/8jGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E83D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbeLJQR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:17:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55878 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbeLJQRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:17:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so11492443wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/FobAdk1F/zKxxqm1vIJo/CC8EUNzQ/B2arqE/fLkis=;
        b=O+e/8jGesF+TnCn8gM5SRD6NP0q6G5NYENXdrkyRc7q6CU8Eb4i7GTW60z95JnEKPO
         3fzgHoSR4cQxYPPHQx7cgqEWpf8VhVRVlamBtQKDyQ+1D8h+RYZ3/XueJyOGoxXBOYx7
         ArhaFDsmcOHfNIiTy6wxPHhItB8ClC60tXJgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/FobAdk1F/zKxxqm1vIJo/CC8EUNzQ/B2arqE/fLkis=;
        b=PJxJ1y2vnjaQpHIYX5YGaowR91TkffnzntEQqezBvhmIzXF02jXjINP0XCWYE+ojai
         noxxQpl8wnkKq/awm5xGyk0WN2HB9LTcDIaGNVEcmP92BxdoPui8AkYNm3NUtLZoDCq4
         n1nd/Ub64uGU78H0DQn/+/5aUlZv5BI5OnN3yA9DRSeJuS7qV6hvXfy5rMo7aK3cFKZF
         rzLx9wEUIIjRs7LnMDiiUS1ob1f9BKivDsjC9Id5OYz1hfZp3zZ5V8Qhqamx97L4zz+Z
         9ArQ/+7JFTyb8x3sIwoc/TepVvoKWmeNQdxPuXABvxae55BlkKU5scZ1Q5Z2zQkXB4Vf
         UKMQ==
X-Gm-Message-State: AA+aEWajrO4fTNkeLzvQs+W3YHsFmh2EC1FcaGMKSLONewZlZqJJwpA+
        Xa0+KGLEd/lWgI2p2/1MomVYEw==
X-Google-Smtp-Source: AFSGD/UGSus8mIueXi7G092yzijN2KgoYa8ydFRdqDZafNWarrOeEj+ecoQ1Q8xrLccYkOaSqYz39g==
X-Received: by 2002:a1c:2787:: with SMTP id n129mr11580381wmn.128.1544458671352;
        Mon, 10 Dec 2018 08:17:51 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:17:50 -0800 (PST)
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
Subject: [PATCH v5 04/17] dt-bindings: sun6i-dsi: Add compatible for A64 MIPI DSI
Date:   Mon, 10 Dec 2018 21:47:16 +0530
Message-Id: <20181210161729.29720-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI controller on Allwinner A64 is similar to
Allwinner A31 without support of DSI mod clock.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index 6a6cf5de08b0..9fa6e7a758ad 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -12,6 +12,7 @@ The DSI Encoder generates the DSI signal from the TCON's.
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun6i-a31-mipi-dsi
+    * allwinner,sun50i-a64-mipi-dsi
   - reg: base address and size of memory-mapped region
   - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the DSI encoder
-- 
2.18.0.321.gffc6fa0e3

