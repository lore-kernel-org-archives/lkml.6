Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034215AbeE1K0i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:26:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034191AbeE1K0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:26:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 250/268] clk: samsung: exynos5250: Fix PLL rates
Date: Mon, 28 May 2018 12:03:44 +0200
Message-Id: <20180528100231.579270171@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrzej Hajda <a.hajda@samsung.com>

[ Upstream commit 2ac051eeabaa411ef89ae7cd5bb8e60cb41ad780 ]

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

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/samsung/clk-exynos5250.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -711,13 +711,13 @@ static struct samsung_pll_rate_table epl
 	/* sorted in descending order */
 	/* PLL_36XX_RATE(rate, m, p, s, k) */
 	PLL_36XX_RATE(192000000, 64, 2, 2, 0),
-	PLL_36XX_RATE(180633600, 90, 3, 2, 20762),
+	PLL_36XX_RATE(180633605, 90, 3, 2, 20762),
 	PLL_36XX_RATE(180000000, 90, 3, 2, 0),
 	PLL_36XX_RATE(73728000, 98, 2, 4, 19923),
-	PLL_36XX_RATE(67737600, 90, 2, 4, 20762),
+	PLL_36XX_RATE(67737602, 90, 2, 4, 20762),
 	PLL_36XX_RATE(49152000, 98, 3, 4, 19923),
-	PLL_36XX_RATE(45158400, 90, 3, 4, 20762),
-	PLL_36XX_RATE(32768000, 131, 3, 5, 4719),
+	PLL_36XX_RATE(45158401, 90, 3, 4, 20762),
+	PLL_36XX_RATE(32768001, 131, 3, 5, 4719),
 	{ },
 };
 
