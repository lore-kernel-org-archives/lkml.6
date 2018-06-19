Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E37C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7295320661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wcr7fRSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7295320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbeFSW0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:26:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34708 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752983AbeFSW0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gqAPjaXHiKyQTWAngh2laA836qwqCLgxCR01xV2eiyc=; b=wcr7fRSDBvd2k769laikL/GeLq
        iCPk6nPiEhjWEYqcNNlPlfdfU/o3d26ywkCQxIPoQCx1xTjY6pbG15H/xw311ynGfchHsfvUi5Aut
        us+VxbRYckcUjvkos6gP47ZRhJdgwgarXRwL2cEt171aHAhn87DOQSX89CDWym4kBsXBASjUWwrBQ
        VEFUmFfATvxKxeKJQ0vk4VKHw3ayV5FSV5moSOxlRhSzAwl9di7PnOhsUGFC3cSqw0BdUIEEY7RHl
        4QYMrAmWxYRMHiNeFmN8iApM5fsa1/xSG74zTlL1HtClRTdT59C1t1XmJOZhvp+rB3qzbG6NyCZbz
        nHRu12sw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVP55-00029Q-VS; Tue, 19 Jun 2018 22:26:32 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild test robot <lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 treewide] headers: separate mod_devicetable.h and
 platform_device.h
Message-ID: <ba6c3354-a4e7-bd1b-5171-b422d04cfe28@infradead.org>
Date:   Tue, 19 Jun 2018 15:26:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

At over 4000 #includes, <linux/platform_device.h> is the 9th most
#included header file in the Linux kernel.  It does not need
<linux/mod_devicetable.h>, so drop that header and explicitly add
<linux/mod_devicetable.h> to source files that need it.

   4146 #include <linux/platform_device.h>

After this patch, there are 225 files that use <linux/mod_devicetable.h>,
for a reduction of around 3900 times that <linux/mod_devicetable.h>
does not have to be read & parsed.

    225 #include <linux/mod_devicetable.h>

This patch was build-tested on 20 different arch-es.

