Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932155AbeE2HsC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:48:02 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7952 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754922AbeE2Hrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:47:48 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 29 May 2018 00:47:51 -0700
Date: Tue, 29 May 2018 10:48:04 +0300
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Stefan Agner <stefan@agner.ch>
CC: <boris.brezillon@bootlin.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <dev@lynxeye.de>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <marcel@ziswiler.com>, <krzk@kernel.org>,
        <digetx@gmail.com>, <benjamin.lindqvist@endian.se>,
        <jonathanh@nvidia.com>, <pgaikwad@nvidia.com>, <mirza.krak@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] clk: tegra20: init NDFLASH clock to sensible rate
Message-ID: <20180529074804.GA6708@tbergstrom-lnx.Nvidia.com>
References: <20180527215442.14760-5-stefan@agner.ch>
 <20180528075510.GQ6835@tbergstrom-lnx.Nvidia.com>
 <5665b799f763daa82dced238fb494863@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5665b799f763daa82dced238fb494863@agner.ch>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 05:53:08PM +0200, Stefan Agner wrote:
> On 28.05.2018 09:55, Peter De Schrijver wrote:
> > On Sun, May 27, 2018 at 11:54:40PM +0200, Stefan Agner wrote:
> >> From: Lucas Stach <dev@lynxeye.de>
> >>
> >> Set up the NAND Flash controller clock to run at 150MHz
> >> instead of the rate set by the bootloader. This is a
> >> conservative rate which also yields good performance.
> >>
> >> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> >>  drivers/clk/tegra/clk-tegra20.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
> >> index 0ee56dd04cec..dff8c425cd28 100644
> >> --- a/drivers/clk/tegra/clk-tegra20.c
> >> +++ b/drivers/clk/tegra/clk-tegra20.c
> >> @@ -1049,6 +1049,7 @@ static struct tegra_clk_init_table init_table[] __initdata = {
> >>  	{ TEGRA20_CLK_GR2D, TEGRA20_CLK_PLL_C, 300000000, 0 },
> >>  	{ TEGRA20_CLK_GR3D, TEGRA20_CLK_PLL_C, 300000000, 0 },
> >>  	{ TEGRA20_CLK_VDE, TEGRA20_CLK_CLK_MAX, 300000000, 0 },
> >> +	{ TEGRA20_CLK_NDFLASH, TEGRA20_CLK_PLL_P, 150000000, 0 },
> >>  	/* must be the last entry */
> >>  	{ TEGRA20_CLK_CLK_MAX, TEGRA20_CLK_CLK_MAX, 0, 0 },
> >>  };
> >> --
> >> 2.17.0
> >>
> > 
> > Maybe better to specify this in the Tegra20 dtsi? See 
> > "Assigned clock parents and rates" in
> > Documentation/devicetree/bindings/clock/clock-bindings.txt
> 
> assigned-clocks indeed works just fine for this case. Thanks for
> bringing this up, will drop this patch and add the device tree
> properties in v3.
> 
> Hm, interesting that none of the Tegra device tree make use of the
> feature so far. I guess there would be other cases where this would be
> useful as well (the one just above, VDE?).
> 

Yes, historically this feature wasn't available, so we used these init tables.
Unfortunately it's not easy to get rid of them for parent and rate
configuration, because new kernels should also work with existing DTBs, so we
can't just add assigned-clock properties and remove the existing table
entries. What we could do is use the CLK_IS_CRITICAL flag for all clocks which
are only enabled by the init table. For not yet merged blocks, this is
ofcourse not a concern.

Cheers,

Peter.
