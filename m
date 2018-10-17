Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74923ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C4721529
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FGJzp7Wi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C4721529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJQXtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:49:39 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:12657 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeJQXti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:49:38 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181017155316epoutp04693ad395b8bebbd83875c5104f6a21ad~ecExz-ou81081110811epoutp04J;
        Wed, 17 Oct 2018 15:53:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181017155316epoutp04693ad395b8bebbd83875c5104f6a21ad~ecExz-ou81081110811epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539791596;
        bh=1oWBRBtDvyVpe9jhkhwu+IptWKCNLtmNwUKxkG3IkfQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=FGJzp7Wig2VITlV1mNtKAr8IfNLnfWb8HFR7WyiykDOjaEvi+RKkRB+9JbygfizRu
         VhZ4FRabg0mPQ/iRSdfOuLSDuZFminn4YHdf/dQeR6fHg0nO2J7RGX+2ySGbFV4V+A
         gGy4PtfyPzZ1o2v3nan767qlUZ+NLdGREVoDAXKA=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20181017155315epcas2p20b1d92095021e9b9febd722567c2f91a~ecExC4hUj2467024670epcas2p2P;
        Wed, 17 Oct 2018 15:53:15 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        00.51.04072.BEA57CB5; Thu, 18 Oct 2018 00:53:15 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20181017155314epcas2p4a5aa24978b36354a2ccb2f9b0fb6f0f6~ecEv04ibc0750407504epcas2p4v;
        Wed, 17 Oct 2018 15:53:14 +0000 (GMT)
X-AuditID: b6c32a47-5b7ff70000000fe8-fa-5bc75aeb44b1
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id AE.34.03633.9EA57CB5; Thu, 18 Oct
        2018 00:53:14 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PGR00KZM2SD3M00@mmp2.samsung.com>; Thu, 18 Oct 2018
        00:53:13 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Amit kucheria <amit.kucheria@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH v2 00/17] thermal: enable+check sensor after its setup is
 finished
Date:   Wed, 17 Oct 2018 17:52:26 +0200
Message-id: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTYRTHe7a7u6t08zJFH11YDgyUfLd8yBSlwAtJlPahnJIjL2rNKZuK
        sxJTS7MUS2niO86wpqGO6Uw0YuaWYZZpyzQtX9MUlUZIQljbtW+//zk/zjkPPARXsI25Eamy
        TEYuk0hFuD3WM+h13GctziT2H15yQoX5ag7qqu7goWWLCaBnZUMYapww89DLW+MA7c6v8dAb
        fQEHFdU0Y6hlcY6PxvvqcGQpewVQ3cY0Hy3OleNoReeCtE8mcfS7rwFDA7MWECGgCzaNOF3z
        9S1OP6+Z4dPdU8dodf8qh9Zq7uL0F3M/TpcVbuB0uU4DaL25gUu/Vm1jtGlSz6EtWvdzZJz9
        ySRGmprNyP3CE+1T6jVV3IztwJzSiQpePpjzLAUEAalguHDPoRTYEwKqF8DPTdU8NmwDONu2
        9C/Y2aSV4T6cbXQCuPRRxWHDDoCtTy02C6dOwAfFGmAd60Sdgbp2wlrmUkMYXLB4WdmRugA/
        vdPbdIzyhN9Wl/lWJqkouPWiDbDL3OGwsXJv8S4ON+q5LJ+GowO1e+wIf5h0fJaFcFnTBaz3
        QEoF4PrOY4wNHQC2jxg5rBUKB01jPPaiA7Bk8A+ffT8JS+4IWIWGRZW3bbqASoDFzT/xCgCb
        wD4NcGYyFGnJjCIwI8hXIUlTZMmSfa+kp2mB7Tt4R/WCntFoA6AIINpP9jobxQKeJFuhTDMA
        SHBFTmSuh0ksIJMkylxGnn5ZniVlFAYgJDCRCzknrBcLqGRJJnONYTIY+f8uh7Bzywd+/kHn
        S5SqTiKxEfve9/BwdHTe0fkP6nh1QohyTBp2NvRSiOuRIo+qQaa4XLrerbpobgkRhpcqm09F
        xt/0uX9Ihod1uRz8lcnHdbV5foWukRZdhPvWtDwmxbyZY6B0U+pY4/Wri/qAisSEGAcO+b51
        JngtdqQcH1Df8I4lH4kwRYokwJsrV0j+AjBVqdQKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsVy+t9jQd1XUcejDc5MZ7JobljMZLFxxnpW
        i2efjzNarO09ymIx/8o1VosDjZcZLf4/es1qcWp7E5NFy6xFLBZLnjxkt7i8aw6bxefeI4wW
        c97dZrd48rCPzeLFFnGLTStusFn83DWPxWLvvc+MDkIeTe+PsXnMun+WzWPnrLvsHltvmXos
        3vOSyWPTqk42jzvX9rB59Da/Y/Po27KK0WP7tXnMHiemf2fxOH5jO5PH501yAbxRXDYpqTmZ
        ZalF+nYJXBlzV01hLvhuVNF1ZQJrA+ND1S5GTg4JAROJFyd3sXUxcnEICaxjlPj5aRsLhPOL
        UWLr+02sIFVsAlYSE9tXMXYxcnCICHhLbFnDAVLDLHCURWLtjG9sIDXCAiES189vB6tnEVCV
        ePDyGTuIzSvgLvFh32pGiG1yEiePTWadwMi1gJFhFaNkakFxbnpusVGBUV5quV5xYm5xaV66
        XnJ+7iZGYEBvO6zVv4Px8ZL4Q4wCHIxKPLw7xI5FC7EmlhVX5h5ilOBgVhLhrVI8Hi3Em5JY
        WZValB9fVJqTWnyIUZqDRUmclz//WKSQQHpiSWp2ampBahFMlomDU6qBcdWspwskzlieNuZ9
        px63nukxs82GxU0eFrtU/WPrN+41n/Rye8n+5f/ZDulVbm09aHKia+5xAS6LiFX5XFEKX8Mk
        1qa8eHq40crU6fy9fOOE56yF26ZG9CxY0qN09LX98j/TiuYdrN63/GEMb9gV98vNAbv0lLY6
        m3Hc02w8+f7afdsnZf0M5UosxRmJhlrMRcWJAN74qI1kAgAA