It also makes these drivers SubmitChecklist#1 compliant.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kbuild test robot <lkp@intel.com> # drivers/media/platform/vimc/
---
v2: add fixes for drivers/media/platform/vimc/

 arch/arm/mach-mmp/sram.c                                      |    1 +
 drivers/ata/pata_imx.c                                        |    1 +
 drivers/ata/pata_samsung_cf.c                                 |    1 +
 drivers/auxdisplay/hd44780.c                                  |    1 +
 drivers/char/hw_random/atmel-rng.c                            |    1 +
 drivers/char/hw_random/exynos-trng.c                          |    1 +
 drivers/char/hw_random/imx-rngc.c                             |    1 +
 drivers/char/hw_random/powernv-rng.c                          |    1 +
 drivers/crypto/mediatek/mtk-platform.c                        |    1 +
 drivers/crypto/qce/core.c                                     |    1 +
 drivers/crypto/stm32/stm32_crc32.c                            |    1 +
 drivers/crypto/ux500/cryp/cryp_core.c                         |    1 +
 drivers/crypto/ux500/hash/hash_core.c                         |    1 +
 drivers/devfreq/tegra-devfreq.c                               |    1 +
 drivers/dma/ep93xx_dma.c                                      |    1 +
 drivers/dma/s3c24xx-dma.c                                     |    1 +
 drivers/extcon/extcon-intel-cht-wc.c                          |    1 +
 drivers/extcon/extcon-qcom-spmi-misc.c                        |    1 +
 drivers/gpu/drm/mediatek/mtk_cec.c                            |    1 +
 drivers/gpu/drm/sun4i/sun6i_drc.c                             |    1 +
 drivers/hsi/controllers/omap_ssi_port.c                       |    1 +
 drivers/hwmon/max197.c                                        |    1 +
 drivers/hwmon/mc13783-adc.c                                   |    1 +
 drivers/media/platform/coda/imx-vdoa.c                        |    1 +
 drivers/media/platform/rcar-fcp.c                             |    1 +
 drivers/media/platform/vimc/vimc-capture.c                    |    1 +
 drivers/media/platform/vimc/vimc-debayer.c                    |    1 +
 drivers/media/platform/vimc/vimc-scaler.c                     |    1 +
 drivers/media/platform/vimc/vimc-sensor.c                     |    1 +
 drivers/memory/tegra/tegra186.c                               |    1 +
 drivers/mfd/atmel-hlcdc.c                                     |    1 +
 drivers/mfd/cros_ec_dev.c                                     |    1 +
 drivers/mtd/nand/raw/brcmnand/brcmstb_nand.c                  |    1 +
 drivers/net/ethernet/calxeda/xgmac.c                          |    1 +
 drivers/net/ethernet/faraday/ftmac100.c                       |    1 +
 drivers/net/wireless/ath/ath9k/ahb.c                          |    1 +
 drivers/net/wireless/ti/wl12xx/main.c                         |    1 +
 drivers/net/wireless/ti/wl18xx/main.c                         |    1 +
 drivers/nvmem/lpc18xx_eeprom.c                                |    1 +
 drivers/nvmem/mtk-efuse.c                                     |    1 +
 drivers/nvmem/qfprom.c                                        |    1 +
 drivers/nvmem/uniphier-efuse.c                                |    1 +
 drivers/perf/arm-ccn.c                                        |    1 +
 drivers/pinctrl/intel/pinctrl-merrifield.c                    |    1 +
 drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c                    |    1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c              |    1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c              |    1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c               |    1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c              |    1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c              |    1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c              |    1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c              |    1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c              |    1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c              |    1 +
 drivers/platform/goldfish/goldfish_pipe.c                     |    1 +
 drivers/platform/x86/intel_bxtwc_tmu.c                        |    1 +
 drivers/power/avs/smartreflex.c                               |    1 +
 drivers/power/reset/ltc2952-poweroff.c                        |    1 +
 drivers/power/supply/max8998_charger.c                        |    1 +
 drivers/power/supply/olpc_battery.c                           |    1 +
 drivers/ptp/ptp_dte.c                                         |    1 +
 drivers/regulator/tps65912-regulator.c                        |    1 +
 drivers/reset/reset-ath79.c                                   |    1 +
 drivers/reset/reset-axs10x.c                                  |    1 +
 drivers/reset/reset-imx7.c                                    |    1 +
 drivers/rtc/rtc-coh901331.c                                   |    1 +
 drivers/rtc/rtc-cpcap.c                                       |    1 +
 drivers/rtc/rtc-ftrtc010.c                                    |    1 +
 drivers/rtc/rtc-mc13xxx.c                                     |    1 +
 drivers/rtc/rtc-mxc_v2.c                                      |    1 +
 drivers/rtc/rtc-r7301.c                                       |    1 +
 drivers/rtc/rtc-sh.c                                          |    1 +
 drivers/rtc/rtc-tegra.c                                       |    1 +
 drivers/siox/siox-bus-gpio.c                                  |    1 +
 drivers/tty/goldfish.c                                        |    1 +
 drivers/tty/serial/8250/8250_em.c                             |    1 +
 drivers/tty/serial/sccnxp.c                                   |    1 +
 drivers/usb/gadget/udc/fsl_mxc_udc.c                          |    1 +
 drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c |    1 +
 drivers/w1/masters/mxc_w1.c                                   |    1 +
 drivers/watchdog/coh901327_wdt.c                              |    1 +
 drivers/watchdog/davinci_wdt.c                                |    1 +
 drivers/watchdog/imgpdc_wdt.c                                 |    1 +
 drivers/watchdog/max63xx_wdt.c                                |    1 +
 drivers/watchdog/max77620_wdt.c                               |    1 +
 drivers/watchdog/moxart_wdt.c                                 |    1 +
 drivers/watchdog/omap_wdt.c                                   |    1 +
 drivers/watchdog/tangox_wdt.c                                 |    1 +
 include/linux/platform_device.h                               |    2 +-
 89 files changed, 89 insertions(+), 1 deletion(-)

