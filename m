Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC324C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC2620836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ak8bciDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC2620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030423AbeFSSoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:44:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030279AbeFSSoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mSWtTY3YcQZE60KN8aCtk8XxzfEOMdcVGjJU3nQqnk4=; b=ak8bciDpoAXriz12mPSq8z+y1
        fsm5VnatzkPmacDBjup633FPlMGojQCjfiNKVtfaeGWU0+OVWQRbfb7ADmYAsCbVZGAMGf3ucd6pE
        9FYtrbbfnvbfoJ5Ln9GQl8ryty3f3XlvHPeVJZk3NI/+O6BYfLXYpVEoQXA1ANksEIjTeTlyJyrPV
        k7/as0BkS038xKDUn/qjuR6/QPqXz/CJp60i//1ORfWHyN6mgLmZ12vbpiP9bchsNT+ek5bmfQ8vz
        bmRfasastbbSG7Njf8Edo/PU9tn6Si6SAIXp9vCJKZq8MlSGA8GWu9iUdzSf7zXjOMeOX+YlvyRi8
        WNHqbEVKA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVLbw-0004H5-1M; Tue, 19 Jun 2018 18:44:12 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH treewide] headers: separate mod_devicetable.h from
 platform_device.h
Message-ID: <8f3c861c-af58-219c-00ef-8d269e9c6323@infradead.org>
Date:   Tue, 19 Jun 2018 11:44:11 -0700
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
---
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
 85 files changed, 85 insertions(+), 1 deletion(-)

--- linux-next-20180615.orig/include/linux/platform_device.h
+++ linux-next-20180615/include/linux/platform_device.h
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
--- linux-next-20180615.orig/drivers/auxdisplay/hd44780.c
+++ linux-next-20180615/drivers/auxdisplay/hd44780.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/slab.h>
--- linux-next-20180615.orig/drivers/char/hw_random/exynos-trng.c
+++ linux-next-20180615/drivers/char/hw_random/exynos-trng.c
@@ -19,6 +19,7 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
--- linux-next-20180615.orig/drivers/crypto/mediatek/mtk-platform.c
+++ linux-next-20180615/drivers/crypto/mediatek/mtk-platform.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include "mtk-platform.h"
--- linux-next-20180615.orig/drivers/crypto/qce/core.c
+++ linux-next-20180615/drivers/crypto/qce/core.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
--- linux-next-20180615.orig/drivers/dma/ep93xx_dma.c
+++ linux-next-20180615/drivers/dma/ep93xx_dma.c
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/dmaengine.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
--- linux-next-20180615.orig/drivers/dma/s3c24xx-dma.c
+++ linux-next-20180615/drivers/dma/s3c24xx-dma.c
@@ -35,6 +35,7 @@
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/platform_data/dma-s3c24xx.h>
 
--- linux-next-20180615.orig/drivers/extcon/extcon-intel-cht-wc.c
+++ linux-next-20180615/drivers/extcon/extcon-intel-cht-wc.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/intel_soc_pmic.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
--- linux-next-20180615.orig/drivers/extcon/extcon-qcom-spmi-misc.c
+++ linux-next-20180615/drivers/extcon/extcon-qcom-spmi-misc.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
--- linux-next-20180615.orig/drivers/hwmon/max197.c
+++ linux-next-20180615/drivers/hwmon/max197.c
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/slab.h>
--- linux-next-20180615.orig/drivers/hwmon/mc13783-adc.c
+++ linux-next-20180615/drivers/hwmon/mc13783-adc.c
@@ -23,6 +23,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/hwmon.h>
 #include <linux/slab.h>
 #include <linux/init.h>
--- linux-next-20180615.orig/drivers/mfd/cros_ec_dev.c
+++ linux-next-20180615/drivers/mfd/cros_ec_dev.c
@@ -20,6 +20,7 @@
 #include <linux/fs.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
--- linux-next-20180615.orig/drivers/media/platform/coda/imx-vdoa.c
+++ linux-next-20180615/drivers/media/platform/coda/imx-vdoa.c
@@ -18,6 +18,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 #include <linux/videodev2.h>
--- linux-next-20180615.orig/drivers/mfd/atmel-hlcdc.c
+++ linux-next-20180615/drivers/mfd/atmel-hlcdc.c
@@ -22,6 +22,7 @@
 #include <linux/mfd/atmel-hlcdc.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
