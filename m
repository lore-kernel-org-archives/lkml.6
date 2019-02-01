Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C91C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4991C20844
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ih5zGZdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbfBAUNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:13:41 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37016 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfBAUNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:13:40 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so3759674plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 12:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1qOUolOgTb/bHqymZTYspz+owow5eKZf/u7lGBdDG6Q=;
        b=Ih5zGZdjve4Q80NylsdskXmo9pT9GJuUMx1xBs6jkuR+2IIoaqPN5z1AbBtLTWhznu
         AAZHpIH/XkttjxKCvuQVYJGBvCh5cElHbK14PZeCl9N6STTSO1P/Nnf/JITmSagOzCkZ
         OYDBiy+hoJ5wZaub44ce/EPyL/03KNHLa8G+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1qOUolOgTb/bHqymZTYspz+owow5eKZf/u7lGBdDG6Q=;
        b=VPbezftqegkw5dQiVOrwdsylHdSI7a1piNrIO/RnwV7qtAj/59NLFAjKDT9yUBtB52
         0gocHoZydVtXfGTfvCme0yOvaH2q3zemHkZyK5Eq368E3CCDh1EdBonhrGTF+YjNohqo
         mlTP5NqJkdeFE4sGFDmvg3ygfzzVYWM/jkNbGKa96I2pBSKUbuA9AK+i0utl5wfFCF80
         g+k9ag9PTUbWsKkJxQSFs4x99CdtM94zmvr4VO6Gvy/7XeNF2xEWJz6L8dSj4kvAkJYd
         EnLvCF7LND7O9EpWN/ioyC4QCnzqEWFkuqda6zU8BnPw7lBQBfBrjP4UtWByp4S+i3XN
         /h0Q==
X-Gm-Message-State: AJcUukeN/N2KUQVzuNEE4S2SNc9kwGXSfZj07Ww0L0lY/K1mZ5cbr6ti
        lhLBv6t4anvarBsbZvyxfg5zYT5jjls=
X-Google-Smtp-Source: ALg8bN4bbiCoT+YoviT1OyH9wNLPV4VT17FzLLcBkARpmv8zjI/WlwdUSPqKX5rpY4O+tXbrSdG9+A==
X-Received: by 2002:a17:902:1105:: with SMTP id d5mr39629545pla.47.1549052019940;
        Fri, 01 Feb 2019 12:13:39 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id b5sm17439413pfc.150.2019.02.01.12.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 12:13:39 -0800 (PST)
Date:   Fri, 1 Feb 2019 12:13:38 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        fan.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] devfreq: add mediatek cci devfreq
Message-ID: <20190201201338.GS81583@google.com>
References: <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1548743704-16821-4-git-send-email-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1548743704-16821-4-git-send-email-andrew-sh.cheng@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, Jan 29, 2019 at 02:35:04PM +0800, Andrew-sh Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>

the 'From' tag is only needed when you send patches not authored by
yourself. It doesn't do any harm either, but you can drop it in future
submissions.

> For big/little cpu cluster architecture,
> not only CPU frequency, but CCI frequency will also affect performance.

This doesn't provide much information, I suggest to drop it unless
others find it valuable.

> Little cores and cci share the same buck in Mediatek mt8183 IC,
> so we add a CCI devfreq which will get notification when buck voltage
> is changed, then CCI devfreq can set cci frequency as high as
> possible.

Possible alternative:

"This adds a devfreq driver for the Cache Coherent Interconnect (CCI)
of the Mediatek MT8183.

On the MT8183 the CCI is supplied by the same regulator as the LITTLE
cores. The driver is notified when the regulator voltage changes
(driven by cpufreq) and adjusts the CCI frequency to the maximum
possible value."

Feel free to ignore or to adjust.

> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/devfreq/Kconfig              |   9 ++
>  drivers/devfreq/Makefile             |   1 +
>  drivers/devfreq/mt8183-cci-devfreq.c | 224 +++++++++++++++++++++++++++++++++++
>  3 files changed, 234 insertions(+)
>  create mode 100644 drivers/devfreq/mt8183-cci-devfreq.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 6a172d3..0b14aab 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -113,6 +113,15 @@ config ARM_RK3399_DMC_DEVFREQ
>            It sets the frequency for the memory controller and reads the usage counts
>            from hardware.
>  
> +config ARM_MT8183_CCI_DEVFREQ
> +	tristate "MT8183 CCI DEVFREQ Driver"
> +	depends on ARM_MEDIATEK_CPUFREQ
> +	help
> +		This adds devfreq for cci clock

"This adds a devfreq driver for the Cache Coherent Interconnect (CCI)
of the Mediatek MT8183"?

> +		which is shared the same regulator with cpu cluster.
> +		It can track buck voltage and update a proper cci frequency.
> +		Use notification to get regulator status.

not sure how important this info is here, sounds more like an
implementation detail to me.

