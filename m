Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeFEL7I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:59:08 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14393 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbeFEL7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:59:06 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 05 Jun 2018 04:59:05 -0700
Date: Tue, 5 Jun 2018 14:58:55 +0300
From: Aapo Vienamo <avienamo@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: tegra: Use sdhci_pltfm_clk_get_max_clock
Message-ID: <20180605145855.3004dae2@dhcp-10-21-25-168>
In-Reply-To: <20180605092801.GC20649@ulmo>
References: <1528126540-27004-1-git-send-email-avienamo@nvidia.com>
        <20180605092801.GC20649@ulmo>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.26.11.41]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To HQMAIL101.nvidia.com
 (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2018 11:28:01 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Mon, Jun 04, 2018 at 06:35:40PM +0300, Aapo Vienamo wrote:
> > The sdhci get_max_clock callback is set to sdhci_pltfm_clk_get_max_clock
> > and tegra_sdhci_get_max_clock is removed. It appears that the
> > shdci-tegra specific callback was originally introduced due to the
> > requirement that the host clock has to be twice the bus clock on DDR50
> > mode. As far as I can tell the only effect the removal has on DDR50 mode
> > is in cases where the parent clock is unable to supply the requested
> > clock rate, causing the DDR50 mode to run at a lower frequency.
> > Currently the DDR50 mode isn't enabled on any of the SoCs and would also
> > require configuring the SDHCI clock divider register to function
> > properly.
> > 
> > The problem with tegra_sdhci_get_max_clock is that it divides the clock
> > rate by two and thus artificially limits the maximum frequency of faster
> > signaling modes which don't have the host-bus frequency ratio requirement
> > of DDR50 such as SDR104 and HS200. Furthermore, the call to
> > clk_round_rate() may return an error which isn't handled by
> > tegra_sdhci_get_max_clock.
> > 
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > ---
> >  drivers/mmc/host/sdhci-tegra.c | 15 ++-------------
> >  1 file changed, 2 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> > index 970d38f6..c8745b5 100644
> > --- a/drivers/mmc/host/sdhci-tegra.c
> > +++ b/drivers/mmc/host/sdhci-tegra.c
> > @@ -234,17 +234,6 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
> >  	sdhci_set_uhs_signaling(host, timing);
> >  }
> >  
> > -static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
> > -{
> > -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > -
> > -	/*
> > -	 * DDR modes require the host to run at double the card frequency, so
> > -	 * the maximum rate we can support is half of the module input clock.
> > -	 */
> > -	return clk_round_rate(pltfm_host->clk, UINT_MAX) / 2;
> > -}  
> 
> sdhci_pltfm_clk_get_max_clock() returns the current frequency of the
> clock, which may not be an accurate maximum.
> 
> Also, even if we don't support DDR modes now, we may want to enable them
> in the future, at which point we'll need to move to something similar to
> the above again, albeit maybe with some of the issues that you mentioned
> fixed.
> 
> I wonder if we have access to the target mode in this function, because
> it seems to me like we'd need to take that into account when determining
> the maximum clock rate. Or perhaps the double-rate aspect is already
> dealt with in other parts of the MMC subsystem, so the value we should
> return here may not even need to take the mode into account.

I don't think that's possible. The callback is only called during probe
from sdhci_setup_host() via sdhci_add_host(). Handling DDR50 properly
might require adding a new SDHCI quirk bit.

> All of the above said, it is true that we don't enable DDR modes as of
> now, and this patch seems like it shouldn't break anything either, so:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 
> I also gave this a brief run on Jetson TK1 and things seem to work fine,
> so:
> 
> Tested-by: Thierry Reding <treding@nvidia.com>
