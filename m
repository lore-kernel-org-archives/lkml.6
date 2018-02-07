Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbeBGXWI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 18:22:08 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36414 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeBGXWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 18:22:06 -0500
X-Google-Smtp-Source: AH8x225LBbNNtoxWL6/a2EOBK3FQH+WDiNbcmpArbJ03bgJn6FmIkR/CYvEUzjhmgYdYzYd9/zUJdQ==
Date: Wed, 7 Feb 2018 15:22:02 -0800
From: Brian Norris <briannorris@chromium.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Derek Basehore <dbasehore@chromium.org>, linux-kernel@vger.kernel.org,
        Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, tglx@linutronix.de
Subject: Re: [PATCH v5 4/4] irqchip/gic-v3-its: add ability to resend MAPC on
 resume
Message-ID: <20180207232201.GB106856@ban.mtv.corp.google.com>
References: <20180207014117.62611-1-dbasehore@chromium.org>
 <20180207014117.62611-5-dbasehore@chromium.org>
 <8276f426-e4a0-c400-9f87-31be3d6b1733@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8276f426-e4a0-c400-9f87-31be3d6b1733@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

I'm really not an expert on this, so take my observations with a large
grain of salt:

On Wed, Feb 07, 2018 at 08:46:42AM +0000, Marc Zyngier wrote:
> On 07/02/18 01:41, Derek Basehore wrote:
> > This adds functionality to resend the MAPC command to an ITS node on
> > resume. If the ITS is powered down during suspend and the collections
> > are not backed by memory, the ITS will lose that state. This just sets
> > up the known state for the collections after the ITS is restored.
> > 
> > This is enabled via the reset-on-suspend flag in the DTS for an ITS
> > that has a non-zero number of collections stored in it.
> > 
> > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > ---
> >  drivers/irqchip/irq-gic-v3-its.c   | 80 ++++++++++++++++++++------------------
> >  include/linux/irqchip/arm-gic-v3.h |  1 +
> >  2 files changed, 43 insertions(+), 38 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> > index 5e63635e2a7b..dd6cd6e68ed0 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -1942,52 +1942,53 @@ static void its_cpu_init_lpis(void)
> >  	dsb(sy);
> >  }
> >  
> > -static void its_cpu_init_collection(void)
> > +static void its_cpu_init_collection(struct its_node *its)

...

> > @@ -3127,6 +3128,9 @@ static void its_restore_enable(void)
> >  			its_write_baser(its, baser, baser->val);
> >  		}
> >  		writel_relaxed(its->ctlr_save, base + GITS_CTLR);
> > +
> > +		if (GITS_TYPER_HWCOLLCNT(gic_read_typer(base + GITS_TYPER)) > 0)
> > +			its_cpu_init_collection(its);
> 
> This isn't correct. Think of a system where half the collections are in
> HW, and the other half memory based (nothing in the spec forbids this).
> You must evaluate the CID of each collection and replay the MAPC *only*
> if it falls into the range [0..HCC-1]. The memory-based collections are
> already mapped, and remapping an already mapped collection requires
> extra care (see MAPC and the UNPREDICTABLE behaviour when V=1), so don't
> go there.

IIUC, this is only run on CPU0 (it's in syscore resume), so implicitly,
CID is 0. Thus, the current condition is already doing what you ask:

	HCC > 0 == CID

which is equivalent to:

	HCC - 1 >= CID

Or should we really double check what CPU we're running on?

Brian
