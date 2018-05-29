Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933956AbeE2MMm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:12:42 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:35470 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933793AbeE2MMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:12:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Tue, 29 May 2018 14:12:35 +0200
From: Stefan Agner <stefan@agner.ch>
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, dev@lynxeye.de,
        miquel.raynal@bootlin.com, richard@nod.at, marcel@ziswiler.com,
        krzk@kernel.org, digetx@gmail.com, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 4/6] clk: tegra20: init NDFLASH clock to sensible rate
In-Reply-To: <20180529074804.GA6708@tbergstrom-lnx.Nvidia.com>
References: <20180527215442.14760-5-stefan@agner.ch>
 <20180528075510.GQ6835@tbergstrom-lnx.Nvidia.com>
 <5665b799f763daa82dced238fb494863@agner.ch>
 <20180529074804.GA6708@tbergstrom-lnx.Nvidia.com>
Message-ID: <90180dd9fc6e60175c54b9d70e50f0e5@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[25];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.05.2018 09:48, Peter De Schrijver wrote:
> On Mon, May 28, 2018 at 05:53:08PM +0200, Stefan Agner wrote:
>> On 28.05.2018 09:55, Peter De Schrijver wrote:
>> > On Sun, May 27, 2018 at 11:54:40PM +0200, Stefan Agner wrote:
>> >> From: Lucas Stach <dev@lynxeye.de>
>> >>
>> >> Set up the NAND Flash controller clock to run at 150MHz
>> >> instead of the rate set by the bootloader. This is a
>> >> conservative rate which also yields good performance.
>> >>
>> >> Signed-off-by: Lucas Stach <dev@lynxeye.de>
>> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> >> ---
>> >>  drivers/clk/tegra/clk-tegra20.c | 1 +
>> >>  1 file changed, 1 insertion(+)
>> >>
>> >> diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
>> >> index 0ee56dd04cec..dff8c425cd28 100644
>> >> --- a/drivers/clk/tegra/clk-tegra20.c
>> >> +++ b/drivers/clk/tegra/clk-tegra20.c
>> >> @@ -1049,6 +1049,7 @@ static struct tegra_clk_init_table init_table[] __initdata = {
>> >>  	{ TEGRA20_CLK_GR2D, TEGRA20_CLK_PLL_C, 300000000, 0 },
>> >>  	{ TEGRA20_CLK_GR3D, TEGRA20_CLK_PLL_C, 300000000, 0 },
>> >>  	{ TEGRA20_CLK_VDE, TEGRA20_CLK_CLK_MAX, 300000000, 0 },
>> >> +	{ TEGRA20_CLK_NDFLASH, TEGRA20_CLK_PLL_P, 150000000, 0 },
>> >>  	/* must be the last entry */
>> >>  	{ TEGRA20_CLK_CLK_MAX, TEGRA20_CLK_CLK_MAX, 0, 0 },
>> >>  };
>> >> --
>> >> 2.17.0
>> >>
>> >
>> > Maybe better to specify this in the Tegra20 dtsi? See
>> > "Assigned clock parents and rates" in
>> > Documentation/devicetree/bindings/clock/clock-bindings.txt
>>
>> assigned-clocks indeed works just fine for this case. Thanks for
>> bringing this up, will drop this patch and add the device tree
>> properties in v3.
>>
>> Hm, interesting that none of the Tegra device tree make use of the
>> feature so far. I guess there would be other cases where this would be
>> useful as well (the one just above, VDE?).
>>
> 
> Yes, historically this feature wasn't available, so we used these init tables.
> Unfortunately it's not easy to get rid of them for parent and rate
> configuration, because new kernels should also work with existing DTBs, so we
> can't just add assigned-clock properties and remove the existing table
> entries. What we could do is use the CLK_IS_CRITICAL flag for all clocks which
> are only enabled by the init table. For not yet merged blocks, this is
> ofcourse not a concern.

Sure I understand.

Was just somewhat surprised that it isn't used at all yet (grep -r -e
assigned-clock arch/arm/boot/dts/tegra* returns nothing). After all,
assigned clocks bindings have been merged in 2014 :-)

At least "clk: tegra: Specify VDE clock rate" merged earlier this year
would have been a candidate already.

--
Stefan
