Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AF7C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54E920881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="P3zqD6Qu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54E920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeJPPMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:12:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48806 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727155AbeJPPL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:11:59 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181016072251euoutp0177df880e519dd7b7df0e10698e4bce51~eBd2MuHOV1696916969euoutp01I;
        Tue, 16 Oct 2018 07:22:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181016072251euoutp0177df880e519dd7b7df0e10698e4bce51~eBd2MuHOV1696916969euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539674571;
        bh=rFY6POhluPHR0NWmZhD+Wgnhxg1mbLVaiWmhmfxp3NY=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=P3zqD6QuU5Gnxk3MIGmZlxU8ffXD8X8kqJVhszXT11Eb4uieuOT/p67E0QXXDfZm5
         DtQA+02zvadM+cmxAS18/u99IZFHkeH/nksodB9sNYf7D7o2JJao+fkUroUCfKxlCq
         eSw50UuAFOqXnmAcsmPLbAZD8DaDCw7Z7hFZXDYc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181016072251eucas1p1805bfdc282c0f1710e05647da5e8c9fe~eBd1voljO1922319223eucas1p1S;
        Tue, 16 Oct 2018 07:22:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 39.F8.04294.AC195CB5; Tue, 16
        Oct 2018 08:22:50 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181016072250eucas1p1a763670c8509d20a6e6847eadb246817~eBd00MPOo1939619396eucas1p1S;
        Tue, 16 Oct 2018 07:22:50 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-c3-5bc591ca8cfb
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E1.66.04128.AC195CB5; Tue, 16
        Oct 2018 08:22:50 +0100 (BST)
Received: from AMDC2768.DIGITAL.local ([106.120.43.17]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGO0048DKHZVR70@eusync1.samsung.com>;
        Tue, 16 Oct 2018 08:22:50 +0100 (BST)
From:   Andrzej Hajda <a.hajda@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm-kernel@lists.infradead.org, andy.shevchenko@gmail.com,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] drivers: use probe_err function in obvious cases
Date:   Tue, 16 Oct 2018 09:22:44 +0200
Message-id: <20181016072244.1216-4-a.hajda@samsung.com>
X-Mailer: git-send-email 2.18.0
In-reply-to: <20181016072244.1216-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7djPc7qnJh6NNti+wNji1rpzrBYvJxxm
        tNg4Yz2rxdSHT9gsmhevZ7NYOG05o8Wmx9dYLS7vmsNmsfbIXXaLuV+mMjtweeycdZfdY9Oq
        TjaP/XPXsHtsXlLv8X7fVTaPvi2rGD0+b5ILYI/isklJzcksSy3St0vgyli5fQJLwbkPHBWd
        f+YwNTBuXczexcjBISFgIrF0o14XIxeHkMAKRomuza/Yuhg5gZzPjBIHHwqC2CA1jy4dZ4Eo
        WsYocWvzOlYI5z+jxOF9t9lBqtgENCX+br4J1i0iYCzRf3YWO0gRs8AbJoknD6YwgSSEBVwl
        +i9cYwGxWQRUJbYv/g5m8wqYS3xs3MgMsU5e4uHxdkYQm1PAQuL6hs3MIIMkBNawSbR9PMYG
        UeQise5KLxOELSzx6vgWdghbRuLy5G4WCLteomnmFajmDkaJE4uXQzVbSxw+fpEVxGYW4JOY
        tG06MyQweCU62oQgTA+JtY1qEF92M0psvfieeQKj5AJGhlWM4qmlxbnpqcVGeanlesWJucWl
        eel6yfm5mxiBMXv63/EvOxh3/Uk6xCjAwajEw/vj+pFoIdbEsuLK3EOMEhzMSiK8spVHo4V4
        UxIrq1KL8uOLSnNSiw8xSnOwKInzLpu3MVpIID2xJDU7NbUgtQgmy8TBKdXA6Hmr5Mxenomr
        5qfd41yaY/JKwvhyT9j1lB65p9P4WBfZGcjIs7qnvbac8W3hpsK35wQWuedtnVNjfm6b3P5j
        VUcL+q7e36+9g7dtQcGH+KqOe/P8ExZMKf+7xE/UeNI/pvgJ3vOPn/5/JOLVAu9VZ+ZXP2rZ
        x2zY9cD8Sb3JL7X1uw1lUiP6upRYijMSDbWYi4oTASLXweXVAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsVy+t/xy7qnJh6NNti2ksvi1rpzrBYvJxxm
        tNg4Yz2rxdSHT9gsmhevZ7NYOG05o8Wmx9dYLS7vmsNmsfbIXXaLuV+mMjtweeycdZfdY9Oq
        TjaP/XPXsHtsXlLv8X7fVTaPvi2rGD0+b5ILYI/isklJzcksSy3St0vgyli5fQJLwbkPHBWd
        f+YwNTBuXczexcjJISFgIvHo0nGWLkYuDiGBJYwSu288gnIamSTWfToGVsUmoCnxd/NNNhBb
        RMBYov/sLHaQImaBd0wSs568YARJCAu4SvRfuMYCYrMIqEpsX/wdzOYVMJf42LiRGWKdvMTD
        4+1g9ZwCFhLXN2wGiwsB1dy+0MY+gZFnASPDKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMCQ
        23bs55YdjF3vgg8xCnAwKvHw/rh+JFqINbGsuDL3EKMEB7OSCK9s5dFoId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rznDSqjhATSE0tSs1NTC1KLYLJMHJxSDYz7BUtevtydsoqlbfX2xSxy9Y3i
        9bL/9zeE++ta31k7RX9FfWFZj9duliP/GNyMFMuMd4ZqdeUXvdy/6GeZI9exaYI3N4kEsv/Y
        vfKO8ZSvjSkS9d/TpLsOrrecOFuq+mvxJcbQ7UHNKo7aMxiFCja7zGWcu+zu4kqXLv/JWziu
        zilY+MjgU7sSS3FGoqEWc1FxIgD+uGmqNQIAAA==
X-CMS-MailID: 20181016072250eucas1p1a763670c8509d20a6e6847eadb246817
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016072250eucas1p1a763670c8509d20a6e6847eadb246817
References: <20181016072244.1216-1-a.hajda@samsung.com>
        <CGME20181016072250eucas1p1a763670c8509d20a6e6847eadb246817@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch replaces obviously matching code with probe_err function.
There are many more places where probe_err could be used.
The patch shows how the new function should be used, and how it
improves the code.

It was generated by cocci script (little bit dirty):

virtual context
virtual patch

@@
expression t, e, dev, err;
expression list l;
@@
-    if (t)
-   { err = e;
-   if (err != -EPROBE_DEFER) \({ dev_err(dev, l, err); }\|dev_err(dev, l, err);\)
-   return err; }
+   if (t) { err = e; return probe_err(dev, err, l, err); }

@@
expression t, e, dev, err;
expression list l;
@@
-    if (t)
-   { err = e;
-   if (err != -EPROBE_DEFER) \({ dev_err(dev, l); }\|dev_err(dev, l);\)
-   return err; }
+   if (t) return probe_err(dev, e, l);

@@
expression t, dev, err;
expression list l;
@@
-    if (t)
-   {
-   if (err != -EPROBE_DEFER) \({ dev_err(dev, l); }\|dev_err(dev, l);\)
-   return err; }
+   if (t) return probe_err(dev, err, l);

@@
expression t, e, dev, err;
expression list l;
@@
-    if (t)
-   { \(err = e;\|\)
-   if (err != ERR_PTR(-EPROBE_DEFER)) \({ dev_err(dev, l); }\|dev_err(dev, l);\)
-   return PTR_ERR(err); }
+   if (t) return probe_err(dev, PTR_ERR(err), l);

@@
expression err, dev;
expression list l;
identifier errlab;
@@
-   if (err != -EPROBE_DEFER) \({ dev_err(dev, l); }\|dev_err(dev, l);\)
+   probe_err(dev, err, l);
    goto errlab;

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/ata/libahci_platform.c                |  7 +-
 drivers/base/power/domain.c                   | 10 ++-
 drivers/bus/fsl-mc/fsl-mc-bus.c               |  8 +--
 drivers/bus/ts-nbus.c                         |  8 +--
 drivers/clk/qcom/clk-spmi-pmic-div.c          |  9 +--
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c          | 16 ++---
 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c       | 11 ++--
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c      |  5 +-
 drivers/cpufreq/qcom-cpufreq-kryo.c           | 10 ++-
 drivers/crypto/caam/caamalg_qi2.c             |  3 +-
 drivers/firmware/arm_scmi/driver.c            |  9 +--
 drivers/firmware/imx/imx-scu.c                |  7 +-
 drivers/gpio/gpio-pca953x.c                   |  4 +-
 drivers/gpio/gpio-pisosr.c                    |  9 +--
 .../gpu/drm/omapdrm/displays/encoder-opa362.c |  8 +--
 .../gpu/drm/omapdrm/displays/encoder-tfp410.c |  8 +--
 .../drm/omapdrm/displays/encoder-tpd12s015.c  |  8 +--
 drivers/gpu/drm/omapdrm/dss/dpi.c             |  8 +--
 drivers/gpu/drm/omapdrm/dss/dsi.c             |  8 +--
 drivers/gpu/drm/omapdrm/dss/hdmi4.c           |  8 +--
 drivers/gpu/drm/omapdrm/dss/hdmi5.c           |  8 +--
 drivers/gpu/drm/omapdrm/dss/sdi.c             |  8 +--
 drivers/gpu/drm/omapdrm/dss/venc.c            |  8 +--
 drivers/gpu/drm/panel/panel-lvds.c            | 10 ++-
 drivers/gpu/drm/panel/panel-simple.c          |  5 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c         |  5 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                 | 23 +++----
 drivers/hid/i2c-hid/i2c-hid-core.c            |  9 +--
 drivers/hwmon/pwm-fan.c                       |  7 +-
 drivers/i2c/busses/i2c-bcm2835.c              |  8 +--
 drivers/i2c/busses/i2c-rk3x.c                 | 10 ++-
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c    | 30 +++------
 drivers/i2c/muxes/i2c-mux-gpmux.c             | 16 ++---
 drivers/iio/adc/envelope-detector.c           | 23 +++----
 drivers/iio/adc/rcar-gyroadc.c                |  5 +-
 drivers/iio/afe/iio-rescale.c                 |  8 +--
 drivers/iio/dac/dpot-dac.c                    | 16 ++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 11 ++--
 drivers/iio/multiplexer/iio-mux.c             | 16 ++---
 drivers/input/keyboard/bcm-keypad.c           |  8 +--
 drivers/input/misc/pwm-beeper.c               | 12 ++--
 drivers/input/misc/pwm-vibra.c                | 18 ++---
 drivers/input/mouse/elan_i2c_core.c           |  6 +-
 drivers/input/touchscreen/bu21029_ts.c        | 14 ++--
 drivers/input/touchscreen/chipone_icn8318.c   |  5 +-
 drivers/input/touchscreen/ektf2127.c          |  5 +-
 drivers/input/touchscreen/elants_i2c.c        | 16 ++---
 drivers/input/touchscreen/pixcir_i2c_ts.c     | 10 ++-
 drivers/input/touchscreen/raydium_i2c_ts.c    | 20 +++---
 .../input/touchscreen/resistive-adc-touch.c   |  9 +--
 drivers/input/touchscreen/silead.c            | 15 ++---
 drivers/input/touchscreen/sis_i2c.c           | 12 ++--
 drivers/input/touchscreen/surface3_spi.c      |  9 +--
 drivers/leds/leds-pwm.c                       |  7 +-
 drivers/media/i2c/ad5820.c                    |  9 +--
 drivers/media/i2c/tc358743.c                  | 10 ++-
 drivers/media/platform/omap3isp/isp.c         |  3 +-
 drivers/media/platform/video-mux.c            |  4 +-
 drivers/media/rc/gpio-ir-recv.c               |  5 +-
 drivers/media/rc/gpio-ir-tx.c                 | 10 ++-
 drivers/mfd/madera-core.c                     |  6 +-
 drivers/mmc/host/bcm2835.c                    |  3 +-
 drivers/mmc/host/davinci_mmc.c                |  5 +-
 drivers/mmc/host/dw_mmc-zx.c                  |  6 +-
 drivers/mmc/host/jz4740_mmc.c                 |  5 +-
 drivers/mmc/host/meson-gx-mmc.c               | 17 ++---
 drivers/mmc/host/sdhci-of-arasan.c            |  8 +--
 drivers/mtd/nand/onenand/omap2.c              |  5 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c  | 20 +++---
 drivers/mux/gpio.c                            |  9 +--
 drivers/net/dsa/lantiq_gswip.c                |  8 +--
 drivers/net/ethernet/renesas/sh_eth.c         |  3 +-
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 10 +--
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   |  9 +--
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 10 +--
 drivers/net/ethernet/ti/cpsw.c                |  9 ++-
 drivers/net/ieee802154/mcr20a.c               |  5 +-
 drivers/net/phy/mdio-mux-mmioreg.c            |  9 +--
 drivers/opp/core.c                            | 12 ++--
 drivers/pci/controller/pcie-rockchip.c        | 66 +++++++------------
 drivers/phy/amlogic/phy-meson-gxl-usb2.c      |  9 +--
 drivers/phy/amlogic/phy-meson-gxl-usb3.c      |  9 +--
 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c      |  8 +--
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 21 +++---
 drivers/phy/qualcomm/phy-qcom-qusb2.c         | 19 ++----
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c |  8 +--
 drivers/phy/rockchip/phy-rockchip-pcie.c      |  9 +--
 drivers/phy/st/phy-stm32-usbphyc.c            | 10 ++-
 drivers/platform/x86/intel_cht_int33fe.c      |  8 +--
 drivers/power/supply/lego_ev3_battery.c       | 24 +++----
 drivers/pwm/pwm-rockchip.c                    | 11 ++--
 drivers/regulator/gpio-regulator.c            |  7 +-
 drivers/remoteproc/da8xx_remoteproc.c         | 11 ++--
 drivers/remoteproc/qcom_q6v5.c                | 55 ++++++----------
 drivers/remoteproc/qcom_q6v5_adsp.c           |  9 +--
 drivers/remoteproc/qcom_q6v5_mss.c            | 11 ++--
 drivers/remoteproc/qcom_q6v5_pas.c            | 19 ++----
 drivers/remoteproc/qcom_wcnss_iris.c          |  8 +--
 drivers/reset/reset-meson-audio-arb.c         |  8 +--
 drivers/rtc/rtc-rk808.c                       | 10 ++-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c        |  7 +-
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c       |  8 +--
 drivers/soc/imx/gpcv2.c                       |  9 ++-
 drivers/soc/lantiq/gphy.c                     |  8 +--
 drivers/soc/qcom/rpmh-rsc.c                   |  9 +--
 drivers/soc/qcom/smem.c                       |  8 +--
 drivers/soc/qcom/smp2p.c                      |  9 +--
 drivers/spi/spi-tegra114.c                    |  6 +-
 drivers/spi/spi-tegra20-slink.c               |  6 +-
 .../clocking-wizard/clk-xlnx-clock-wizard.c   | 16 ++---
 drivers/thermal/broadcom/bcm2835_thermal.c    |  5 +-
 drivers/thermal/hisi_thermal.c                |  5 +-
 drivers/tty/serial/8250/8250_dw.c             |  7 +-
 drivers/tty/serial/8250/8250_ingenic.c        | 12 ++--
 drivers/tty/serial/amba-pl011.c               |  7 +-
 drivers/usb/chipidea/ci_hdrc_imx.c            |  5 +-
 drivers/usb/chipidea/ci_hdrc_msm.c            |  3 +-
 drivers/usb/chipidea/ci_hdrc_usb2.c           |  7 +-
 drivers/usb/dwc3/core.c                       | 24 +++----
 drivers/usb/host/ehci-mv.c                    |  3 +-
 drivers/usb/host/ehci-omap.c                  |  5 +-
 drivers/usb/host/ohci-da8xx.c                 |  6 +-
 drivers/usb/musb/da8xx.c                      |  8 +--
 drivers/usb/musb/musb_cppi41.c                |  5 +-
 drivers/usb/typec/tcpm/fusb302.c              |  3 +-
 drivers/video/backlight/gpio_backlight.c      | 12 +---
 drivers/video/backlight/pwm_bl.c              |  3 +-
 drivers/watchdog/davinci_wdt.c                |  8 +--
 sound/soc/atmel/tse850-pcm5142.c              | 32 ++++-----
 sound/soc/codecs/es7241.c                     | 13 ++--
 sound/soc/codecs/max9759.c                    | 15 ++---
 sound/soc/codecs/max9860.c                    |  8 +--
 sound/soc/codecs/pcm3168a.c                   |  8 +--
 sound/soc/codecs/sgtl5000.c                   |  5 +-
 sound/soc/codecs/simple-amplifier.c           |  5 +-
 sound/soc/codecs/ssm2305.c                    |  6 +-
 sound/soc/davinci/davinci-mcasp.c             | 11 ++--
 sound/soc/generic/audio-graph-card.c          |  3 +-
 sound/soc/generic/audio-graph-scu-card.c      |  3 +-
 sound/soc/generic/simple-card.c               |  3 +-
 sound/soc/generic/simple-scu-card.c           |  3 +-
 sound/soc/img/img-i2s-in.c                    |  8 +--
 sound/soc/img/img-i2s-out.c                   | 24 +++----
 sound/soc/img/img-parallel-out.c              | 24 +++----
 sound/soc/img/img-spdif-in.c                  |  8 +--
 sound/soc/img/img-spdif-out.c                 | 24 +++----
 sound/soc/img/pistachio-internal-dac.c        |  6 +-
 sound/soc/meson/axg-card.c                    |  7 +-
 sound/soc/meson/axg-fifo.c                    | 20 +++---
 sound/soc/meson/axg-pdm.c                     | 12 +---
 sound/soc/meson/axg-spdifout.c                |  8 +--
 sound/soc/meson/axg-tdm-formatter.c           | 22 ++-----
 sound/soc/meson/axg-tdm-interface.c           |  8 +--
 sound/soc/mxs/mxs-sgtl5000.c                  |  9 +--
 sound/soc/sunxi/sun4i-codec.c                 |  5 +-
 155 files changed, 580 insertions(+), 1030 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 4b900fc659f7..52e891fe1586 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -581,11 +581,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
 	int i, irq, n_ports, rc;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "no irq\n");
-		return irq;
-	}
+	if (irq <= 0)
+		return probe_err(dev, irq, "no irq\n");
 
 	hpriv->irq = irq;
 
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7f38a92b444a..ad8ab12d3be6 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2267,12 +2267,10 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
 	ret = genpd_add_device(pd, dev, NULL);
 	mutex_unlock(&gpd_list_lock);
 
-	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to add to PM domain %s: %d",
-				pd->name, ret);
-		return ret;
-	}
+	if (ret < 0)
+		return probe_err(dev, ret,
+				 "failed to add to PM domain %s: %d",
+				 pd->name, ret);
 
 	dev->pm_domain->detach = genpd_dev_pm_detach;
 	dev->pm_domain->sync = genpd_dev_pm_sync;
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index f0404c6d1ff4..b084e6966270 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -239,11 +239,9 @@ static int fsl_mc_driver_probe(struct device *dev)
 	mc_drv = to_fsl_mc_driver(dev->driver);
 
 	error = mc_drv->probe(mc_dev);
