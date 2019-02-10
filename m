Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6543FC282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2C02145D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfBJPie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 10:38:34 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:31067 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfBJPid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 10:38:33 -0500
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1AFcC2U070970;
        Mon, 11 Feb 2019 00:38:12 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Mon, 11 Feb 2019 00:38:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from localhost.localdomain (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1AFc9M3070960
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 11 Feb 2019 00:38:12 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH v2] clk: fractional-divider: check parent rate only if flag is set
Date:   Mon, 11 Feb 2019 00:38:06 +0900
Message-Id: <20190210153806.24201-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Custom approximation of fractional-divider may not need parent clock
rate checking. For example Rockchip SoCs work fine using grand parent
clock rate even if target rate is greater than parent.

This patch checks parent clock rate only if CLK_SET_RATE_PARENT flag
is set.

For detailed example, clock tree of Rockchip I2S audio hardware.
  - Clock rate of CPLL is 1.2GHz, GPLL is 491.52MHz.
  - i2s1_div is integer divider can divide N (N is 1~128).
    Input clock is CPLL or GPLL. Initial divider value is N = 1.
    Ex) PLL = CPLL, N = 10, i2s1_div output rate is
      CPLL / 10 = 1.2GHz / 10 = 120MHz
  - i2s1_frac is fractional divider can divide input to x/y, x and
    y are 16bit integer.

CPLL --> | selector | ---> i2s1_div -+--> | selector | --> I2S1 MCLK
GPLL --> |          | ,--------------'    |          |
                      `--> i2s1_frac ---> |          |

Clock mux system try to choose suitable one from i2s1_div and
i2s1_frac for master clock (MCLK) of I2S1.

Bad scenario as follows:
  - Try to set MCLK to 8.192MHz (32kHz audio replay)
    Candidate setting is
    - i2s1_div: GPLL / 60 = 8.192MHz
    i2s1_div candidate is exactly same as target clock rate, so mux
    choose this clock source. i2s1_div output rate is changed
    491.52MHz -> 8.192MHz

  - After that try to set to 11.2896MHz (44.1kHz audio replay)
    Candidate settings are
    - i2s1_div : CPLL / 107 = 11.214945MHz
    - i2s1_frac: i2s1_div   = 8.192MHz
      This is because clk_fd_round_rate() thinks target rate
      (11.2896MHz) is higher than parent rate (i2s1_div = 8.192MHz)
      and returns parent clock rate.

Above is current upstreamed behavior. Clock mux system choose
i2s1_div, but this clock rate is not acceptable for I2S driver, so
users cannot replay audio.

Expected behavior is:
  - Try to set master clock to 11.2896MHz (44.1kHz audio replay)
    Candidate settings are
    - i2s1_div : CPLL / 107          = 11.214945MHz
    - i2s1_frac: i2s1_div * 147/6400 = 11.2896MHz
                 Change i2s1_div to GPLL / 1 = 491.52MHz at same
                 time.

If apply this commit, clk_fd_round_rate() calls custom approximate
function of Rockchip even if target rate is higher than parent.
Custom function changes both grand parent (i2s1_div) and parent
(i2s_frac) settings at same time. Clock mux system can choose
i2s1_frac and audio works fine.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 drivers/clk/clk-fractional-divider.c | 2 +-
 drivers/clk/clk.c                    | 8 ++++++++
 include/linux/clk-provider.h         | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index 545dceec0bbf..fdfe2e423d15 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -79,7 +79,7 @@ static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long m, n;
 	u64 ret;
 
-	if (!rate || rate >= *parent_rate)
+	if (!rate || (!clk_hw_can_set_rate_parent(hw) && rate >= *parent_rate))
 		return *parent_rate;
 
 	if (fd->approximation)
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d2477a5058ac..070c0cb29ee8 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -518,6 +518,14 @@ void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
 }
 EXPORT_SYMBOL_GPL(clk_hw_set_rate_range);
 
+bool clk_hw_can_set_rate_parent(struct clk_hw *hw)
+{
+	unsigned long flags = clk_hw_get_flags(hw);
+
+	return flags & CLK_SET_RATE_PARENT;
+}
+EXPORT_SYMBOL_GPL(clk_hw_can_set_rate_parent);
+
 /*
  * Helper for finding best parent to provide a given frequency. This can be used
  * directly as a determine_rate callback (e.g. for a mux), or from a more
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index e443fa9fa859..693a51937ded 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -808,6 +808,7 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
 void clk_hw_reparent(struct clk_hw *hw, struct clk_hw *new_parent);
 void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
 			   unsigned long max_rate);
+bool clk_hw_can_set_rate_parent(struct clk_hw *hw);
 
 static inline void __clk_hw_set_clk(struct clk_hw *dst, struct clk_hw *src)
 {
-- 
2.20.1

