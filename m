Return-Path: <mbrugger@localhost>
X-Google-Smtp-Source: AIpwx4+EmKzbrMBG1oxQ62AgTSjWxzV2kLGeVoULSY57/fAQ6hPs2Nm+bv8bgUB04ZLtcN8kmmVC
ARC-Seal: i=1; a=rsa-sha256; t=1524497542; cv=none;
        d=google.com; s=arc-20160816;
        b=W6+nHMdLihmFzwhpvEe4CpEsFnXivJhljPDnj4fk2NwBrj6DYihghkpTiCTH97cLtT
         351+vJoM6mUDPHOWT/eKqdAxPjFZeKAT55PEC+rBJqSTHi2LsAmUegVdblejMFAAxQMS
         m89bNA/Jd50xn07OH6ABNO0wqX0oLX3OLQXTnjOUWPpP/0kHhUeqRotpgjwueEeetpvw
         iHc+c5iZr1J8SV3Uv8oGZp1FJkiqjdtM2hzgxdtmWcfzPRe7D1OPmrMLJlkalEWKghEB
         0o/79JjOxmQ6vs14pdLjgS1RdhtuREtBLO2DB0oja2tGeQFCvxsufRZnjjPETKSHUjL0
         oVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ti0TwhGuOPICNuy0DwPgQS5asqZbIX48rFdyxGORyAc=;
        b=pAqjKj420iJzS5vdvm4UIzZAO+gSpT52H36c4bpZSrGgczuWMXgiNu0CLYQj0mFhO2
         CSk3EU74Gkqd1Y36xKDj5RGceqiyq5Qfbha8xwCN1N2IWI+IdjE2FZgX8P1MxN8Tm5sk
         1eGU6HZqr9W4Z5t2iXrpaO0U2tRYkd2xdtXe+aMhu591iyYv2tVq15BmbUUrOOJ/l9xL
         MuORh8oNe9IyvLezMXfSRAKoq2O+u/6ZMYWIvYPAKyHpRw+6HOV3U4fEBWMgKstWmm1Q
         f5sCdzV/nES/VuOPEdi5UOA9fzKn8uxdNhXKbpsz76cZSxG5SMuGhWnB/HFC9IXxBadX
         zLpg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 37.223.140.222 is neither permitted nor denied by best guess record for domain of mbrugger@localhost) smtp.mailfrom=mbrugger@localhost
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 37.223.140.222 is neither permitted nor denied by best guess record for domain of mbrugger@localhost) smtp.mailfrom=mbrugger@localhost
From: Matthias Brugger <mbrugger@suse.com>
To: ulrich.hecht+renesas@gmail.com,
	laurent.pinchart@ideasonboard.com,
	ck.hu@mediatek.com,
	p.zabel@pengutronix.de,
	airlied@linux.ie,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	mturquette@baylibre.com,
	sboyd@codeaurora.org,
	lee.jones@linaro.org
Cc: davem@davemloft.net,
	gregkh@linuxfoundation.org,
	mchehab@kernel.org,
	rdunlap@infradead.org,
	pi-cheng.chen@linaro.org,
	sean.wang@mediatek.com,
	linux-clk@vger.kernel.org,
	linux@armlinux.org.uk,
	matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: [v2 08/10] clk: mediatek: mt8173-mm: switch to mfd device
Date: Mon, 23 Apr 2018 17:32:07 +0200
Message-Id: <74bf4058534cf187e10ef041da1706878914aa45.1524497268.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598551535365976934?=
X-GMAIL-MSGID: =?utf-8?q?1598551535365976934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As the new mfd device is in place, switch probing
for the MMSYS to support invocation from the mfd device.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/mediatek/clk-mt8173.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 96c292c3e440..abd2592078d4 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
 
 #include "clk-mtk.h"
 #include "clk-gate.h"
@@ -1152,10 +1153,13 @@ static void __init mtk_imgsys_init(struct device_node *node)
 }
 CLK_OF_DECLARE(mtk_imgsys, "mediatek,mt8173-imgsys", mtk_imgsys_init);
 
-static void __init mtk_mmsys_init(struct device_node *node)
+static int mtk_mmsys_probe(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
 	int r;
+	struct device_node *node;
+
+	node = pdev->dev.parent->of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
@@ -1166,8 +1170,17 @@ static void __init mtk_mmsys_init(struct device_node *node)
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+
+	return r;
 }
-CLK_OF_DECLARE(mtk_mmsys, "mediatek,mt8173-mmsys", mtk_mmsys_init);
+
+static struct platform_driver clk_mt8173_mm_drv = {
+	.probe = mtk_mmsys_probe,
+	.driver = {
+		.name = "clk-mt8173-mm",
+	},
+};
+builtin_platform_driver(clk_mt8173_mm_drv);
 
 static void __init mtk_vdecsys_init(struct device_node *node)
 {
-- 
2.16.3
