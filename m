Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934430AbeBLPDY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:03:24 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34439 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932451AbeBLO7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:59:04 -0500
X-Google-Smtp-Source: AH8x226obt8A0sNbfURjLFWB9RkbpLi07YGwHzEgRxPytrHA1xh+SjYDDsKrlc1VdR3q0sfnuOOc5A==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/19] clk: meson: add regmap helpers for parm
Date: Mon, 12 Feb 2018 15:58:39 +0100
Message-Id: <20180212145846.19380-13-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180212145846.19380-1-jbrunet@baylibre.com>
References: <20180212145846.19380-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meson clock drivers are using struct parm to describe each field of the
clock provider. Providing helpers to access these fields with regmap
helps to keep drivers readable

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/clkc.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index aa2dfa0ff89f..8edc25297422 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -38,6 +38,22 @@ struct parm {
 	u8	width;
 };
 
+static inline unsigned int meson_parm_read(struct regmap *map, struct parm *p)
+{
+	unsigned int val;
+
+	regmap_read(map, p->reg_off, &val);
+	return PARM_GET(p->width, p->shift, val);
+}
+
+static inline void meson_parm_write(struct regmap *map, struct parm *p,
+				    unsigned int val)
+{
+	regmap_update_bits(map, p->reg_off, SETPMASK(p->width, p->shift),
+			   val << p->shift);
+}
+
+
 struct pll_rate_table {
 	unsigned long	rate;
 	u16		m;
-- 
2.14.3
