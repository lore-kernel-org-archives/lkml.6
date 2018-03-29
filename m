Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeC2Obf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:31:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35258 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeC2Obd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:31:33 -0400
X-Google-Smtp-Source: AIpwx48uOJa22KhVw+beagbynLj7Z6DxdbiVWghrE882eecBN6Ea9FEqTwribRadeoXLzZ186XLLdA==
Date: Thu, 29 Mar 2018 15:31:29 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: thierry.reding@gmail.com, alexandre.torgue@st.com,
        benjamin.gaignard@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, mcoquelin.stm32@gmail.com,
        benjamin.gaignard@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [RESEND PATCH v2 4/8] mfd: stm32-timers: add support for dmas
Message-ID: <20180329143129.xdvw6gujghkwbjtm@dell>
References: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
 <1518602679-3064-5-git-send-email-fabrice.gasnier@st.com>
 <20180328152251.xeh72dpeflzohn4k@dell>
 <106ff518-4973-5d4a-b5bf-dd58cbd8439a@st.com>
 <20180329125912.jgasmw75qvtlszgx@dell>
 <12d53b2e-eec4-a498-1e1f-c217161c5086@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12d53b2e-eec4-a498-1e1f-c217161c5086@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2018, Fabrice Gasnier wrote:

> On 03/29/2018 02:59 PM, Lee Jones wrote:
> > On Wed, 28 Mar 2018, Fabrice Gasnier wrote:
> > 
> >> On 03/28/2018 05:22 PM, Lee Jones wrote:
> >>> On Wed, 14 Feb 2018, Fabrice Gasnier wrote:
> >>>
> >>>> STM32 Timers can support up to 7 DMA requests:
> >>>> - 4 channels, update, compare and trigger.
> >>>> Optionally request part, or all DMAs from stm32-timers MFD core.
> >>>>
> >>>> Also add routine to implement burst reads using DMA from timer registers.
> >>>> This is exported. So, it can be used by child drivers, PWM capture
> >>>> for instance (but not limited to).
> >>>>
> >>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> >>>> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> >>>> ---
> >>>> Changes in v2:
> >>>> - Abstract DMA handling from child driver: move it to MFD core
> >>>> - Add comments on optional dma support
> >>>> ---
> >>>>  drivers/mfd/stm32-timers.c       | 215 ++++++++++++++++++++++++++++++++++++++-
> >>>>  include/linux/mfd/stm32-timers.h |  27 +++++
> >>>>  2 files changed, 238 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
> >>>> index a6675a4..2cdad2c 100644
> >>>> --- a/drivers/mfd/stm32-timers.c
> >>>> +++ b/drivers/mfd/stm32-timers.c
> > 
> > [...]
> > 
> >>>> +	struct dma_chan *dmas[STM32_TIMERS_MAX_DMAS];
> >>>> +	struct stm32_timers ddata;
> >>>
> >>> This looks odd to me.  Why can't you expand the current ddata
> >>> structure?  Wouldn't it be better to create a stm32_timers_dma
> >>> structure to place all this information in (except *dev, that should
> >>> live in the ddata struct), then place a reference in the existing
> >>> stm32_timers struct?
> >>
> >> Maybe I miss-understand you here, from what we discussed in V1:
> >> https://lkml.org/lkml/2018/1/23/574
> >>> ... "passing in the physical address of the parent MFD into
> >>> a child device doesn't quite sit right with me"
> >> I introduced this private struct in MFD parent, and completely hide it
> >> from the child.
> >>
> >> So, do you suggest to add struct definition here ? But make it part of
> >> struct stm32_timers *ddata?
> >>
> >> And only put declaration in include/linux/mfd/stm32-timers.h:
> >> + struct stm32_timers_dma;
> >>
> >> struct stm32_timers {
> >> 	struct clk *clk;
> >> 	struct regmap *regmap;
> >> 	u32 max_arr;
> >> +	struct stm32_timers_dma;
> >> };
> > 
> > Yes, that's the basic idea.
> > 
> >> I can probably spare the *dev then... use dev->parent in child driver.
> > 
> > What would you use dev->parent for?
> 
> Hi Lee,
> 
> This is to follow your sugestion to use *dev instead of *ddata when
> calling stm32_timers_dma_burst_read(), the idea is to use it on child side:
> stm32_timers_dma_burst_read(dev->parent,...) from pwm driver.
> Then there is no need to keep *dev inside ddata struct.

I'm wondering if it would be neater to us the child's *dev, then do
the ->parent deference in the parent MFD (with a comment to say what
you're doing of course).

> > [...]
> > 
> >>>> +static int stm32_timers_remove(struct platform_device *pdev)
> >>>> +{
> >>>> +	struct stm32_timers *ddata = platform_get_drvdata(pdev);
> >>>> +	struct stm32_timers_priv *priv = to_stm32_timers_priv(ddata);
> >>>> +
> >>>> +	of_platform_depopulate(&pdev->dev);
> >>>
> >>> Why can't you continue using devm_*?
> >>
> >> I can use devm_of_platform_depopulate() here if you prefer, and keep
> >> devm_of_platform_populate() in probe.
> > 
> > The point of devm_* is that you don't have to call depopulate.
> > 
> > It happens automatically once this driver is unbound.
> 
> Ok, so to clarify, keeping devm_ here may be a bit racy:
> of_platform_depopulate will happen after dma has been released (there is
> no devm_ variant to release dma).
> Only way to prevent race condition here, is to enforce
> of_platform_depopulate() is called before dma release (e.g. in reverse
> order compared to probe).
> 
> Do you wish I add a comment about it ?

Best thing to do then is keep the non-devm variant and provide a
comment as to why is it not possible to use devm_*.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
