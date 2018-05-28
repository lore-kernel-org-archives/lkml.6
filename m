Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755496AbeE1QIh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936836AbeE1KON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:14:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 178/185] clk: samsung: exynos3250: Fix PLL rates
Date: Mon, 28 May 2018 12:03:39 +0200
Message-Id: <20180528100115.587558966@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrzej Hajda <a.hajda@samsung.com>

[ Upstream commit a8321e7887410a2b2e80ab89d1ef7b30562658ea ]

Rates declared in PLL rate tables should match exactly rates calculated
from PLL coefficients. If that is not the case, rate of the PLL's child clock
might be set not as expected. For instance, if in the PLL rates table we have
a 393216000 Hz entry and the real value as returned by the PLL's recalc_rate
callback is 393216003, after setting PLL's clk rate to 393216000 clk_get_rate
will return 393216003. If we now attempt to set rate of a PLL's child divider
clock to 393216000/2 its rate will be 131072001, rather than 196608000.
That is, the divider will be set to 3 instead of 2, because 393216003/2 is
greater than 196608000.

To fix this issue declared rates are changed to exactly match rates generated
by the PLL, as calculated from the P, M, S, K coefficients.

In this patch an erroneous P value for 74176002 output frequency is also
corrected.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/samsung/clk-exynos3250.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -740,7 +740,7 @@ static struct samsung_pll_rate_table exy
 	PLL_36XX_RATE(144000000,  96, 2, 3,     0),
 	PLL_36XX_RATE( 96000000, 128, 2, 4,     0),
 	PLL_36XX_RATE( 84000000, 112, 2, 4,     0),
-	PLL_36XX_RATE( 80000004, 106, 2, 4, 43691),
+	PLL_36XX_RATE( 80000003, 106, 2, 4, 43691),
 	PLL_36XX_RATE( 73728000,  98, 2, 4, 19923),
 	PLL_36XX_RATE( 67737598, 270, 3, 5, 62285),
 	PLL_36XX_RATE( 65535999, 174, 2, 5, 49982),
@@ -776,7 +776,7 @@ static struct samsung_pll_rate_table exy
 	PLL_36XX_RATE(148352005,  98, 2, 3, 59070),
 	PLL_36XX_RATE(108000000, 144, 2, 4,     0),
 	PLL_36XX_RATE( 74250000,  99, 2, 4,     0),
-	PLL_36XX_RATE( 74176002,  98, 3, 4, 59070),
+	PLL_36XX_RATE( 74176002,  98, 2, 4, 59070),
 	PLL_36XX_RATE( 54054000, 216, 3, 5, 14156),
 	PLL_36XX_RATE( 54000000, 144, 2, 5,     0),
 	{ /* sentinel */ }
