Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeFBBr1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 21:47:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:49711 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbeFBBrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 21:47:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,467,1520924400";
   d="scan'208";a="61116749"
Message-ID: <1527904043.22001.49.camel@linux.intel.com>
Subject: Re: [PATCH V2] platform/x86: intel_pmc_core: Add CNP SLPS0 debug
 registers
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: andy@infradead.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, kyle.d.pelton@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 01 Jun 2018 18:47:23 -0700
In-Reply-To: <20180530113329.GA24455@raj-desk2.iind.intel.com>
References: <CAHp75VfLqvjVPwhcsK4enhsvXSLggX9_pO9AozZT56DWDrkjPg@mail.gmail.com>
         <20180525011056.25132-1-david.e.box@linux.intel.com>
         <20180528070032.GA6321@raj-desk2.iind.intel.com>
         <1527677592.5247.24.camel@linux.intel.com>
         <20180530113329.GA24455@raj-desk2.iind.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.3 (3.26.3-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-30 at 17:03 +0530, Rajneesh Bhardwaj wrote:
> On Wed, May 30, 2018 at 03:53:12AM -0700, David E. Box wrote:
> 
> Hi Dave,
> 
> > Hi Rajneesh,
> > 
> > On Mon, 2018-05-28 at 12:30 +0530, Rajneesh Bhardwaj wrote:
> > > On Thu, May 24, 2018 at 06:10:56PM -0700, David E. Box wrote:
> > > 
> > > Thanks for sending this, Dave. Few comments below.
> > > 
> > > > Adds debugfs access to registers in the Cannon Point PCH PMC
> > > > that
> > > > are
> > > 
> > > Please use Cannonlake PCH.
> > > 
> > > > useful for debugging #SLP_S0 signal assertion and other low
> > > > power
> > > > related
> > > 
> > > assertion failures and other low power debug.
> > > 
> > > > activities. Device pm states are latched in these registers
> > > > whenever the
> > > > package enters C10 and can be read from slp_s0_debug_status.
> > > > The pm
> > > > states may also be latched by writing 1 to slp_s0_dbg_latch
> > > > which
> > > > will
> > > > immediately capture the current state on the next read of
> > > > slp_s0_debug_status. Also while in intel_pmc_core.h clean up
> > > > spacing.
> > > > 
> > > 
> > > Initially, unless the latch bit is not set the debugfs file does
> > > not
> > > show
> > > any information as expected but once you write Y to latch file,
> > > the
> > > debugfs
> > > file continues to show blockers even though you write N back
> > > there or
> > > unload
> > > - reload the driver. Please fix this.
> > 
> > See comments below
> > 
> > > 
> > > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > > ---
> > > > 
> > > > V2:
> > > > 	Per Andy Shevchenko:
> > > > 	- Clear latch bit after use
> > > > 	- Pass pmc_dev as parameter
> > > > 	- Use DEFINE_SHOW_ATTRIBUTE macro
> > > > 
> > > >  drivers/platform/x86/intel_pmc_core.c | 112
> > > > ++++++++++++++++++++++++++++++++++
> > > >  drivers/platform/x86/intel_pmc_core.h |  27 +++++---
> > > >  2 files changed, 132 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/platform/x86/intel_pmc_core.c
> > > > b/drivers/platform/x86/intel_pmc_core.c
> > > > index 43bbe74..ed40999 100644
> > > > --- a/drivers/platform/x86/intel_pmc_core.c
> > > > +++ b/drivers/platform/x86/intel_pmc_core.c
> > > > @@ -196,9 +196,64 @@ static const struct pmc_bit_map
> > > > cnp_pfear_map[] = {
> > > >  	{}
> > > >  };
> > > >  
> > > > +static const struct pmc_bit_map cnp_slps0_dbg0_map[] = {
> > > > +	{"AUDIO_D3",		BIT(0)},
> > > > +	{"OTG_D3",		BIT(1)},
> > > > +	{"XHCI_D3",		BIT(2)},
> > > > +	{"LPIO_D3",		BIT(3)},
> > > > +	{"SDX_D3",		BIT(4)},
> > > > +	{"SATA_D3",		BIT(5)},
> > > > +	{"UFS0_D3",		BIT(6)},
> > > > +	{"UFS1_D3",		BIT(7)},
> > > > +	{"EMMC_D3",		BIT(8)},
> > > > +};
> > > > +
> > > > +static const struct pmc_bit_map cnp_slps0_dbg1_map[] = {
> > > > +	{"SDIO_PLL_OFF",	BIT(0)},
> > > > +	{"USB2_PLL_OFF",	BIT(1)},
> > > > +	{"AUDIO_PLL_OFF",	BIT(2)},
> > > > +	{"OC_PLL_OFF",		BIT(3)},
> > > 
> > > Please rename to ISCLK_OC as it is the preferred nomenclature for
> > > debug.
> > 
> > Okay
> > 
> > > 
> > > > +	{"MAIN_PLL_OFF",	BIT(4)},
> > > 
> > > Ditto, please use ISCLK_MAIN.
> > > 
> > > > +	{"XOSC_OFF",		BIT(5)},
> > > > +	{"LPC_CLKS_GATED",	BIT(6)},
> > > > +	{"PCIE_CLKREQS_IDLE",	BIT(7)},
> > > > +	{"AUDIO_ROSC_OFF",	BIT(8)},
> > > > +	{"HPET_XOSC_CLK_REQ",	BIT(9)},
> > > > +	{"PMC_ROSC_SLOW_CLK",	BIT(10)},
> > > > +	{"AON2_ROSC_GATED",	BIT(11)},
> > > > +	{"CLKACKS_DEASSERTED",	BIT(12)},
> > > > +};
> > > > +
> > > > +static const struct pmc_bit_map cnp_slps0_dbg2_map[] = {
> > > > +	{"MPHY_CORE_GATED",	BIT(0)},
> > > > +	{"CSME_GATED",		BIT(1)},
> > > > +	{"USB2_SUS_GATED",	BIT(2)},
> > > > +	{"DYN_FLEX_IO_IDLE",	BIT(3)},
> > > > +	{"GBE_NO_LINK",		BIT(4)},
> > > > +	{"THERM_SEN_DISABLED",	BIT(5)},
> > > > +	{"PCIE_LOW_POWER",	BIT(6)},
> > > > +	{"ISH_VNNAON_REQ_ACT",	BIT(7)},
> > > > +	{"ISH_VNN_REQ_ACT",	BIT(8)},
> > > > +	{"CNV_VNNAON_REQ_ACT",	BIT(9)},
> > > > +	{"CNV_VNN_REQ_ACT",	BIT(10)},
> > > > +	{"NPK_VNNON_REQ_ACT",	BIT(11)},
> > > > +	{"PMSYNC_STATE_IDLE",	BIT(12)},
> > > > +	{"ALST_GT_THRES",	BIT(13)},
> > > > +	{"PMC_ARC_PG_READY",	BIT(14)},
> > > > +};
> > > > +
> > > > +static const struct slps0_dbg_map cnp_slps0_dbg_maps[] = {
> > > > +	{cnp_slps0_dbg0_map, ARRAY_SIZE(cnp_slps0_dbg0_map)},
> > > > +	{cnp_slps0_dbg1_map, ARRAY_SIZE(cnp_slps0_dbg1_map)},
> > > > +	{cnp_slps0_dbg2_map, ARRAY_SIZE(cnp_slps0_dbg2_map)},
> > > > +};
> > > > +
> > > >  static const struct pmc_reg_map cnp_reg_map = {
> > > >  	.pfear_sts = cnp_pfear_map,
> > > >  	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
> > > > +	.slps0_dbg_maps = cnp_slps0_dbg_maps,
> > > > +	.slps0_dbg_offset = CNP_PMC_SLPS0_DBG_OFFSET,
> > > > +	.slps0_dbg_num = ARRAY_SIZE(cnp_slps0_dbg_maps),
> > > >  	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
> > > >  	.regmap_length = CNP_PMC_MMIO_REG_LEN,
> > > >  	.ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
> > > > @@ -252,6 +307,8 @@ static int
> > > > pmc_core_check_read_lock_bit(void)
> > > >  }
> > > >  
> > > >  #if IS_ENABLED(CONFIG_DEBUG_FS)
> > > > +static bool slps0_dbg_latch;
> > > > +
> > > >  static void pmc_core_display_map(struct seq_file *s, int
> > > > index,
> > > >  				 u8 pf_reg, const struct
> > > > pmc_bit_map *pf_map)
> > > >  {
> > > > @@ -481,6 +538,52 @@ static const struct file_operations
> > > > pmc_core_ltr_ignore_ops = {
> > > >  	.release        = single_release,
> > > >  };
> > > >  
> > > > +static void pmc_core_slps0_dbg_latch(struct pmc_dev *pmcdev,
> > > > bool
> > > > reset)
> > > > +{
> > > > +	const struct pmc_reg_map *map = pmcdev->map;
> > > > +	u32 fd;
> > > > +
> > > > +	mutex_lock(&pmcdev->lock);
> > > > +
> > > > +	if (!reset && !slps0_dbg_latch)
> > > > +		goto out_unlock;
> > > > +
> > > > +	fd = pmc_core_reg_read(pmcdev, map->slps0_dbg_offset);
> > > > +	reset ? (fd &= ~CNP_PMC_LATCH_SLPS0_EVENTS) :
> > > > +		(fd |= CNP_PMC_LATCH_SLPS0_EVENTS);
> > > > +	pmc_core_reg_write(pmcdev, map->slps0_dbg_offset, fd);
> > > > +
> > > > +	slps0_dbg_latch = 0;
> > > > +
> > > > +out_unlock:
> > > > +	mutex_unlock(&pmcdev->lock);
> > > > +}
> > > > +
> > > > +static int pmc_core_slps0_dbg_show(struct seq_file *s, void
> > > > *unused)
> > > > +{
> > > > +	struct pmc_dev *pmcdev = s ? s->private : &pmc;
> > > > +	const struct slps0_dbg_map *maps = pmcdev->map-
> > > > > slps0_dbg_maps;
> > > > 
> > > > +	int num_slps0_dbg_regs = pmcdev->map->slps0_dbg_num;
> > > > +	int i, offset;
> > > > +	u32 data;
> > > > +
> > > > +	pmc_core_slps0_dbg_latch(pmcdev, false);
> > > > +	offset = pmcdev->map->slps0_dbg_offset;
> > > > +	while (num_slps0_dbg_regs--) {
> > > > +		data = pmc_core_reg_read(pmcdev, offset);
> > > > +		offset += 4;
> > > > +		for (i = 0; i < maps->size; i++)
> > > > +			seq_printf(s, "SLP_S0_DBG: %-
> > > > 32s\tState:
> > > > %s\n",
> > > > +				   maps-
> > > > >slps0_dbg_sts[i].name,
> > > > +				   data & maps-
> > > > > slps0_dbg_sts[i].bit_mask ?
> > > > 
> > > > +				   "Yes" : "No");
> > > 
> > > In current form, it looks pretty similar to
> > > pch_ip_power_gating_status
> > > output. Since it helps in debug, please use Blocks_slp_s0:
> > > instead of
> > > State: 
> > > 
> > 
> > That may not be true. What blocks or doesn't can be configured by
> > the
> > OEM.
> 
> IIUC, The IPs exposed by these registers are the ones that the PMC
> always looks at
> before making a decision to assert SLP_S0#. I dont think they can be
> changed
> by OEMs in determining the S0ix flows.

I confirmed with the architect that the logic operates independently of
other BIOS settings OEMs can make to ignore these same IPs. Reporting
an IP as blocking on a system where the IP is being ignored would be
confusing. The reported state the IP is in remains correct and that is
what this shows.

> 
> > 
> > > > +		maps++;
> > > > +	}
> > > > +	pmc_core_slps0_dbg_latch(pmcdev, true);
> > > > +	return 0;
> > > > +}
> > > > +DEFINE_SHOW_ATTRIBUTE(pmc_core_slps0_dbg);
> > > 
> > > When the latch bit is not set, can we format the output of this
> > > attribute
> > > stating clearly whether the current blockers are "live" or the
> > > "last
> > > captured at PC10 entry" ?
> > 
> > There is no "live". It's always the last captured state which is
> > why
> > the status doesn't update the way you expect above. With V2 the
> > latch
> > is automatically reset after every read.
> > 
> > When the latch isn't set, any updates would indeed be from PC10
> > transitions, but you can't be sure this isn't the last forced latch
> > state unless you monitor PC10 residency and assume that the values
> > were
> > updated when the count changes. Even with the latch, if there's a
> > PC10
> > transition that occurs after the bit is written but before the
> > registers are read, the values may be from that transition, not the
> > latch.
> 
> 
> All default values are printed as "No". Here, we can rather print a
> message
> that unless latch is set or Package enters c10 (which is unlikely
> unless
> the display is off) the debugfs would not show any blockers.
> 
> In the current form this patch prints the output when we read the
> first time
> before setting the latch.
> 
> SLP_S0_DBG: AUDIO_D3                            State: No
> SLP_S0_DBG: OTG_D3                              State: No
> ---- xxx ---- snip ---- xxx ----
> 
> Once the latch bit is set the SLP_S0_DBG_X registers show proper
> values but
> after explicitely setting latch as "N", the stale values are
> printed. 
> The
> system on which i tested never enters PC10 so once the latch is
> unset, the
> values should be shown as default i.e. NO but that is not always
> correct as
> you mentioned above. 
> 
> 
> IMO, a better approch would be to set/unset the latch internally when
> the
> user does a read on SLP_S0_DEBUG_X registers rather than exposing a
> seperate
> debugfs file because a write of 0 to the latch bit has no effect but
> it is a
> requirement for the next read.

If the latch file is used, the code will already reset it automatically
by writing 0 after each read. Writing "N" is not necessary unless you
wrote "Y" and changed your mind. The reset does not set the values to
all "No". The registers, once updated the first time, always hold the
last saved state. 

If the latch file is not used the registers will only update whenever
the system enters PC10. This works on my system that does enter PC10.

What you suggest would limit the read to forcibly latched values only.
The greatest value of this file IMHO is in being able to see system
state after it enters PC10, a state you cannot guarantee the system
will be in if you only forcibly latch the state with the latch file.

David