> +
>  source "drivers/devfreq/event/Kconfig"
>  
>  endif # PM_DEVFREQ
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 32b8d4d..25afe8c 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
> +obj-$(CONFIG_ARM_MT8183_CCI_DEVFREQ)	+= mt8183-cci-devfreq.o
>  
>  # DEVFREQ Event Drivers
>  obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
> diff --git a/drivers/devfreq/mt8183-cci-devfreq.c b/drivers/devfreq/mt8183-cci-devfreq.c
> new file mode 100644
> index 0000000..4837892
> --- /dev/null
> +++ b/drivers/devfreq/mt8183-cci-devfreq.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2018 MediaTek Inc.

2019 :)

> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>
> +#include <linux/devfreq.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include "governor.h"
> +
> +struct cci_devfreq_data {

nit: consider dropping the '_data' suffix, it doesn't add much/any
value.

> +	struct devfreq		*devfreq;
> +	struct regulator	*proc_reg;
> +	struct clk		*cci_clk;
> +	unsigned long		buck_volt;

proc_reg_uV?

place after proc_reg

> +	int			volt_increasing;

should be bool

actually, is it really needed? See comment in cci_devfreq_regulator_notifier()

> +	struct notifier_block	nb;
> +};
> +
> +static int mtk_cci_governor_get_target(struct devfreq *devfreq,
> +				       unsigned long *freq)
> +{
> +	struct cci_devfreq_data *cci_devdata;

nit: consider calling it 'cci_df' (here and elsewhere). In the context
the abbreviation is clear and there is less clutter when accessing
fields in the structure.

> +	int	i, opp_count;
> +	struct dev_pm_opp	*opp;
> +	unsigned long	opp_rate, opp_voltage;
> +
> +	cci_devdata = dev_get_drvdata(devfreq->dev.parent);
> +
> +	/* find available frequency */
> +	opp_count = dev_pm_opp_get_opp_count(devfreq->dev.parent);
> +	for (i = 0, opp_rate = ULONG_MAX; i < opp_count; i++, opp_rate--) {
> +		opp = dev_pm_opp_find_freq_floor(devfreq->dev.parent,
> +						 &opp_rate);
> +		opp_voltage = dev_pm_opp_get_voltage(opp);
> +		dev_pm_opp_put(opp);
> +
> +		if (opp_voltage <= cci_devdata->buck_volt)
> +			break;
> +	}
> +	*freq = opp_rate;
> +
> +	return 0;
> +}
> +
> +static int mtk_cci_governor_event_handler(struct devfreq *devfreq,
> +					  unsigned int event, void *data)
> +{
> +	return 0;
> +}
> +
> +static struct devfreq_governor mtk_cci_devfreq_governor = {
> +	.name = "voltage_monitor",

"mtk_cci_vmon" or similar?

> +	.get_target_freq = mtk_cci_governor_get_target,
> +	.event_handler = mtk_cci_governor_event_handler,
> +};
> +
> +static int mtk_cci_devfreq_target(struct device *dev, unsigned long *freq,
> +				  u32 flags)
> +{
> +	struct cci_devfreq_data *cci_devdata;
> +
> +	cci_devdata = dev_get_drvdata(dev);
> +
> +	clk_set_rate(cci_devdata->cci_clk, *freq);
> +
> +	return 0;
> +}
> +
> +static struct devfreq_dev_profile cci_devfreq_profile = {
> +	.polling_ms	= 0,
> +	.target		= mtk_cci_devfreq_target,
> +};
> +
> +static int cci_devfreq_regulator_notifier(struct notifier_block *nb,
> +					  unsigned long val, void *data)
> +{
> +	struct cci_devfreq_data *cci_devdata =
> +		container_of(nb, struct cci_devfreq_data, nb);
> +
> +	/* deal with reduce frequency */
> +	if (val & REGULATOR_EVENT_PRE_VOLTAGE_CHANGE) {
> +		struct pre_voltage_change_data *pvc_data = data;
> +
> +		if (pvc_data->old_uV > pvc_data->min_uV) {

I would suggest to invert the condition. For humans it is easier to
parse "is the new voltage smaller than the previous one", than
viceversa.

> +			cci_devdata->volt_increasing = 0;
> +			cci_devdata->buck_volt =
> +				(unsigned long)(pvc_data->min_uV);
> +			mutex_lock(&cci_devdata->devfreq->lock);
> +			update_devfreq(cci_devdata->devfreq);
> +			mutex_unlock(&cci_devdata->devfreq->lock);
> +		} else {
> +			cci_devdata->volt_increasing = 1;
> +		}
> +	}

nit: add empty line

> +	/* deal with abort reduce frequency */

Shouldn't this be "abort voltage change?". If so I suggest to drop the
comment, REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE in the condition makes
it clear.

> +	if ((val & REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE) ||
> +	    /* deal with increase frequency */
> +	    ((val & REGULATOR_EVENT_VOLTAGE_CHANGE) &&
> +	     cci_devdata->volt_increasing == 1)) {

to check for a voltage increase you could use 'cci_devdata->buck_volt
< (unsigned long)data' instead of ->volt_increasing.

> +		cci_devdata->buck_volt = (unsigned long)data;
> +		mutex_lock(&cci_devdata->devfreq->lock);
> +		update_devfreq(cci_devdata->devfreq);
> +		mutex_unlock(&cci_devdata->devfreq->lock);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_cci_devfreq_probe(struct platform_device *pdev)
> +{
> +	struct device *cci_dev = &pdev->dev;
> +	struct cci_devfreq_data *cci_devdata;
> +	struct notifier_block *nb;
> +	int ret;
> +
> +	dev_pm_opp_of_add_table(&pdev->dev);
> +
> +	cci_devdata = devm_kzalloc(cci_dev, sizeof(*cci_devdata), GFP_KERNEL);
> +	if (!cci_devdata)
> +		return -ENOMEM;
> +	nb = &cci_devdata->nb;
> +	cci_devdata->cci_clk = ERR_PTR(-ENODEV);

initialization not needed, the field is assigned a few lines below.

> +	cci_devdata->proc_reg = ERR_PTR(-ENODEV);

also not really needed with the right gotos in place

> +
> +	cci_devdata->cci_clk = clk_get(cci_dev, "cci_clock");
> +	ret = PTR_ERR_OR_ZERO(cci_devdata->cci_clk);
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
> +			pr_err("cci clock not ready, retry\n");
> +		else
> +			pr_err("no clock for cci: %d\n", ret);
> +
> +		goto out_free_resources;

nothing to be freed here, just return ret.

> +	}
> +
> +	cci_devdata->proc_reg = regulator_get_optional(cci_dev, "proc");
> +	ret = PTR_ERR_OR_ZERO(cci_devdata->proc_reg);
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
> +			pr_err("cci regulator not ready, retry\n");
> +		else
> +			pr_err("no regulator for cci: %d\n", ret);
> +
> +		goto out_free_resources;
> +	}
> +
> +	platform_set_drvdata(pdev, cci_devdata);
> +
> +	/* create cci_devfreq and add to cci device.
> +	 * governor is voltage_monitor.
> +	 * governor will get platform_device data to make decision.
> +	 */
> +	cci_devdata->devfreq = devm_devfreq_add_device(cci_dev,
> +						       &cci_devfreq_profile,
> +						       "voltage_monitor",

adjust name in case you follow my suggestion above.

check cci_devdata->devfreq for errors.

> +						       NULL);
> +
> +	nb->notifier_call = cci_devfreq_regulator_notifier;
> +	regulator_register_notifier(cci_devdata->proc_reg,
> +				    nb);
> +
> +	return 0;
> +
> +out_free_resources:
> +	if (!IS_ERR(cci_devdata->cci_clk))
> +		clk_put(cci_devdata->cci_clk);
> +	if (!IS_ERR(cci_devdata->proc_reg))
> +		regulator_put(cci_devdata->proc_reg);

use individual labels and get rid of the IS_ERRs.

e.g.

err_put_reg:
	regulator_put(cci_devdata->proc_reg);

err_put_clk:
	clk_put(cci_devdata->cci_clk);


and jump to the corresponding lable above.

> +
> +	return ret;
> +}
> +
> +static const struct of_device_id mediatek_cci_devfreq_of_match[] = {
> +	{ .compatible = "mediatek,mt8183-cci" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, mediatek_cci_devfreq_of_match);
> +
> +static struct platform_driver cci_devfreq_driver = {
> +	.probe	= mtk_cci_devfreq_probe,
> +	.driver = {
> +		.name = "mediatek-cci-devfreq",
> +		.of_match_table = mediatek_cci_devfreq_of_match,
> +	},
> +};
> +
> +static int __init mtk_cci_devfreq_init(void)
> +{
> +	int ret = 0;

initialization not needed

> +
> +	ret = devfreq_add_governor(&mtk_cci_devfreq_governor);
> +	if (ret) {
> +		pr_err("%s: failed to add governor: %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	ret = platform_driver_register(&cci_devfreq_driver);
> +	if (ret)
> +		devfreq_remove_governor(&mtk_cci_devfreq_governor);
> +
> +	return ret;
> +}
> +module_init(mtk_cci_devfreq_init)
> +
> +static void __exit mtk_cci_devfreq_exit(void)
> +{
> +	int ret = 0;

initialization not needed

> +	platform_driver_unregister(&cci_devfreq_driver);
> +
> +	ret = devfreq_remove_governor(&mtk_cci_devfreq_governor);
> +	if (ret)
> +		pr_err("%s: failed to remove governor: %d\n", __func__, ret);

typically you reverse the order of initialization, i.e. remove the
governor, then unregister the driver.

> +}
> +module_exit(mtk_cci_devfreq_exit)
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Mediatek CCI devfreq driver");
> +MODULE_AUTHOR("andrew-sh.cheng");

should be either "Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>" or
"Andrew-sh.Cheng"

Cheers

Matthias