--- linux-next-20180615.orig/drivers/media/platform/rcar-fcp.c
+++ linux-next-20180615/drivers/media/platform/rcar-fcp.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
--- linux-next-20180615.orig/drivers/nvmem/lpc18xx_eeprom.c
+++ linux-next-20180615/drivers/nvmem/lpc18xx_eeprom.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
--- linux-next-20180615.orig/drivers/net/ethernet/calxeda/xgmac.c
+++ linux-next-20180615/drivers/net/ethernet/calxeda/xgmac.c
@@ -14,6 +14,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/kernel.h>
 #include <linux/circ_buf.h>
 #include <linux/interrupt.h>
--- linux-next-20180615.orig/drivers/nvmem/mtk-efuse.c
+++ linux-next-20180615/drivers/nvmem/mtk-efuse.c
@@ -14,6 +14,7 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/io.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
--- linux-next-20180615.orig/drivers/net/wireless/ath/ath9k/ahb.c
+++ linux-next-20180615/drivers/net/wireless/ath/ath9k/ahb.c
@@ -19,6 +19,7 @@
 #include <linux/nl80211.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include "ath9k.h"
 
 static const struct platform_device_id ath9k_platform_id_table[] = {
--- linux-next-20180615.orig/drivers/nvmem/qfprom.c
+++ linux-next-20180615/drivers/nvmem/qfprom.c
@@ -13,6 +13,7 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/io.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
--- linux-next-20180615.orig/drivers/net/wireless/ti/wl12xx/main.c
+++ linux-next-20180615/drivers/net/wireless/ti/wl12xx/main.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include <linux/err.h>
--- linux-next-20180615.orig/drivers/net/wireless/ti/wl18xx/main.c
+++ linux-next-20180615/drivers/net/wireless/ti/wl18xx/main.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/ip.h>
 #include <linux/firmware.h>
--- linux-next-20180615.orig/drivers/nvmem/uniphier-efuse.c
+++ linux-next-20180615/drivers/nvmem/uniphier-efuse.c
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
 
--- linux-next-20180615.orig/drivers/pinctrl/intel/pinctrl-merrifield.c
+++ linux-next-20180615/drivers/pinctrl/intel/pinctrl-merrifield.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
--- linux-next-20180615.orig/drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c
+++ linux-next-20180615/drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include "pinctrl-sprd.h"
--- linux-next-20180615.orig/drivers/platform/x86/intel_bxtwc_tmu.c
+++ linux-next-20180615/drivers/platform/x86/intel_bxtwc_tmu.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/intel_soc_pmic.h>
--- linux-next-20180615.orig/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
+++ linux-next-20180615/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
--- linux-next-20180615.orig/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
+++ linux-next-20180615/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
--- linux-next-20180615.orig/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
+++ linux-next-20180615/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
--- linux-next-20180615.orig/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
+++ linux-next-20180615/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
--- linux-next-20180615.orig/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ linux-next-20180615/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
--- linux-next-20180615.orig/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
+++ linux-next-20180615/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
--- linux-next-20180615.orig/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
+++ linux-next-20180615/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
--- linux-next-20180615.orig/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
+++ linux-next-20180615/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
--- linux-next-20180615.orig/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
+++ linux-next-20180615/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
@@ -15,6 +15,7 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
--- linux-next-20180615.orig/drivers/power/reset/ltc2952-poweroff.c
+++ linux-next-20180615/drivers/power/reset/ltc2952-poweroff.c
@@ -62,6 +62,7 @@
 #include <linux/slab.h>
 #include <linux/kmod.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/gpio/consumer.h>
 #include <linux/reboot.h>
 
--- linux-next-20180615.orig/drivers/power/supply/max8998_charger.c
+++ linux-next-20180615/drivers/power/supply/max8998_charger.c
@@ -21,6 +21,7 @@
 
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
--- linux-next-20180615.orig/drivers/ptp/ptp_dte.c
+++ linux-next-20180615/drivers/ptp/ptp_dte.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/types.h>
--- linux-next-20180615.orig/drivers/regulator/tps65912-regulator.c
+++ linux-next-20180615/drivers/regulator/tps65912-regulator.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 
--- linux-next-20180615.orig/drivers/reset/reset-ath79.c
+++ linux-next-20180615/drivers/reset/reset-ath79.c
@@ -17,6 +17,7 @@
 
 #include <linux/io.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/reboot.h>
--- linux-next-20180615.orig/drivers/reset/reset-axs10x.c
+++ linux-next-20180615/drivers/reset/reset-axs10x.c
@@ -10,6 +10,7 @@
 
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 
--- linux-next-20180615.orig/drivers/reset/reset-imx7.c
+++ linux-next-20180615/drivers/reset/reset-imx7.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/mfd/syscon.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/regmap.h>
--- linux-next-20180615.orig/drivers/rtc/rtc-coh901331.c
+++ linux-next-20180615/drivers/rtc/rtc-coh901331.c
@@ -8,6 +8,7 @@
  */
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/rtc.h>
 #include <linux/clk.h>
 #include <linux/interrupt.h>
--- linux-next-20180615.orig/drivers/siox/siox-bus-gpio.c
+++ linux-next-20180615/drivers/siox/siox-bus-gpio.c
@@ -5,6 +5,7 @@
 
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include <linux/delay.h>
--- linux-next-20180615.orig/drivers/rtc/rtc-cpcap.c
+++ linux-next-20180615/drivers/rtc/rtc-cpcap.c
@@ -24,6 +24,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
--- linux-next-20180615.orig/drivers/rtc/rtc-ftrtc010.c
+++ linux-next-20180615/drivers/rtc/rtc-ftrtc010.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/clk.h>
 
 #define DRV_NAME        "rtc-ftrtc010"
--- linux-next-20180615.orig/drivers/rtc/rtc-mc13xxx.c
+++ linux-next-20180615/drivers/rtc/rtc-mc13xxx.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/rtc.h>
 
--- linux-next-20180615.orig/drivers/rtc/rtc-r7301.c
+++ linux-next-20180615/drivers/rtc/rtc-r7301.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/delay.h>
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
--- linux-next-20180615.orig/drivers/rtc/rtc-tegra.c
+++ linux-next-20180615/drivers/rtc/rtc-tegra.c
@@ -25,6 +25,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/rtc.h>
--- linux-next-20180615.orig/drivers/tty/serial/sccnxp.c
+++ linux-next-20180615/drivers/tty/serial/sccnxp.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/device.h>
 #include <linux/console.h>
 #include <linux/serial_core.h>
--- linux-next-20180615.orig/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
+++ linux-next-20180615/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
@@ -12,6 +12,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
--- linux-next-20180615.orig/drivers/w1/masters/mxc_w1.c
+++ linux-next-20180615/drivers/w1/masters/mxc_w1.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include <linux/w1.h>
--- linux-next-20180615.orig/drivers/watchdog/davinci_wdt.c
+++ linux-next-20180615/drivers/watchdog/davinci_wdt.c
@@ -13,6 +13,7 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mod_devicetable.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/watchdog.h>
--- linux-next-20180615.orig/drivers/watchdog/imgpdc_wdt.c
+++ linux-next-20180615/drivers/watchdog/imgpdc_wdt.c
@@ -44,6 +44,7 @@
 #include <linux/io.h>
 #include <linux/log2.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/watchdog.h>
--- linux-next-20180615.orig/drivers/watchdog/max63xx_wdt.c
+++ linux-next-20180615/drivers/watchdog/max63xx_wdt.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mod_devicetable.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/watchdog.h>
--- linux-next-20180615.orig/drivers/watchdog/max77620_wdt.c
+++ linux-next-20180615/drivers/watchdog/max77620_wdt.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mfd/max77620.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
--- linux-next-20180615.orig/drivers/watchdog/moxart_wdt.c
+++ linux-next-20180615/drivers/watchdog/moxart_wdt.c
@@ -13,6 +13,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
--- linux-next-20180615.orig/drivers/watchdog/omap_wdt.c
+++ linux-next-20180615/drivers/watchdog/omap_wdt.c
@@ -29,6 +29,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
--- linux-next-20180615.orig/drivers/watchdog/tangox_wdt.c
+++ linux-next-20180615/drivers/watchdog/tangox_wdt.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 
--- linux-next-20180615.orig/drivers/tty/goldfish.c
+++ linux-next-20180615/drivers/tty/goldfish.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/goldfish.h>
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
--- linux-next-20180615.orig/drivers/net/ethernet/faraday/ftmac100.c
+++ linux-next-20180615/drivers/net/ethernet/faraday/ftmac100.c
@@ -29,6 +29,7 @@
 #include <linux/io.h>
 #include <linux/mii.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/netdevice.h>
 #include <linux/platform_device.h>
 
--- linux-next-20180615.orig/drivers/power/supply/olpc_battery.c
+++ linux-next-20180615/drivers/power/supply/olpc_battery.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/types.h>
 #include <linux/err.h>
 #include <linux/device.h>
--- linux-next-20180615.orig/arch/arm/mach-mmp/sram.c
+++ linux-next-20180615/arch/arm/mach-mmp/sram.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
--- linux-next-20180615.orig/drivers/ata/pata_imx.c
+++ linux-next-20180615/drivers/ata/pata_imx.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/libata.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #define DRV_NAME "pata_imx"
--- linux-next-20180615.orig/drivers/ata/pata_samsung_cf.c
+++ linux-next-20180615/drivers/ata/pata_samsung_cf.c
@@ -17,6 +17,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/libata.h>
--- linux-next-20180615.orig/drivers/char/hw_random/atmel-rng.c
+++ linux-next-20180615/drivers/char/hw_random/atmel-rng.c
@@ -8,6 +8,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/clk.h>
--- linux-next-20180615.orig/drivers/char/hw_random/imx-rngc.c
+++ linux-next-20180615/drivers/char/hw_random/imx-rngc.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/clk.h>
--- linux-next-20180615.orig/drivers/crypto/stm32/stm32_crc32.c
+++ linux-next-20180615/drivers/crypto/stm32/stm32_crc32.c
@@ -7,6 +7,7 @@
 #include <linux/bitrev.h>
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include <crypto/internal/hash.h>
--- linux-next-20180615.orig/drivers/crypto/ux500/cryp/cryp_core.c
+++ linux-next-20180615/drivers/crypto/ux500/cryp/cryp_core.c
@@ -20,6 +20,7 @@
 #include <linux/irqreturn.h>
 #include <linux/klist.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/semaphore.h>
--- linux-next-20180615.orig/drivers/crypto/ux500/hash/hash_core.c
+++ linux-next-20180615/drivers/crypto/ux500/hash/hash_core.c
@@ -21,6 +21,7 @@
 #include <linux/klist.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/crypto.h>
 
--- linux-next-20180615.orig/drivers/devfreq/tegra-devfreq.c
+++ linux-next-20180615/drivers/devfreq/tegra-devfreq.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/reset.h>
--- linux-next-20180615.orig/drivers/gpu/drm/mediatek/mtk_cec.c
+++ linux-next-20180615/drivers/gpu/drm/mediatek/mtk_cec.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include "mtk_cec.h"
--- linux-next-20180615.orig/drivers/gpu/drm/sun4i/sun6i_drc.c
+++ linux-next-20180615/drivers/gpu/drm/sun4i/sun6i_drc.c
@@ -12,6 +12,7 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
--- linux-next-20180615.orig/drivers/hsi/controllers/omap_ssi_port.c
+++ linux-next-20180615/drivers/hsi/controllers/omap_ssi_port.c
@@ -20,6 +20,7 @@
  * 02110-1301 USA
  */
 
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
--- linux-next-20180615.orig/drivers/mtd/nand/raw/brcmnand/brcmstb_nand.c
+++ linux-next-20180615/drivers/mtd/nand/raw/brcmnand/brcmstb_nand.c
@@ -13,6 +13,7 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include "brcmnand.h"
--- linux-next-20180615.orig/drivers/perf/arm-ccn.c
+++ linux-next-20180615/drivers/perf/arm-ccn.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
--- linux-next-20180615.orig/drivers/platform/goldfish/goldfish_pipe.c
+++ linux-next-20180615/drivers/platform/goldfish/goldfish_pipe.c
@@ -48,6 +48,7 @@
 
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
--- linux-next-20180615.orig/drivers/power/avs/smartreflex.c
+++ linux-next-20180615/drivers/power/avs/smartreflex.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <linux/io.h>
--- linux-next-20180615.orig/drivers/rtc/rtc-mxc_v2.c
+++ linux-next-20180615/drivers/rtc/rtc-mxc_v2.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
 
--- linux-next-20180615.orig/drivers/rtc/rtc-sh.c
+++ linux-next-20180615/drivers/rtc/rtc-sh.c
@@ -15,6 +15,7 @@
  * for more details.
  */
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/kernel.h>
 #include <linux/bcd.h>
 #include <linux/rtc.h>
--- linux-next-20180615.orig/drivers/tty/serial/8250/8250_em.c
+++ linux-next-20180615/drivers/tty/serial/8250/8250_em.c
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
 #include <linux/platform_device.h>
--- linux-next-20180615.orig/drivers/usb/gadget/udc/fsl_mxc_udc.c
+++ linux-next-20180615/drivers/usb/gadget/udc/fsl_mxc_udc.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/fsl_devices.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
--- linux-next-20180615.orig/drivers/watchdog/coh901327_wdt.c
+++ linux-next-20180615/drivers/watchdog/coh901327_wdt.c
@@ -7,6 +7,7 @@
  * Author: Linus Walleij <linus.walleij@stericsson.com>
  */
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 #include <linux/interrupt.h>
--- linux-next-20180615.orig/drivers/memory/tegra/tegra186.c
+++ linux-next-20180615/drivers/memory/tegra/tegra186.c
@@ -8,6 +8,7 @@
 
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include <dt-bindings/memory/tegra186-mc.h>
--- linux-next-20180615.orig/drivers/char/hw_random/powernv-rng.c
+++ linux-next-20180615/drivers/char/hw_random/powernv-rng.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/random.h>


