Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6651C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 02:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9E72145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 02:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KAdb8w4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9E72145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeIXH7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 03:59:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44713 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIXH7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 03:59:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so18023341wro.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 18:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2fb16bJRDT9bVyPt9hGm+c+ZGVY2Lu+AiVBgX8EX/aU=;
        b=KAdb8w4TYZmQ0mXK04I+RK0OKCKe3jWe3Eo+y4t6wwwBNYWXuWcFB+xrdo6aoEIVLt
         yIrOhcPtZsLJ0L/sCIaj6CgNOyEF7wssTCc3BYCXawGbNY2/sQZ37P6H/AnY9CPRfvDA
         NdTVvna8HZh4JkNwmp7eC75V0u70nwJb65Yv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2fb16bJRDT9bVyPt9hGm+c+ZGVY2Lu+AiVBgX8EX/aU=;
        b=FioDFkWTbkrnr0utdccZHfPtFKOPb8/k+6ALODZl3h8YUxKLnDW+FMr5IEP6Rtzc63
         PtX2sTA+vc1pzYkQNsIFDUd/uvAp8myiEfLwEBuHWaEsVeKmG7f+exKGaFs449qnUy2g
         C/qG4NHO19d6QsGhjLmptbCzCKyoNhi79kFN4pIAkIxm1OWjP0QEKpjCWNZk6MGJ9Iy2
         wwEtVMBdoU6pg9Dgx3lCGb0EWlVEJ3PwtDYudEcCavVksS9ttsLb4UF1jpHDlQE146do
         SpMjIlg2zQgOKoeu0Ab0GOxVgRa8gpikXtazyxDfk6kur4KnsnWa36x6bBe2Hj8C19Mt
         LPqA==
X-Gm-Message-State: ABuFfoiTwrANi3idC+oId9rtBjTmZ65jICLnjM1NOGB8MbseqvTidx36
        qobdfWfqBj8Sk9tFf98BggOvMgf+GfY=
X-Google-Smtp-Source: ACcGV63itCnVc8GE725h304DKeV6XGZoQjlJEBJOG1vlXpAxOJtdPa90I/5FzG/J/r87aW95faP49g==
X-Received: by 2002:adf:8425:: with SMTP id 34-v6mr3377372wrf.153.1537754397496;
        Sun, 23 Sep 2018 18:59:57 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id l10-v6sm2614494wrp.40.2018.09.23.18.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 18:59:56 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v7 2/7] clocksource/drivers: Add a new driver for the Atmel
 ARM TC blocks
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180913113024.3571-1-alexandre.belloni@bootlin.com>
 <20180913113024.3571-3-alexandre.belloni@bootlin.com>
Message-ID: <3ff4d71d-6a63-58ca-bdfd-79b9867fa477@linaro.org>
Date:   Mon, 24 Sep 2018 03:59:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180913113024.3571-3-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2018 13:30, Alexandre Belloni wrote:
> Add a driver for the Atmel Timer Counter Blocks. This driver provides a
> clocksource and two clockevent devices.
> 
> One of the clockevent device is linked to the clocksource counter and so it
> will run at the same frequency. This will be used when there is only on TCB
> channel available for timers.
> 
> The other clockevent device runs on a separate TCB channel when available.
> 
> This driver uses regmap and syscon to be able to probe early in the boot
> and avoid having to switch on the TCB clocksource later. 

Sorry, I don't get it. Can you elaborate?

> Using regmap also
> means that unused TCB channels may be used by other drivers (PWM for
> example). read/writel are still used to access channel specific registers
> to avoid the performance impact of regmap (mainly locking).

I don't get the regmap reasoning here.

My main concern with this driver is the 16bits chained support. See
below in the comments.