--- lnx-418-rc1.orig/include/linux/platform_device.h
+++ lnx-418-rc1/include/linux/platform_device.h
@@ -12,13 +12,13 @@
 #define _PLATFORM_DEVICE_H_
 
 #include <linux/device.h>
-#include <linux/mod_devicetable.h>
 
 #define PLATFORM_DEVID_NONE	(-1)
 #define PLATFORM_DEVID_AUTO	(-2)
 
 struct mfd_cell;
 struct property_entry;
+struct platform_device_id;
 
 struct platform_device {
 	const char	*name;
--- lnx-418-rc1.orig/drivers/auxdisplay/hd44780.c
+++ lnx-418-rc1/drivers/auxdisplay/hd44780.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/slab.h>
--- lnx-418-rc1.orig/drivers/char/hw_random/exynos-trng.c
+++ lnx-418-rc1/drivers/char/hw_random/exynos-trng.c
@@ -19,6 +19,7 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
--- lnx-418-rc1.orig/drivers/crypto/mediatek/mtk-platform.c
+++ lnx-418-rc1/drivers/crypto/mediatek/mtk-platform.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include "mtk-platform.h"
--- lnx-418-rc1.orig/drivers/crypto/qce/core.c
+++ lnx-418-rc1/drivers/crypto/qce/core.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
--- lnx-418-rc1.orig/drivers/dma/ep93xx_dma.c
+++ lnx-418-rc1/drivers/dma/ep93xx_dma.c
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/dmaengine.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
--- lnx-418-rc1.orig/drivers/dma/s3c24xx-dma.c
+++ lnx-418-rc1/drivers/dma/s3c24xx-dma.c
@@ -35,6 +35,7 @@
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/platform_data/dma-s3c24xx.h>
 
--- lnx-418-rc1.orig/drivers/extcon/extcon-intel-cht-wc.c
+++ lnx-418-rc1/drivers/extcon/extcon-intel-cht-wc.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/intel_soc_pmic.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
--- lnx-418-rc1.orig/drivers/extcon/extcon-qcom-spmi-misc.c
+++ lnx-418-rc1/drivers/extcon/extcon-qcom-spmi-misc.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
--- lnx-418-rc1.orig/drivers/hwmon/max197.c
+++ lnx-418-rc1/drivers/hwmon/max197.c
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/slab.h>
--- lnx-418-rc1.orig/drivers/hwmon/mc13783-adc.c
+++ lnx-418-rc1/drivers/hwmon/mc13783-adc.c
@@ -23,6 +23,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/hwmon.h>
 #include <linux/slab.h>
 #include <linux/init.h>
--- lnx-418-rc1.orig/drivers/mfd/cros_ec_dev.c
+++ lnx-418-rc1/drivers/mfd/cros_ec_dev.c
@@ -20,6 +20,7 @@
 #include <linux/fs.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
--- lnx-418-rc1.orig/drivers/media/platform/coda/imx-vdoa.c
+++ lnx-418-rc1/drivers/media/platform/coda/imx-vdoa.c
@@ -18,6 +18,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 #include <linux/videodev2.h>
--- lnx-418-rc1.orig/drivers/mfd/atmel-hlcdc.c
+++ lnx-418-rc1/drivers/mfd/atmel-hlcdc.c
@@ -22,6 +22,7 @@
 #include <linux/mfd/atmel-hlcdc.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
--- lnx-418-rc1.orig/drivers/media/platform/rcar-fcp.c
+++ lnx-418-rc1/drivers/media/platform/rcar-fcp.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
--- lnx-418-rc1.orig/drivers/nvmem/lpc18xx_eeprom.c
+++ lnx-418-rc1/drivers/nvmem/lpc18xx_eeprom.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
--- lnx-418-rc1.orig/drivers/net/ethernet/calxeda/xgmac.c
+++ lnx-418-rc1/drivers/net/ethernet/calxeda/xgmac.c
@@ -14,6 +14,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/kernel.h>
 #include <linux/circ_buf.h>
 #include <linux/interrupt.h>
--- lnx-418-rc1.orig/drivers/nvmem/mtk-efuse.c
+++ lnx-418-rc1/drivers/nvmem/mtk-efuse.c
@@ -14,6 +14,7 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/io.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
--- lnx-418-rc1.orig/drivers/net/wireless/ath/ath9k/ahb.c
+++ lnx-418-rc1/drivers/net/wireless/ath/ath9k/ahb.c
@@ -19,6 +19,7 @@
 #include <linux/nl80211.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include "ath9k.h"
 
 static const struct platform_device_id ath9k_platform_id_table[] = {
--- lnx-418-rc1.orig/drivers/nvmem/qfprom.c
+++ lnx-418-rc1/drivers/nvmem/qfprom.c
@@ -13,6 +13,7 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/io.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
--- lnx-418-rc1.orig/drivers/net/wireless/ti/wl12xx/main.c
+++ lnx-418-rc1/drivers/net/wireless/ti/wl12xx/main.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include <linux/err.h>
--- lnx-418-rc1.orig/drivers/net/wireless/ti/wl18xx/main.c
+++ lnx-418-rc1/drivers/net/wireless/ti/wl18xx/main.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/ip.h>
 #include <linux/firmware.h>
--- lnx-418-rc1.orig/drivers/nvmem/uniphier-efuse.c
+++ lnx-418-rc1/drivers/nvmem/uniphier-efuse.c
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
 
--- lnx-418-rc1.orig/drivers/pinctrl/intel/pinctrl-merrifield.c
+++ lnx-418-rc1/drivers/pinctrl/intel/pinctrl-merrifield.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
--- lnx-418-rc1.orig/drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c
+++ lnx-418-rc1/drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include "pinctrl-sprd.h"
--- lnx-418-rc1.orig/drivers/platform/x86/intel_bxtwc_tmu.c
+++ lnx-418-rc1/drivers/platform/x86/intel_bxtwc_tmu.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/intel_soc_pmic.h>
--- lnx-418-rc1.orig/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
+++ lnx-418-rc1/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
--- lnx-418-rc1.orig/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
+++ lnx-418-rc1/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
--- lnx-418-rc1.orig/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
+++ lnx-418-rc1/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
--- lnx-418-rc1.orig/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
+++ lnx-418-rc1/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
--- lnx-418-rc1.orig/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ lnx-418-rc1/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
--- lnx-418-rc1.orig/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
+++ lnx-418-rc1/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
--- lnx-418-rc1.orig/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
+++ lnx-418-rc1/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
--- lnx-418-rc1.orig/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
+++ lnx-418-rc1/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
--- lnx-418-rc1.orig/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
+++ lnx-418-rc1/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
@@ -15,6 +15,7 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
--- lnx-418-rc1.orig/drivers/power/reset/ltc2952-poweroff.c
+++ lnx-418-rc1/drivers/power/reset/ltc2952-poweroff.c
@@ -62,6 +62,7 @@
 #include <linux/slab.h>
 #include <linux/kmod.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/gpio/consumer.h>
 #include <linux/reboot.h>
 
--- lnx-418-rc1.orig/drivers/power/supply/max8998_charger.c
+++ lnx-418-rc1/drivers/power/supply/max8998_charger.c
@@ -21,6 +21,7 @@
 
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
--- lnx-418-rc1.orig/drivers/ptp/ptp_dte.c
+++ lnx-418-rc1/drivers/ptp/ptp_dte.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/types.h>
--- lnx-418-rc1.orig/drivers/regulator/tps65912-regulator.c
+++ lnx-418-rc1/drivers/regulator/tps65912-regulator.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 
--- lnx-418-rc1.orig/drivers/reset/reset-ath79.c
+++ lnx-418-rc1/drivers/reset/reset-ath79.c
@@ -17,6 +17,7 @@
 
 #include <linux/io.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/reboot.h>
--- lnx-418-rc1.orig/drivers/reset/reset-axs10x.c
+++ lnx-418-rc1/drivers/reset/reset-axs10x.c
@@ -10,6 +10,7 @@
 
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 
--- lnx-418-rc1.orig/drivers/reset/reset-imx7.c
+++ lnx-418-rc1/drivers/reset/reset-imx7.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/mfd/syscon.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/regmap.h>
--- lnx-418-rc1.orig/drivers/rtc/rtc-coh901331.c
+++ lnx-418-rc1/drivers/rtc/rtc-coh901331.c
@@ -8,6 +8,7 @@
  */
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/rtc.h>
 #include <linux/clk.h>
 #include <linux/interrupt.h>
--- lnx-418-rc1.orig/drivers/siox/siox-bus-gpio.c
+++ lnx-418-rc1/drivers/siox/siox-bus-gpio.c
@@ -5,6 +5,7 @@
 
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include <linux/delay.h>
--- lnx-418-rc1.orig/drivers/rtc/rtc-cpcap.c
+++ lnx-418-rc1/drivers/rtc/rtc-cpcap.c
@@ -24,6 +24,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
--- lnx-418-rc1.orig/drivers/rtc/rtc-ftrtc010.c
+++ lnx-418-rc1/drivers/rtc/rtc-ftrtc010.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/clk.h>
 
 #define DRV_NAME        "rtc-ftrtc010"
--- lnx-418-rc1.orig/drivers/rtc/rtc-mc13xxx.c
+++ lnx-418-rc1/drivers/rtc/rtc-mc13xxx.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/rtc.h>
 
--- lnx-418-rc1.orig/drivers/rtc/rtc-r7301.c
+++ lnx-418-rc1/drivers/rtc/rtc-r7301.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/delay.h>
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
--- lnx-418-rc1.orig/drivers/rtc/rtc-tegra.c
+++ lnx-418-rc1/drivers/rtc/rtc-tegra.c
@@ -25,6 +25,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/rtc.h>
--- lnx-418-rc1.orig/drivers/tty/serial/sccnxp.c
+++ lnx-418-rc1/drivers/tty/serial/sccnxp.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/device.h>
 #include <linux/console.h>
 #include <linux/serial_core.h>
--- lnx-418-rc1.orig/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
+++ lnx-418-rc1/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
@@ -12,6 +12,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
--- lnx-418-rc1.orig/drivers/w1/masters/mxc_w1.c
+++ lnx-418-rc1/drivers/w1/masters/mxc_w1.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include <linux/w1.h>
--- lnx-418-rc1.orig/drivers/watchdog/davinci_wdt.c
+++ lnx-418-rc1/drivers/watchdog/davinci_wdt.c
@@ -13,6 +13,7 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mod_devicetable.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/watchdog.h>
--- lnx-418-rc1.orig/drivers/watchdog/imgpdc_wdt.c
+++ lnx-418-rc1/drivers/watchdog/imgpdc_wdt.c
@@ -44,6 +44,7 @@
 #include <linux/io.h>
 #include <linux/log2.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/watchdog.h>
--- lnx-418-rc1.orig/drivers/watchdog/max63xx_wdt.c
+++ lnx-418-rc1/drivers/watchdog/max63xx_wdt.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mod_devicetable.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/watchdog.h>
--- lnx-418-rc1.orig/drivers/watchdog/max77620_wdt.c
+++ lnx-418-rc1/drivers/watchdog/max77620_wdt.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mfd/max77620.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
--- lnx-418-rc1.orig/drivers/watchdog/moxart_wdt.c
+++ lnx-418-rc1/drivers/watchdog/moxart_wdt.c
@@ -13,6 +13,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
--- lnx-418-rc1.orig/drivers/watchdog/omap_wdt.c
+++ lnx-418-rc1/drivers/watchdog/omap_wdt.c
@@ -29,6 +29,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
--- lnx-418-rc1.orig/drivers/watchdog/tangox_wdt.c
+++ lnx-418-rc1/drivers/watchdog/tangox_wdt.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 
--- lnx-418-rc1.orig/drivers/tty/goldfish.c
+++ lnx-418-rc1/drivers/tty/goldfish.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/goldfish.h>
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
--- lnx-418-rc1.orig/drivers/net/ethernet/faraday/ftmac100.c
+++ lnx-418-rc1/drivers/net/ethernet/faraday/ftmac100.c
@@ -29,6 +29,7 @@
 #include <linux/io.h>
 #include <linux/mii.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/netdevice.h>
 #include <linux/platform_device.h>
 
--- lnx-418-rc1.orig/drivers/power/supply/olpc_battery.c
+++ lnx-418-rc1/drivers/power/supply/olpc_battery.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/types.h>
 #include <linux/err.h>
 #include <linux/device.h>
--- lnx-418-rc1.orig/arch/arm/mach-mmp/sram.c
+++ lnx-418-rc1/arch/arm/mach-mmp/sram.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
--- lnx-418-rc1.orig/drivers/ata/pata_imx.c
+++ lnx-418-rc1/drivers/ata/pata_imx.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/libata.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #define DRV_NAME "pata_imx"
--- lnx-418-rc1.orig/drivers/ata/pata_samsung_cf.c
+++ lnx-418-rc1/drivers/ata/pata_samsung_cf.c
@@ -17,6 +17,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/libata.h>
--- lnx-418-rc1.orig/drivers/char/hw_random/atmel-rng.c
+++ lnx-418-rc1/drivers/char/hw_random/atmel-rng.c
@@ -8,6 +8,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/clk.h>
--- lnx-418-rc1.orig/drivers/char/hw_random/imx-rngc.c
+++ lnx-418-rc1/drivers/char/hw_random/imx-rngc.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/clk.h>
--- lnx-418-rc1.orig/drivers/crypto/stm32/stm32_crc32.c
+++ lnx-418-rc1/drivers/crypto/stm32/stm32_crc32.c
@@ -7,6 +7,7 @@
 #include <linux/bitrev.h>
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include <crypto/internal/hash.h>
--- lnx-418-rc1.orig/drivers/crypto/ux500/cryp/cryp_core.c
+++ lnx-418-rc1/drivers/crypto/ux500/cryp/cryp_core.c
@@ -20,6 +20,7 @@
 #include <linux/irqreturn.h>
 #include <linux/klist.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/semaphore.h>
--- lnx-418-rc1.orig/drivers/crypto/ux500/hash/hash_core.c
+++ lnx-418-rc1/drivers/crypto/ux500/hash/hash_core.c
@@ -21,6 +21,7 @@
 #include <linux/klist.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/crypto.h>
 
--- lnx-418-rc1.orig/drivers/devfreq/tegra-devfreq.c
+++ lnx-418-rc1/drivers/devfreq/tegra-devfreq.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/reset.h>
--- lnx-418-rc1.orig/drivers/gpu/drm/mediatek/mtk_cec.c
+++ lnx-418-rc1/drivers/gpu/drm/mediatek/mtk_cec.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include "mtk_cec.h"
--- lnx-418-rc1.orig/drivers/gpu/drm/sun4i/sun6i_drc.c
+++ lnx-418-rc1/drivers/gpu/drm/sun4i/sun6i_drc.c
@@ -12,6 +12,7 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
--- lnx-418-rc1.orig/drivers/hsi/controllers/omap_ssi_port.c
+++ lnx-418-rc1/drivers/hsi/controllers/omap_ssi_port.c
@@ -20,6 +20,7 @@
  * 02110-1301 USA
  */
 
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
--- lnx-418-rc1.orig/drivers/mtd/nand/raw/brcmnand/brcmstb_nand.c
+++ lnx-418-rc1/drivers/mtd/nand/raw/brcmnand/brcmstb_nand.c
@@ -13,6 +13,7 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include "brcmnand.h"
--- lnx-418-rc1.orig/drivers/perf/arm-ccn.c
+++ lnx-418-rc1/drivers/perf/arm-ccn.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
--- lnx-418-rc1.orig/drivers/platform/goldfish/goldfish_pipe.c
+++ lnx-418-rc1/drivers/platform/goldfish/goldfish_pipe.c
@@ -48,6 +48,7 @@
 
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
--- lnx-418-rc1.orig/drivers/power/avs/smartreflex.c
+++ lnx-418-rc1/drivers/power/avs/smartreflex.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <linux/io.h>
--- lnx-418-rc1.orig/drivers/rtc/rtc-mxc_v2.c
+++ lnx-418-rc1/drivers/rtc/rtc-mxc_v2.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
 
--- lnx-418-rc1.orig/drivers/rtc/rtc-sh.c
+++ lnx-418-rc1/drivers/rtc/rtc-sh.c
@@ -15,6 +15,7 @@
  * for more details.
  */
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/kernel.h>
 #include <linux/bcd.h>
 #include <linux/rtc.h>
--- lnx-418-rc1.orig/drivers/tty/serial/8250/8250_em.c
+++ lnx-418-rc1/drivers/tty/serial/8250/8250_em.c
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
 #include <linux/platform_device.h>
--- lnx-418-rc1.orig/drivers/usb/gadget/udc/fsl_mxc_udc.c
+++ lnx-418-rc1/drivers/usb/gadget/udc/fsl_mxc_udc.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/fsl_devices.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
--- lnx-418-rc1.orig/drivers/watchdog/coh901327_wdt.c
+++ lnx-418-rc1/drivers/watchdog/coh901327_wdt.c
@@ -7,6 +7,7 @@
  * Author: Linus Walleij <linus.walleij@stericsson.com>
  */
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 #include <linux/interrupt.h>
--- lnx-418-rc1.orig/drivers/memory/tegra/tegra186.c
+++ lnx-418-rc1/drivers/memory/tegra/tegra186.c
@@ -8,6 +8,7 @@
 
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include <dt-bindings/memory/tegra186-mc.h>
--- lnx-418-rc1.orig/drivers/char/hw_random/powernv-rng.c
+++ lnx-418-rc1/drivers/char/hw_random/powernv-rng.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/random.h>
--- lnx-418-rc1.orig/drivers/media/platform/vimc/vimc-capture.c
+++ lnx-418-rc1/drivers/media/platform/vimc/vimc-capture.c
@@ -17,6 +17,7 @@
 
 #include <linux/component.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <media/v4l2-ioctl.h>
 #include <media/videobuf2-core.h>
--- lnx-418-rc1.orig/drivers/media/platform/vimc/vimc-debayer.c
+++ lnx-418-rc1/drivers/media/platform/vimc/vimc-debayer.c
@@ -17,6 +17,7 @@
 
 #include <linux/component.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/vmalloc.h>
 #include <linux/v4l2-mediabus.h>
--- lnx-418-rc1.orig/drivers/media/platform/vimc/vimc-scaler.c
+++ lnx-418-rc1/drivers/media/platform/vimc/vimc-scaler.c
@@ -17,6 +17,7 @@
 
 #include <linux/component.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/vmalloc.h>
 #include <linux/v4l2-mediabus.h>
--- lnx-418-rc1.orig/drivers/media/platform/vimc/vimc-sensor.c
+++ lnx-418-rc1/drivers/media/platform/vimc/vimc-sensor.c
@@ -19,6 +19,7 @@
 #include <linux/freezer.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/v4l2-mediabus.h>
 #include <linux/vmalloc.h>


