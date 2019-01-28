Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C40BC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFEF2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pAVKDPg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfA1SFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:05:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55951 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfA1SFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:05:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so14893884wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4wf9FAXSPyYzzMogrRK8K8vMBiOAXKZiQZa3fRw2VeY=;
        b=pAVKDPg0Pm08cuC8o0hw5D/VrYpOKQ6CKzqXA6L/cQ6OzR7OMKDBtPu4Aghtl8Sx47
         RoDoP4Yh/ydPBu2tTQGJll0VfUElhArZksnOZ7/SNkJjFsJ+QHBvI02iR//UIU/Zlj92
         AijANg0jt6jMbZpvcNhTRF4fDcWlxphkLBVIFrA/fbCkM7DRbPLNnbLBqsPnvwqLOz4L
         W27uG/V+37FNXPyqp1HysQmNQXBPOFh7qkKPWCHIandCIvV5DoI87D1L/IprVTk7hkyp
         ZQY7s8ze0GnSpSPvsVjNcjIDYU3nwRXnxsXBu1EBBZQYuSnYRn+ejlquTub0LXhjfRoV
         yO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4wf9FAXSPyYzzMogrRK8K8vMBiOAXKZiQZa3fRw2VeY=;
        b=ReAEy6w0EjgKacmPjjVRGy7D9h3Pe2PQPCeqHP7E8Vt3M1KOzxC5/w3+LVl7xipUwP
         zn++wZqYAvsKCvjH/7D+/S3okgHt0GE/s8Gyc+Gb2nRZ+VVz0UCdp6bm2Xtij/8lvyjo
         tEpSn1j+qUwtxq3uBZSlaeiJcGUs+gBzyC8WmsLXQtH0V6n53FmNmcKxADM8sPf0xH9N
         eMUSGUUzrOoqasKrApKkc8oreyIQ+qm6qp4YQPeOEREQjQYFszcrv7MWi90X/wbG2KcS
         DeV9kE2dgj2V/2cdKFLuHDQnH/rYjIZtQVxkDdUwEbzHpL7WpppsdN104cgbFHO169T3
         meiQ==
X-Gm-Message-State: AJcUuke16gv+XsDaAGrMPNoNNYmbmg+klsitE1YCjdLFHgIfMn2DYEOy
        V1Ng23ATdxue1l26p3dizPN8O47SnXI=
X-Google-Smtp-Source: ALg8bN75sC55jztbjVVmJDd8FxG0eY5D28u2GiTxNeyFtpJy0sKx6KZZC4T1/iMaBQT0GzM1D63dLA==
X-Received: by 2002:a1c:a68f:: with SMTP id p137mr16745488wme.64.1548698703842;
        Mon, 28 Jan 2019 10:05:03 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id p6sm145548193wrx.50.2019.01.28.10.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:05:03 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 13/14] clk: meson: move sclk-div out of clkc-audio
Date:   Mon, 28 Jan 2019 19:04:29 +0100
Message-Id: <20190128180430.28689-14-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128180430.28689-1-jbrunet@baylibre.com>
References: <20190128180430.28689-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg-audio.c                  | 2 +-
 drivers/clk/meson/sclk-div.c                   | 9 ++++++++-
 drivers/clk/meson/{clkc-audio.h => sclk-div.h} | 6 +++---
 3 files changed, 12 insertions(+), 5 deletions(-)
 rename drivers/clk/meson/{clkc-audio.h => sclk-div.h} (79%)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 8db0508ec6ab..7ab200b6c3bf 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -14,11 +14,11 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 
-#include "clkc-audio.h"
 #include "axg-audio.h"
 #include "clk-input.h"
 #include "clk-regmap.h"
 #include "clk-phase.h"
+#include "sclk-div.h"
 
 #define AXG_MST_IN_COUNT	8
 #define AXG_SLV_SCLK_COUNT	10
diff --git a/drivers/clk/meson/sclk-div.c b/drivers/clk/meson/sclk-div.c
index d3eea53945e9..3acf03780221 100644
--- a/drivers/clk/meson/sclk-div.c
+++ b/drivers/clk/meson/sclk-div.c
@@ -16,8 +16,11 @@
  * duty_cycle = (1 + hi) / (1 + val)
  */
 
-#include "clkc-audio.h"
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+
 #include "clk-regmap.h"
+#include "sclk-div.h"
 
 static inline struct meson_sclk_div_data *
 meson_sclk_div_data(struct clk_regmap *clk)
@@ -242,3 +245,7 @@ const struct clk_ops meson_sclk_div_ops = {
 	.init		= sclk_div_init,
 };
 EXPORT_SYMBOL_GPL(meson_sclk_div_ops);
+
+MODULE_DESCRIPTION("Amlogic Sample divider driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/clkc-audio.h b/drivers/clk/meson/sclk-div.h
similarity index 79%
rename from drivers/clk/meson/clkc-audio.h
rename to drivers/clk/meson/sclk-div.h
index 1eaf4ecac4f7..b64b2a32005f 100644
--- a/drivers/clk/meson/clkc-audio.h
+++ b/drivers/clk/meson/sclk-div.h
@@ -4,8 +4,8 @@
  * Author: Jerome Brunet <jbrunet@baylibre.com>
  */
 
-#ifndef __MESON_CLKC_AUDIO_H
-#define __MESON_CLKC_AUDIO_H
+#ifndef __MESON_SCLK_DIV_H
+#define __MESON_SCLK_DIV_H
 
 #include <linux/clk-provider.h>
 #include "parm.h"
@@ -19,4 +19,4 @@ struct meson_sclk_div_data {
 
 extern const struct clk_ops meson_sclk_div_ops;
 
-#endif /* __MESON_CLKC_AUDIO_H */
+#endif /* __MESON_SCLK_DIV_H */
-- 
2.20.1