X-CMS-MailID: 20181017155314epcas2p4a5aa24978b36354a2ccb2f9b0fb6f0f6
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20181017155314epcas2p4a5aa24978b36354a2ccb2f9b0fb6f0f6
References: <CGME20181017155314epcas2p4a5aa24978b36354a2ccb2f9b0fb6f0f6@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[devm]_thermal_zone_of_sensor_register() is used to register
thermal sensor by thermal drivers using DeviceTree. Besides
registering sensor this function also immediately:

- enables it:

  tzd->ops->set_mode(tzd, THERMAL_DEVICE_ENABLED)
  (->set_mode is set to of_thermal_set_mode() in of-thermal.c)

- checks it (indirectly by using of_thermal_set_mode()):

  thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
  (which in turn ends up using ->get_temp method).

For many DT thermal drivers this causes a problem because:

- [devm]_thermal_zone_of_sensor_register() need to be called in
  order to obtain data about thermal trips which are then used to
  finish hardware sensor setup (only after which ->get_temp can
  be used)

There is also related issue for DT thermal drivers that support
IRQ (i.e. exynos and rockchip ones):

- sensor hardware should be enabled only after IRQ handler is
  requested (because otherwise we might get IRQs that we can't
  handle)

- IRQ handler needs tzd structure which is obtained from
  [devm_]thermal_zone_of_sensor_register()

- after [devm_]thermal_zone_of_sensor_register() call core
  thermal code assumes that sensor is enabled and ready to use
  (i.e. that IRQ handler has been requested and sensor hardware
  has been enabled)

In order to fix all abovementioned issues sensor registration,
enable and check operations are separated in the core DT thermal
code and corresponding DT thermal drivers are modified to do sensor
setup correctly.

Changes since v1:
- rebased on the current -next kernel (next-20181015)
- enhanced patch descriptions and cover letter
- renamed thermal_zone_device_toggler() to thermal_zone_set_mode()
- converted thermal_zone_set_mode() to use enum thermal_device_mode
- added CONFIG_THERMAL=n stubs for thermal_zone_set_mode() and
  thermal_zone_device_check()
- fixed uses of [devm]_thermal_zone_of_sensor_register() outside of
  drivers/thermal/
- changed ordering between patch #2 and #3 in order to add all
  needed core helpers first before fixing sensor setup code
- changed ordering between patch #3 and #4 in order to simplify them
- renamed patch #3 to "thermal: separate sensor enable and check
  operations"