-	if (error < 0) {
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "%s failed: %d\n", __func__, error);
-		return error;
-	}
+	if (error < 0)
+		return probe_err(dev, error, "%s failed: %d\n", __func__,
+				 error);
 
 	return 0;
 }
diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index 9989ce904a37..14d30f7852f1 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -292,12 +292,8 @@ static int ts_nbus_probe(struct platform_device *pdev)
 		return ret;
 
 	pwm = devm_pwm_get(dev, NULL);
-	if (IS_ERR(pwm)) {
-		ret = PTR_ERR(pwm);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "unable to request PWM\n");
-		return ret;
-	}
+	if (IS_ERR(pwm))
+		return probe_err(dev, PTR_ERR(pwm), "unable to request PWM\n");
 
 	pwm_get_args(pwm, &pargs);
 	if (!pargs.period) {
diff --git a/drivers/clk/qcom/clk-spmi-pmic-div.c b/drivers/clk/qcom/clk-spmi-pmic-div.c
index c90dfdd6c147..9988a85021ac 100644
--- a/drivers/clk/qcom/clk-spmi-pmic-div.c
+++ b/drivers/clk/qcom/clk-spmi-pmic-div.c
@@ -245,12 +245,9 @@ static int spmi_pmic_clkdiv_probe(struct platform_device *pdev)
 	cc->nclks = nclks;
 
 	cxo = clk_get(dev, "xo");
-	if (IS_ERR(cxo)) {
-		ret = PTR_ERR(cxo);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get xo clock\n");
-		return ret;
-	}
+	if (IS_ERR(cxo))
+		return probe_err(dev, PTR_ERR(cxo),
+				 "failed to get xo clock\n");
 	cxo_hz = clk_get_rate(cxo);
 	clk_put(cxo);
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
index bae5ee67a797..d178d0b1998a 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -217,26 +217,22 @@ static int sunxi_de2_clk_probe(struct platform_device *pdev)
 	bus_clk = devm_clk_get(&pdev->dev, "bus");
 	if (IS_ERR(bus_clk)) {
 		ret = PTR_ERR(bus_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Couldn't get bus clk: %d\n", ret);
-		return ret;
+		return probe_err(&pdev->dev, ret,
+				 "Couldn't get bus clk: %d\n", ret);
 	}
 
 	mod_clk = devm_clk_get(&pdev->dev, "mod");
 	if (IS_ERR(mod_clk)) {
 		ret = PTR_ERR(mod_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Couldn't get mod clk: %d\n", ret);
-		return ret;
+		return probe_err(&pdev->dev, ret,
+				 "Couldn't get mod clk: %d\n", ret);
 	}
 
 	rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(rstc)) {
 		ret = PTR_ERR(rstc);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"Couldn't get reset control: %d\n", ret);
-		return ret;
+		return probe_err(&pdev->dev, ret,
+				 "Couldn't get reset control: %d\n", ret);
 	}
 
 	/* The clocks need to be enabled for us to access the registers */
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
index 6d116581c86d..9a5acb3f67d0 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
@@ -225,18 +225,15 @@ static int sun9i_a80_de_clk_probe(struct platform_device *pdev)
 	bus_clk = devm_clk_get(&pdev->dev, "bus");
 	if (IS_ERR(bus_clk)) {
 		ret = PTR_ERR(bus_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Couldn't get bus clk: %d\n", ret);
-		return ret;
+		return probe_err(&pdev->dev, ret,
+				 "Couldn't get bus clk: %d\n", ret);
 	}
 
 	rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(rstc)) {
 		ret = PTR_ERR(rstc);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"Couldn't get reset control: %d\n", ret);
-		return ret;
+		return probe_err(&pdev->dev, ret,
+				 "Couldn't get reset control: %d\n", ret);
 	}
 
 	/* The bus clock needs to be enabled for us to access the registers */
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
index 1d76f24f7df3..480b9e3185ae 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
@@ -105,9 +105,8 @@ static int sun9i_a80_usb_clk_probe(struct platform_device *pdev)
 	bus_clk = devm_clk_get(&pdev->dev, "bus");
 	if (IS_ERR(bus_clk)) {
 		ret = PTR_ERR(bus_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Couldn't get bus clk: %d\n", ret);
-		return ret;
+		return probe_err(&pdev->dev, ret,
+				 "Couldn't get bus clk: %d\n", ret);
 	}
 
 	/* The bus clock needs to be enabled for us to access the registers */
diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index 2a3675c24032..1a2cf26c02ec 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -108,12 +108,10 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 
 	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
 	of_node_put(np);
-	if (IS_ERR(speedbin_nvmem)) {
-		if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
-			dev_err(cpu_dev, "Could not get nvmem cell: %ld\n",
-				PTR_ERR(speedbin_nvmem));
-		return PTR_ERR(speedbin_nvmem);
-	}
+	if (IS_ERR(speedbin_nvmem))
+		return probe_err(cpu_dev, PTR_ERR(speedbin_nvmem),
+				 "Could not get nvmem cell: %ld\n",
+				 PTR_ERR(speedbin_nvmem));
 
 	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
 	nvmem_cell_put(speedbin_nvmem);
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 7d8ac0222fa3..97a8da6f3e53 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -4873,8 +4873,7 @@ static int dpaa2_caam_probe(struct fsl_mc_device *dpseci_dev)
 	/* DPIO */
 	err = dpaa2_dpseci_dpio_setup(priv);
 	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "dpaa2_dpseci_dpio_setup() failed\n");
+		probe_err(dev, err, "dpaa2_dpseci_dpio_setup() failed\n");
 		goto err_dpio_setup;
 	}
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 8f952f2f1a29..e31055ed4ea9 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -742,12 +742,9 @@ scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev, int prot_id)
 
 	/* Transmit channel is first entry i.e. index 0 */
 	cinfo->chan = mbox_request_channel(cl, 0);
-	if (IS_ERR(cinfo->chan)) {
-		ret = PTR_ERR(cinfo->chan);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to request SCMI Tx mailbox\n");
-		return ret;
-	}
+	if (IS_ERR(cinfo->chan))
+		return probe_err(dev, PTR_ERR(cinfo->chan),
+				 "failed to request SCMI Tx mailbox\n");
 
 idr_alloc:
 	ret = idr_alloc(&info->tx_idr, cinfo, prot_id, prot_id + 1, GFP_KERNEL);
diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 2bb1a19c413f..c0b9f80d7b63 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -229,10 +229,9 @@ static int imx_scu_probe(struct platform_device *pdev)
 		sc_chan->ch = mbox_request_channel_byname(cl, chan_name);
 		if (IS_ERR(sc_chan->ch)) {
 			ret = PTR_ERR(sc_chan->ch);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "Failed to request mbox chan %s ret %d\n",
-					chan_name, ret);
-			return ret;
+			return probe_err(dev, ret,
+					 "Failed to request mbox chan %s ret %d\n",
+					 chan_name, ret);
 		}
 
 		dev_dbg(dev, "request mbox chan %s\n", chan_name);
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 023a32cfac42..d28cdf4036d3 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -824,9 +824,7 @@ static int pca953x_probe(struct i2c_client *client,
 	reg = devm_regulator_get(&client->dev, "vcc");
 	if (IS_ERR(reg)) {
 		ret = PTR_ERR(reg);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&client->dev, "reg get err: %d\n", ret);
-		return ret;
+		return probe_err(&client->dev, ret, "reg get err: %d\n", ret);
 	}
 	ret = regulator_enable(reg);
 	if (ret) {
diff --git a/drivers/gpio/gpio-pisosr.c b/drivers/gpio/gpio-pisosr.c
index f809a5a8e9eb..fab54487a371 100644
--- a/drivers/gpio/gpio-pisosr.c
+++ b/drivers/gpio/gpio-pisosr.c
@@ -148,12 +148,9 @@ static int pisosr_gpio_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	gpio->load_gpio = devm_gpiod_get_optional(dev, "load", GPIOD_OUT_LOW);
-	if (IS_ERR(gpio->load_gpio)) {
-		ret = PTR_ERR(gpio->load_gpio);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Unable to allocate load GPIO\n");
-		return ret;
-	}
+	if (IS_ERR(gpio->load_gpio))
+		return probe_err(dev, PTR_ERR(gpio->load_gpio),
+				 "Unable to allocate load GPIO\n");
 
 	mutex_init(&gpio->lock);
 
diff --git a/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c b/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
index 4fefd80f53bb..1d758bc3c048 100644
--- a/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
+++ b/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
@@ -121,11 +121,9 @@ static int opa362_probe(struct platform_device *pdev)
 	dssdev->of_ports = BIT(1) | BIT(0);
 
 	dssdev->next = omapdss_of_find_connected_device(pdev->dev.of_node, 1);
-	if (IS_ERR(dssdev->next)) {
-		if (PTR_ERR(dssdev->next) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to find video sink\n");
-		return PTR_ERR(dssdev->next);
-	}
+	if (IS_ERR(dssdev->next))
+		return probe_err(&pdev->dev, PTR_ERR(dssdev->next),
+				 "failed to find video sink\n");
 
 	omapdss_device_register(dssdev);
 
diff --git a/drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c b/drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c
index f1a748353279..7f4cc2fdf7eb 100644
--- a/drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c
+++ b/drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c
@@ -115,11 +115,9 @@ static int tfp410_probe(struct platform_device *pdev)
 			  | DRM_BUS_FLAG_PIXDATA_POSEDGE;
 
 	dssdev->next = omapdss_of_find_connected_device(pdev->dev.of_node, 1);
-	if (IS_ERR(dssdev->next)) {
-		if (PTR_ERR(dssdev->next) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to find video sink\n");
-		return PTR_ERR(dssdev->next);
-	}
+	if (IS_ERR(dssdev->next))
+		return probe_err(&pdev->dev, PTR_ERR(dssdev->next),
+				 "failed to find video sink\n");
 
 	omapdss_device_register(dssdev);
 
diff --git a/drivers/gpu/drm/omapdrm/displays/encoder-tpd12s015.c b/drivers/gpu/drm/omapdrm/displays/encoder-tpd12s015.c
index 94de55fd8884..47e646810aa9 100644
--- a/drivers/gpu/drm/omapdrm/displays/encoder-tpd12s015.c
+++ b/drivers/gpu/drm/omapdrm/displays/encoder-tpd12s015.c
@@ -205,11 +205,9 @@ static int tpd_probe(struct platform_device *pdev)
 			  | OMAP_DSS_DEVICE_OP_HPD;
 
 	dssdev->next = omapdss_of_find_connected_device(pdev->dev.of_node, 1);
-	if (IS_ERR(dssdev->next)) {
-		if (PTR_ERR(dssdev->next) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to find video sink\n");
-		return PTR_ERR(dssdev->next);
-	}
+	if (IS_ERR(dssdev->next))
+		return probe_err(&pdev->dev, PTR_ERR(dssdev->next),
+				 "failed to find video sink\n");
 
 	omapdss_device_register(dssdev);
 
diff --git a/drivers/gpu/drm/omapdrm/dss/dpi.c b/drivers/gpu/drm/omapdrm/dss/dpi.c
index ca4f3c4c6318..3d4d3a7f0c79 100644
--- a/drivers/gpu/drm/omapdrm/dss/dpi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dpi.c
@@ -658,11 +658,9 @@ static int dpi_init_output_port(struct dpi_data *dpi, struct device_node *port)
 	out->owner = THIS_MODULE;
 
 	out->next = omapdss_of_find_connected_device(out->dev->of_node, 0);
-	if (IS_ERR(out->next)) {
-		if (PTR_ERR(out->next) != -EPROBE_DEFER)
-			dev_err(out->dev, "failed to find video sink\n");
-		return PTR_ERR(out->next);
-	}
+	if (IS_ERR(out->next))
+		return probe_err(out->dev, PTR_ERR(out->next),
+				 "failed to find video sink\n");
 
 	r = omapdss_output_validate(out);
 	if (r) {
diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 394c129cfb3b..7799994fafa8 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -5140,11 +5140,9 @@ static int dsi_init_output(struct dsi_data *dsi)
 		       | DRM_BUS_FLAG_SYNC_NEGEDGE;
 
 	out->next = omapdss_of_find_connected_device(out->dev->of_node, 0);
-	if (IS_ERR(out->next)) {
-		if (PTR_ERR(out->next) != -EPROBE_DEFER)
-			dev_err(out->dev, "failed to find video sink\n");
-		return PTR_ERR(out->next);
-	}
+	if (IS_ERR(out->next))
+		return probe_err(out->dev, PTR_ERR(out->next),
+				 "failed to find video sink\n");
 
 	r = omapdss_output_validate(out);
 	if (r) {
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
index cf6230eac31a..b815628e6828 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -699,11 +699,9 @@ static int hdmi4_init_output(struct omap_hdmi *hdmi)
 	out->ops_flags = OMAP_DSS_DEVICE_OP_EDID;
 
 	out->next = omapdss_of_find_connected_device(out->dev->of_node, 0);
-	if (IS_ERR(out->next)) {
-		if (PTR_ERR(out->next) != -EPROBE_DEFER)
-			dev_err(out->dev, "failed to find video sink\n");
-		return PTR_ERR(out->next);
-	}
+	if (IS_ERR(out->next))
+		return probe_err(out->dev, PTR_ERR(out->next),
+				 "failed to find video sink\n");
 
 	r = omapdss_output_validate(out);
 	if (r) {
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5.c b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
index b0e4a7463f8c..550cfaa2d988 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
@@ -691,11 +691,9 @@ static int hdmi5_init_output(struct omap_hdmi *hdmi)
 	out->ops_flags = OMAP_DSS_DEVICE_OP_EDID;
 
 	out->next = omapdss_of_find_connected_device(out->dev->of_node, 0);
-	if (IS_ERR(out->next)) {
-		if (PTR_ERR(out->next) != -EPROBE_DEFER)
-			dev_err(out->dev, "failed to find video sink\n");
-		return PTR_ERR(out->next);
-	}
+	if (IS_ERR(out->next))
+		return probe_err(out->dev, PTR_ERR(out->next),
+				 "failed to find video sink\n");
 
 	r = omapdss_output_validate(out);
 	if (r) {
diff --git a/drivers/gpu/drm/omapdrm/dss/sdi.c b/drivers/gpu/drm/omapdrm/dss/sdi.c
index b2fe2387037a..4ff33fc57d60 100644
--- a/drivers/gpu/drm/omapdrm/dss/sdi.c
+++ b/drivers/gpu/drm/omapdrm/dss/sdi.c
@@ -298,11 +298,9 @@ static int sdi_init_output(struct sdi_device *sdi)
 		       | DRM_BUS_FLAG_SYNC_POSEDGE;
 
 	out->next = omapdss_of_find_connected_device(out->dev->of_node, 1);
-	if (IS_ERR(out->next)) {
-		if (PTR_ERR(out->next) != -EPROBE_DEFER)
-			dev_err(out->dev, "failed to find video sink\n");
-		return PTR_ERR(out->next);
-	}
+	if (IS_ERR(out->next))
+		return probe_err(out->dev, PTR_ERR(out->next),
+				 "failed to find video sink\n");
 
 	r = omapdss_output_validate(out);
 	if (r) {
diff --git a/drivers/gpu/drm/omapdrm/dss/venc.c b/drivers/gpu/drm/omapdrm/dss/venc.c
index ff0b18c8e4ac..49f3e8db3080 100644
--- a/drivers/gpu/drm/omapdrm/dss/venc.c
+++ b/drivers/gpu/drm/omapdrm/dss/venc.c
@@ -784,11 +784,9 @@ static int venc_init_output(struct venc_device *venc)
 	out->of_ports = BIT(0);
 
 	out->next = omapdss_of_find_connected_device(out->dev->of_node, 0);
-	if (IS_ERR(out->next)) {
-		if (PTR_ERR(out->next) != -EPROBE_DEFER)
-			dev_err(out->dev, "failed to find video sink\n");
-		return PTR_ERR(out->next);
-	}
+	if (IS_ERR(out->next))
+		return probe_err(out->dev, PTR_ERR(out->next),
+				 "failed to find video sink\n");
 
 	r = omapdss_output_validate(out);
 	if (r) {
diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index 3f6550e6b6a4..9290bcb16128 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -212,12 +212,10 @@ static int panel_lvds_probe(struct platform_device *pdev)
 	if (IS_ERR(lvds->supply)) {
 		ret = PTR_ERR(lvds->supply);
 
-		if (ret != -ENODEV) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(lvds->dev, "failed to request regulator: %d\n",
-					ret);
-			return ret;
-		}
+		if (ret != -ENODEV)
+			return probe_err(lvds->dev, ret,
+					 "failed to request regulator: %d\n",
+					 ret);
 
 		lvds->supply = NULL;
 	}
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 97964f7f2ace..a6b2bffd8c50 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -313,9 +313,8 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 						     GPIOD_OUT_LOW);
 	if (IS_ERR(panel->enable_gpio)) {
 		err = PTR_ERR(panel->enable_gpio);
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "failed to request GPIO: %d\n", err);
-		return err;
+		return probe_err(dev, err, "failed to request GPIO: %d\n",
+				 err);
 	}
 
 	backlight = of_parse_phandle(dev->of_node, "backlight", 0);
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 084f58df4a8c..3709f7a071e2 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -492,9 +492,8 @@ static int rcar_du_probe(struct platform_device *pdev)
 
 	ret = rcar_du_modeset_init(rcdu);
 	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to initialize DRM/KMS (%d)\n", ret);
+		probe_err(&pdev->dev, ret,
+			  "failed to initialize DRM/KMS (%d)\n", ret);
 		goto error;
 	}
 
diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 0c607eb33d7e..20a65edce07c 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -1580,34 +1580,29 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
 	else
 		ret = devm_request_irq(dev, platform_get_irq(pdev, 0),
 				       vc4_dsi_irq_handler, 0, "vc4 dsi", dsi);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get interrupt: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return probe_err(dev, ret, "Failed to get interrupt: %d\n",
+				 ret);
 
 	dsi->escape_clock = devm_clk_get(dev, "escape");
 	if (IS_ERR(dsi->escape_clock)) {
 		ret = PTR_ERR(dsi->escape_clock);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get escape clock: %d\n", ret);
-		return ret;
+		return probe_err(dev, ret, "Failed to get escape clock: %d\n",
+				 ret);
 	}
 
 	dsi->pll_phy_clock = devm_clk_get(dev, "phy");
 	if (IS_ERR(dsi->pll_phy_clock)) {
 		ret = PTR_ERR(dsi->pll_phy_clock);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get phy clock: %d\n", ret);
-		return ret;
+		return probe_err(dev, ret, "Failed to get phy clock: %d\n",
+				 ret);
 	}
 
 	dsi->pixel_clock = devm_clk_get(dev, "pixel");
 	if (IS_ERR(dsi->pixel_clock)) {
 		ret = PTR_ERR(dsi->pixel_clock);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get pixel clock: %d\n", ret);
-		return ret;
+		return probe_err(dev, ret, "Failed to get pixel clock: %d\n",
+				 ret);
 	}
 
 	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 4aab96cf0818..a36d31097f01 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1012,12 +1012,9 @@ static int i2c_hid_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	if (client->irq < 0) {
-		if (client->irq != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"HID over i2c doesn't have a valid IRQ\n");
-		return client->irq;
-	}
+	if (client->irq < 0)
+		return probe_err(&client->dev, client->irq,
+				 "HID over i2c doesn't have a valid IRQ\n");
 
 	ihid = devm_kzalloc(&client->dev, sizeof(*ihid), GFP_KERNEL);
 	if (!ihid)
diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 7da6a160d45a..36bd3607ce0b 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -222,11 +222,8 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	ctx->pwm = devm_of_pwm_get(&pdev->dev, pdev->dev.of_node, NULL);
 	if (IS_ERR(ctx->pwm)) {
 		ret = PTR_ERR(ctx->pwm);
-
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Could not get PWM: %d\n", ret);
-
-		return ret;
+		return probe_err(&pdev->dev, ret, "Could not get PWM: %d\n",
+				 ret);
 	}
 
 	platform_set_drvdata(pdev, ctx);
diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 44deae78913e..7b6d6da969ba 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -348,11 +348,9 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(i2c_dev->regs);
 
 	i2c_dev->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(i2c_dev->clk)) {
-		if (PTR_ERR(i2c_dev->clk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Could not get clock\n");
-		return PTR_ERR(i2c_dev->clk);
-	}
+	if (IS_ERR(i2c_dev->clk))
+		return probe_err(&pdev->dev, PTR_ERR(i2c_dev->clk),
+				 "Could not get clock\n");
 
 	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
 				   &i2c_dev->bus_clk_rate);
diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index b8a2728dd4b6..7011c5231ebb 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -1290,15 +1290,13 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 
 	if (IS_ERR(i2c->clk)) {
 		ret = PTR_ERR(i2c->clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Can't get bus clk: %d\n", ret);
-		return ret;
+		return probe_err(&pdev->dev, ret, "Can't get bus clk: %d\n",
+				 ret);
 	}
 	if (IS_ERR(i2c->pclk)) {
 		ret = PTR_ERR(i2c->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Can't get periph clk: %d\n", ret);
-		return ret;
+		return probe_err(&pdev->dev, ret,
+				 "Can't get periph clk: %d\n", ret);
 	}
 
 	ret = clk_prepare(i2c->clk);
diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
index 812b8cff265f..736d0c7f107a 100644
--- a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
+++ b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
@@ -140,38 +140,28 @@ static int i2c_arbitrator_probe(struct platform_device *pdev)
 
 	/* Request GPIOs */
 	ret = of_get_named_gpio_flags(np, "our-claim-gpio", 0, &gpio_flags);
-	if (!gpio_is_valid(ret)) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Error getting our-claim-gpio\n");
-		return ret;
-	}
+	if (!gpio_is_valid(ret))
+		return probe_err(dev, ret, "Error getting our-claim-gpio\n");
 	arb->our_gpio = ret;
 	arb->our_gpio_release = !!(gpio_flags & OF_GPIO_ACTIVE_LOW);
 	out_init = (gpio_flags & OF_GPIO_ACTIVE_LOW) ?
 		GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW;
 	ret = devm_gpio_request_one(dev, arb->our_gpio, out_init,
 				    "our-claim-gpio");
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Error requesting our-claim-gpio\n");
-		return ret;
-	}
+	if (ret)
+		return probe_err(dev, ret,
+				 "Error requesting our-claim-gpio\n");
 
 	ret = of_get_named_gpio_flags(np, "their-claim-gpios", 0, &gpio_flags);
-	if (!gpio_is_valid(ret)) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Error getting their-claim-gpio\n");
-		return ret;
-	}
+	if (!gpio_is_valid(ret))
+		return probe_err(dev, ret, "Error getting their-claim-gpio\n");
 	arb->their_gpio = ret;
 	arb->their_gpio_release = !!(gpio_flags & OF_GPIO_ACTIVE_LOW);
 	ret = devm_gpio_request_one(dev, arb->their_gpio, GPIOF_IN,
 				    "their-claim-gpio");
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Error requesting their-claim-gpio\n");
-		return ret;
-	}
+	if (ret)
+		return probe_err(dev, ret,
+				 "Error requesting their-claim-gpio\n");
 
 	/* At the moment we only support a single two master (us + 1 other) */
 	if (gpio_is_valid(of_get_named_gpio(np, "their-claim-gpios", 1))) {
diff --git a/drivers/i2c/muxes/i2c-mux-gpmux.c b/drivers/i2c/muxes/i2c-mux-gpmux.c
index f60b670deff7..580534159588 100644
--- a/drivers/i2c/muxes/i2c-mux-gpmux.c
+++ b/drivers/i2c/muxes/i2c-mux-gpmux.c
@@ -88,18 +88,14 @@ static int i2c_mux_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mux->control = devm_mux_control_get(dev, NULL);
-	if (IS_ERR(mux->control)) {
-		if (PTR_ERR(mux->control) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get control-mux\n");
-		return PTR_ERR(mux->control);
-	}
+	if (IS_ERR(mux->control))
+		return probe_err(dev, PTR_ERR(mux->control),
+				 "failed to get control-mux\n");
 
 	parent = mux_parent_adapter(dev);
-	if (IS_ERR(parent)) {
-		if (PTR_ERR(parent) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get i2c-parent adapter\n");
-		return PTR_ERR(parent);
-	}
+	if (IS_ERR(parent))
+		return probe_err(dev, PTR_ERR(parent),
+				 "failed to get i2c-parent adapter\n");
 
 	children = of_get_child_count(np);
 
diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
index 2f2b563c1162..190f4405c35c 100644
--- a/drivers/iio/adc/envelope-detector.c
+++ b/drivers/iio/adc/envelope-detector.c
@@ -350,26 +350,19 @@ static int envelope_detector_probe(struct platform_device *pdev)
 	indio_dev->num_channels = 1;
 
 	env->dac = devm_iio_channel_get(dev, "dac");
-	if (IS_ERR(env->dac)) {
-		if (PTR_ERR(env->dac) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get dac input channel\n");
-		return PTR_ERR(env->dac);
-	}
+	if (IS_ERR(env->dac))
+		return probe_err(dev, PTR_ERR(env->dac),
+				 "failed to get dac input channel\n");
 
 	env->comp_irq = platform_get_irq_byname(pdev, "comp");
-	if (env->comp_irq < 0) {
-		if (env->comp_irq != -EPROBE_DEFER)
-			dev_err(dev, "failed to get compare interrupt\n");
-		return env->comp_irq;
-	}
+	if (env->comp_irq < 0)
+		return probe_err(dev, env->comp_irq,
+				 "failed to get compare interrupt\n");
 
 	ret = devm_request_irq(dev, env->comp_irq, envelope_detector_comp_isr,
 			       0, "envelope-detector", env);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to request interrupt\n");
-		return ret;
-	}
+	if (ret)
+		return probe_err(dev, ret, "failed to request interrupt\n");
 	env->comp_irq_trigger = irq_get_trigger_type(env->comp_irq);
 	if (env->comp_irq_trigger & IRQF_TRIGGER_RISING)
 		env->comp_irq_trigger_inv |= IRQF_TRIGGER_FALLING;
diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index 4e982b51bcda..2dec7ceefc8c 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -510,9 +510,8 @@ static int rcar_gyroadc_probe(struct platform_device *pdev)
 	priv->clk = devm_clk_get(dev, "fck");
 	if (IS_ERR(priv->clk)) {
 		ret = PTR_ERR(priv->clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get IF clock (ret=%i)\n", ret);
-		return ret;
+		return probe_err(dev, ret,
+				 "Failed to get IF clock (ret=%i)\n", ret);
 	}
 
 	ret = rcar_gyroadc_parse_subdevs(indio_dev);
diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index e9ceee66d1e7..2298521ef90b 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -276,11 +276,9 @@ static int rescale_probe(struct platform_device *pdev)
 	int ret;
 
 	source = devm_iio_channel_get(dev, NULL);
-	if (IS_ERR(source)) {
-		if (PTR_ERR(source) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get source channel\n");
-		return PTR_ERR(source);
-	}
+	if (IS_ERR(source))
+		return probe_err(dev, PTR_ERR(source),
+				 "failed to get source channel\n");
 
 	sizeof_ext_info = iio_get_channel_ext_info_count(source);
 	if (sizeof_ext_info) {
diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
index a791d0a09d3b..1273e0feb47b 100644
--- a/drivers/iio/dac/dpot-dac.c
+++ b/drivers/iio/dac/dpot-dac.c
@@ -184,18 +184,14 @@ static int dpot_dac_probe(struct platform_device *pdev)
 	indio_dev->num_channels = 1;
 
 	dac->vref = devm_regulator_get(dev, "vref");
-	if (IS_ERR(dac->vref)) {
-		if (PTR_ERR(dac->vref) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get vref regulator\n");
-		return PTR_ERR(dac->vref);
-	}
+	if (IS_ERR(dac->vref))
+		return probe_err(&pdev->dev, PTR_ERR(dac->vref),
+				 "failed to get vref regulator\n");
 
 	dac->dpot = devm_iio_channel_get(dev, "dpot");
-	if (IS_ERR(dac->dpot)) {
-		if (PTR_ERR(dac->dpot) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get dpot input channel\n");
-		return PTR_ERR(dac->dpot);
-	}
+	if (IS_ERR(dac->dpot))
+		return probe_err(dev, PTR_ERR(dac->dpot),
+				 "failed to get dpot input channel\n");
 
 	ret = iio_get_channel_type(dac->dpot, &type);
 	if (ret < 0)
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 1e428c196a82..e390d082f269 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1027,13 +1027,10 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	}
 
 	st->vddio_supply = devm_regulator_get(dev, "vddio");
-	if (IS_ERR(st->vddio_supply)) {
-		if (PTR_ERR(st->vddio_supply) != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get vddio regulator %d\n",
-				(int)PTR_ERR(st->vddio_supply));
-
-		return PTR_ERR(st->vddio_supply);
-	}
+	if (IS_ERR(st->vddio_supply))
+		return probe_err(dev, PTR_ERR(st->vddio_supply),
+				 "Failed to get vddio regulator %d\n",
+				 (int)PTR_ERR(st->vddio_supply));
 
 	result = inv_mpu_core_enable_regulator(st);
 	if (result)
diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index 0422ef57914c..3184dcccac2e 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -354,11 +354,9 @@ static int mux_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	parent = devm_iio_channel_get(dev, "parent");
-	if (IS_ERR(parent)) {
-		if (PTR_ERR(parent) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get parent channel\n");
-		return PTR_ERR(parent);
-	}
+	if (IS_ERR(parent))
+		return probe_err(dev, PTR_ERR(parent),
+				 "failed to get parent channel\n");
 
 	sizeof_ext_info = iio_get_channel_ext_info_count(parent);
 	if (sizeof_ext_info) {
@@ -417,11 +415,9 @@ static int mux_probe(struct platform_device *pdev)
 	}
 
 	mux->control = devm_mux_control_get(dev, NULL);
-	if (IS_ERR(mux->control)) {
-		if (PTR_ERR(mux->control) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get control-mux\n");
-		return PTR_ERR(mux->control);
-	}
+	if (IS_ERR(mux->control))
+		return probe_err(dev, PTR_ERR(mux->control),
+				 "failed to get control-mux\n");
 
 	i = 0;
 	of_property_for_each_string_index(np, "channels", prop, label, state) {
diff --git a/drivers/input/keyboard/bcm-keypad.c b/drivers/input/keyboard/bcm-keypad.c
index e1cf63ee148f..77f833c43e28 100644
--- a/drivers/input/keyboard/bcm-keypad.c
+++ b/drivers/input/keyboard/bcm-keypad.c
@@ -379,11 +379,9 @@ static int bcm_kp_probe(struct platform_device *pdev)
 	kp->clk = devm_clk_get(&pdev->dev, "peri_clk");
 	if (IS_ERR(kp->clk)) {
 		error = PTR_ERR(kp->clk);
-		if (error != -ENOENT) {
-			if (error != -EPROBE_DEFER)
-				dev_err(&pdev->dev, "Failed to get clock\n");
-			return error;
-		}
+		if (error != -ENOENT)
+			return probe_err(&pdev->dev, error,
+					 "Failed to get clock\n");
 		dev_dbg(&pdev->dev,
 			"No clock specified. Assuming it's enabled\n");
 		kp->clk = NULL;
diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index edca0d737750..faeb09231a60 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -143,10 +143,8 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	beeper->pwm = devm_pwm_get(dev, NULL);
 	if (IS_ERR(beeper->pwm)) {
 		error = PTR_ERR(beeper->pwm);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "Failed to request PWM device: %d\n",
-				error);
-		return error;
+		return probe_err(dev, error,
+				 "Failed to request PWM device: %d\n", error);
 	}
 
 	/* Sync up PWM state and ensure it is off. */
@@ -162,10 +160,8 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	beeper->amplifier = devm_regulator_get(dev, "amp");
 	if (IS_ERR(beeper->amplifier)) {
 		error = PTR_ERR(beeper->amplifier);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get 'amp' regulator: %d\n",
-				error);
-		return error;
+		return probe_err(dev, error,
+				 "Failed to get 'amp' regulator: %d\n", error);
 	}
 
 	INIT_WORK(&beeper->work, pwm_beeper_work);
diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibra.c
index 55da191ae550..b5ed20037347 100644
--- a/drivers/input/misc/pwm-vibra.c
+++ b/drivers/input/misc/pwm-vibra.c
@@ -132,21 +132,15 @@ static int pwm_vibrator_probe(struct platform_device *pdev)
 
 	vibrator->vcc = devm_regulator_get(&pdev->dev, "vcc");
 	err = PTR_ERR_OR_ZERO(vibrator->vcc);
-	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to request regulator: %d",
-				err);
-		return err;
-	}
+	if (err)
+		return probe_err(&pdev->dev, err,
+				 "Failed to request regulator: %d", err);
 
 	vibrator->pwm = devm_pwm_get(&pdev->dev, "enable");
 	err = PTR_ERR_OR_ZERO(vibrator->pwm);
-	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to request main pwm: %d",
-				err);
-		return err;
-	}
+	if (err)
+		return probe_err(&pdev->dev, err,
+				 "Failed to request main pwm: %d", err);
 
 	INIT_WORK(&vibrator->play_work, pwm_vibrator_play_work);
 
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index f5ae24865355..1201d56f2d09 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1142,10 +1142,8 @@ static int elan_probe(struct i2c_client *client,
 	data->vcc = devm_regulator_get(dev, "vcc");
 	if (IS_ERR(data->vcc)) {
 		error = PTR_ERR(data->vcc);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get 'vcc' regulator: %d\n",
-				error);
-		return error;
+		return probe_err(dev, error,
+				 "Failed to get 'vcc' regulator: %d\n", error);
 	}
 
 	error = regulator_enable(data->vcc);
diff --git a/drivers/input/touchscreen/bu21029_ts.c b/drivers/input/touchscreen/bu21029_ts.c
index 49a8d4bbca3a..6f468bc036b8 100644
--- a/drivers/input/touchscreen/bu21029_ts.c
+++ b/drivers/input/touchscreen/bu21029_ts.c
@@ -362,20 +362,18 @@ static int bu21029_probe(struct i2c_client *client,
 	bu21029->vdd = devm_regulator_get(&client->dev, "vdd");
 	if (IS_ERR(bu21029->vdd)) {
 		error = PTR_ERR(bu21029->vdd);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"failed to acquire 'vdd' supply: %d\n", error);
-		return error;
+		return probe_err(&client->dev, error,
+				 "failed to acquire 'vdd' supply: %d\n",
+				 error);
 	}
 
 	bu21029->reset_gpios = devm_gpiod_get_optional(&client->dev,
 						       "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(bu21029->reset_gpios)) {
 		error = PTR_ERR(bu21029->reset_gpios);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"failed to acquire 'reset' gpio: %d\n", error);
-		return error;
+		return probe_err(&client->dev, error,
+				 "failed to acquire 'reset' gpio: %d\n",
+				 error);
 	}
 
 	in_dev = devm_input_allocate_device(&client->dev);
diff --git a/drivers/input/touchscreen/chipone_icn8318.c b/drivers/input/touchscreen/chipone_icn8318.c
index 0bf14067c167..5aa1137bcaa0 100644
--- a/drivers/input/touchscreen/chipone_icn8318.c
+++ b/drivers/input/touchscreen/chipone_icn8318.c
@@ -200,9 +200,8 @@ static int icn8318_probe(struct i2c_client *client,
 	data->wake_gpio = devm_gpiod_get(dev, "wake", GPIOD_OUT_LOW);
 	if (IS_ERR(data->wake_gpio)) {
 		error = PTR_ERR(data->wake_gpio);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "Error getting wake gpio: %d\n", error);
-		return error;
+		return probe_err(dev, error, "Error getting wake gpio: %d\n",
+				 error);
 	}
 
 	input = devm_input_allocate_device(dev);
diff --git a/drivers/input/touchscreen/ektf2127.c b/drivers/input/touchscreen/ektf2127.c
index 0ed34ff787ce..348c6946acd7 100644
--- a/drivers/input/touchscreen/ektf2127.c
+++ b/drivers/input/touchscreen/ektf2127.c
@@ -243,9 +243,8 @@ static int ektf2127_probe(struct i2c_client *client,
 	ts->power_gpios = devm_gpiod_get(dev, "power", GPIOD_OUT_HIGH);
 	if (IS_ERR(ts->power_gpios)) {
 		error = PTR_ERR(ts->power_gpios);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "Error getting power gpio: %d\n", error);
-		return error;
+		return probe_err(dev, error, "Error getting power gpio: %d\n",
+				 error);
 	}
 
 	input = devm_input_allocate_device(dev);
diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index f2cb23121833..9c1edadc57da 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -1159,21 +1159,17 @@ static int elants_i2c_probe(struct i2c_client *client,
 	ts->vcc33 = devm_regulator_get(&client->dev, "vcc33");
 	if (IS_ERR(ts->vcc33)) {
 		error = PTR_ERR(ts->vcc33);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"Failed to get 'vcc33' regulator: %d\n",
-				error);
-		return error;
+		return probe_err(&client->dev, error,
+				 "Failed to get 'vcc33' regulator: %d\n",
+				 error);
 	}
 
 	ts->vccio = devm_regulator_get(&client->dev, "vccio");
 	if (IS_ERR(ts->vccio)) {
 		error = PTR_ERR(ts->vccio);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"Failed to get 'vccio' regulator: %d\n",
-				error);
-		return error;
+		return probe_err(&client->dev, error,
+				 "Failed to get 'vccio' regulator: %d\n",
+				 error);
 	}
 
 	ts->reset_gpio = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_LOW);
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 37ff672c7802..8bf3b1fb0f0f 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -534,18 +534,16 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
 						    GPIOD_OUT_HIGH);
 	if (IS_ERR(tsdata->gpio_wake)) {
 		error = PTR_ERR(tsdata->gpio_wake);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get wake gpio: %d\n", error);
-		return error;
+		return probe_err(dev, error, "Failed to get wake gpio: %d\n",
+				 error);
 	}
 
 	tsdata->gpio_enable = devm_gpiod_get_optional(dev, "enable",
 						      GPIOD_OUT_HIGH);
 	if (IS_ERR(tsdata->gpio_enable)) {
 		error = PTR_ERR(tsdata->gpio_enable);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get enable gpio: %d\n", error);
-		return error;
+		return probe_err(dev, error,
+				 "Failed to get enable gpio: %d\n", error);
 	}
 
 	if (tsdata->gpio_enable)
diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index c89853a36f9e..da45f8c95e04 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -1026,29 +1026,25 @@ static int raydium_i2c_probe(struct i2c_client *client,
 	ts->avdd = devm_regulator_get(&client->dev, "avdd");
 	if (IS_ERR(ts->avdd)) {
 		error = PTR_ERR(ts->avdd);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"Failed to get 'avdd' regulator: %d\n", error);
-		return error;
+		return probe_err(&client->dev, error,
+				 "Failed to get 'avdd' regulator: %d\n",
+				 error);
 	}
 
 	ts->vccio = devm_regulator_get(&client->dev, "vccio");
 	if (IS_ERR(ts->vccio)) {
 		error = PTR_ERR(ts->vccio);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"Failed to get 'vccio' regulator: %d\n", error);
-		return error;
+		return probe_err(&client->dev, error,
+				 "Failed to get 'vccio' regulator: %d\n",
+				 error);
 	}
 
 	ts->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
 						 GPIOD_OUT_LOW);
 	if (IS_ERR(ts->reset_gpio)) {
 		error = PTR_ERR(ts->reset_gpio);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"failed to get reset gpio: %d\n", error);
-		return error;
+		return probe_err(&client->dev, error,
+				 "failed to get reset gpio: %d\n", error);
 	}
 
 	error = raydium_i2c_power_on(ts);
diff --git a/drivers/input/touchscreen/resistive-adc-touch.c b/drivers/input/touchscreen/resistive-adc-touch.c
index cfc8bb4553f7..c576e9b5b8c7 100644
--- a/drivers/input/touchscreen/resistive-adc-touch.c
+++ b/drivers/input/touchscreen/resistive-adc-touch.c
@@ -108,12 +108,9 @@ static int grts_probe(struct platform_device *pdev)
 
 	/* get the channels from IIO device */
 	st->iio_chans = devm_iio_channel_get_all(dev);
-	if (IS_ERR(st->iio_chans)) {
-		error = PTR_ERR(st->iio_chans);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "can't get iio channels.\n");
-		return error;
-	}
+	if (IS_ERR(st->iio_chans))
+		return probe_err(dev, PTR_ERR(st->iio_chans),
+				 "can't get iio channels.\n");
 
 	chan = &st->iio_chans[0];
 	st->pressure = false;
diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 09241d4cdebc..89a9ab65a42b 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -520,11 +520,9 @@ static int silead_ts_probe(struct i2c_client *client,
 
 	/* Power GPIO pin */
 	data->gpio_power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
-	if (IS_ERR(data->gpio_power)) {
-		if (PTR_ERR(data->gpio_power) != -EPROBE_DEFER)
-			dev_err(dev, "Shutdown GPIO request failed\n");
-		return PTR_ERR(data->gpio_power);
-	}
+	if (IS_ERR(data->gpio_power))
+		return probe_err(dev, PTR_ERR(data->gpio_power),
+				 "Shutdown GPIO request failed\n");
 
 	error = silead_ts_setup(client);
 	if (error)
@@ -537,11 +535,8 @@ static int silead_ts_probe(struct i2c_client *client,
 	error = devm_request_threaded_irq(dev, client->irq,
 					  NULL, silead_ts_threaded_irq_handler,
 					  IRQF_ONESHOT, client->name, data);
-	if (error) {
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "IRQ request failed %d\n", error);
-		return error;
-	}
+	if (error)
+		return probe_err(dev, error, "IRQ request failed %d\n", error);
 
 	return 0;
 }
diff --git a/drivers/input/touchscreen/sis_i2c.c b/drivers/input/touchscreen/sis_i2c.c
index 67c2563031d6..4f63b8b778eb 100644
--- a/drivers/input/touchscreen/sis_i2c.c
+++ b/drivers/input/touchscreen/sis_i2c.c
@@ -321,20 +321,16 @@ static int sis_ts_probe(struct i2c_client *client,
 						"attn", GPIOD_IN);
 	if (IS_ERR(ts->attn_gpio)) {
 		error = PTR_ERR(ts->attn_gpio);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"Failed to get attention GPIO: %d\n", error);
-		return error;
+		return probe_err(&client->dev, error,
+				 "Failed to get attention GPIO: %d\n", error);
 	}
 
 	ts->reset_gpio = devm_gpiod_get_optional(&client->dev,
 						 "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ts->reset_gpio)) {
 		error = PTR_ERR(ts->reset_gpio);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"Failed to get reset GPIO: %d\n", error);
