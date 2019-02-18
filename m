Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D01C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F19721738
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbfBRV5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:57:54 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55667 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfBRV5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 16:57:54 -0500
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B23A020003;
        Mon, 18 Feb 2019 21:57:48 +0000 (UTC)
Date:   Mon, 18 Feb 2019 22:57:48 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 4/4] rtc: imx-sc: add rtc alarm support
Message-ID: <20190218215748.GC10129@piout.net>
References: <1550115535-14488-1-git-send-email-Anson.Huang@nxp.com>
 <1550115535-14488-5-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550115535-14488-5-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/02/2019 03:44:48+0000, Anson Huang wrote:
> Add i.MX system controller RTC alarm support, the RTC alarm
> is implemented via SIP(silicon provider) runtime service call
> and ARM-Trusted-Firmware will communicate with system controller
> via MU(message unit) IPC to set RTC alarm. When RTC alarm fires,
> system controller will generate a common MU irq event and notify
> system controller RTC driver to handle the irq event.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No V1 patch, just add it into the i.MX SC general irq support patch series,
> to support system controller RTC's alarm function and also to provide an
> example of how to use general MU irq, this patch depends on the i.MX SC
> general irq support patch set, so add it into same patch series.

Through which tree do you expect this patch to be merged?

> --
>  drivers/rtc/rtc-imx-sc.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c
> index 60570a2..147545e 100644
> --- a/drivers/rtc/rtc-imx-sc.c
> +++ b/drivers/rtc/rtc-imx-sc.c
> @@ -3,6 +3,7 @@
>   * Copyright 2018 NXP.
>   */
>  
> +#include <dt-bindings/firmware/imx/rsrc.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/firmware/imx/sci.h>
>  #include <linux/module.h>
> @@ -11,11 +12,17 @@
>  #include <linux/rtc.h>
>  
>  #define IMX_SC_TIMER_FUNC_GET_RTC_SEC1970	9
> +#define IMX_SC_TIMER_FUNC_SET_RTC_ALARM		8
>  #define IMX_SC_TIMER_FUNC_SET_RTC_TIME		6
>  
> +#define IMX_SC_IRQ_FUNC_ENABLE			1
> +
>  #define IMX_SIP_SRTC			0xC2000002
>  #define IMX_SIP_SRTC_SET_TIME		0x0
>  
> +#define SC_IRQ_GROUP_RTC    2
> +#define SC_IRQ_RTC          1
> +
>  static struct imx_sc_ipc *rtc_ipc_handle;
>  static struct rtc_device *imx_sc_rtc;
>  
> @@ -24,6 +31,24 @@ struct imx_sc_msg_timer_get_rtc_time {
>  	u32 time;
>  } __packed;
>  
> +struct imx_sc_msg_timer_enable_irq {
> +	struct imx_sc_rpc_msg hdr;
> +	u32 mask;
> +	u16 resource;
> +	u8 group;
> +	u8 enable;
> +} __packed;
> +
> +struct imx_sc_msg_timer_rtc_set_alarm {
> +	struct imx_sc_rpc_msg hdr;
> +	u16 year;
> +	u8 mon;
> +	u8 day;
> +	u8 hour;
> +	u8 min;
> +	u8 sec;
> +} __packed;
> +
>  static int imx_sc_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct imx_sc_msg_timer_get_rtc_time msg;
> @@ -60,9 +85,80 @@ static int imx_sc_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	return res.a0;
>  }
>  
> +static int imx_sc_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
> +{
> +	struct imx_sc_msg_timer_enable_irq msg;
> +	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +	int ret;
> +
> +	hdr->ver = IMX_SC_RPC_VERSION;
> +	hdr->svc = IMX_SC_RPC_SVC_IRQ;
> +	hdr->func = IMX_SC_IRQ_FUNC_ENABLE;
> +	hdr->size = 3;
> +
> +	msg.resource = IMX_SC_R_MU_1A;
> +	msg.group = SC_IRQ_GROUP_RTC;
> +	msg.mask = SC_IRQ_RTC;
> +	msg.enable = enable;
> +
> +	ret = imx_scu_call_rpc(rtc_ipc_handle, &msg, true);
> +	if (ret) {
> +		dev_err(dev, "enable rtc irq failed, ret %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx_sc_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct imx_sc_msg_timer_rtc_set_alarm msg;
> +	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +	int ret;
> +	struct rtc_time *alrm_tm = &alrm->time;
> +
> +	hdr->ver = IMX_SC_RPC_VERSION;
> +	hdr->svc = IMX_SC_RPC_SVC_TIMER;
> +	hdr->func = IMX_SC_TIMER_FUNC_SET_RTC_ALARM;
> +	hdr->size = 3;
> +
> +	msg.year = alrm_tm->tm_year + 1900;
> +	msg.mon = alrm_tm->tm_mon + 1;
> +	msg.day = alrm_tm->tm_mday;
> +	msg.hour = alrm_tm->tm_hour;
> +	msg.min = alrm_tm->tm_min;
> +	msg.sec = alrm_tm->tm_sec;
> +
> +	ret = imx_scu_call_rpc(rtc_ipc_handle, &msg, true);
> +	if (ret) {
> +		dev_err(dev, "set rtc alarm failed, ret %d\n", ret);
> +		return ret;
> +	}
> +

You must check whether the alarm needs to be enabled here and enable the
alarm else the userspace application that are using RTC_WKALM_SET will
not work properly.

> +	return 0;
> +}
> +
>  static const struct rtc_class_ops imx_sc_rtc_ops = {
>  	.read_time = imx_sc_rtc_read_time,
>  	.set_time = imx_sc_rtc_set_time,
> +	.set_alarm = imx_sc_rtc_set_alarm,
> +	.alarm_irq_enable = imx_sc_rtc_alarm_irq_enable,
> +};
> +
> +static int imx_sc_rtc_alarm_sc_notify(struct notifier_block *nb,
> +					unsigned long event, void *group)
> +{
> +	/* ignore non-rtc irq */
> +	if (!((event & SC_IRQ_RTC) && (*(u8 *)group == SC_IRQ_GROUP_RTC)))
> +		return 0;
> +
> +	rtc_update_irq(imx_sc_rtc, 1, RTC_IRQF | RTC_AF);
> +
> +	return 0;
> +}
> +
> +static struct notifier_block imx_sc_rtc_alarm_sc_notifier = {
> +	.notifier_call = imx_sc_rtc_alarm_sc_notify,
>  };
>  
>  static int imx_sc_rtc_probe(struct platform_device *pdev)
> @@ -73,6 +169,8 @@ static int imx_sc_rtc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	device_init_wakeup(&pdev->dev, true);
> +
>  	imx_sc_rtc = devm_rtc_allocate_device(&pdev->dev);
>  	if (IS_ERR(imx_sc_rtc))
>  		return PTR_ERR(imx_sc_rtc);
> @@ -87,6 +185,8 @@ static int imx_sc_rtc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	imx_scu_register_notifier(&imx_sc_rtc_alarm_sc_notifier);
> +
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
