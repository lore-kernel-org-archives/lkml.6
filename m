Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750816AbeEaXE5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 19:04:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:14001 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbeEaXEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 19:04:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,464,1520924400";
   d="scan'208";a="53852731"
Message-ID: <1527807882.10176.11.camel@linux.intel.com>
Subject: Re: [PATCH V2] platform/x86: intel_pmc_core: Add CNP SLPS0 debug
 registers
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@infradead.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>, kyle.d.pelton@linux.intel.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 31 May 2018 16:04:42 -0700
In-Reply-To: <CAHp75VfgAS4mDbtnVSMCJcadra=mPEsSQ5jt153r-Fks6vis7A@mail.gmail.com>
References: <CAHp75VfLqvjVPwhcsK4enhsvXSLggX9_pO9AozZT56DWDrkjPg@mail.gmail.com>
         <20180525011056.25132-1-david.e.box@linux.intel.com>
         <CAHp75VfgAS4mDbtnVSMCJcadra=mPEsSQ5jt153r-Fks6vis7A@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.3 (3.26.3-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-31 at 21:38 +0300, Andy Shevchenko wrote:
> On Fri, May 25, 2018 at 4:10 AM, David E. Box
> <david.e.box@linux.intel.com> wrote:
> > Adds debugfs access to registers in the Cannon Point PCH PMC that
> > are
> > useful for debugging #SLP_S0 signal assertion and other low power
> > related
> > activities. Device pm states are latched in these registers
> > whenever the
> > package enters C10 and can be read from slp_s0_debug_status. The pm
> > states may also be latched by writing 1 to slp_s0_dbg_latch which
> > will
> > immediately capture the current state on the next read of
> > slp_s0_debug_status. Also while in intel_pmc_core.h clean up
> > spacing.
> > 
> 
> Thanks for an update. My comments below.
> 
> As far as I understand there is still ongoing discussion about the
> approach when and how to show data. So I'll wait a bit for a
> settlement between you, guys.
> 
> > +static void pmc_core_slps0_dbg_latch(struct pmc_dev *pmcdev, bool
> > reset)
> > +{
> > +       const struct pmc_reg_map *map = pmcdev->map;
> > +       u32 fd;
> > +
> > +       mutex_lock(&pmcdev->lock);
> > +
> > +       if (!reset && !slps0_dbg_latch)
> > +               goto out_unlock;
> > +
> > +       fd = pmc_core_reg_read(pmcdev, map->slps0_dbg_offset);
> > +       reset ? (fd &= ~CNP_PMC_LATCH_SLPS0_EVENTS) :
> > +               (fd |= CNP_PMC_LATCH_SLPS0_EVENTS);
> 
> I would rather use classical pattern here, i.e.
> 
> if (reset)
>  fd ...
> else
>  fd ...
> 
> > +       pmc_core_reg_write(pmcdev, map->slps0_dbg_offset, fd);
> > +
> > +       slps0_dbg_latch = 0;
> > +
> > +out_unlock:
> > +       mutex_unlock(&pmcdev->lock);
> > +}
> > +       struct pmc_dev *pmcdev = s ? s->private : &pmc;
> 
> I'm not sure why do we need such condition.
> 
> Simple
> 
> ... pmcdev = s->private;
> 
> is enough.
> 
> >  /* Cannonlake Power Management Controller register offsets */
> > -#define CNP_PMC_SLP_S0_RES_COUNTER_OFFSET      0x193C
> > -#define CNP_PMC_LTR_IGNORE_OFFSET              0x1B0C
> > -#define CNP_PMC_PM_CFG_OFFSET                  0x1818
> > +#define CNP_PMC_SLP_S0_RES_COUNTER_OFFSET      0x193C
> > +#define CNP_PMC_LTR_IGNORE_OFFSET              0x1B0C
> > +#define CNP_PMC_PM_CFG_OFFSET                  0x1818
> 
> I have hard time to understand what is the difference here.
> Either do another clean up patch (white spaces vs. tabs?) or leave it
> untouched.
> 
> >  /* Cannonlake: PGD PFET Enable Ack Status Register(s) start */
> > -#define CNP_PMC_HOST_PPFEAR0A                  0x1D90
> > +#define CNP_PMC_HOST_PPFEAR0A                  0x1D90
> > 
> > -#define CNP_PMC_MMIO_REG_LEN                   0x2000
> > -#define CNP_PPFEAR_NUM_ENTRIES                 8
> > -#define CNP_PMC_READ_DISABLE_BIT               22
> > +#define CNP_PMC_MMIO_REG_LEN                   0x2000
> > +#define CNP_PPFEAR_NUM_ENTRIES                 8
> > +#define CNP_PMC_READ_DISABLE_BIT               22
> 
> Ditto.
> 
> > +struct slps0_dbg_map {
> > +       const struct pmc_bit_map *slps0_dbg_sts;
> > +       int size;
> > +};
> 
> Didn't pay attention to this earlier. Why do we have a separate size
> member? What does it define?

It holds the size of the pmc_bit_map array, assigned as shown here:

+static const struct slps0_dbg_map cnp_slps0_dbg_maps[] = {
+ {cnp_slps0_dbg0_map, ARRAY_SIZE(cnp_slps0_dbg0_map)},
+ {cnp_slps0_dbg1_map, ARRAY_SIZE(cnp_slps0_dbg1_map)},
+ {cnp_slps0_dbg2_map, ARRAY_SIZE(cnp_slps0_dbg2_map)},
+};


Okay on all other comments

Dave