-		return error;
+		return probe_err(&client->dev, error,
+				 "Failed to get reset GPIO: %d\n", error);
 	}
 
 	sis_ts_reset(ts);
diff --git a/drivers/input/touchscreen/surface3_spi.c b/drivers/input/touchscreen/surface3_spi.c
index 5db0f1c4ef38..a856034fe92e 100644
--- a/drivers/input/touchscreen/surface3_spi.c
+++ b/drivers/input/touchscreen/surface3_spi.c
@@ -239,12 +239,9 @@ static int surface3_spi_get_gpio_config(struct surface3_ts_data *data)
 		gpiod = devm_gpiod_get_index(dev, NULL, i, GPIOD_OUT_LOW);
 		if (IS_ERR(gpiod)) {
 			error = PTR_ERR(gpiod);
-			if (error != -EPROBE_DEFER)
-				dev_err(dev,
-					"Failed to get power GPIO %d: %d\n",
-					i,
-					error);
-			return error;
+			return probe_err(dev, error,
+					 "Failed to get power GPIO %d: %d\n",
+					 i, error);
 		}
 
 		data->gpiod_rst[i] = gpiod;
diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 5d3faae51d59..0ef0e2c88815 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -100,10 +100,9 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		led_data->pwm = devm_pwm_get(dev, led->name);
 	if (IS_ERR(led_data->pwm)) {
 		ret = PTR_ERR(led_data->pwm);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "unable to request PWM for %s: %d\n",
-				led->name, ret);
-		return ret;
+		return probe_err(dev, ret,
+				 "unable to request PWM for %s: %d\n",
+				 led->name, ret);
 	}
 
 	led_data->cdev.brightness_set_blocking = led_pwm_set;
diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
index 907323f0ca3b..150ea3694b02 100644
--- a/drivers/media/i2c/ad5820.c
+++ b/drivers/media/i2c/ad5820.c
@@ -305,12 +305,9 @@ static int ad5820_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	coil->vana = devm_regulator_get(&client->dev, "VANA");
-	if (IS_ERR(coil->vana)) {
-		ret = PTR_ERR(coil->vana);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&client->dev, "could not get regulator for vana\n");
-		return ret;
-	}
+	if (IS_ERR(coil->vana))
+		return probe_err(&client->dev, PTR_ERR(coil->vana),
+				 "could not get regulator for vana\n");
 
 	mutex_init(&coil->power_lock);
 
diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index ca5d92942820..a65fb0f7218b 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -1902,12 +1902,10 @@ static int tc358743_probe_of(struct tc358743_state *state)
 	int ret;
 
 	refclk = devm_clk_get(dev, "refclk");
-	if (IS_ERR(refclk)) {
-		if (PTR_ERR(refclk) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get refclk: %ld\n",
-				PTR_ERR(refclk));
-		return PTR_ERR(refclk);
-	}
+	if (IS_ERR(refclk))
+		return probe_err(dev, PTR_ERR(refclk),
+				 "failed to get refclk: %ld\n",
+				 PTR_ERR(refclk));
 
 	ep = of_graph_get_next_endpoint(dev->of_node, NULL);
 	if (!ep) {
diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index 77fb7987b42f..7c1f8e58297a 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -1875,8 +1875,7 @@ static int isp_initialize_modules(struct isp_device *isp)
 
 	ret = omap3isp_ccp2_init(isp);
 	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(isp->dev, "CCP2 initialization failed\n");
+		probe_err(isp->dev, ret, "CCP2 initialization failed\n");
 		goto error_ccp2;
 	}
 
diff --git a/drivers/media/platform/video-mux.c b/drivers/media/platform/video-mux.c
index c33900e3c23e..4ae701e73544 100644
--- a/drivers/media/platform/video-mux.c
+++ b/drivers/media/platform/video-mux.c
@@ -390,9 +390,7 @@ static int video_mux_probe(struct platform_device *pdev)
 	vmux->mux = devm_mux_control_get(dev, NULL);
 	if (IS_ERR(vmux->mux)) {
 		ret = PTR_ERR(vmux->mux);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get mux: %d\n", ret);
-		return ret;
+		return probe_err(dev, ret, "Failed to get mux: %d\n", ret);
 	}
 
 	mutex_init(&vmux->lock);
diff --git a/drivers/media/rc/gpio-ir-recv.c b/drivers/media/rc/gpio-ir-recv.c
index 3d99b51384ac..00a2e8bec359 100644
--- a/drivers/media/rc/gpio-ir-recv.c
+++ b/drivers/media/rc/gpio-ir-recv.c
@@ -60,10 +60,7 @@ static int gpio_ir_recv_probe(struct platform_device *pdev)
 	gpio_dev->gpiod = devm_gpiod_get(dev, NULL, GPIOD_IN);
 	if (IS_ERR(gpio_dev->gpiod)) {
 		rc = PTR_ERR(gpio_dev->gpiod);
-		/* Just try again if this happens */
-		if (rc != -EPROBE_DEFER)
-			dev_err(dev, "error getting gpio (%d)\n", rc);
-		return rc;
+		return probe_err(dev, rc, "error getting gpio (%d)\n", rc);
 	}
 	gpio_dev->irq = gpiod_to_irq(gpio_dev->gpiod);
 	if (gpio_dev->irq < 0)
diff --git a/drivers/media/rc/gpio-ir-tx.c b/drivers/media/rc/gpio-ir-tx.c
index cd476cab9782..c7d4413f4ff2 100644
--- a/drivers/media/rc/gpio-ir-tx.c
+++ b/drivers/media/rc/gpio-ir-tx.c
@@ -137,12 +137,10 @@ static int gpio_ir_tx_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	gpio_ir->gpio = devm_gpiod_get(&pdev->dev, NULL, GPIOD_OUT_LOW);
-	if (IS_ERR(gpio_ir->gpio)) {
-		if (PTR_ERR(gpio_ir->gpio) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to get gpio (%ld)\n",
-				PTR_ERR(gpio_ir->gpio));
-		return PTR_ERR(gpio_ir->gpio);
-	}
+	if (IS_ERR(gpio_ir->gpio))
+		return probe_err(&pdev->dev, PTR_ERR(gpio_ir->gpio),
+				 "Failed to get gpio (%ld)\n",
+				 PTR_ERR(gpio_ir->gpio));
 
 	rcdev->priv = gpio_ir;
 	rcdev->driver_name = DRIVER_NAME;
diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 440030cecbbd..3fb445cd1457 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -298,10 +298,8 @@ static int madera_get_reset_gpio(struct madera *madera)
 	reset = devm_gpiod_get_optional(madera->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(reset)) {
 		ret = PTR_ERR(reset);
-		if (ret != -EPROBE_DEFER)
-			dev_err(madera->dev, "Failed to request /RESET: %d\n",
-				ret);
-		return ret;
+		return probe_err(madera->dev, ret,
+				 "Failed to request /RESET: %d\n", ret);
 	}
 
 	/*
diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 768972af8b85..52ec0e309221 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1397,8 +1397,7 @@ static int bcm2835_probe(struct platform_device *pdev)
 	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "could not get clk: %d\n", ret);
+		probe_err(dev, ret, "could not get clk: %d\n", ret);
 		goto err;
 	}
 
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 9e68c3645e22..e1a4bc80d8c1 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1253,9 +1253,8 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 		pdev->id_entry = match->data;
 		ret = mmc_of_parse(mmc);
 		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(&pdev->dev,
-					"could not parse of data: %d\n", ret);
+			probe_err(&pdev->dev, ret,
+				  "could not parse of data: %d\n", ret);
 			goto parse_fail;
 		}
 	} else {
diff --git a/drivers/mmc/host/dw_mmc-zx.c b/drivers/mmc/host/dw_mmc-zx.c
index c06b5393312f..b9710e6407f0 100644
--- a/drivers/mmc/host/dw_mmc-zx.c
+++ b/drivers/mmc/host/dw_mmc-zx.c
@@ -169,10 +169,8 @@ static int dw_mci_zx_parse_dt(struct dw_mci *host)
 
 		if (IS_ERR(sysc_base)) {
 			ret = PTR_ERR(sysc_base);
-			if (ret != -EPROBE_DEFER)
-				dev_err(host->dev, "Can't get syscon: %d\n",
-					ret);
-			return ret;
+			return probe_err(host->dev, ret,
+					 "Can't get syscon: %d\n", ret);
 		}
 	} else {
 		return 0;
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 0c1efd5100b7..76dbb98e75a6 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1042,9 +1042,8 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 		host->version = (enum jz4740_mmc_version)match->data;
 		ret = mmc_of_parse(mmc);
 		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(&pdev->dev,
-					"could not parse of data: %d\n", ret);
+			probe_err(&pdev->dev, ret,
+				  "could not parse of data: %d\n", ret);
 			goto err_free_host;
 		}
 	} else {
diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index c201c378537e..8a7a2c6cd0a8 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -507,11 +507,9 @@ static int meson_mmc_clk_init(struct meson_host *host)
 
 		snprintf(name, sizeof(name), "clkin%d", i);
 		clk = devm_clk_get(host->dev, name);
-		if (IS_ERR(clk)) {
-			if (clk != ERR_PTR(-EPROBE_DEFER))
-				dev_err(host->dev, "Missing clock %s\n", name);
-			return PTR_ERR(clk);
-		}
+		if (IS_ERR(clk))
+			return probe_err(host->dev, PTR_ERR(clk),
+					 "Missing clock %s\n", name);
 
 		mux_parent_names[i] = __clk_get_name(clk);
 	}
@@ -1214,12 +1212,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	}
 
 	ret = device_reset_optional(&pdev->dev);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "device reset failed: %d\n", ret);
-
-		return ret;
-	}
+	if (ret)
+		return probe_err(&pdev->dev, ret, "device reset failed: %d\n",
+				 ret);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->regs = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 142c4b802f31..5ce26065696e 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -796,9 +796,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 		if (IS_ERR(sdhci_arasan->soc_ctl_base)) {
 			ret = PTR_ERR(sdhci_arasan->soc_ctl_base);
-			if (ret != -EPROBE_DEFER)
-				dev_err(&pdev->dev, "Can't get syscon: %d\n",
-					ret);
+			probe_err(&pdev->dev, ret, "Can't get syscon: %d\n",
+				  ret);
 			goto err_pltfm_free;
 		}
 	}
@@ -851,8 +850,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "parsing dt failed (%d)\n", ret);
+		probe_err(&pdev->dev, ret, "parsing dt failed (%d)\n", ret);
 		goto unreg_clk;
 	}
 
diff --git a/drivers/mtd/nand/onenand/omap2.c b/drivers/mtd/nand/onenand/omap2.c
index 321137158ff3..689f9c1a5eac 100644
--- a/drivers/mtd/nand/onenand/omap2.c
+++ b/drivers/mtd/nand/onenand/omap2.c
@@ -507,10 +507,7 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 	c->int_gpiod = devm_gpiod_get_optional(dev, "int", GPIOD_IN);
 	if (IS_ERR(c->int_gpiod)) {
 		r = PTR_ERR(c->int_gpiod);
-		/* Just try again if this happens */
-		if (r != -EPROBE_DEFER)
-			dev_err(dev, "error getting gpio: %d\n", r);
-		return r;
+		return probe_err(dev, r, "error getting gpio: %d\n", r);
 	}
 
 	if (c->int_gpiod) {
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index fb33f6be7c4f..328ffbc13416 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1929,10 +1929,9 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
 	nc->pmecc = devm_atmel_pmecc_get(dev);
 	if (IS_ERR(nc->pmecc)) {
 		ret = PTR_ERR(nc->pmecc);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Could not get PMECC object (err = %d)\n",
-				ret);
-		return ret;
+		return probe_err(dev, ret,
+				 "Could not get PMECC object (err = %d)\n",
+				 ret);
 	}
 
 	if (nc->caps->has_dma && !atmel_nand_avoid_dma) {
@@ -2057,9 +2056,8 @@ atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
 	nc->irq = of_irq_get(nand_np, 0);
 	if (nc->irq <= 0) {
 		ret = nc->irq ?: -ENXIO;
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get IRQ number (err = %d)\n",
-				ret);
+		probe_err(dev, ret, "Failed to get IRQ number (err = %d)\n",
+			  ret);
 		goto out;
 	}
 
@@ -2148,11 +2146,9 @@ atmel_hsmc_nand_controller_init(struct atmel_hsmc_nand_controller *nc)
 	nc->irq = of_irq_get(np, 0);
 	of_node_put(np);
 	if (nc->irq <= 0) {
-		ret = nc->irq ?: -ENXIO;
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get IRQ number (err = %d)\n",
-				ret);
-		return ret;
+		ret = nc->irq ? : -ENXIO;
+		return probe_err(dev, ret,
+				 "Failed to get IRQ number (err = %d)\n", ret);
 	}
 
 	np = of_parse_phandle(dev->of_node, "atmel,nfc-io", 0);
diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index 02c1f2c014e8..7d420846e466 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -64,12 +64,9 @@ static int mux_gpio_probe(struct platform_device *pdev)
 	mux_chip->ops = &mux_gpio_ops;
 
 	mux_gpio->gpios = devm_gpiod_get_array(dev, "mux", GPIOD_OUT_LOW);
-	if (IS_ERR(mux_gpio->gpios)) {
-		ret = PTR_ERR(mux_gpio->gpios);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get gpios\n");
-		return ret;
-	}
+	if (IS_ERR(mux_gpio->gpios))
+		return probe_err(dev, PTR_ERR(mux_gpio->gpios),
+				 "failed to get gpios\n");
 	WARN_ON(pins != mux_gpio->gpios->ndescs);
 	mux_chip->mux->states = 1 << pins;
 
diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 693a67f45bef..731c698d35c5 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -932,11 +932,9 @@ static int gswip_gphy_fw_probe(struct gswip_priv *priv,
 	}
 
 	gphy_fw->reset = of_reset_control_array_get_exclusive(gphy_fw_np);
-	if (IS_ERR(gphy_fw->reset)) {
-		if (PTR_ERR(gphy_fw->reset) != -EPROBE_DEFER)
-			dev_err(dev, "Failed to lookup gphy reset\n");
-		return PTR_ERR(gphy_fw->reset);
-	}
+	if (IS_ERR(gphy_fw->reset))
+		return probe_err(dev, PTR_ERR(gphy_fw->reset),
+				 "Failed to lookup gphy reset\n");
 
 	return gswip_gphy_fw_load(priv, gphy_fw);
 }
diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index f27a0dc8c563..35db28c8d238 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3312,8 +3312,7 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
 	/* MDIO bus init */
 	ret = sh_mdio_init(mdp, pd);
 	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "MDIO init failed: %d\n", ret);
+		probe_err(&pdev->dev, ret, "MDIO init failed: %d\n", ret);
 		goto out_release;
 	}
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 3256e5cbad27..d473cc85d808 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -434,13 +434,9 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 	 * resource initialization is done in the glue logic.
 	 */
 	stmmac_res.irq = platform_get_irq(pdev, 0);
-	if (stmmac_res.irq < 0) {
-		if (stmmac_res.irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"IRQ configuration information not found\n");
-
-		return stmmac_res.irq;
-	}
+	if (stmmac_res.irq < 0)
+		return probe_err(&pdev->dev, stmmac_res.irq,
+				 "IRQ configuration information not found\n");
 	stmmac_res.wol_irq = stmmac_res.irq;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index c5979569fd60..f35ad1043d37 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -129,12 +129,9 @@ static int meson8b_init_rgmii_tx_clk(struct meson8b_dwmac *dwmac)
 
 		snprintf(name, sizeof(name), "clkin%d", i);
 		clk = devm_clk_get(dev, name);
-		if (IS_ERR(clk)) {
-			ret = PTR_ERR(clk);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "Missing clock %s\n", name);
-			return ret;
-		}
+		if (IS_ERR(clk))
+			return probe_err(dev, PTR_ERR(clk),
+					 "Missing clock %s\n", name);
 
 		mux_parent_names[i] = __clk_get_name(clk);
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 2b800ce1d5bf..1b90fc851237 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -618,13 +618,9 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 	 * probe if needed before we went too far with resource allocation.
 	 */
 	stmmac_res->irq = platform_get_irq_byname(pdev, "macirq");
-	if (stmmac_res->irq < 0) {
-		if (stmmac_res->irq != -EPROBE_DEFER) {
-			dev_err(&pdev->dev,
-				"MAC IRQ configuration information not found\n");
-		}
-		return stmmac_res->irq;
-	}
+	if (stmmac_res->irq < 0)
+		return probe_err(&pdev->dev, stmmac_res->irq,
+				 "MAC IRQ configuration information not found\n");
 
 	/* On some platforms e.g. SPEAr the wake up irq differs from the mac irq
 	 * The external wake up irq can be passed through the platform code
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 16dcbf36f8cc..f4698fd6d004 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -3147,11 +3147,10 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
 			 * to the PHY is the Ethernet MAC DT node.
 			 */
 			ret = of_phy_register_fixed_link(slave_node);
-			if (ret) {
-				if (ret != -EPROBE_DEFER)
-					dev_err(&pdev->dev, "failed to register fixed-link phy: %d\n", ret);
-				return ret;
-			}
+			if (ret)
+				return probe_err(&pdev->dev, ret,
+						 "failed to register fixed-link phy: %d\n",
+						 ret);
 			slave_data->phy_node = of_node_get(slave_node);
 		} else if (parp) {
 			u32 phyid;
diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index 44de81e5f140..593e242e2c8f 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -1243,9 +1243,8 @@ mcr20a_probe(struct spi_device *spi)
 	rst_b = devm_gpiod_get(&spi->dev, "rst_b", GPIOD_OUT_HIGH);
 	if (IS_ERR(rst_b)) {
 		ret = PTR_ERR(rst_b);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&spi->dev, "Failed to get 'rst_b' gpio: %d", ret);
-		return ret;
+		return probe_err(&spi->dev, ret,
+				 "Failed to get 'rst_b' gpio: %d", ret);
 	}
 
 	/* reset mcr20a */
diff --git a/drivers/net/phy/mdio-mux-mmioreg.c b/drivers/net/phy/mdio-mux-mmioreg.c
index 70f6115530af..054f91bbb71a 100644
--- a/drivers/net/phy/mdio-mux-mmioreg.c
+++ b/drivers/net/phy/mdio-mux-mmioreg.c
@@ -162,12 +162,9 @@ static int mdio_mux_mmioreg_probe(struct platform_device *pdev)
 	ret = mdio_mux_init(&pdev->dev, pdev->dev.of_node,
 			    mdio_mux_mmioreg_switch_fn,
 			    &s->mux_handle, s, NULL);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to register mdio-mux bus %pOF\n", np);
-		return ret;
-	}
+	if (ret)
+		return probe_err(&pdev->dev, ret,
+				 "failed to register mdio-mux bus %pOF\n", np);
 
 	pdev->dev.platform_data = s;
 
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2c2df4e4fc14..3eed62e054b1 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1406,9 +1406,9 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 		reg = regulator_get_optional(dev, names[i]);
 		if (IS_ERR(reg)) {
 			ret = PTR_ERR(reg);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "%s: no regulator (%s) found: %d\n",
-					__func__, names[i], ret);
+			probe_err(dev, ret,
+				  "%s: no regulator (%s) found: %d\n",
+				  __func__, names[i], ret);
 			goto free_regulators;
 		}
 
@@ -1501,10 +1501,8 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 	opp_table->clk = clk_get(dev, name);
 	if (IS_ERR(opp_table->clk)) {
 		ret = PTR_ERR(opp_table->clk);
-		if (ret != -EPROBE_DEFER) {
-			dev_err(dev, "%s: Couldn't find clock: %d\n", __func__,
-				ret);
-		}
+		probe_err(dev, ret, "%s: Couldn't find clock: %d\n", __func__,
+			  ret);
 		goto err;
 	}
 
diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index c53d1322a3d6..2f84972da966 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -69,54 +69,40 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 		rockchip->link_gen = 2;
 
 	rockchip->core_rst = devm_reset_control_get_exclusive(dev, "core");
