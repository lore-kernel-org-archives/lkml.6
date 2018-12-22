Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824D2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BB721974
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392336AbeLVRWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:22:16 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:25915 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbeLVRWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:22:16 -0500
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBMGgt7q021255;
        Sun, 23 Dec 2018 01:42:56 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Sun, 23 Dec 2018 01:42:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from localhost.localdomain (183.38.232.153.ap.dti.ne.jp [153.232.38.183])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBMGgqGI021248
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 23 Dec 2018 01:42:55 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] clk: rockchip: fix frac settings of GPLL clock for rk3328
Date:   Sun, 23 Dec 2018 01:42:49 +0900
Message-Id: <20181222164249.25620-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes settings of GPLL frequency in fractional mode for
rk3328. In this mode, FOUTVCO is calcurated by following formula:
  FOUTVCO = FREF * FBDIV / REFDIV + ((FREF * FRAC / REFDIV) >> 24)

The problem is in FREF * FRAC >> 24 term. This result always lacks
one from target value is specified by rate member. For example first
itme of rk3328_pll_frac_rate originally has
  - rate  : 1016064000
  - refdiv: 3
  - fbdiv : 127
  - frac  : 134217
  - FREF * FBDIV / REFDIV        = 1016000000
  - (FREF * FRAC / REFDIV) >> 24 = 63999
Thus calculated rate is 1016063999. It seems wrong.

If frac has 134218 (it is increased 1 from original value), second
term is 64000. All other items have same situation. So this patch
adds 1 to frac member in all items of rk3328_pll_frac_rate.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 drivers/clk/rockchip/clk-rk3328.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
index faa94adb2a37..65ab5c2f48b0 100644
--- a/drivers/clk/rockchip/clk-rk3328.c
+++ b/drivers/clk/rockchip/clk-rk3328.c
@@ -78,17 +78,17 @@ static struct rockchip_pll_rate_table rk3328_pll_rates[] = {
 
 static struct rockchip_pll_rate_table rk3328_pll_frac_rates[] = {
 	/* _mhz, _refdiv, _fbdiv, _postdiv1, _postdiv2, _dsmpd, _frac */
-	RK3036_PLL_RATE(1016064000, 3, 127, 1, 1, 0, 134217),
+	RK3036_PLL_RATE(1016064000, 3, 127, 1, 1, 0, 134218),
 	/* vco = 1016064000 */
-	RK3036_PLL_RATE(983040000, 24, 983, 1, 1, 0, 671088),
+	RK3036_PLL_RATE(983040000, 24, 983, 1, 1, 0, 671089),
 	/* vco = 983040000 */
-	RK3036_PLL_RATE(491520000, 24, 983, 2, 1, 0, 671088),
+	RK3036_PLL_RATE(491520000, 24, 983, 2, 1, 0, 671089),
 	/* vco = 983040000 */
-	RK3036_PLL_RATE(61440000, 6, 215, 7, 2, 0, 671088),
+	RK3036_PLL_RATE(61440000, 6, 215, 7, 2, 0, 671089),
 	/* vco = 860156000 */
-	RK3036_PLL_RATE(56448000, 12, 451, 4, 4, 0, 9797894),
+	RK3036_PLL_RATE(56448000, 12, 451, 4, 4, 0, 9797895),
 	/* vco = 903168000 */
-	RK3036_PLL_RATE(40960000, 12, 409, 4, 5, 0, 10066329),
+	RK3036_PLL_RATE(40960000, 12, 409, 4, 5, 0, 10066330),
 	/* vco = 819200000 */
 	{ /* sentinel */ },
 };
-- 
2.19.2

