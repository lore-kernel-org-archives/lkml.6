Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D5EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFC421900
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfA3Xui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:50:38 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:46174 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfA3Xuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:50:37 -0500
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0UNoSoi061321;
        Thu, 31 Jan 2019 08:50:28 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Thu, 31 Jan 2019 08:50:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from localhost.localdomain (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0UNoPnB061293
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 31 Jan 2019 08:50:28 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] clk: fractional-divider: check parent rate only for general approximation
Date:   Thu, 31 Jan 2019 08:50:22 +0900
Message-Id: <20190130235022.21949-1-katsuhiro@katsuster.net>
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

This patch removes parent clock rate check from custom approximation.

For detailied example, clock tree of Rockchip I2S audio hardware.
  - A i2s1_div is integer divider can divide input clock 1/1 ~ 1/16.
    Initialize divider value is 1.
  - A i2s1_frac is fractional divider can divide input to x/y, x and
    y are 16bit integer.
  - Clock rate of CPLL is 1.2GHz, GPLL is 491.52MHz.

CPLL --> | selector | ---> i2s1_div -+--> | selector | --> I2S1 MCLK
GPLL --> |          | ,--------------'    |          |
                      `--> i2s1_frac ---> |          |

Clock mux system try to choose suitable one from i2s1_div and
i2s1_frac for master clock (MCLK) of I2S1.

Bad scenario as follows:
  - Try to set MCLK to 8.192MHz (32kHz audio replay)
    Candidate setting is
    - i2s1_div : GPLL / 60           = 8.192MHz
    i2s1_div is same as target clock rate, so mux choose this.
    i2s1_div output rate is changed 491.52MHz -> 8.192MHz

  - After that try to set to 11.2896MHz (44.1kHz audio replay)
    Candidate settings are
    - i2s1_div : CPLL / 107 = 11.214945MHz
    - i2s1_frac: i2s1_div   = 8.192MHz
      This is because clk_fd_round_rate() thinks target rate
      (11.2896MHz) is higher than parent rate (i2s1_div = 8.192MHz)
      and returns parent clock rate.
    Clock mux system choose i2s1_div, but this clock rate is not
    acceptable for I2S driver, so users cannot replay audio.

Expected behavior is:
  - Try to set master clock to 11.2896MHz (44.1kHz audio replay)
    Candidate settings are
    - i2s1_div : CPLL / 107          = 11.214945MHz
    - i2s1_frac: i2s1_div * 147/6400 = 11.2896MHz
                 (change i2s1_div to GPLL / 1 = 491.52MHz)
      If apply this commit, clk_fd_round_rate() calls custom
      approximate function of Rockchip even if target rate is higher
      than parent. Custom function changes both grand parent
      (i2s1_div) and parent (i2s_frac) settings at same time.
    Clock mux system can choose i2s1_frac and audio works fine.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 drivers/clk/clk-fractional-divider.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index 545dceec0bbf..b0fc5509e0ff 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -79,13 +79,17 @@ static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long m, n;
 	u64 ret;
 
-	if (!rate || rate >= *parent_rate)
+	if (!rate)
 		return *parent_rate;
 
-	if (fd->approximation)
+	if (fd->approximation) {
 		fd->approximation(hw, rate, parent_rate, &m, &n);
-	else
+	} else {
+		if (rate >= *parent_rate)
+			return *parent_rate;
+
 		clk_fd_general_approximation(hw, rate, parent_rate, &m, &n);
+	}
 
 	ret = (u64)*parent_rate * m;
 	do_div(ret, n);
-- 
2.20.1

