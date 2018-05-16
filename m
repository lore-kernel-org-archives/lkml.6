Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeEPEmg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 00:42:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56638 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbeEPEmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 00:42:35 -0400
To: moderated for non-subscribers <alsa-devel@alsa-project.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ASoC: codecs: fix pcm1789.c build errors
Cc: =?UTF-8?Q?Myl=c3=a8ne_Josserand?= <mylene.josserand@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <lkp@intel.com>
Message-ID: <c99575a2-5172-b42e-dd18-6bc763fee361@infradead.org>
Date: Tue, 15 May 2018 21:42:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors in pcm1789.c.
The source file needs to #include <linux/gpio/consumer.h> since it
uses interfaces and macros that are provided by it.
However, it does not need to #include <linux/gpio.h>, so drop it.

Fixes these build errors:

../sound/soc/codecs/pcm1789.c: In function 'pcm1789_common_init':
../sound/soc/codecs/pcm1789.c:247:2: error: implicit declaration of function 'devm_gpiod_get_optional' [-Werror=implicit-function-declaration]
  pcm1789->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
../sound/soc/codecs/pcm1789.c:247:57: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function)
  pcm1789->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
../sound/soc/codecs/pcm1789.c:251:2: error: implicit declaration of function 'gpiod_set_value_cansleep' [-Werror=implicit-function-declaration]
  gpiod_set_value_cansleep(pcm1789->reset, 0);

Fixes: 4ae340d1be36 ("ASoC: codecs: Add support for PCM1789")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mylène Josserand <mylene.josserand@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/codecs/pcm1789.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

BTW, MODULE_AUTHOR() still uses @free-electrons.com.

--- lnx-417-rc4.orig/sound/soc/codecs/pcm1789.c
+++ lnx-417-rc4/sound/soc/codecs/pcm1789.c
@@ -3,7 +3,7 @@
 // Copyright (C) 2018 Bootlin
 // Mylène Josserand <mylene.josserand@bootlin.com>
 
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/workqueue.h>
 
