Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EACEC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1193820881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uAlDI7al"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1193820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJPPL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:11:56 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59792 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeJPPL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:11:56 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181016072250euoutp0287b92d3b04f14186857d34217dd5cdd8~eBd1GxxA01631116311euoutp02R;
        Tue, 16 Oct 2018 07:22:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181016072250euoutp0287b92d3b04f14186857d34217dd5cdd8~eBd1GxxA01631116311euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539674570;
        bh=4PXZJ+LXXEF+OtbzATccRUV0NPhfME8U+BVmIFjw9bk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=uAlDI7alhN3ZfnSSfWKo+PihazyYgtm5STJ4FulA4ez0u7CznuDznK/swgIJSX/ri
         t8/Jqs2fBleria/CNrQOWEjwn4JGGCCy9n45bNerH0AeZFCjtHLTrEg65Iv7HI9EDb
         ErbPaQ8DjETZOPOW19J2Ml6yKr/i2ssHcavso8NQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181016072249eucas1p170e0b078977f3b79b4ee1b59fc5744b3~eBd0S-Jya1687516875eucas1p1o;
        Tue, 16 Oct 2018 07:22:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0A.2A.04806.9C195CB5; Tue, 16
        Oct 2018 08:22:49 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181016072248eucas1p18943ce87e084797cd597afd4edb65a65~eBdzaxeFq1687516875eucas1p1n;
        Tue, 16 Oct 2018 07:22:48 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-6a-5bc591c96f49
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9F.56.04128.8C195CB5; Tue, 16
        Oct 2018 08:22:48 +0100 (BST)
Received: from AMDC2768.DIGITAL.local ([106.120.43.17]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGO0048DKHZVR70@eusync1.samsung.com>;
        Tue, 16 Oct 2018 08:22:48 +0100 (BST)
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
Subject: [PATCH 0/3] driver core: add probe error check helper
Date:   Tue, 16 Oct 2018 09:22:41 +0200
Message-id: <20181016072244.1216-1-a.hajda@samsung.com>
X-Mailer: git-send-email 2.18.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7djP87onJx6NNjjcJWxxa905VouXEw4z
        WmycsZ7VYurDJ2wWzYvXs1ksnLac0WLT42usFpd3zWGzWHvkLrvF3C9TmR24PHbOusvusWlV
        J5vH/rlr2D02L6n3eL/vKptH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZdzZu5yx4JpfRXt7
        eQPjRtMuRk4OCQETiavzLrF0MXJxCAmsYJRYemEmE4TzmVFiw80mRpiqyf1vmUFsIYFljBJP
        m+whiv4zStzd/5sdJMEmoCnxd/NNNhBbRMBYov/sLHaQImaBN0wSTx5MYQJJCAvYSczaeBxs
        KouAqsTGhbtYQGxeAXOJjbfPQ22Tl3h4vJ0RpFlCYAKbxJyvR5kgEi4SD09eYYewhSVeHd8C
        ZctIXJ7czQJh10s0zbzCDNHcwShxYvFyNoiEtcTh4xdZQWxmAT6JSdumAxVxAMV5JTrahCBM
        D4k3uwxBTCGBWImnb/0nMEosYGRYxSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJERiTp/8d
        /7qDcd+fpEOMAhyMSjy8P64fiRZiTSwrrsw9xCjBwawkwitbeTRaiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOO+yeRujhQTSE0tSs1NTC1KLYLJMHJxSDYz8su+f7mr2nnHssXfVnmLXl3x+Dbdf
        //stZR56+XCq4LX+RtM1b7WdPk1jSDrCeuh0xM+/xfaG1quZNziIyd6OO+uw4Nn/+dPbNkz6
        fou3baNaXfE1ZVel+Vuu66tWlRlpBN69wf+vP77sVDLfG60e79SyKXtmRfbwbrdc6Pmi//BZ
        rVA+8+tKLMUZiYZazEXFiQChpEWGxQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnluLIzCtJLcpLzFFi42I5/e/4Zd0TE49GGxz5oGlxa905VouXEw4z
        WmycsZ7VYurDJ2wWzYvXs1ksnLac0WLT42usFpd3zWGzWHvkLrvF3C9TmR24PHbOusvusWlV
        J5vH/rlr2D02L6n3eL/vKptH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZdzZu5yx4JpfRXt7
        eQPjRtMuRk4OCQETicn9b5m7GLk4hASWMEr8n9fBBOE0Mkm8fnSKGaSKTUBT4u/mm2wgtoiA
        sUT/2VnsIEXMAu+YJGY9ecEIkhAWsJOYtfE4mM0ioCqxceEuFhCbV8BcYuPt84wQ6+QlHh5v
        Z5zAyLWAkWEVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYPBsO/Zzyw7GrnfBhxgFOBiVeHh/
        XD8SLcSaWFZcmXuIUYKDWUmEV7byaLQQb0piZVVqUX58UWlOavEhRmkOFiVx3vMGlVFCAumJ
        JanZqakFqUUwWSYOTqkGRg4u9s2HjAx6/7He2XVijYrOeW+GHquL54OzOCanz2w4Pu1sJI9O
        64w9VXJ87pJ5v2c0/nJNKlTWV9yyRc4vju1g88Z/ziceLWdKvxYqUvjm3XovWfHNFpudmR8+
        SWRJu1d47eght/KiFO+U03PVGP6wzlE5HZgwhfebMH/yRrWvio+8OPu2K7EUZyQaajEXFScC
        AOsjSTkaAgAA
X-CMS-MailID: 20181016072248eucas1p18943ce87e084797cd597afd4edb65a65
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016072248eucas1p18943ce87e084797cd597afd4edb65a65
References: <CGME20181016072248eucas1p18943ce87e084797cd597afd4edb65a65@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Rafael,

This patchset proposes probe helper function which should simplify little bit
resource acquisition error handling, it also extend it with adding defer probe
reason to devices_deferred property:

# cat /sys/kernel/debug/devices_deferred
exynos-hdmi 13970000.hdmi: cannot find out bridge
arizona-extcon
tm2-audio sound: Unable to get codec_dai_name

The last patch was generated by cocci script to show the gain for the most
obvious probe_err usage scenarios. Of course there are many more places where it
could be used.
If the 1st patch will be accepted I can split 3rd one per subsystems if neccessary.

Regards
Andrzej


Andrzej Hajda (3):
  driver core: add probe_err log helper
  driver core: add deferring probe reason to devices_deferred property
  drivers: use probe_err function in obvious cases

 drivers/ata/libahci_platform.c                |  7 +-
 drivers/base/base.h                           |  3 +
 drivers/base/core.c                           | 40 +++++++++++
 drivers/base/dd.c                             | 34 +++++++++-
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
 include/linux/device.h                        |  2 +
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
 159 files changed, 658 insertions(+), 1031 deletions(-)

-- 
2.18.0