-	if (IS_ERR(rockchip->core_rst)) {
-		if (PTR_ERR(rockchip->core_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing core reset property in node\n");
-		return PTR_ERR(rockchip->core_rst);
-	}
+	if (IS_ERR(rockchip->core_rst))
+		return probe_err(dev, PTR_ERR(rockchip->core_rst),
+				 "missing core reset property in node\n");
 
 	rockchip->mgmt_rst = devm_reset_control_get_exclusive(dev, "mgmt");
-	if (IS_ERR(rockchip->mgmt_rst)) {
-		if (PTR_ERR(rockchip->mgmt_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing mgmt reset property in node\n");
-		return PTR_ERR(rockchip->mgmt_rst);
-	}
+	if (IS_ERR(rockchip->mgmt_rst))
+		return probe_err(dev, PTR_ERR(rockchip->mgmt_rst),
+				 "missing mgmt reset property in node\n");
 
 	rockchip->mgmt_sticky_rst = devm_reset_control_get_exclusive(dev,
 								     "mgmt-sticky");
-	if (IS_ERR(rockchip->mgmt_sticky_rst)) {
-		if (PTR_ERR(rockchip->mgmt_sticky_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing mgmt-sticky reset property in node\n");
-		return PTR_ERR(rockchip->mgmt_sticky_rst);
-	}
+	if (IS_ERR(rockchip->mgmt_sticky_rst))
+		return probe_err(dev, PTR_ERR(rockchip->mgmt_sticky_rst),
+				 "missing mgmt-sticky reset property in node\n");
 
 	rockchip->pipe_rst = devm_reset_control_get_exclusive(dev, "pipe");
-	if (IS_ERR(rockchip->pipe_rst)) {
-		if (PTR_ERR(rockchip->pipe_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing pipe reset property in node\n");
-		return PTR_ERR(rockchip->pipe_rst);
-	}
+	if (IS_ERR(rockchip->pipe_rst))
+		return probe_err(dev, PTR_ERR(rockchip->pipe_rst),
+				 "missing pipe reset property in node\n");
 
 	rockchip->pm_rst = devm_reset_control_get_exclusive(dev, "pm");
-	if (IS_ERR(rockchip->pm_rst)) {
-		if (PTR_ERR(rockchip->pm_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing pm reset property in node\n");
-		return PTR_ERR(rockchip->pm_rst);
-	}
+	if (IS_ERR(rockchip->pm_rst))
+		return probe_err(dev, PTR_ERR(rockchip->pm_rst),
+				 "missing pm reset property in node\n");
 
 	rockchip->pclk_rst = devm_reset_control_get_exclusive(dev, "pclk");
-	if (IS_ERR(rockchip->pclk_rst)) {
-		if (PTR_ERR(rockchip->pclk_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing pclk reset property in node\n");
-		return PTR_ERR(rockchip->pclk_rst);
-	}
+	if (IS_ERR(rockchip->pclk_rst))
+		return probe_err(dev, PTR_ERR(rockchip->pclk_rst),
+				 "missing pclk reset property in node\n");
 
 	rockchip->aclk_rst = devm_reset_control_get_exclusive(dev, "aclk");
-	if (IS_ERR(rockchip->aclk_rst)) {
-		if (PTR_ERR(rockchip->aclk_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing aclk reset property in node\n");
-		return PTR_ERR(rockchip->aclk_rst);
-	}
+	if (IS_ERR(rockchip->aclk_rst))
+		return probe_err(dev, PTR_ERR(rockchip->aclk_rst),
+				 "missing aclk reset property in node\n");
 
 	if (rockchip->is_rc) {
 		rockchip->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
@@ -323,12 +309,10 @@ int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
 		phy = devm_of_phy_get(dev, dev->of_node, name);
 		kfree(name);
 
-		if (IS_ERR(phy)) {
-			if (PTR_ERR(phy) != -EPROBE_DEFER)
-				dev_err(dev, "missing phy for lane %d: %ld\n",
-					i, PTR_ERR(phy));
-			return PTR_ERR(phy);
-		}
+		if (IS_ERR(phy))
+			return probe_err(dev, PTR_ERR(phy),
+					 "missing phy for lane %d: %ld\n", i,
+					 PTR_ERR(phy));
 
 		rockchip->phys[i] = phy;
 	}
diff --git a/drivers/phy/amlogic/phy-meson-gxl-usb2.c b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
index 9f9b5414b97a..39bfaf7e72a0 100644
--- a/drivers/phy/amlogic/phy-meson-gxl-usb2.c
+++ b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
@@ -274,13 +274,8 @@ static int phy_meson_gxl_usb2_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->reset);
 
 	phy = devm_phy_create(dev, NULL, &phy_meson_gxl_usb2_ops);
-	if (IS_ERR(phy)) {
-		ret = PTR_ERR(phy);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to create PHY\n");
-
-		return ret;
-	}
+	if (IS_ERR(phy))
+		return probe_err(dev, PTR_ERR(phy), "failed to create PHY\n");
 
 	phy_set_drvdata(phy, priv);
 
diff --git a/drivers/phy/amlogic/phy-meson-gxl-usb3.c b/drivers/phy/amlogic/phy-meson-gxl-usb3.c
index d37d94ddf9c0..440b1eacc68f 100644
--- a/drivers/phy/amlogic/phy-meson-gxl-usb3.c
+++ b/drivers/phy/amlogic/phy-meson-gxl-usb3.c
@@ -247,13 +247,8 @@ static int phy_meson_gxl_usb3_probe(struct platform_device *pdev)
 	priv->mode = PHY_MODE_USB_HOST;
 
 	phy = devm_phy_create(dev, np, &phy_meson_gxl_usb3_ops);
-	if (IS_ERR(phy)) {
-		ret = PTR_ERR(phy);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to create PHY\n");
-
-		return ret;
-	}
+	if (IS_ERR(phy))
+		return probe_err(dev, PTR_ERR(phy), "failed to create PHY\n");
 
 	phy_set_drvdata(phy, priv);
 
diff --git a/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
index f9e0dd19ff26..84234e9e93db 100644
--- a/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
+++ b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
@@ -188,11 +188,9 @@ static int ltq_rcu_usb2_of_parse(struct ltq_rcu_usb2_priv *priv,
 	}
 
 	priv->ctrl_reset = devm_reset_control_get_shared(dev, "ctrl");
-	if (IS_ERR(priv->ctrl_reset)) {
-		if (PTR_ERR(priv->ctrl_reset) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get 'ctrl' reset\n");
-		return PTR_ERR(priv->ctrl_reset);
-	}
+	if (IS_ERR(priv->ctrl_reset))
+		return probe_err(dev, PTR_ERR(priv->ctrl_reset),
+				 "failed to get 'ctrl' reset\n");
 
 	priv->phy_reset = devm_reset_control_get_optional(dev, "phy");
 
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index a83332411026..c3dce5f0d129 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -1643,14 +1643,11 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
 	snprintf(prop_name, sizeof(prop_name), "pipe%d", id);
 	qphy->pipe_clk = of_clk_get_by_name(np, prop_name);
 	if (IS_ERR(qphy->pipe_clk)) {
-		if (qmp->cfg->type == PHY_TYPE_PCIE ||
-		    qmp->cfg->type == PHY_TYPE_USB3) {
+		if (qmp->cfg->type == PHY_TYPE_PCIE || qmp->cfg->type == PHY_TYPE_USB3) {
 			ret = PTR_ERR(qphy->pipe_clk);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev,
-					"failed to get lane%d pipe_clk, %d\n",
-					id, ret);
-			return ret;
+			return probe_err(dev, ret,
+					 "failed to get lane%d pipe_clk, %d\n",
+					 id, ret);
 		}
 		qphy->pipe_clk = NULL;
 	}
@@ -1763,12 +1760,10 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = qcom_qmp_phy_vreg_init(dev);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get regulator supplies: %d\n",
-				ret);
-		return ret;
-	}
+	if (ret)
+		return probe_err(dev, ret,
+				 "failed to get regulator supplies: %d\n",
+				 ret);
 
 	num = of_get_available_child_count(dev->of_node);
 	/* do we have a rogue child node ? */
diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index 9ce531194f8a..84a3c6f3d718 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -766,17 +766,14 @@ static int qusb2_phy_probe(struct platform_device *pdev)
 	qphy->cfg_ahb_clk = devm_clk_get(dev, "cfg_ahb");
 	if (IS_ERR(qphy->cfg_ahb_clk)) {
 		ret = PTR_ERR(qphy->cfg_ahb_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get cfg ahb clk, %d\n", ret);
-		return ret;
+		return probe_err(dev, ret, "failed to get cfg ahb clk, %d\n",
+				 ret);
 	}
 
 	qphy->ref_clk = devm_clk_get(dev, "ref");
 	if (IS_ERR(qphy->ref_clk)) {
 		ret = PTR_ERR(qphy->ref_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get ref clk, %d\n", ret);
-		return ret;
+		return probe_err(dev, ret, "failed to get ref clk, %d\n", ret);
 	}
 
 	qphy->iface_clk = devm_clk_get(dev, "iface");
@@ -799,12 +796,10 @@ static int qusb2_phy_probe(struct platform_device *pdev)
 		qphy->vregs[i].supply = qusb2_phy_vreg_names[i];
 
 	ret = devm_regulator_bulk_get(dev, num, qphy->vregs);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get regulator supplies: %d\n",
-				ret);
-		return ret;
-	}
+	if (ret)
+		return probe_err(dev, ret,
+				 "failed to get regulator supplies: %d\n",
+				 ret);
 
 	/* Get the specific init parameters of QMP phy */
 	qphy->cfg = of_device_get_match_data(dev);
diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 24bd2717abdb..6d61b93376d7 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -385,11 +385,9 @@ static int rockchip_usb2phy_extcon_register(struct rockchip_usb2phy *rphy)
 
 	if (of_property_read_bool(node, "extcon")) {
 		edev = extcon_get_edev_by_phandle(rphy->dev, 0);
-		if (IS_ERR(edev)) {
-			if (PTR_ERR(edev) != -EPROBE_DEFER)
-				dev_err(rphy->dev, "Invalid or missing extcon\n");
-			return PTR_ERR(edev);
-		}
+		if (IS_ERR(edev))
+			return probe_err(rphy->dev, PTR_ERR(edev),
+					 "Invalid or missing extcon\n");
 	} else {
 		/* Initialize extcon device */
 		edev = devm_extcon_dev_allocate(rphy->dev,
diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index 7cbdde029c0a..9ad4bcb5d5f7 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -397,12 +397,9 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
 	mutex_init(&rk_phy->pcie_mutex);
 
 	rk_phy->phy_rst = devm_reset_control_get(dev, "phy");
-	if (IS_ERR(rk_phy->phy_rst)) {
-		if (PTR_ERR(rk_phy->phy_rst) != -EPROBE_DEFER)
-			dev_err(dev,
-				"missing phy property for reset controller\n");
-		return PTR_ERR(rk_phy->phy_rst);
-	}
+	if (IS_ERR(rk_phy->phy_rst))
+		return probe_err(dev, PTR_ERR(rk_phy->phy_rst),
+				 "missing phy property for reset controller\n");
 
 	rk_phy->clk_pciephy_ref = devm_clk_get(dev, "refclk");
 	if (IS_ERR(rk_phy->clk_pciephy_ref)) {
diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index 1255cd1d9a60..4be9fb10b620 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -365,9 +365,8 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 		phy = devm_phy_create(dev, child, &stm32_usbphyc_phy_ops);
 		if (IS_ERR(phy)) {
 			ret = PTR_ERR(phy);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "failed to create phy%d: %d\n",
-					port, ret);
+			probe_err(dev, ret, "failed to create phy%d: %d\n",
+				  port, ret);
 			goto put_child;
 		}
 
@@ -384,9 +383,8 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 		ret = devm_regulator_bulk_get(&phy->dev, NUM_SUPPLIES,
 					      usbphyc_phy->supplies);
 		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(&phy->dev,
-					"failed to get regulators: %d\n", ret);
+			probe_err(&phy->dev, ret,
+				  "failed to get regulators: %d\n", ret);
 			goto put_child;
 		}
 
diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 7787c6ed9671..aadcd0b64907 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -140,11 +140,9 @@ static int cht_int33fe_probe(struct i2c_client *client)
 
 	/* The FUSB302 uses the irq at index 1 and is the only irq user */
 	fusb302_irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 1);
-	if (fusb302_irq < 0) {
-		if (fusb302_irq != -EPROBE_DEFER)
-			dev_err(dev, "Error getting FUSB302 irq\n");
-		return fusb302_irq;
-	}
+	if (fusb302_irq < 0)
+		return probe_err(dev, fusb302_irq,
+				 "Error getting FUSB302 irq\n");
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
diff --git a/drivers/power/supply/lego_ev3_battery.c b/drivers/power/supply/lego_ev3_battery.c
index 1ae3710909b7..86bd045e4d7f 100644
--- a/drivers/power/supply/lego_ev3_battery.c
+++ b/drivers/power/supply/lego_ev3_battery.c
@@ -166,27 +166,21 @@ static int lego_ev3_battery_probe(struct platform_device *pdev)
 
 	batt->iio_v = devm_iio_channel_get(dev, "voltage");
 	err = PTR_ERR_OR_ZERO(batt->iio_v);
-	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get voltage iio channel\n");
-		return err;
-	}
+	if (err)
+		return probe_err(dev, err,
+				 "Failed to get voltage iio channel\n");
 
 	batt->iio_i = devm_iio_channel_get(dev, "current");
 	err = PTR_ERR_OR_ZERO(batt->iio_i);
-	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get current iio channel\n");
-		return err;
-	}
+	if (err)
+		return probe_err(dev, err,
+				 "Failed to get current iio channel\n");
 
 	batt->rechargeable_gpio = devm_gpiod_get(dev, "rechargeable", GPIOD_IN);
 	err = PTR_ERR_OR_ZERO(batt->rechargeable_gpio);
-	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get rechargeable gpio\n");
-		return err;
-	}
+	if (err)
+		return probe_err(dev, err,
+				 "Failed to get rechargeable gpio\n");
 
 	/*
 	 * The rechargeable battery indication switch cannot be changed without
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 4d99d468df09..58bafea819ed 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -322,10 +322,8 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		pc->clk = devm_clk_get(&pdev->dev, NULL);
 		if (IS_ERR(pc->clk)) {
 			ret = PTR_ERR(pc->clk);
-			if (ret != -EPROBE_DEFER)
-				dev_err(&pdev->dev, "Can't get bus clk: %d\n",
-					ret);
-			return ret;
+			return probe_err(&pdev->dev, ret,
+					 "Can't get bus clk: %d\n", ret);
 		}
 	}
 
@@ -338,9 +336,8 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 
 	if (IS_ERR(pc->pclk)) {
 		ret = PTR_ERR(pc->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Can't get APB clk: %d\n", ret);
-		return ret;
+		return probe_err(&pdev->dev, ret, "Can't get APB clk: %d\n",
+				 ret);
 	}
 
 	ret = clk_prepare_enable(pc->clk);
diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index b2f5ec4f658a..8da68d890546 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -288,10 +288,9 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 		drvdata->nr_gpios = config->nr_gpios;
 		ret = gpio_request_array(drvdata->gpios, drvdata->nr_gpios);
 		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(&pdev->dev,
-					"Could not obtain regulator setting GPIOs: %d\n",
-					ret);
+			probe_err(&pdev->dev, ret,
+				  "Could not obtain regulator setting GPIOs: %d\n",
+				  ret);
 			goto err_memgpio;
 		}
 	}
diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index d200334577f6..33687f23c6b0 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -283,13 +283,10 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 	}
 
 	dsp_reset = devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(dsp_reset)) {
-		if (PTR_ERR(dsp_reset) != -EPROBE_DEFER)
-			dev_err(dev, "unable to get reset control: %ld\n",
-				PTR_ERR(dsp_reset));
-
-		return PTR_ERR(dsp_reset);
-	}
+	if (IS_ERR(dsp_reset))
+		return probe_err(dev, PTR_ERR(dsp_reset),
+				 "unable to get reset control: %ld\n",
+				 PTR_ERR(dsp_reset));
 
 	if (dev->of_node) {
 		ret = of_reserved_mem_device_init(dev);
diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 0d33e3079f0d..332676905bb3 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -187,13 +187,10 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	init_completion(&q6v5->stop_done);
 
 	q6v5->wdog_irq = platform_get_irq_byname(pdev, "wdog");
-	if (q6v5->wdog_irq < 0) {
-		if (q6v5->wdog_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve wdog IRQ: %d\n",
-				q6v5->wdog_irq);
-		return q6v5->wdog_irq;
-	}
+	if (q6v5->wdog_irq < 0)
+		return probe_err(&pdev->dev, q6v5->wdog_irq,
+				 "failed to retrieve wdog IRQ: %d\n",
+				 q6v5->wdog_irq);
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->wdog_irq,
 					NULL, q6v5_wdog_interrupt,
@@ -205,13 +202,10 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	}
 
 	q6v5->fatal_irq = platform_get_irq_byname(pdev, "fatal");
-	if (q6v5->fatal_irq < 0) {
-		if (q6v5->fatal_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve fatal IRQ: %d\n",
-				q6v5->fatal_irq);
-		return q6v5->fatal_irq;
-	}
+	if (q6v5->fatal_irq < 0)
+		return probe_err(&pdev->dev, q6v5->fatal_irq,
+				 "failed to retrieve fatal IRQ: %d\n",
+				 q6v5->fatal_irq);
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->fatal_irq,
 					NULL, q6v5_fatal_interrupt,
@@ -223,13 +217,10 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	}
 
 	q6v5->ready_irq = platform_get_irq_byname(pdev, "ready");
-	if (q6v5->ready_irq < 0) {
-		if (q6v5->ready_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve ready IRQ: %d\n",
-				q6v5->ready_irq);
-		return q6v5->ready_irq;
-	}
+	if (q6v5->ready_irq < 0)
+		return probe_err(&pdev->dev, q6v5->ready_irq,
+				 "failed to retrieve ready IRQ: %d\n",
+				 q6v5->ready_irq);
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->ready_irq,
 					NULL, q6v5_ready_interrupt,
@@ -241,13 +232,10 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	}
 
 	q6v5->handover_irq = platform_get_irq_byname(pdev, "handover");
-	if (q6v5->handover_irq < 0) {
-		if (q6v5->handover_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve handover IRQ: %d\n",
-				q6v5->handover_irq);
-		return q6v5->handover_irq;
-	}
+	if (q6v5->handover_irq < 0)
+		return probe_err(&pdev->dev, q6v5->handover_irq,
+				 "failed to retrieve handover IRQ: %d\n",
+				 q6v5->handover_irq);
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->handover_irq,
 					NULL, q6v5_handover_interrupt,
@@ -260,13 +248,10 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	disable_irq(q6v5->handover_irq);
 
 	q6v5->stop_irq = platform_get_irq_byname(pdev, "stop-ack");
-	if (q6v5->stop_irq < 0) {
-		if (q6v5->stop_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve stop-ack IRQ: %d\n",
-				q6v5->stop_irq);
-		return q6v5->stop_irq;
-	}
+	if (q6v5->stop_irq < 0)
+		return probe_err(&pdev->dev, q6v5->stop_irq,
+				 "failed to retrieve stop-ack IRQ: %d\n",
+				 q6v5->stop_irq);
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->stop_irq,
 					NULL, q6v5_stop_interrupt,
diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 79374d1de311..d66dfc4fcd53 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -285,12 +285,9 @@ static int adsp_init_clock(struct qcom_adsp *adsp)
 	int i, ret;
 
 	adsp->xo = devm_clk_get(adsp->dev, "xo");
-	if (IS_ERR(adsp->xo)) {
-		ret = PTR_ERR(adsp->xo);
-		if (ret != -EPROBE_DEFER)
-			dev_err(adsp->dev, "failed to get xo clock");
-		return ret;
-	}
+	if (IS_ERR(adsp->xo))
+		return probe_err(adsp->dev, PTR_ERR(adsp->xo),
+				 "failed to get xo clock");
 
 	adsp->num_clks = ARRAY_SIZE(adsp_clk_id);
 	adsp->clks = devm_kcalloc(adsp->dev, adsp->num_clks,
diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 4c47f5e0a87c..27de373ab8d2 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -205,13 +205,10 @@ static int q6v5_regulator_init(struct device *dev, struct reg_info *regs,
 
 	for (i = 0; reg_res[i].supply; i++) {
 		regs[i].reg = devm_regulator_get(dev, reg_res[i].supply);
-		if (IS_ERR(regs[i].reg)) {
-			rc = PTR_ERR(regs[i].reg);
-			if (rc != -EPROBE_DEFER)
-				dev_err(dev, "Failed to get %s\n regulator",
-					reg_res[i].supply);
-			return rc;
-		}
+		if (IS_ERR(regs[i].reg))
+			return probe_err(dev, PTR_ERR(regs[i].reg),
+					 "Failed to get %s\n regulator",
+					 reg_res[i].supply);
 
 		regs[i].uV = reg_res[i].uV;
 		regs[i].uA = reg_res[i].uA;
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index b1e63fcd5fdf..bfeed6ab8e48 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -192,22 +192,15 @@ static int adsp_init_clock(struct qcom_adsp *adsp)
 	int ret;
 
 	adsp->xo = devm_clk_get(adsp->dev, "xo");
-	if (IS_ERR(adsp->xo)) {
-		ret = PTR_ERR(adsp->xo);
-		if (ret != -EPROBE_DEFER)
-			dev_err(adsp->dev, "failed to get xo clock");
-		return ret;
-	}
+	if (IS_ERR(adsp->xo))
+		return probe_err(adsp->dev, PTR_ERR(adsp->xo),
+				 "failed to get xo clock");
 
 	if (adsp->has_aggre2_clk) {
 		adsp->aggre2_clk = devm_clk_get(adsp->dev, "aggre2");
-		if (IS_ERR(adsp->aggre2_clk)) {
-			ret = PTR_ERR(adsp->aggre2_clk);
-			if (ret != -EPROBE_DEFER)
-				dev_err(adsp->dev,
-					"failed to get aggre2 clock");
-			return ret;
-		}
+		if (IS_ERR(adsp->aggre2_clk))
+			return probe_err(adsp->dev, PTR_ERR(adsp->aggre2_clk),
+					 "failed to get aggre2 clock");
 	}
 
 	return 0;
diff --git a/drivers/remoteproc/qcom_wcnss_iris.c b/drivers/remoteproc/qcom_wcnss_iris.c
index e842be58e8c7..a6d5aa28e1d9 100644
--- a/drivers/remoteproc/qcom_wcnss_iris.c
+++ b/drivers/remoteproc/qcom_wcnss_iris.c
@@ -117,11 +117,9 @@ static int qcom_iris_probe(struct platform_device *pdev)
 	wcnss = dev_get_drvdata(pdev->dev.parent);
 
 	iris->xo_clk = devm_clk_get(&pdev->dev, "xo");
-	if (IS_ERR(iris->xo_clk)) {
-		if (PTR_ERR(iris->xo_clk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to acquire xo clk\n");
-		return PTR_ERR(iris->xo_clk);
-	}
+	if (IS_ERR(iris->xo_clk))
+		return probe_err(&pdev->dev, PTR_ERR(iris->xo_clk),
+				 "failed to acquire xo clk\n");
 
 	iris->num_vregs = data->num_vregs;
 	iris->vregs = devm_kcalloc(&pdev->dev,
diff --git a/drivers/reset/reset-meson-audio-arb.c b/drivers/reset/reset-meson-audio-arb.c
index 91751617b37a..03519a2c5489 100644
--- a/drivers/reset/reset-meson-audio-arb.c
+++ b/drivers/reset/reset-meson-audio-arb.c
@@ -114,11 +114,9 @@ static int meson_audio_arb_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, arb);
 
 	arb->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(arb->clk)) {
-		if (PTR_ERR(arb->clk) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get clock\n");
-		return PTR_ERR(arb->clk);
-	}
+	if (IS_ERR(arb->clk))
+		return probe_err(dev, PTR_ERR(arb->clk),
+				 "failed to get clock\n");
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	arb->regs = devm_ioremap_resource(dev, res);
diff --git a/drivers/rtc/rtc-rk808.c b/drivers/rtc/rtc-rk808.c
index 739c0d42e835..2ab59ad286bc 100644
--- a/drivers/rtc/rtc-rk808.c
+++ b/drivers/rtc/rtc-rk808.c
@@ -412,12 +412,10 @@ static int rk808_rtc_probe(struct platform_device *pdev)
 	rk808_rtc->rtc->ops = &rk808_rtc_ops;
 
 	rk808_rtc->irq = platform_get_irq(pdev, 0);
-	if (rk808_rtc->irq < 0) {
-		if (rk808_rtc->irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Wake up is not possible as irq = %d\n",
-				rk808_rtc->irq);
-		return rk808_rtc->irq;
-	}
+	if (rk808_rtc->irq < 0)
+		return probe_err(&pdev->dev, rk808_rtc->irq,
+				 "Wake up is not possible as irq = %d\n",
+				 rk808_rtc->irq);
 
 	/* request alarm irq of rk808 */
 	ret = devm_request_threaded_irq(&pdev->dev, rk808_rtc->irq, NULL,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 9c5c5a601332..da64023ee2b2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3612,11 +3612,8 @@ static int hisi_sas_v2_probe(struct platform_device *pdev)
 	 */
 	int ret = platform_get_irq(pdev, 0);
 
-	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "cannot obtain irq\n");
-		return ret;
-	}
+	if (ret < 0)
+		return probe_err(&pdev->dev, ret, "cannot obtain irq\n");
 
 	return hisi_sas_probe(pdev, &hisi_sas_v2_hw);
 }
diff --git a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
index 6289965c42e9..6d73cfd8c16f 100644
--- a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
+++ b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
@@ -183,11 +183,9 @@ static int meson_gx_pwrc_vpu_probe(struct platform_device *pdev)
 	}
 
 	rstc = devm_reset_control_array_get(&pdev->dev, false, false);
-	if (IS_ERR(rstc)) {
-		if (PTR_ERR(rstc) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get reset lines\n");
-		return PTR_ERR(rstc);
-	}
+	if (IS_ERR(rstc))
+		return probe_err(&pdev->dev, PTR_ERR(rstc),
+				 "failed to get reset lines\n");
 
 	vpu_clk = devm_clk_get(&pdev->dev, "vpu");
 	if (IS_ERR(vpu_clk)) {
diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index e7b5994fee9d..a4a7d2ffde6c 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -212,11 +212,10 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 
 	domain->regulator = devm_regulator_get_optional(domain->dev, "power");
 	if (IS_ERR(domain->regulator)) {
-		if (PTR_ERR(domain->regulator) != -ENODEV) {
-			if (PTR_ERR(domain->regulator) != -EPROBE_DEFER)
-				dev_err(domain->dev, "Failed to get domain's regulator\n");
-			return PTR_ERR(domain->regulator);
-		}
+		if (PTR_ERR(domain->regulator) != -ENODEV)
+			return probe_err(domain->dev,
+					 PTR_ERR(domain->regulator),
+					 "Failed to get domain's regulator\n");
 	} else {
 		regulator_set_voltage(domain->regulator,
 				      domain->voltage, domain->voltage);
diff --git a/drivers/soc/lantiq/gphy.c b/drivers/soc/lantiq/gphy.c
index feeb17cebc25..be24b8f89f05 100644
--- a/drivers/soc/lantiq/gphy.c
+++ b/drivers/soc/lantiq/gphy.c
@@ -123,11 +123,9 @@ static int xway_gphy_of_probe(struct platform_device *pdev,
 		return PTR_ERR(priv->membase);
 
 	priv->gphy_reset = devm_reset_control_get(dev, "gphy");
-	if (IS_ERR(priv->gphy_reset)) {
-		if (PTR_ERR(priv->gphy_reset) != -EPROBE_DEFER)
-			dev_err(dev, "Failed to lookup gphy reset\n");
-		return PTR_ERR(priv->gphy_reset);
-	}
+	if (IS_ERR(priv->gphy_reset))
+		return probe_err(dev, PTR_ERR(priv->gphy_reset),
+				 "Failed to lookup gphy reset\n");
 
 	priv->gphy_reset2 = devm_reset_control_get_optional(dev, "gphy2");
 	if (IS_ERR(priv->gphy_reset2))
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 75bd9a83aef0..b2ee7c3ee1f2 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -627,12 +627,9 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	 * do. To avoid adding this check to our children we'll do it now.
 	 */
 	ret = cmd_db_ready();
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Command DB not available (%d)\n",
-									ret);
-		return ret;
-	}
+	if (ret)
+		return probe_err(&pdev->dev, ret,
+				 "Command DB not available (%d)\n", ret);
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
 	if (!drv)
diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index f80d040601fd..a217f8537ab1 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -959,11 +959,9 @@ static int qcom_smem_probe(struct platform_device *pdev)
 		return ret;
 
 	hwlock_id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
-	if (hwlock_id < 0) {
-		if (hwlock_id != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to retrieve hwlock\n");
-		return hwlock_id;
-	}
+	if (hwlock_id < 0)
+		return probe_err(&pdev->dev, hwlock_id,
+				 "failed to retrieve hwlock\n");
 
 	smem->hwlock = hwspin_lock_request_specific(hwlock_id);
 	if (!smem->hwlock)
diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index c22503cd1edf..432334ef5877 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -379,12 +379,9 @@ static int qcom_smp2p_alloc_outbound_item(struct qcom_smp2p *smp2p)
 	int ret;
 
 	ret = qcom_smem_alloc(pid, smem_id, sizeof(*out));
-	if (ret < 0 && ret != -EEXIST) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(smp2p->dev,
-				"unable to allocate local smp2p item\n");
-		return ret;
-	}
+	if (ret < 0 && ret != -EEXIST)
+		return probe_err(smp2p->dev, ret,
+				 "unable to allocate local smp2p item\n");
 
 	out = qcom_smem_get(pid, smem_id, NULL);
 	if (IS_ERR(out)) {
diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index a76acedd7e2f..ed38cb10c608 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -588,10 +588,8 @@ static int tegra_spi_init_dma_param(struct tegra_spi_data *tspi,
 					dma_to_memory ? "rx" : "tx");
 	if (IS_ERR(dma_chan)) {
 		ret = PTR_ERR(dma_chan);
-		if (ret != -EPROBE_DEFER)
-			dev_err(tspi->dev,
-				"Dma channel is not available: %d\n", ret);
-		return ret;
+		return probe_err(tspi->dev, ret,
+				 "Dma channel is not available: %d\n", ret);
 	}
 
 	dma_buf = dma_alloc_coherent(tspi->dev, tspi->dma_buf_size,
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 1427f343b39a..0051488f92df 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -614,10 +614,8 @@ static int tegra_slink_init_dma_param(struct tegra_slink_data *tspi,
 						dma_to_memory ? "rx" : "tx");
 	if (IS_ERR(dma_chan)) {
 		ret = PTR_ERR(dma_chan);
-		if (ret != -EPROBE_DEFER)
-			dev_err(tspi->dev,
-				"Dma channel is not available: %d\n", ret);
-		return ret;
+		return probe_err(tspi->dev, ret,
+				 "Dma channel is not available: %d\n", ret);
 	}
 
 	dma_buf = dma_alloc_coherent(tspi->dev, tspi->dma_buf_size,
diff --git a/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c b/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
index 15b7a82f4b1e..7c6a205eee44 100644
--- a/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
+++ b/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
@@ -158,18 +158,14 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 	}
 
 	clk_wzrd->clk_in1 = devm_clk_get(&pdev->dev, "clk_in1");
-	if (IS_ERR(clk_wzrd->clk_in1)) {
-		if (clk_wzrd->clk_in1 != ERR_PTR(-EPROBE_DEFER))
-			dev_err(&pdev->dev, "clk_in1 not found\n");
-		return PTR_ERR(clk_wzrd->clk_in1);
-	}
+	if (IS_ERR(clk_wzrd->clk_in1))
+		return probe_err(&pdev->dev, PTR_ERR(clk_wzrd->clk_in1),
+				 "clk_in1 not found\n");
 
 	clk_wzrd->axi_clk = devm_clk_get(&pdev->dev, "s_axi_aclk");
-	if (IS_ERR(clk_wzrd->axi_clk)) {
-		if (clk_wzrd->axi_clk != ERR_PTR(-EPROBE_DEFER))
-			dev_err(&pdev->dev, "s_axi_aclk not found\n");
-		return PTR_ERR(clk_wzrd->axi_clk);
-	}
+	if (IS_ERR(clk_wzrd->axi_clk))
+		return probe_err(&pdev->dev, PTR_ERR(clk_wzrd->axi_clk),
+				 "s_axi_aclk not found\n");
 	ret = clk_prepare_enable(clk_wzrd->axi_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "enabling s_axi_aclk failed\n");
diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 23ad4f9f2143..5cc77745b421 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -201,9 +201,8 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 	data->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(data->clk)) {
 		err = PTR_ERR(data->clk);
-		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Could not get clk: %d\n", err);
-		return err;
+		return probe_err(&pdev->dev, err, "Could not get clk: %d\n",
+				 err);
 	}
 
 	err = clk_prepare_enable(data->clk);
diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 761d0559c268..de37b1383a89 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -389,9 +389,8 @@ static int hi6220_thermal_probe(struct hisi_thermal_data *data)
 	data->clk = devm_clk_get(dev, "thermal_clk");
 	if (IS_ERR(data->clk)) {
 		ret = PTR_ERR(data->clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get thermal clk: %d\n", ret);
-		return ret;
+		return probe_err(dev, ret, "failed to get thermal clk: %d\n",
+				 ret);
 	}
 
 	data->irq = platform_get_irq(pdev, 0);
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index d31b975dd3fd..4ea1bbc33b7c 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -506,11 +506,8 @@ static int dw8250_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (irq < 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "cannot get irq\n");
-		return irq;
-	}
+	if (irq < 0)
+		return probe_err(dev, irq, "cannot get irq\n");
 
 	spin_lock_init(&p->lock);
 	p->mapbase	= regs->start;
diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 15a8c8dfa92b..48bbc4463945 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -258,19 +258,15 @@ static int ingenic_uart_probe(struct platform_device *pdev)
 	data->clk_module = devm_clk_get(&pdev->dev, "module");
 	if (IS_ERR(data->clk_module)) {
 		err = PTR_ERR(data->clk_module);
-		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"unable to get module clock: %d\n", err);
-		return err;
+		return probe_err(&pdev->dev, err,
+				 "unable to get module clock: %d\n", err);
 	}
 
 	data->clk_baud = devm_clk_get(&pdev->dev, "baud");
 	if (IS_ERR(data->clk_baud)) {
 		err = PTR_ERR(data->clk_baud);
-		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"unable to get baud clock: %d\n", err);
-		return err;
+		return probe_err(&pdev->dev, err,
+				 "unable to get baud clock: %d\n", err);
 	}
 
 	err = clk_prepare_enable(data->clk_module);
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index ebd33c0232e6..3cb39c608207 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2718,11 +2718,8 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "cannot obtain irq\n");
-		return ret;
-	}
+	if (ret < 0)
+		return probe_err(&pdev->dev, ret, "cannot obtain irq\n");
 	uap->port.irq	= ret;
 
 #ifdef CONFIG_ACPI_SPCR_TABLE
diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 09b37c0d075d..acac5a007a56 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -314,9 +314,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 				&pdata);
 	if (IS_ERR(data->ci_pdev)) {
 		ret = PTR_ERR(data->ci_pdev);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"ci_hdrc_add_device failed, err=%d\n", ret);
+		probe_err(&pdev->dev, ret,
+			  "ci_hdrc_add_device failed, err=%d\n", ret);
 		goto err_clk;
 	}
 
diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index 880009987460..92d87a1546b5 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -259,8 +259,7 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 				     pdev->num_resources, &ci->pdata);
 	if (IS_ERR(plat_ci)) {
 		ret = PTR_ERR(plat_ci);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "ci_hdrc_add_device failed!\n");
+		probe_err(&pdev->dev, ret, "ci_hdrc_add_device failed!\n");
 		goto err_mux;
 	}
 
diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
index c044fba463e4..0745b71c13ce 100644
--- a/drivers/usb/chipidea/ci_hdrc_usb2.c
+++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
@@ -79,10 +79,9 @@ static int ci_hdrc_usb2_probe(struct platform_device *pdev)
 					   pdev->num_resources, ci_pdata);
 	if (IS_ERR(priv->ci_pdev)) {
 		ret = PTR_ERR(priv->ci_pdev);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev,
-				"failed to register ci_hdrc platform device: %d\n",
-				ret);
+		probe_err(dev, ret,
+			  "failed to register ci_hdrc platform device: %d\n",
+			  ret);
 		goto clk_err;
 	}
 
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index becfbb87f791..0baa9bf1e1b8 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1145,11 +1145,9 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
 
 		ret = dwc3_gadget_init(dwc);
