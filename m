Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754062AbeAaSPn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:15:43 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40934 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753484AbeAaSJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:09:52 -0500
X-Google-Smtp-Source: AH8x226fBzDWlEGnrCMT2JHGF6Psg0FnKlNOgqg0WcFyTPMTpxVVTrkOodxUkwpl6TufybUngfyx5g==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/19] clk: meson: use devm_of_clk_add_hw_provider
Date: Wed, 31 Jan 2018 19:09:28 +0100
Message-Id: <20180131180945.18025-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131180945.18025-1-jbrunet@baylibre.com>
References: <20180131180945.18025-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no remove callbacks in meson's clock controllers and
of_clk_del_provider is never called if of_clk_add_hw_provider has been
executed, introducing a potential memory leak.
Fixing this by the using the devm variant.

In reality, the leak would never happen since these controllers are
never unloaded once in use ... still, this is worth cleaning.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c     | 4 ++--
 drivers/clk/meson/gxbb.c    | 5 +++--
 drivers/clk/meson/meson8b.c | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 0db0fc0762e2..2f2b3845c01d 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -854,8 +854,8 @@ static int axg_clkc_probe(struct platform_device *pdev)
 		}
 	}
 
-	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
-			clkc_data->hw_onecell_data);
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   clkc_data->hw_onecell_data);
 }
 
 static struct platform_driver axg_driver = {
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 423abcb8ef88..17f44ac751b3 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -2002,8 +2002,9 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 			goto iounmap;
 	}
 
-	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
-			clkc_data->hw_onecell_data);
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   clkc_data->hw_onecell_data);
 
 iounmap:
 	iounmap(clk_base);
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 3ffea80c1308..abac079ff77f 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -878,8 +878,8 @@ static int meson8b_clkc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
-			&meson8b_hw_onecell_data);
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   &meson8b_hw_onecell_data);
 }
 
 static const struct of_device_id meson8b_clkc_match_table[] = {
-- 
2.14.3
