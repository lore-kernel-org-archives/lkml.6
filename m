Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbeFAJ3q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:29:46 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:48952 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeFAJ3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:29:08 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jia-Ju Bai <baijiaju1990@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/4] thermal: bcm2835: Stop using printk format %pCr
Date: Fri,  1 Jun 2018 11:28:20 +0200
Message-Id: <1527845302-12159-3-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
References: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printk format "%pCr" will be removed soon, as clk_get_rate() must not be
called in atomic context.

Replace it by printing the variable that already holds the clock rate.
Note that calling clk_get_rate() is safe here, as the code runs in task
context.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/thermal/broadcom/bcm2835_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index a4d6a0e2e9938190..23ad4f9f21438e45 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -213,8 +213,8 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 	rate = clk_get_rate(data->clk);
 	if ((rate < 1920000) || (rate > 5000000))
 		dev_warn(&pdev->dev,
-			 "Clock %pCn running at %pCr Hz is outside of the recommended range: 1.92 to 5MHz\n",
-			 data->clk, data->clk);
+			 "Clock %pCn running at %lu Hz is outside of the recommended range: 1.92 to 5MHz\n",
+			 data->clk, rate);
 
 	/* register of thermal sensor and get info from DT */
 	tz = thermal_zone_of_sensor_register(&pdev->dev, 0, data,
-- 
2.7.4