-		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "failed to initialize gadget\n");
-			return ret;
-		}
+		if (ret)
+			return probe_err(dev, ret,
+					 "failed to initialize gadget\n");
 		break;
 	case USB_DR_MODE_HOST:
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
@@ -1160,21 +1158,17 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
 
 		ret = dwc3_host_init(dwc);
-		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "failed to initialize host\n");
-			return ret;
-		}
+		if (ret)
+			return probe_err(dev, ret,
+					 "failed to initialize host\n");
 		phy_calibrate(dwc->usb2_generic_phy);
 		break;
 	case USB_DR_MODE_OTG:
 		INIT_WORK(&dwc->drd_work, __dwc3_set_mode);
 		ret = dwc3_drd_init(dwc);
-		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "failed to initialize dual-role\n");
-			return ret;
-		}
+		if (ret)
+			return probe_err(dev, ret,
+					 "failed to initialize dual-role\n");
 		break;
 	default:
 		dev_err(dev, "Unsupported mode of operation %d\n", dwc->dr_mode);
diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index f26109eafdbf..4f0d3853a7cc 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -119,8 +119,7 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	ehci_mv->phy = devm_phy_get(&pdev->dev, "usb");
 	if (IS_ERR(ehci_mv->phy)) {
 		retval = PTR_ERR(ehci_mv->phy);
-		if (retval != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to get phy.\n");
+		probe_err(&pdev->dev, retval, "Failed to get phy.\n");
 		goto err_put_hcd;
 	}
 
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 7e4c13346a1e..5b42a8a83ca0 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -164,9 +164,8 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 				continue;
 
 			ret = PTR_ERR(phy);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "Can't get PHY for port %d: %d\n",
-					i, ret);
+			probe_err(dev, ret, "Can't get PHY for port %d: %d\n",
+				  i, ret);
 			goto err_phy;
 		}
 
diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index a55cbba40a5a..d70cf467d6ae 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -416,16 +416,14 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 	da8xx_ohci->usb11_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(da8xx_ohci->usb11_clk)) {
 		error = PTR_ERR(da8xx_ohci->usb11_clk);
-		if (error != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to get clock.\n");
+		probe_err(&pdev->dev, error, "Failed to get clock.\n");
 		goto err;
 	}
 
 	da8xx_ohci->usb11_phy = devm_phy_get(&pdev->dev, "usb-phy");
 	if (IS_ERR(da8xx_ohci->usb11_phy)) {
 		error = PTR_ERR(da8xx_ohci->usb11_phy);
-		if (error != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to get phy.\n");
+		probe_err(&pdev->dev, error, "Failed to get phy.\n");
 		goto err;
 	}
 
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 1c023c0091c4..aa6e1697c1e7 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -524,11 +524,9 @@ static int da8xx_probe(struct platform_device *pdev)
 	}
 
 	glue->phy = devm_phy_get(&pdev->dev, "usb-phy");
-	if (IS_ERR(glue->phy)) {
-		if (PTR_ERR(glue->phy) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get phy\n");
-		return PTR_ERR(glue->phy);
-	}
+	if (IS_ERR(glue->phy))
+		return probe_err(&pdev->dev, PTR_ERR(glue->phy),
+				 "failed to get phy\n");
 
 	glue->dev			= &pdev->dev;
 	glue->clk			= clk;
diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index 7fbb8a307145..fb1af74a188d 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -719,9 +719,8 @@ static int cppi41_dma_controller_start(struct cppi41_dma_controller *controller)
 		dc = dma_request_chan(dev->parent, str);
 		if (IS_ERR(dc)) {
 			ret = PTR_ERR(dc);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "Failed to request %s: %d.\n",
-					str, ret);
+			probe_err(dev, ret, "Failed to request %s: %d.\n",
+				  str, ret);
 			goto err;
 		}
 
diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 43b64d9309d0..b4e5fb51e904 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -1793,8 +1793,7 @@ static int fusb302_probe(struct i2c_client *client,
 	chip->tcpm_port = tcpm_register_port(&client->dev, &chip->tcpc_dev);
 	if (IS_ERR(chip->tcpm_port)) {
 		ret = PTR_ERR(chip->tcpm_port);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "cannot register tcpm port, ret=%d", ret);
+		probe_err(dev, ret, "cannot register tcpm port, ret=%d", ret);
 		goto destroy_workqueue;
 	}
 
diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index e470da95d806..6e04303ed56b 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -69,15 +69,9 @@ static int gpio_backlight_probe_dt(struct platform_device *pdev,
 	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
 
 	gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
-	if (IS_ERR(gbl->gpiod)) {
-		ret = PTR_ERR(gbl->gpiod);
-
-		if (ret != -EPROBE_DEFER) {
-			dev_err(dev,
-				"Error: The gpios parameter is missing or invalid.\n");
-		}
-		return ret;
-	}
+	if (IS_ERR(gbl->gpiod))
+		return probe_err(dev, PTR_ERR(gbl->gpiod),
+				 "Error: The gpios parameter is missing or invalid.\n");
 
 	return 0;
 }
diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 678b27063198..50ac08119d26 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -536,8 +536,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 	if (IS_ERR(pb->pwm)) {
 		ret = PTR_ERR(pb->pwm);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "unable to request PWM\n");
+		probe_err(&pdev->dev, ret, "unable to request PWM\n");
 		goto err_alloc;
 	}
 
diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index ebb85d60b6d5..5e53f2a5b283 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -205,11 +205,9 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 
 	davinci_wdt->clk = devm_clk_get(dev, NULL);
 
-	if (IS_ERR(davinci_wdt->clk)) {
-		if (PTR_ERR(davinci_wdt->clk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get clock node\n");
-		return PTR_ERR(davinci_wdt->clk);
-	}
+	if (IS_ERR(davinci_wdt->clk))
+		return probe_err(&pdev->dev, PTR_ERR(davinci_wdt->clk),
+				 "failed to get clock node\n");
 
 	ret = clk_prepare_enable(davinci_wdt->clk);
 	if (ret) {
diff --git a/sound/soc/atmel/tse850-pcm5142.c b/sound/soc/atmel/tse850-pcm5142.c
index 214adcad5419..0987c8b6a0dc 100644
--- a/sound/soc/atmel/tse850-pcm5142.c
+++ b/sound/soc/atmel/tse850-pcm5142.c
@@ -366,35 +366,27 @@ static int tse850_probe(struct platform_device *pdev)
 	}
 
 	tse850->add = devm_gpiod_get(dev, "axentia,add", GPIOD_OUT_HIGH);
-	if (IS_ERR(tse850->add)) {
-		if (PTR_ERR(tse850->add) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get 'add' gpio\n");
-		return PTR_ERR(tse850->add);
-	}
+	if (IS_ERR(tse850->add))
+		return probe_err(dev, PTR_ERR(tse850->add),
+				 "failed to get 'add' gpio\n");
 	tse850->add_cache = 1;
 
 	tse850->loop1 = devm_gpiod_get(dev, "axentia,loop1", GPIOD_OUT_HIGH);
-	if (IS_ERR(tse850->loop1)) {
-		if (PTR_ERR(tse850->loop1) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get 'loop1' gpio\n");
-		return PTR_ERR(tse850->loop1);
-	}
+	if (IS_ERR(tse850->loop1))
+		return probe_err(dev, PTR_ERR(tse850->loop1),
+				 "failed to get 'loop1' gpio\n");
 	tse850->loop1_cache = 1;
 
 	tse850->loop2 = devm_gpiod_get(dev, "axentia,loop2", GPIOD_OUT_HIGH);
-	if (IS_ERR(tse850->loop2)) {
-		if (PTR_ERR(tse850->loop2) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get 'loop2' gpio\n");
-		return PTR_ERR(tse850->loop2);
-	}
+	if (IS_ERR(tse850->loop2))
+		return probe_err(dev, PTR_ERR(tse850->loop2),
+				 "failed to get 'loop2' gpio\n");
 	tse850->loop2_cache = 1;
 
 	tse850->ana = devm_regulator_get(dev, "axentia,ana");
-	if (IS_ERR(tse850->ana)) {
-		if (PTR_ERR(tse850->ana) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get 'ana' regulator\n");
-		return PTR_ERR(tse850->ana);
-	}
+	if (IS_ERR(tse850->ana))
+		return probe_err(dev, PTR_ERR(tse850->ana),
+				 "failed to get 'ana' regulator\n");
 
 	ret = regulator_enable(tse850->ana);
 	if (ret < 0) {
diff --git a/sound/soc/codecs/es7241.c b/sound/soc/codecs/es7241.c
index 87991bd4acef..7af2385f365d 100644
--- a/sound/soc/codecs/es7241.c
+++ b/sound/soc/codecs/es7241.c
@@ -273,25 +273,20 @@ static int es7241_probe(struct platform_device *pdev)
 	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->reset)) {
 		err = PTR_ERR(priv->reset);
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get 'reset' gpio: %d", err);
-		return err;
+		return probe_err(dev, err, "Failed to get 'reset' gpio: %d",
+				 err);
 	}
 
 	priv->m0 = devm_gpiod_get_optional(dev, "m0", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->m0)) {
 		err = PTR_ERR(priv->m0);
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get 'm0' gpio: %d", err);
-		return err;
+		return probe_err(dev, err, "Failed to get 'm0' gpio: %d", err);
 	}
 
 	priv->m1 = devm_gpiod_get_optional(dev, "m1", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->m1)) {
 		err = PTR_ERR(priv->m1);
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get 'm1' gpio: %d", err);
-		return err;
+		return probe_err(dev, err, "Failed to get 'm1' gpio: %d", err);
 	}
 
 	return devm_snd_soc_register_component(&pdev->dev,
diff --git a/sound/soc/codecs/max9759.c b/sound/soc/codecs/max9759.c
index ecfb4a80424b..7567144ac285 100644
--- a/sound/soc/codecs/max9759.c
+++ b/sound/soc/codecs/max9759.c
@@ -151,26 +151,23 @@ static int max9759_probe(struct platform_device *pdev)
 	priv->gpiod_shutdown = devm_gpiod_get(dev, "shutdown", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->gpiod_shutdown)) {
 		err = PTR_ERR(priv->gpiod_shutdown);
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get 'shutdown' gpio: %d", err);
-		return err;
+		return probe_err(dev, err,
+				 "Failed to get 'shutdown' gpio: %d", err);
 	}
 
 	priv->gpiod_mute = devm_gpiod_get(dev, "mute", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->gpiod_mute)) {
 		err = PTR_ERR(priv->gpiod_mute);
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get 'mute' gpio: %d", err);
-		return err;
+		return probe_err(dev, err, "Failed to get 'mute' gpio: %d",
+				 err);
 	}
 	priv->is_mute = true;
 
 	priv->gpiod_gain = devm_gpiod_get_array(dev, "gain", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->gpiod_gain)) {
 		err = PTR_ERR(priv->gpiod_gain);
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get 'gain' gpios: %d", err);
-		return err;
+		return probe_err(dev, err, "Failed to get 'gain' gpios: %d",
+				 err);
 	}
 	priv->gain = 0;
 
diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index de3d44e9199b..6d577e4395e8 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -608,9 +608,8 @@ static int max9860_probe(struct i2c_client *i2c)
 	max9860->dvddio = devm_regulator_get(dev, "DVDDIO");
 	if (IS_ERR(max9860->dvddio)) {
 		ret = PTR_ERR(max9860->dvddio);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get DVDDIO supply: %d\n", ret);
-		return ret;
+		return probe_err(dev, ret,
+				 "Failed to get DVDDIO supply: %d\n", ret);
 	}
 
 	max9860->dvddio_nb.notifier_call = max9860_dvddio_event;
@@ -642,8 +641,7 @@ static int max9860_probe(struct i2c_client *i2c)
 
 	if (IS_ERR(mclk)) {
 		ret = PTR_ERR(mclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get MCLK: %d\n", ret);
+		probe_err(dev, ret, "Failed to get MCLK: %d\n", ret);
 		goto err_regulator;
 	}
 
diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 3356c91f55b0..3ceeec1fba7f 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -621,9 +621,8 @@ int pcm3168a_probe(struct device *dev, struct regmap *regmap)
 	pcm3168a->scki = devm_clk_get(dev, "scki");
 	if (IS_ERR(pcm3168a->scki)) {
 		ret = PTR_ERR(pcm3168a->scki);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to acquire clock 'scki': %d\n", ret);
-		return ret;
+		return probe_err(dev, ret,
+				 "failed to acquire clock 'scki': %d\n", ret);
 	}
 
 	ret = clk_prepare_enable(pcm3168a->scki);
@@ -640,8 +639,7 @@ int pcm3168a_probe(struct device *dev, struct regmap *regmap)
 	ret = devm_regulator_bulk_get(dev,
 			ARRAY_SIZE(pcm3168a->supplies), pcm3168a->supplies);
 	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to request supplies: %d\n", ret);
+		probe_err(dev, ret, "failed to request supplies: %d\n", ret);
 		goto err_clk;
 	}
 
diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index add18d6d77da..52452191b9ac 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1422,9 +1422,8 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 		if (ret == -ENOENT)
 			ret = -EPROBE_DEFER;
 
-		if (ret != -EPROBE_DEFER)
-			dev_err(&client->dev, "Failed to get mclock: %d\n",
-				ret);
+		probe_err(&client->dev, ret, "Failed to get mclock: %d\n",
+			  ret);
 		goto disable_regs;
 	}
 
diff --git a/sound/soc/codecs/simple-amplifier.c b/sound/soc/codecs/simple-amplifier.c
index 85524acf3e9c..ea9da0468f35 100644
--- a/sound/soc/codecs/simple-amplifier.c
+++ b/sound/soc/codecs/simple-amplifier.c
@@ -88,9 +88,8 @@ static int simple_amp_probe(struct platform_device *pdev)
 	priv->gpiod_enable = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->gpiod_enable)) {
 		err = PTR_ERR(priv->gpiod_enable);
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get 'enable' gpio: %d", err);
-		return err;
+		return probe_err(dev, err, "Failed to get 'enable' gpio: %d",
+				 err);
 	}
 
 	return devm_snd_soc_register_component(dev,
diff --git a/sound/soc/codecs/ssm2305.c b/sound/soc/codecs/ssm2305.c
index 2968959c4b75..80b1fecc6716 100644
--- a/sound/soc/codecs/ssm2305.c
+++ b/sound/soc/codecs/ssm2305.c
@@ -71,10 +71,8 @@ static int ssm2305_probe(struct platform_device *pdev)
 					      GPIOD_OUT_LOW);
 	if (IS_ERR(priv->gpiod_shutdown)) {
 		err = PTR_ERR(priv->gpiod_shutdown);
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get 'shutdown' gpio: %d\n",
-				err);
-		return err;
+		return probe_err(dev, err,
+				 "Failed to get 'shutdown' gpio: %d\n", err);
 	}
 
 	return devm_snd_soc_register_component(dev, &ssm2305_component_driver,
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 267aee776b2d..8577d090652f 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1762,13 +1762,10 @@ static int davinci_mcasp_get_dma_type(struct davinci_mcasp *mcasp)
 
 	tmp = mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK].filter_data;
 	chan = dma_request_slave_channel_reason(mcasp->dev, tmp);
