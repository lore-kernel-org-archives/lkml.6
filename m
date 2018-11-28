Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869FFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A0320832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A0320832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeK1UBo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:01:44 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.25]:55049 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeK1UBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:01:44 -0500
Received: from [89.1.81.74] (helo=karo-electronics.de)
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <LW@KARO-electronics.de>)
        id 1gRvi5-0007YK-Mk; Wed, 28 Nov 2018 10:00:41 +0100
Date:   Wed, 28 Nov 2018 10:00:40 +0100
From:   Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 2/4] rtc: add i.MX system controller RTC support
Message-ID: <20181128100040.4072d8e4@karo-electronics.de>
In-Reply-To: <1543382119-2918-3-git-send-email-Anson.Huang@nxp.com>
References: <1543382119-2918-1-git-send-email-Anson.Huang@nxp.com>
        <1543382119-2918-3-git-send-email-Anson.Huang@nxp.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 28 Nov 2018 05:21:11 +0000 Anson Huang wrote:
> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
> inside, the system controller is in charge of controlling power,
> clock and secure rtc etc..
> 
> This patch adds i.MX system controller RTC driver support,
> Linux kernel has to communicate with system controller via MU
> (message unit) IPC to set/get RTC time and other alarm functions,
> since the RTC set time needs to be done in secure EL3 mode (required
> by system controller firmware) and alarm functions needs to be done
> with general MU IRQ handle, these depend on other components which
> are NOT ready, so this patch ONLY enables the RTC time read.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> changes since V1:
> 	- sort module in Makefile alphabetically;
> 	- remove boiler plate license text;
> 	- use devm_rtc_allocate_device and rtc_register_device to register the RTC.
>  drivers/rtc/Kconfig      |   6 +++
>  drivers/rtc/Makefile     |   1 +
>  drivers/rtc/rtc-imx-sc.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 114 insertions(+)
>  create mode 100644 drivers/rtc/rtc-imx-sc.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index a819ef0..3b9642e 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1677,6 +1677,12 @@ config RTC_DRV_SNVS
>  	   This driver can also be built as a module, if so, the module
>  	   will be called "rtc-snvs".
>  
> +config RTC_DRV_IMX_SC
> +	tristate "NXP i.MX System Controller RTC support"
> +	help
> +	   If you say yes here you get support for the NXP i.MX System
> +	   Controller RTC module.
> +
>  config RTC_DRV_SIRFSOC
>  	tristate "SiRFSOC RTC"
>  	depends on ARCH_SIRF
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 290c173..f97c05e 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -75,6 +75,7 @@ obj-$(CONFIG_RTC_DRV_GOLDFISH)	+= rtc-goldfish.o
>  obj-$(CONFIG_RTC_DRV_HID_SENSOR_TIME) += rtc-hid-sensor-time.o
>  obj-$(CONFIG_RTC_DRV_HYM8563)	+= rtc-hym8563.o
>  obj-$(CONFIG_RTC_DRV_IMXDI)	+= rtc-imxdi.o
> +obj-$(CONFIG_RTC_DRV_IMX_SC)	+= rtc-imx-sc.o
>  obj-$(CONFIG_RTC_DRV_ISL12022)	+= rtc-isl12022.o
>  obj-$(CONFIG_RTC_DRV_ISL12026)	+= rtc-isl12026.o
>  obj-$(CONFIG_RTC_DRV_ISL1208)	+= rtc-isl1208.o
> diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c
> new file mode 100644
> index 0000000..7212e38
> --- /dev/null
> +++ b/drivers/rtc/rtc-imx-sc.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018 NXP.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/firmware/imx/sci.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/rtc.h>
> +
> +#define IMX_SC_TIMER_FUNC_GET_RTC_SEC1970	9
> +#define IMX_SC_TIMER_FUNC_SET_RTC_TIME		6
> +
> +struct imx_sc_ipc *rtc_ipc_handle;
> +struct rtc_device *rtc;
> +
Shouldn't these be static?
A generic name like 'rtc' as a global variable name is definitely a very
bad idea.

> +struct imx_sc_msg_req_timer_get_rtc_time {
> +	struct imx_sc_rpc_msg hdr;
> +} __packed;
> +
> +struct imx_sc_msg_resp_timer_get_rtc_time {
> +	struct imx_sc_rpc_msg hdr;
> +	u32 time;
> +} __packed;
> +
> +static int imx_sc_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct imx_sc_msg_resp_timer_get_rtc_time *resp;
> +	struct imx_sc_msg_req_timer_get_rtc_time msg;
> +	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +	int ret;
> +
> +	hdr->ver = IMX_SC_RPC_VERSION;
> +	hdr->svc = IMX_SC_RPC_SVC_TIMER;
> +	hdr->func = IMX_SC_TIMER_FUNC_GET_RTC_SEC1970;
> +	hdr->size = 1;
> +
> +	ret = imx_scu_call_rpc(rtc_ipc_handle, &msg, true);
> +	if (ret) {
> +		pr_err("read rtc time failed, ret %d\n", ret);
> +		return ret;
> +	}
> +
> +	resp = (struct imx_sc_msg_resp_timer_get_rtc_time *)&msg;
> +	rtc_time_to_tm(resp->time, tm);
> +
> +	return 0;
> +}
> +
> +static const struct rtc_class_ops imx_sc_rtc_ops = {
> +	.read_time = imx_sc_rtc_read_time,
> +};
> +
> +static int imx_sc_rtc_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = imx_scu_get_handle(&rtc_ipc_handle);
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +
> +		dev_err(&pdev->dev, "failed to get ipc handle: %d!\n", ret);
> +		return ret;
> +	}
> +
> +	rtc = devm_rtc_allocate_device(&pdev->dev);
> +	if (IS_ERR(rtc)) {
> +		ret = PTR_ERR(rtc);
> +		return ret;
> +	}
> +
> +	rtc->ops = &imx_sc_rtc_ops;
> +	rtc->range_min = 0;
> +	rtc->range_max = U32_MAX;
> +
> +	ret = rtc_register_device(rtc);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register rtc: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id imx_sc_dt_ids[] = {
> +	{ .compatible = "nxp,imx8qxp-sc-rtc", },
> +	{},
s/{},/{}/
The trailing comma is usually added to make patches that add more
entries to the array simpler and help avoid patch conflicts.
Since the empty entry MUST be the LAST entry in this array the comma
should NOT be added here. Without the comma, adding new entries after
the EOL marker will generate a compile error.


Lothar Waßmann
