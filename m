Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754272AbeDFEjh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 00:39:37 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:41414 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754174AbeDFEjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 00:39:16 -0400
Date: Fri, 6 Apr 2018 06:35:55 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Mark Brown <broonie@kernel.org>
Cc: hch@lst.de, thomas.lendacky@amd.com, tglx@linutronix.de,
        dwmw2@infradead.org, joro@8bytes.org, jdmason@kudzu.us,
        konrad.wilk@oracle.com, torvalds@linux-foundation.org, mulix@mulix.org,
        peterz@infradead.org, iommu@lists.linux-foundation.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, Vinod Koul <vinod.koul@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: x86/dma conversion for v4.17-rc1 breaks sound / sst-acpi (commit
 6e4bf5867783)
Message-ID: <20180406043555.GA7632@light.dominikbrodowski.net>
References: <20180405205657.GA1788@light.dominikbrodowski.net>
 <20180406011418.GE12349@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406011418.GE12349@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 02:14:18AM +0100, Mark Brown wrote:
> On Thu, Apr 05, 2018 at 10:56:57PM +0200, Dominik Brodowski wrote:
> > Christoph,
> > 
> > unfortunately, commit 6e4bf5867783 breaks sound on my Dell XPS13, see the
> > dmesg diff between fec777c385b6 and 6e4bf5867783:
> 
> Adding Vinod and Pierre from Intel in case they have any ideas here.
> Which model of XPS13 is this (2015?)?

Dell Inc. XPS 13 9343/0TM99H, BIOS A11 12/08/2016, with

# CONFIG_GPIOLIB is not set,

just CONFIG_PINCTRL=y but no

# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set

(yes, this works, see commit d1fa74520dcd ), and,

CONFIG_SND_HDA_I915=y
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_ACPI=y
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=y
CONFIG_SND_SST_IPC_ACPI=y
CONFIG_SND_SOC_INTEL_SST_ACPI=y
CONFIG_SND_SOC_INTEL_SST=y
CONFIG_SND_SOC_INTEL_SST_FIRMWARE=y
CONFIG_SND_SOC_INTEL_HASWELL=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=y
CONFIG_SND_SOC_ACPI_INTEL_MATCH=y
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=y
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=y
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=y
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=y
CONFIG_SND_SOC_I2C_AND_SPI=y
CONFIG_SND_SOC_AC97_CODEC=y


Thanks for looking into this!

	Dominik


> > -sst-acpi INT3438:00: DesignWare DMA Controller, 8 channels
> > -haswell-pcm-audio haswell-pcm-audio: Direct firmware load for intel/IntcPP01.bin failed with error -2
> > -haswell-pcm-audio haswell-pcm-audio: fw image intel/IntcPP01.bin not available(-2)
> > -haswell-pcm-audio haswell-pcm-audio: FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
> > -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> System Pin mapping ok
> > -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload0 Pin mapping ok
> > -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload1 Pin mapping ok
> > -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Loopback Pin mapping ok
> > -broadwell-audio broadwell-audio: rt286-aif1 <-> snd-soc-dummy-dai mapping ok
> > -input: broadwell-rt286 Headset as /devices/pci0000:00/INT3438:00/broadwell-audio/sound/card1/input15
> > +broadwell-audio broadwell-audio: ASoC: CPU DAI System Pin not registered
> 
> > So it seems that sst-acpi is unhappy with this patch. Any ideas?