-	if (IS_ERR(chan)) {
-		if (PTR_ERR(chan) != -EPROBE_DEFER)
-			dev_err(mcasp->dev,
-				"Can't verify DMA configuration (%ld)\n",
-				PTR_ERR(chan));
-		return PTR_ERR(chan);
-	}
+	if (IS_ERR(chan))
+		return probe_err(mcasp->dev, PTR_ERR(chan),
+				 "Can't verify DMA configuration (%ld)\n",
+				 PTR_ERR(chan));
 	if (WARN_ON(!chan->device || !chan->device->dev))
 		return -EINVAL;
 
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 25c819e402e1..9dabb6cabe30 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -352,8 +352,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 
 	ret = asoc_graph_card_parse_of(priv);
 	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "parse error %d\n", ret);
+		probe_err(dev, ret, "parse error %d\n", ret);
 		goto err;
 	}
 
diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index b83bb31021a9..4a8681f72309 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -383,8 +383,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 
 	ret = asoc_graph_card_parse_of(priv);
 	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "parse error %d\n", ret);
+		probe_err(dev, ret, "parse error %d\n", ret);
 		goto err;
 	}
 
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 5a3f59aa4ba5..98298e3798f1 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -410,8 +410,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 
 		ret = asoc_simple_card_parse_of(priv);
 		if (ret < 0) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "parse error %d\n", ret);
+			probe_err(dev, ret, "parse error %d\n", ret);
 			goto err;
 		}
 
diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 85b46f0eae0f..9b4674f0c933 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -280,8 +280,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 
 	ret = asoc_simple_card_parse_of(priv);
 	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "parse error %d\n", ret);
+		probe_err(dev, ret, "parse error %d\n", ret);
 		goto err;
 	}
 
diff --git a/sound/soc/img/img-i2s-in.c b/sound/soc/img/img-i2s-in.c
index 388cefd7340a..dddf907b9a90 100644
--- a/sound/soc/img/img-i2s-in.c
+++ b/sound/soc/img/img-i2s-in.c
@@ -453,11 +453,9 @@ static int img_i2s_in_probe(struct platform_device *pdev)
 	i2s->channel_base = base + (max_i2s_chan_pow_2 * 0x20);
 
 	i2s->clk_sys = devm_clk_get(dev, "sys");
-	if (IS_ERR(i2s->clk_sys)) {
-		if (PTR_ERR(i2s->clk_sys) != -EPROBE_DEFER)
-			dev_err(dev, "Failed to acquire clock 'sys'\n");
-		return PTR_ERR(i2s->clk_sys);
-	}
+	if (IS_ERR(i2s->clk_sys))
+		return probe_err(dev, PTR_ERR(i2s->clk_sys),
+				 "Failed to acquire clock 'sys'\n");
 
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
diff --git a/sound/soc/img/img-i2s-out.c b/sound/soc/img/img-i2s-out.c
index fc2d1dac6333..7bc77b320614 100644
--- a/sound/soc/img/img-i2s-out.c
+++ b/sound/soc/img/img-i2s-out.c
@@ -459,25 +459,19 @@ static int img_i2s_out_probe(struct platform_device *pdev)
 	i2s->channel_base = base + (max_i2s_chan_pow_2 * 0x20);
 
 	i2s->rst = devm_reset_control_get_exclusive(&pdev->dev, "rst");
-	if (IS_ERR(i2s->rst)) {
-		if (PTR_ERR(i2s->rst) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "No top level reset found\n");
-		return PTR_ERR(i2s->rst);
-	}
+	if (IS_ERR(i2s->rst))
+		return probe_err(&pdev->dev, PTR_ERR(i2s->rst),
+				 "No top level reset found\n");
 
 	i2s->clk_sys = devm_clk_get(&pdev->dev, "sys");
-	if (IS_ERR(i2s->clk_sys)) {
-		if (PTR_ERR(i2s->clk_sys) != -EPROBE_DEFER)
-			dev_err(dev, "Failed to acquire clock 'sys'\n");
-		return PTR_ERR(i2s->clk_sys);
-	}
+	if (IS_ERR(i2s->clk_sys))
+		return probe_err(dev, PTR_ERR(i2s->clk_sys),
+				 "Failed to acquire clock 'sys'\n");
 
 	i2s->clk_ref = devm_clk_get(&pdev->dev, "ref");
-	if (IS_ERR(i2s->clk_ref)) {
-		if (PTR_ERR(i2s->clk_ref) != -EPROBE_DEFER)
-			dev_err(dev, "Failed to acquire clock 'ref'\n");
-		return PTR_ERR(i2s->clk_ref);
-	}
+	if (IS_ERR(i2s->clk_ref))
+		return probe_err(dev, PTR_ERR(i2s->clk_ref),
+				 "Failed to acquire clock 'ref'\n");
 
 	i2s->suspend_ch_ctl = devm_kcalloc(dev,
 		i2s->max_i2s_chan, sizeof(*i2s->suspend_ch_ctl), GFP_KERNEL);
diff --git a/sound/soc/img/img-parallel-out.c b/sound/soc/img/img-parallel-out.c
index acc005217be0..7830b7f22ccc 100644
--- a/sound/soc/img/img-parallel-out.c
+++ b/sound/soc/img/img-parallel-out.c
@@ -231,25 +231,19 @@ static int img_prl_out_probe(struct platform_device *pdev)
 	prl->base = base;
 
 	prl->rst = devm_reset_control_get_exclusive(&pdev->dev, "rst");
-	if (IS_ERR(prl->rst)) {
-		if (PTR_ERR(prl->rst) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "No top level reset found\n");
-		return PTR_ERR(prl->rst);
-	}
+	if (IS_ERR(prl->rst))
+		return probe_err(&pdev->dev, PTR_ERR(prl->rst),
+				 "No top level reset found\n");
 
 	prl->clk_sys = devm_clk_get(&pdev->dev, "sys");
-	if (IS_ERR(prl->clk_sys)) {
-		if (PTR_ERR(prl->clk_sys) != -EPROBE_DEFER)
-			dev_err(dev, "Failed to acquire clock 'sys'\n");
-		return PTR_ERR(prl->clk_sys);
-	}
+	if (IS_ERR(prl->clk_sys))
+		return probe_err(dev, PTR_ERR(prl->clk_sys),
+				 "Failed to acquire clock 'sys'\n");
 
 	prl->clk_ref = devm_clk_get(&pdev->dev, "ref");
-	if (IS_ERR(prl->clk_ref)) {
-		if (PTR_ERR(prl->clk_ref) != -EPROBE_DEFER)
-			dev_err(dev, "Failed to acquire clock 'ref'\n");
-		return PTR_ERR(prl->clk_ref);
-	}
+	if (IS_ERR(prl->clk_ref))
+		return probe_err(dev, PTR_ERR(prl->clk_ref),
+				 "Failed to acquire clock 'ref'\n");
 
 	ret = clk_prepare_enable(prl->clk_sys);
 	if (ret)
diff --git a/sound/soc/img/img-spdif-in.c b/sound/soc/img/img-spdif-in.c
index cedd40c8d1f3..8b350a002f2e 100644
--- a/sound/soc/img/img-spdif-in.c
+++ b/sound/soc/img/img-spdif-in.c
@@ -743,11 +743,9 @@ static int img_spdif_in_probe(struct platform_device *pdev)
 	spdif->base = base;
 
 	spdif->clk_sys = devm_clk_get(dev, "sys");
-	if (IS_ERR(spdif->clk_sys)) {
-		if (PTR_ERR(spdif->clk_sys) != -EPROBE_DEFER)
-			dev_err(dev, "Failed to acquire clock 'sys'\n");
-		return PTR_ERR(spdif->clk_sys);
-	}
+	if (IS_ERR(spdif->clk_sys))
+		return probe_err(dev, PTR_ERR(spdif->clk_sys),
+				 "Failed to acquire clock 'sys'\n");
 
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
diff --git a/sound/soc/img/img-spdif-out.c b/sound/soc/img/img-spdif-out.c
index 934ed3df2ebf..bfba1628bd1b 100644
--- a/sound/soc/img/img-spdif-out.c
+++ b/sound/soc/img/img-spdif-out.c
@@ -346,25 +346,19 @@ static int img_spdif_out_probe(struct platform_device *pdev)
 	spdif->base = base;
 
 	spdif->rst = devm_reset_control_get_exclusive(&pdev->dev, "rst");
-	if (IS_ERR(spdif->rst)) {
-		if (PTR_ERR(spdif->rst) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "No top level reset found\n");
-		return PTR_ERR(spdif->rst);
-	}
+	if (IS_ERR(spdif->rst))
+		return probe_err(&pdev->dev, PTR_ERR(spdif->rst),
+				 "No top level reset found\n");
 
 	spdif->clk_sys = devm_clk_get(&pdev->dev, "sys");
-	if (IS_ERR(spdif->clk_sys)) {
-		if (PTR_ERR(spdif->clk_sys) != -EPROBE_DEFER)
-			dev_err(dev, "Failed to acquire clock 'sys'\n");
-		return PTR_ERR(spdif->clk_sys);
-	}
+	if (IS_ERR(spdif->clk_sys))
+		return probe_err(dev, PTR_ERR(spdif->clk_sys),
+				 "Failed to acquire clock 'sys'\n");
 
 	spdif->clk_ref = devm_clk_get(&pdev->dev, "ref");
-	if (IS_ERR(spdif->clk_ref)) {
-		if (PTR_ERR(spdif->clk_ref) != -EPROBE_DEFER)
-			dev_err(dev, "Failed to acquire clock 'ref'\n");
-		return PTR_ERR(spdif->clk_ref);
-	}
+	if (IS_ERR(spdif->clk_ref))
+		return probe_err(dev, PTR_ERR(spdif->clk_ref),
+				 "Failed to acquire clock 'ref'\n");
 
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
diff --git a/sound/soc/img/pistachio-internal-dac.c b/sound/soc/img/pistachio-internal-dac.c
index 915b894f99ce..589c5297f269 100644
--- a/sound/soc/img/pistachio-internal-dac.c
+++ b/sound/soc/img/pistachio-internal-dac.c
@@ -166,9 +166,9 @@ static int pistachio_internal_dac_probe(struct platform_device *pdev)
 	dac->supply = devm_regulator_get(dev, "VDD");
 	if (IS_ERR(dac->supply)) {
 		ret = PTR_ERR(dac->supply);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to acquire supply 'VDD-supply': %d\n", ret);
-		return ret;
+		return probe_err(dev, ret,
+				 "failed to acquire supply 'VDD-supply': %d\n",
+				 ret);
 	}
 
 	ret = regulator_enable(dac->supply);
diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index aa54d2c612c9..e8bf834623c9 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -68,11 +68,8 @@ static int axg_card_parse_dai(struct snd_soc_card *card,
 
 	ret = of_parse_phandle_with_args(node, "sound-dai",
 					 "#sound-dai-cells", 0, &args);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(card->dev, "can't parse dai %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return probe_err(card->dev, ret, "can't parse dai %d\n", ret);
 	*dai_of_node = args.np;
 
 	return snd_soc_get_dai_name(&args, dai_name);
diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 0e4f65e654c4..a59a637ffc6d 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -312,20 +312,16 @@ int axg_fifo_probe(struct platform_device *pdev)
 	}
 
 	fifo->pclk = devm_clk_get(dev, NULL);
-	if (IS_ERR(fifo->pclk)) {
-		if (PTR_ERR(fifo->pclk) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pclk: %ld\n",
-				PTR_ERR(fifo->pclk));
-		return PTR_ERR(fifo->pclk);
-	}
+	if (IS_ERR(fifo->pclk))
+		return probe_err(dev, PTR_ERR(fifo->pclk),
+				 "failed to get pclk: %ld\n",
+				 PTR_ERR(fifo->pclk));
 
 	fifo->arb = devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(fifo->arb)) {
-		if (PTR_ERR(fifo->arb) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get arb reset: %ld\n",
-				PTR_ERR(fifo->arb));
-		return PTR_ERR(fifo->arb);
-	}
+	if (IS_ERR(fifo->arb))
+		return probe_err(dev, PTR_ERR(fifo->arb),
+				 "failed to get arb reset: %ld\n",
+				 PTR_ERR(fifo->arb));
 
 	fifo->irq = of_irq_get(dev->of_node, 0);
 	if (fifo->irq <= 0) {
diff --git a/sound/soc/meson/axg-pdm.c b/sound/soc/meson/axg-pdm.c
index 9d5684493ffc..1001269d9fdb 100644
--- a/sound/soc/meson/axg-pdm.c
+++ b/sound/soc/meson/axg-pdm.c
@@ -615,25 +615,19 @@ static int axg_pdm_probe(struct platform_device *pdev)
 	priv->pclk = devm_clk_get(dev, "pclk");
 	if (IS_ERR(priv->pclk)) {
 		ret = PTR_ERR(priv->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pclk: %d\n", ret);
-		return ret;
+		return probe_err(dev, ret, "failed to get pclk: %d\n", ret);
 	}
 
 	priv->dclk = devm_clk_get(dev, "dclk");
 	if (IS_ERR(priv->dclk)) {
 		ret = PTR_ERR(priv->dclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get dclk: %d\n", ret);
-		return ret;
+		return probe_err(dev, ret, "failed to get dclk: %d\n", ret);
 	}
 
 	priv->sysclk = devm_clk_get(dev, "sysclk");
 	if (IS_ERR(priv->sysclk)) {
 		ret = PTR_ERR(priv->sysclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get dclk: %d\n", ret);
-		return ret;
+		return probe_err(dev, ret, "failed to get dclk: %d\n", ret);
 	}
 
 	return devm_snd_soc_register_component(dev, &axg_pdm_component_drv,
diff --git a/sound/soc/meson/axg-spdifout.c b/sound/soc/meson/axg-spdifout.c
index 9dea528053ad..6a75ddab7f7d 100644
--- a/sound/soc/meson/axg-spdifout.c
+++ b/sound/soc/meson/axg-spdifout.c
@@ -425,17 +425,13 @@ static int axg_spdifout_probe(struct platform_device *pdev)
 	priv->pclk = devm_clk_get(dev, "pclk");
 	if (IS_ERR(priv->pclk)) {
 		ret = PTR_ERR(priv->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pclk: %d\n", ret);
-		return ret;
+		return probe_err(dev, ret, "failed to get pclk: %d\n", ret);
 	}
 
 	priv->mclk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(priv->mclk)) {
 		ret = PTR_ERR(priv->mclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get mclk: %d\n", ret);
-		return ret;
+		return probe_err(dev, ret, "failed to get mclk: %d\n", ret);
 	}
 
 	return devm_snd_soc_register_component(dev, &axg_spdifout_component_drv,
diff --git a/sound/soc/meson/axg-tdm-formatter.c b/sound/soc/meson/axg-tdm-formatter.c
index 43e390f9358a..00d6e0449d34 100644
--- a/sound/soc/meson/axg-tdm-formatter.c
+++ b/sound/soc/meson/axg-tdm-formatter.c
@@ -263,45 +263,37 @@ int axg_tdm_formatter_probe(struct platform_device *pdev)
 	formatter->pclk = devm_clk_get(dev, "pclk");
 	if (IS_ERR(formatter->pclk)) {
 		ret = PTR_ERR(formatter->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pclk: %d\n", ret);
-		return ret;
+		return probe_err(dev, ret, "failed to get pclk: %d\n", ret);
 	}
 
 	/* Formatter bit clock */
 	formatter->sclk = devm_clk_get(dev, "sclk");
 	if (IS_ERR(formatter->sclk)) {
 		ret = PTR_ERR(formatter->sclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get sclk: %d\n", ret);
-		return ret;
+		return probe_err(dev, ret, "failed to get sclk: %d\n", ret);
 	}
 
 	/* Formatter sample clock */
 	formatter->lrclk = devm_clk_get(dev, "lrclk");
 	if (IS_ERR(formatter->lrclk)) {
 		ret = PTR_ERR(formatter->lrclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get lrclk: %d\n", ret);
-		return ret;
+		return probe_err(dev, ret, "failed to get lrclk: %d\n", ret);
 	}
 
 	/* Formatter bit clock input multiplexer */
 	formatter->sclk_sel = devm_clk_get(dev, "sclk_sel");
 	if (IS_ERR(formatter->sclk_sel)) {
 		ret = PTR_ERR(formatter->sclk_sel);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get sclk_sel: %d\n", ret);
-		return ret;
+		return probe_err(dev, ret, "failed to get sclk_sel: %d\n",
+				 ret);
 	}
 
 	/* Formatter sample clock input multiplexer */
 	formatter->lrclk_sel = devm_clk_get(dev, "lrclk_sel");
 	if (IS_ERR(formatter->lrclk_sel)) {
 		ret = PTR_ERR(formatter->lrclk_sel);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get lrclk_sel: %d\n", ret);
-		return ret;
+		return probe_err(dev, ret, "failed to get lrclk_sel: %d\n",
+				 ret);
 	}
 
 	return devm_snd_soc_register_component(dev, drv->component_drv,
diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 585ce030b79b..47605aa8647e 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -499,18 +499,14 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
 	iface->sclk = devm_clk_get(dev, "sclk");
 	if (IS_ERR(iface->sclk)) {
 		ret = PTR_ERR(iface->sclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get sclk: %d\n", ret);
-		return ret;
+		return probe_err(dev, ret, "failed to get sclk: %d\n", ret);
 	}
 
 	/* Sample clock provided on the pad */
 	iface->lrclk = devm_clk_get(dev, "lrclk");
 	if (IS_ERR(iface->lrclk)) {
 		ret = PTR_ERR(iface->lrclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get lrclk: %d\n", ret);
-		return ret;
+		return probe_err(dev, ret, "failed to get lrclk: %d\n", ret);
 	}
 
 	/*
diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index 2b3f2408301a..867e9b5419ff 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -162,12 +162,9 @@ static int mxs_sgtl5000_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
-				ret);
-		return ret;
-	}
+	if (ret)
+		return probe_err(&pdev->dev, ret,
+				 "snd_soc_register_card failed (%d)\n", ret);
 
 	return 0;
 }
diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 9a3cb7704810..b510d81642a7 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1621,9 +1621,8 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 						  GPIOD_OUT_LOW);
 	if (IS_ERR(scodec->gpio_pa)) {
 		ret = PTR_ERR(scodec->gpio_pa);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to get pa gpio: %d\n", ret);
-		return ret;
+		return probe_err(&pdev->dev, ret,
+				 "Failed to get pa gpio: %d\n", ret);
 	}
 
 	/* reg_field setup */
-- 
2.18.0