- renamed patch #4 to "thermal: separate sensor registration and
  enable+check operations"

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (17):
  thermal: add thermal_zone_set_mode() helper
  thermal: add thermal_zone_device_check() helper
  thermal: separate sensor enable and check operations
  thermal: separate sensor registration and enable+check operations
  thermal: bcm2835: enable+check sensor after its setup is finished
  thermal: brcmstb: enable+check sensor after its setup is finished
  thermal: hisi_thermal: enable+check sensor after its setup is finished
  thermal: qcom: tsens: enable+check sensor after its setup is finished
  thermal: qoriq: enable+check sensor after its setup is finished
  thermal: rcar_gen3_thermal: enable+check sensor after its setup is
    finished
  thermal: rockchip_thermal: enable+check sensor after its setup is
    finished
  thermal: exynos: enable+check sensor after its setup is finished
  thermal: tegra: enable+check sensor after its setup is finished
  thermal: ti-soc-thermal: enable+check sensor after its setup is
    finished
  thermal: uniphier: enable+check sensor after its setup is finished
  thermal: zx2967: enable+check sensor after its setup is finished
  thermal: warn on attempts to read temperature on disabled sensors

 drivers/acpi/thermal.c                             |  5 +--
 drivers/ata/ahci_imx.c                             | 10 ++++--
 drivers/hwmon/hwmon.c                              |  5 +++
 drivers/hwmon/ntc_thermistor.c                     |  4 +++
 drivers/hwmon/scpi-hwmon.c                         |  4 +++
 drivers/iio/adc/sun4i-gpadc-iio.c                  |  5 +++
 drivers/input/touchscreen/sun4i-ts.c               |  8 ++++-
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  1 -
 drivers/platform/x86/acerhdf.c                     |  6 +++-
 drivers/regulator/max8973-regulator.c              |  6 ++--
 drivers/thermal/armada_thermal.c                   |  3 ++
 drivers/thermal/broadcom/bcm2835_thermal.c         |  3 ++
 drivers/thermal/broadcom/brcmstb_thermal.c         |  3 ++
 drivers/thermal/broadcom/ns-thermal.c              |  3 ++
 drivers/thermal/da9062-thermal.c                   |  7 ++--
 drivers/thermal/db8500_thermal.c                   |  5 ++-
 drivers/thermal/hisi_thermal.c                     | 22 ++++---------
 drivers/thermal/imx_thermal.c                      |  3 +-
 drivers/thermal/int340x_thermal/int3400_thermal.c  |  1 +
 drivers/thermal/intel_bxt_pmic_thermal.c           |  3 +-
 drivers/thermal/intel_soc_dts_iosf.c               |  3 +-
 drivers/thermal/max77620_thermal.c                 |  6 ++--
 drivers/thermal/mtk_thermal.c                      |  3 ++
 drivers/thermal/of-thermal.c                       |  6 ++--
 drivers/thermal/qcom-spmi-temp-alarm.c             |  5 ++-
 drivers/thermal/qcom/tsens.c                       |  6 ++++
 drivers/thermal/qoriq_thermal.c                    |  3 ++
 drivers/thermal/rcar_gen3_thermal.c                |  7 ++--
 drivers/thermal/rcar_thermal.c                     |  7 ++--
 drivers/thermal/rockchip_thermal.c                 | 38 +++++++++++-----------
 drivers/thermal/samsung/exynos_tmu.c               |  7 +++-
 drivers/thermal/st/st_thermal_memmap.c             |  3 +-
 drivers/thermal/tango_thermal.c                    |  5 +++
 drivers/thermal/tegra/soctherm.c                   |  3 ++
 drivers/thermal/tegra/tegra-bpmp-thermal.c         |  3 ++
 drivers/thermal/thermal-generic-adc.c              |  3 ++
 drivers/thermal/thermal_core.c                     | 14 ++++----
 drivers/thermal/thermal_helpers.c                  | 32 ++++++++++++++++++
 drivers/thermal/thermal_sysfs.c                    | 17 ++++++----
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  7 +++-
 drivers/thermal/uniphier_thermal.c                 |  6 +++-
 drivers/thermal/x86_pkg_temp_thermal.c             |  2 +-
 drivers/thermal/zx2967_thermal.c                   |  3 ++
 include/linux/thermal.h                            | 11 +++++++
 44 files changed, 220 insertions(+), 87 deletions(-)

-- 
1.9.1

