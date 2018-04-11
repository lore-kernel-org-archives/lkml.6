Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeDKImF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:42:05 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:56209 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752500AbeDKIl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:41:58 -0400
X-Google-Smtp-Source: AIpwx4/Ks8UPNi+7QK/Oaxj3SaihESdNUQBil2ByAgrlLzVrZ3pLhars2R3/jquY+Ai+pcKG14D6qw==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: davem@davemloft.net, frankt@promise.com, andre@linux-ide.org,
        sergei.shtylyov@cogentembedded.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/2 v2] ide: pdc202xx_new: Replace mdelay with usleep_range in detect_pll_input_clock
Date: Wed, 11 Apr 2018 16:41:27 +0800
Message-Id: <1523436087-4485-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

detect_pll_input_clock() is never called in atomic context.

detect_pll_input_clock() is only called by init_chipset_pdcnew(), which 
is set as ".init_chipset" in struct ide_port_info.
This function is not called in atomic context.

Despite never getting called from atomic context, detect_pll_input_clock()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Correct wrong usage of usleep_range() in v1.
  Thank Sergei for pointing it out.
---
 drivers/ide/pdc202xx_new.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/pdc202xx_new.c b/drivers/ide/pdc202xx_new.c
index b33646b..6afa66d 100644
--- a/drivers/ide/pdc202xx_new.c
+++ b/drivers/ide/pdc202xx_new.c
@@ -258,7 +258,7 @@ static long detect_pll_input_clock(unsigned long dma_base)
 	outb(scr1 | 0x40, dma_base + 0x03);
 
 	/* Let the counter run for 10 ms. */
-	mdelay(10);
+	usleep_range(10000, 11000);
 
 	end_count = read_counter(dma_base);
 	end_time = ktime_get();
-- 
1.9.1
