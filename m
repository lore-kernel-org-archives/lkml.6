Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E7EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BB02086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eCZWO6rH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfARKen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:34:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42216 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfARKej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:34:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so14388348wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 02:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J19q6XdK6LukgFHT/iRLr1xXTdkoFW905MZs5kCf7/Y=;
        b=eCZWO6rHH72af+VdL5LwDKyZbSgPO2gBTQGiGbgpuF208XE0Ju9jIeA/cfzIOHN6kC
         hjo8teM6DQSUfZ38WCEgmvtBeAl0rsJfrU/2OFLtr5ezu03G/oE2+788/cWstIrMISA0
         CUrBZ9NrE/KowsrXxbgLPGRjnvXlMWDcQhHiqzM08sLhEwX62Nw27FyKIUX4O0uKdq/S
         qrd4uRA+fjggEXVZIW146BUdAvszXrFzy261u0LFvhyzKT3pfHezpICJwyZFzTVSTX5A
         /evBNqmWmjKTX+0aSB2nVgwhYTlmWE9qeOd308eYtT2jYFZTfbW46e3W0UAg4KYSpRUa
         yZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J19q6XdK6LukgFHT/iRLr1xXTdkoFW905MZs5kCf7/Y=;
        b=otiSO/Pu4PcTm1wZezUjJav0f8/q9Eb0N+qczISUPz6qg8qKckutnlmBwdKr4cywzU
         5x8UCyEF6HwR4YmGOwYUfY5/Cykxc5j1pQ5ePeFBWeJf+NjD2OZPmLikfDYDtycnqVCp
         RypMcC5Fg0gEm5xLaBvSTliE8X3FlGagUNxUS+dyw/JFX8DSrq0R1HGzOwODa8ckSc2I
         j96WTiSp+jJBMB0hjKfsXS8U+Vce3cBP4SDLezCWjn/I9DagXfqWLnM8Phg5mY1dkqlA
         j+kdxXoBCyYVedsA0yCi86Z6nGAlnXfBL4czB/+dNPZKXZ0OGEHBNJwoAaa65b2Omkgg
         OijA==
X-Gm-Message-State: AJcUukf5KDGbZ928tN36rAxWxshrb5qCaoKRJWCUDpTVYpeqUBsYNcev
        Vx4Y1SjhYSFGtzFZDq+0JwC/jQ==
X-Google-Smtp-Source: ALg8bN4DKcq+60K1ZCDVPEdmFXS15/3bRbfCEQ0QaKGf9VQ9JmogJMOI9zCueNZTgaaJGyjy33LNlg==
X-Received: by 2002:a5d:4ac7:: with SMTP id y7mr14996128wrs.196.1547807677748;
        Fri, 18 Jan 2019 02:34:37 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id s16sm67066247wrt.77.2019.01.18.02.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 02:34:37 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH v2 1/4] dt-bindings: amlogic: add new compatible devices to clk_measure
Date:   Fri, 18 Jan 2019 11:34:20 +0100
Message-Id: <20190118103423.15075-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118103423.15075-1-jbrunet@baylibre.com>
References: <20190118103423.15075-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the axg and g12a SoC family compatible to the clock measure bindings

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
index 205a54bcd7c7..6bf6b43f8dd8 100644
--- a/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
+++ b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
@@ -9,6 +9,8 @@ Required properties:
 			"amlogic,meson-gx-clk-measure" for GX SoCs
 			"amlogic,meson8-clk-measure" for Meson8 SoCs
 			"amlogic,meson8b-clk-measure" for Meson8b SoCs
+			"amlogic,meson-axg-clk-measure" for AXG SoCs
+			"amlogic,meson-g12a-clk-measure" for G12a SoCs
 - reg: base address and size of the Clock Measurer register space.
 
 Example:
-- 
2.20.1