> Tested-by: Alexander Dahl <ada@thorsis.com>
> Tested-by: Andras Szemzo <szemzo.andras@gmail.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/clocksource/Kconfig           |   8 +
>  drivers/clocksource/Makefile          |   3 +-
>  drivers/clocksource/timer-atmel-tcb.c | 410 ++++++++++++++++++++++++++
>  3 files changed, 420 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clocksource/timer-atmel-tcb.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index a11f4ba98b05..8c7324e409f6 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -403,6 +403,14 @@ config ATMEL_ST
>  	help
>  	  Support for the Atmel ST timer.
>  
> +config ATMEL_ARM_TCB_CLKSRC
> +	bool "Microchip ARM TC Block" if COMPILE_TEST
> +	select REGMAP_MMIO
> +	depends on GENERIC_CLOCKEVENTS
> +	help
> +	  This enables build of clocksource and clockevent driver for
> +	  the integrated Timer Counter Blocks in Microchip ARM SoCs.
> +
>  config CLKSRC_EXYNOS_MCT
>  	bool "Exynos multi core timer driver" if COMPILE_TEST
>  	depends on ARM || ARM64
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index db51b2427e8a..0df9384a1230 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -3,7 +3,8 @@ obj-$(CONFIG_TIMER_OF)		+= timer-of.o
>  obj-$(CONFIG_TIMER_PROBE)	+= timer-probe.o
>  obj-$(CONFIG_ATMEL_PIT)		+= timer-atmel-pit.o
>  obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
> -obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
> +obj-$(CONFIG_ATMEL_TCB_CLKSRC) += tcb_clksrc.o
> +obj-$(CONFIG_ATMEL_ARM_TCB_CLKSRC)	+= timer-atmel-tcb.o
>  obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
>  obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
>  obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+= cs5535-clockevt.o
> diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
> new file mode 100644
> index 000000000000..21fbe430f91b
> --- /dev/null
> +++ b/drivers/clocksource/timer-atmel-tcb.c
> @@ -0,0 +1,410 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/regmap.h>
> +#include <linux/sched_clock.h>
> +#include <soc/at91/atmel_tcb.h>
> +
> +struct atmel_tcb_clksrc {
> +	struct clocksource clksrc;
> +	struct clock_event_device clkevt;
> +	struct regmap *regmap;
> +	void __iomem *base;
> +	struct clk *clk[2];
> +	char name[20];

You can reasonably remove this field and use directly the ones in the
clocksrc/evt.

> +	int channels[2];
> +	int bits;
> +	int irq;

After removing the request_irq/free_irq calls below (see comment), this
field can be removed.

> +	struct {
> +		u32 cmr;
> +		u32 imr;
> +		u32 rc;
> +		bool clken;

Not sure clken is needed, 16/32 is enough information.

> +	} cache[2];
> +	u32 bmr_cache;

Are you sure you should save the bmr content ?

> +	bool registered;
> +	bool clk_enabled;

Not used.

> +};
> +
> +static struct atmel_tcb_clksrc tc;
> +
> +static struct clk *tcb_clk_get(struct device_node *node, int channel)
> +{
> +	struct clk *clk;
> +	char clk_name[] = "t0_clk";
> +
> +	clk_name[1] += channel;
> +	clk = of_clk_get_by_name(node->parent, clk_name);
> +	if (!IS_ERR(clk))
> +		return clk;
> +
> +	return of_clk_get_by_name(node->parent, "t0_clk");

Can you explain why returning "t0_clk" is better than returning an error?

> +}
> +
> +/*
> + * Clocksource and clockevent using the same channel(s)
> + */
> +static u64 tc_get_cycles(struct clocksource *cs)
> +{
> +	u32 lower, upper;
> +
> +	do {
> +		upper = readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[1]));
> +		lower = readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[0]));
> +	} while (upper != readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[1])));
> +
> +	return (upper << 16) | lower;
> +}
> +
> +static u64 tc_get_cycles32(struct clocksource *cs)
> +{
> +	return readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[0]));
> +}
> +
> +static u64 notrace tc_sched_clock_read(void)
> +{
> +	return tc_get_cycles(&tc.clksrc);
> +}
> +
> +static u64 notrace tc_sched_clock_read32(void)
> +{
> +	return tc_get_cycles32(&tc.clksrc);
> +}
> +
> +static int tcb_clkevt_next_event(unsigned long delta,
> +				 struct clock_event_device *d)
> +{
> +	u32 old, next, cur;
> +
> +	old = readl(tc.base + ATMEL_TC_CV(tc.channels[0]));
> +	next = old + delta;
> +	writel(next, tc.base + ATMEL_TC_RC(tc.channels[0]));
> +	cur = readl(tc.base + ATMEL_TC_CV(tc.channels[0]));
> +
> +	/* check whether the delta elapsed while setting the register */
> +	if ((next < old && cur < old && cur > next) ||
> +	    (next > old && (cur < old || cur > next))) {
> +		/*
> +		 * Clear the CPCS bit in the status register to avoid
> +		 * generating a spurious interrupt next time a valid
> +		 * timer event is configured.
> +		 */
> +		old = readl(tc.base + ATMEL_TC_SR(tc.channels[0]));
> +		return -ETIME;
> +	}
> > +	writel(ATMEL_TC_CPCS, tc.base + ATMEL_TC_IER(tc.channels[0]));


How this is compatible with 16bits as defined in the init function ?

> +	return 0;
> +}
> +
> +static irqreturn_t tc_clkevt_irq(int irq, void *handle)
> +{
> +	unsigned int sr;
> +
> +	sr = readl(tc.base + ATMEL_TC_SR(tc.channels[0]));
> +	if (sr & ATMEL_TC_CPCS) {
> +		tc.clkevt.event_handler(&tc.clkevt);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +static int tcb_clkevt_oneshot(struct clock_event_device *dev)
> +{
> +	if (clockevent_state_oneshot(dev))
> +		return 0;
> +
> +	/*
> +	 * Because both clockevent devices may share the same IRQ, we don't want
> +	 * the less likely one to stay requested
> +	 */
> +	return request_irq(tc.irq, tc_clkevt_irq, IRQF_TIMER | IRQF_SHARED,
> +			   tc.name, &tc);
> +}
> +
> +static int tcb_clkevt_shutdown(struct clock_event_device *dev)
> +{
> +	writel(0xff, tc.base + ATMEL_TC_IDR(tc.channels[0]));
> +	if (tc.bits == 16)
> +		writel(0xff, tc.base + ATMEL_TC_IDR(tc.channels[1]));
> +
> +	if (!clockevent_state_detached(dev))
> +		free_irq(tc.irq, &tc);

Why are you requesting and freeing the irq instead of using the
disable/enable register operations ?

> +	return 0;
> +}
> +
> +static void __init tcb_setup_dual_chan(struct atmel_tcb_clksrc *tc,
> +				       int mck_divisor_idx)
> +{
> +	/* first channel: waveform mode, input mclk/8, clock TIOA on overflow */
> +	writel(mck_divisor_idx			/* likely divide-by-8 */
> +	       | ATMEL_TC_CMR_WAVE
> +	       | ATMEL_TC_CMR_WAVESEL_UP	/* free-run */
> +	       | ATMEL_TC_CMR_ACPA(SET)		/* TIOA rises at 0 */
> +	       | ATMEL_TC_CMR_ACPC(CLEAR),	/* (duty cycle 50%) */
> +	       tc->base + ATMEL_TC_CMR(tc->channels[0]));
> +	writel(0x0000, tc->base + ATMEL_TC_RA(tc->channels[0]));
> +	writel(0x8000, tc->base + ATMEL_TC_RC(tc->channels[0]));
> +	writel(0xff, tc->base + ATMEL_TC_IDR(tc->channels[0]));	/* no irqs */
> +	writel(ATMEL_TC_CCR_CLKEN, tc->base + ATMEL_TC_CCR(tc->channels[0]));
> +
> +	/* second channel: waveform mode, input TIOA */
> +	writel(ATMEL_TC_CMR_XC(tc->channels[1])		/* input: TIOA */
> +	       | ATMEL_TC_CMR_WAVE
> +	       | ATMEL_TC_CMR_WAVESEL_UP,		/* free-run */
> +	       tc->base + ATMEL_TC_CMR(tc->channels[1]));
> +	writel(0xff, tc->base + ATMEL_TC_IDR(tc->channels[1]));	/* no irqs */
> +	writel(ATMEL_TC_CCR_CLKEN, tc->base + ATMEL_TC_CCR(tc->channels[1]));
> +
> +	/* chain both channel, we assume the previous channel */
> +	regmap_write(tc->regmap, ATMEL_TC_BMR,
> +		     ATMEL_TC_BMR_TCXC(1 + tc->channels[1], tc->channels[1]));
> +	/* then reset all the timers */
> +	regmap_write(tc->regmap, ATMEL_TC_BCR, ATMEL_TC_BCR_SYNC);
> +}
> +
> +static void __init tcb_setup_single_chan(struct atmel_tcb_clksrc *tc,
> +					 int mck_divisor_idx)
> +{
> +	/* channel 0:  waveform mode, input mclk/8 */
> +	writel(mck_divisor_idx			/* likely divide-by-8 */
> +	       | ATMEL_TC_CMR_WAVE
> +	       | ATMEL_TC_CMR_WAVESEL_UP,	/* free-run */
> +	       tc->base + ATMEL_TC_CMR(tc->channels[0]));
> +	writel(0xff, tc->base + ATMEL_TC_IDR(tc->channels[0]));	/* no irqs */
> +	writel(ATMEL_TC_CCR_CLKEN, tc->base + ATMEL_TC_CCR(tc->channels[0]));
> +
> +	/* then reset all the timers */
> +	regmap_write(tc->regmap, ATMEL_TC_BCR, ATMEL_TC_BCR_SYNC);
> +}
> +
> +static void tc_clksrc_suspend(struct clocksource *cs)
> +{
> +	int i;
> +
> +	for (i = 0; i < 1 + (tc.bits == 16); i++) {
> +		tc.cache[i].cmr = readl(tc.base + ATMEL_TC_CMR(tc.channels[i]));
> +		tc.cache[i].imr = readl(tc.base + ATMEL_TC_IMR(tc.channels[i]));
> +		tc.cache[i].rc = readl(tc.base + ATMEL_TC_RC(tc.channels[i]));
> +		tc.cache[i].clken = !!(readl(tc.base +
> +					     ATMEL_TC_SR(tc.channels[i])) &
> +				       ATMEL_TC_CLKSTA);
> +	}
> +
> +	if (tc.bits == 16)
> +		regmap_read(tc.regmap, ATMEL_TC_BMR, &tc.bmr_cache);
> +}
> +
> +static void tc_clksrc_resume(struct clocksource *cs)
> +{
> +	int i;
> +
> +	for (i = 0; i < 1 + (tc.bits == 16); i++) {
> +		/* Restore registers for the channel, RA and RB are not used  */
> +		writel(tc.cache[i].cmr, tc.base + ATMEL_TC_CMR(tc.channels[i]));
> +		writel(tc.cache[i].rc, tc.base + ATMEL_TC_RC(tc.channels[i]));
> +		writel(0, tc.base + ATMEL_TC_RA(tc.channels[i]));
> +		writel(0, tc.base + ATMEL_TC_RB(tc.channels[i]));
> +		/* Disable all the interrupts */
> +		writel(0xff, tc.base + ATMEL_TC_IDR(tc.channels[i]));
> +		/* Reenable interrupts that were enabled before suspending */
> +		writel(tc.cache[i].imr, tc.base + ATMEL_TC_IER(tc.channels[i]));
> +
> +		/* Start the clock if it was used */
> +		if (tc.cache[i].clken)
> +			writel(ATMEL_TC_CCR_CLKEN, tc.base +
> +			       ATMEL_TC_CCR(tc.channels[i]));
> +	}
> +
> +	/* in case of dual channel, chain channels */
> +	if (tc.bits == 16)
> +		regmap_write(tc.regmap, ATMEL_TC_BMR, tc.bmr_cache);
> +	/* Finally, trigger all the channels*/
> +	regmap_write(tc.regmap, ATMEL_TC_BCR, ATMEL_TC_BCR_SYNC);
> +}
> +
> +static int __init tcb_clksrc_register(struct device_node *node,
> +				      struct regmap *regmap, void __iomem *base,
> +				      int channel, int channel1, int irq,
> +				      int bits)
> +{
> +	u32 rate, divided_rate = 0;
> +	int best_divisor_idx = -1;
> +	int i, err = -1;
> +	u64 (*tc_sched_clock)(void);
> +
> +	tc.regmap = regmap;
> +	tc.base = base;
> +	tc.channels[0] = channel;
> +	tc.channels[1] = channel1;
> +	tc.irq = irq;
> +	tc.bits = bits;
> +
> +	tc.clk[0] = tcb_clk_get(node, tc.channels[0]);
> +	if (IS_ERR(tc.clk[0]))
> +		return PTR_ERR(tc.clk[0]);
> +	err = clk_prepare_enable(tc.clk[0]);
> +	if (err) {
> +		pr_debug("can't enable T0 clk\n");
> +		goto err_clk;
> +	}
> +
> +	/* How fast will we be counting?  Pick something over 5 MHz.  */
> +	rate = (u32)clk_get_rate(tc.clk[0]);
> +	for (i = 0; i < 5; i++) {
> +		unsigned int divisor = atmel_tc_divisors[i];
> +		unsigned int tmp;
> +
> +		if (!divisor)
> +			continue;

I suppose you meant here 'break' ? Use atmel_tc_divisors[] = { 2, 8, 32,
128 }; And then the ARRAY_SIZE macro.

> +		tmp = rate / divisor;
> +		pr_debug("TC: %u / %-3u [%d] --> %u\n", rate, divisor, i, tmp);
> +		if (best_divisor_idx > 0) {
> +			if (tmp < 5 * 1000 * 1000)
> +				continue;
> +		}
> +		divided_rate = tmp;
> +		best_divisor_idx = i;

What is a best divisor ? The highest one or the one closer to 5MHz ?

> +	}
> +
> +	if (tc.bits == 32) {
> +		tc.clksrc.read = tc_get_cycles32;
> +		tcb_setup_single_chan(&tc, best_divisor_idx);
> +		tc_sched_clock = tc_sched_clock_read32;
> +		snprintf(tc.name, sizeof(tc.name), "%s:%d",
> +			 kbasename(node->parent->full_name), tc.channels[0]);
> +	} else {
> +		tc.clk[1] = tcb_clk_get(node, tc.channels[1]);
> +		if (IS_ERR(tc.clk[1]))
> +			goto err_disable_t0;

This is very confusing. If the function tcb_clk_get() fails with this
channel, it will return "t0_clk" and will be used here ? Why ?

> +		err = clk_prepare_enable(tc.clk[1]);
> +		if (err) {
> +			pr_debug("can't enable T1 clk\n");
> +			goto err_clk1;
> +		}
> +		tc.clksrc.read = tc_get_cycles,
> +		tcb_setup_dual_chan(&tc, best_divisor_idx);
> +		tc_sched_clock = tc_sched_clock_read;
> +		snprintf(tc.name, sizeof(tc.name), "%s:%d,%d",
> +			 kbasename(node->parent->full_name), tc.channels[0],
> +			 tc.channels[1]);
> +	}
> +
> +	pr_debug("%s at %d.%03d MHz\n", tc.name,
> +		 divided_rate / 1000000,
> +		 ((divided_rate + 500000) % 1000000) / 1000);

Using two channels to emulate a 32bits timer has a significant cost,
especially in the sched_clock function which is part of the hot kernel
path. In addition it makes the code less maintainable and readable.

Why don't you just stick to a specific rate with the prescalar value and
reduce the rating of the timer ? (example in the stm32 timer,
stm32_timer_set_prescaler and init function).

It will be less precise (thus the lower rating) but will make the system
faster by preventing multiple register reads in the sched_clock.

Is it an acceptable trade-off ?

> +	tc.clksrc.name = tc.name;
> +	tc.clksrc.suspend = tc_clksrc_suspend;
> +	tc.clksrc.resume = tc_clksrc_resume;
> +	tc.clksrc.rating = 200;
> +	tc.clksrc.mask = CLOCKSOURCE_MASK(32);
> +	tc.clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
> +
> +	err = clocksource_register_hz(&tc.clksrc, divided_rate);
> +	if (err)
> +		goto err_disable_t1;
> +
> +	sched_clock_register(tc_sched_clock, 32, divided_rate);
> +
> +	tc.registered = true;
> +
> +	/* Set up and register clockevents */
> +	tc.clkevt.name = tc.name;
> +	tc.clkevt.cpumask = cpumask_of(0);
> +	tc.clkevt.set_next_event = tcb_clkevt_next_event;
> +	tc.clkevt.set_state_oneshot = tcb_clkevt_oneshot;
> +	tc.clkevt.set_state_shutdown = tcb_clkevt_shutdown;
> +	tc.clkevt.features = CLOCK_EVT_FEAT_ONESHOT;
> +	tc.clkevt.rating = 125;
> +
> +	clockevents_config_and_register(&tc.clkevt, divided_rate, 1,
> +					BIT(tc.bits) - 1);
> +
> +	return 0;
> +
> +err_disable_t1:
> +	if (tc.bits == 16)
> +		clk_disable_unprepare(tc.clk[1]);
> +
> +err_clk1:
> +	if (tc.bits == 16)
> +		clk_put(tc.clk[1]);
> +
> +err_disable_t0:
> +	clk_disable_unprepare(tc.clk[0]);
> +
> +err_clk:
> +	clk_put(tc.clk[0]);
> +
> +	pr_err("%s: unable to register clocksource/clockevent\n",
> +	       tc.clksrc.name);
> +
> +	return err;
> +}
> +
> +static int __init tcb_clksrc_init(struct device_node *node)
> +{
> +	const struct of_device_id *match;
> +	struct regmap *regmap;
> +	void __iomem *tcb_base;
> +	u32 channel;
> +	int irq, err, chan1 = -1;
> +	unsigned bits;
> +
> +	if (tc.registered)
> +		return -ENODEV;
> +
> +	/*
> +	 * The regmap has to be used to access registers that are shared
> +	 * between channels on the same TCB but we keep direct IO access for
> +	 * the counters to avoid the impact on performance
> +	 */
> +	regmap = syscon_node_to_regmap(node->parent);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	tcb_base = of_iomap(node->parent, 0);
> +	if (!tcb_base) {
> +		pr_err("%s +%d %s\n", __FILE__, __LINE__, __func__);

Remove those debug information and replace them by a proper error message.

> +		return -ENXIO;
> +	}
> +
> +	match = of_match_node(atmel_tcb_dt_ids, node->parent);
> +	bits = (uintptr_t)match->data;
> +
> +	err = of_property_read_u32_index(node, "reg", 0, &channel);
> +	if (err)
> +		return err;
> +
> +	irq = of_irq_get(node->parent, channel);
> +	if (irq < 0) {

if (irq <= 0) {

> +		irq = of_irq_get(node->parent, 0);

Why ?

> +		if (irq < 0)

if (irq <= 0) {

> +			return irq;
> +	}
> +
> +	if (bits == 16) {
> +		of_property_read_u32_index(node, "reg", 1, &chan1);
> +		if (chan1 == -1) {
> +			pr_err("%s: clocksource needs two channels\n",
> +			       node->parent->full_name);

Think about it. The code is giving up at this point in the boot process.
So of two things, you consider there is an alternate clocksource /
clockevent or the system hangs:

 - If there is an alternate clocksource why support 32bits by chaining
the channels with the cost it introduces instead of using the alternate
one ?

 - If there is no alternate clocksource why not support a 16bits less
precise timer and give up with the 32bits emulation and the complexity
it introduces in this driver ?

> +			return -EINVAL;
> +		}
> +	}
> +	return tcb_clksrc_register(node, regmap, tcb_base, channel, chan1, irq,
> +				   bits);
> +}
> +TIMER_OF_DECLARE(atmel_tcb_clksrc, "atmel,tcb-timer", tcb_clksrc_init);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

