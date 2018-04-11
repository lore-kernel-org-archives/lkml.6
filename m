Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbeDKP5V (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:57:21 -0400
Received: from smtprelay0007.hostedemail.com ([216.40.44.7]:44931 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752973AbeDKP5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:57:20 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 57,3.5,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:278:355:379:421:541:599:800:960:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2198:2199:2200:2393:2559:2562:2693:2731:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:4250:4321:4385:5007:6119:7576:7903:10004:10400:10848:11026:11232:11473:11658:11914:12438:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21433:21451:21627:21740:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: wave44_22cd2ca766257
X-Filterd-Recvd-Size: 2114
Message-ID: <2f5a6878bf17e9cfa78de3c5b2ae52c1e8995bb1.camel@perches.com>
Subject: Re: [PATCH] mfd: mc13xxx: Add mc34708 adc support
From: Joe Perches <joe@perches.com>
To: Lukasz Majewski <lukma@denx.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 11 Apr 2018 08:57:17 -0700
In-Reply-To: <20180411140929.30357-1-lukma@denx.de>
References: <20180411140929.30357-1-lukma@denx.de>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-11 at 16:09 +0200, Lukasz Majewski wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The mc34708 has an improved adc. The older variants will always convert
> a fixed order of channels. The mc34708 can do up to eight conversions
> in arbitrary channel order. Currently this extended feature is not
> supported. We only support touchscreen conversions now, which will
> be sampled in a data format compatible to the older chips in order
> to keep the API between the mfd and the touchscreen driver.
[]
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
[]
> +static int mc34708_adc_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
> +		unsigned int channel, u8 ato, bool atox,
> +		unsigned int *sample)
> +{
> +	int ret, i;
[]
> +	if (mc13xxx->adcflags & MC13XXX_ADC_WORKING) {
> +		ret = -EBUSY;
> +		goto out;
> +	}

This doesn't work.

> []
> +	mc13xxx_irq_free(mc13xxx, MC34708_IRQ_TSDONE, &adcdone_data);
> +
> +	if (!ret) {
> +		ret = -ETIMEDOUT;
> +		goto out;
> +	}
[]
> +out:
> +	ret = mc13xxx_reg_write(mc13xxx, MC13XXX_ADC0, old_adc0);

ret is reassigned here, so the ret = -<FOO>
uses above don't do what is expected.

> +
> +	mc13xxx->adcflags &= ~MC13XXX_ADC_WORKING;
> +	mc13xxx_unlock(mc13xxx);
> +
> +	return ret;
> +}
