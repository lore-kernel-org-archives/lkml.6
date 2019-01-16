Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1430EC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD015206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="iCHR1hlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392305AbfAPMKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:10:08 -0500
Received: from plaes.org ([188.166.43.21]:45318 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731741AbfAPMKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:10:08 -0500
Received: from plaes.org (localhost [127.0.0.1])
        by plaes.org (Postfix) with ESMTPSA id 9E4C64057C;
        Wed, 16 Jan 2019 12:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1547640599; bh=IliL75XUgcdygZBqmHV+UcNp6F0JkREAynm2tdDO0KI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iCHR1hlNWcTXpt8dWn8Mi7UEMtZ4Jz0JWQ3pjZ4TRWmL6ra7beoEWHX6z11z7wADB
         mdYzvKo26MZfGXqh0/Gg1gmG9YiwrVBiHMyBzxvZOrEA5aHoj/OXtGG61YGpF7XdI+
         WpiUtKlUQjgrMNW5i9W69icM3pxK875a65H07Oa+94BzRcpmq62TLIrXN650S14wJc
         m+ee00TBLY0DxNJYXdSlUVKAJJsHjjfS2S0K96i9QKuvTlskQE9YPPBMoE/Tnajc+b
         V+PFsFjnc/Hvts7YUe9QoCkyeRptNjTiKpU+VAe7PrKcXnnUMQBjkgcPDo0H69VIYi
         qmiNooNye7OyQ==
Date:   Wed, 16 Jan 2019 12:09:58 +0000
From:   Priit Laes <plaes@plaes.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, airlied@linux.ie,
        architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH v3 02/28] clk: sunxi-ng: Adjust MP clock
 parent rate when allowed
Message-ID: <20190116120958.gvxr6tpstvhjpe5a@plaes.org>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
 <20181104182705.18047-3-jernej.skrabec@siol.net>
 <20190110091548.e6btt2qofi7ttt6z@plaes.org>
 <2085880.8AFF3nNMGQ@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="o3ryd2jdq2coyz2h"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2085880.8AFF3nNMGQ@jernej-laptop>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o3ryd2jdq2coyz2h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jan 10, 2019 at 06:10:59PM +0100, Jernej Škrabec wrote:
> Dne četrtek, 10. januar 2019 ob 10:15:48 CET je Priit Laes napisal(a):
> > On Sun, Nov 04, 2018 at 07:26:39PM +0100, Jernej Skrabec wrote:
> > > Currently MP clocks don't consider adjusting parent rate even if they
> > > are allowed to do so. Such behaviour considerably lowers amount of
> > > possible rates, which is very inconvenient when such clock is used for
> > > pixel clock, for example.
> > > 
> > > In order to improve the situation, adjusting parent rate is considered
> > > when allowed.
> > > 
> > > This code is inspired by clk_divider_bestdiv() function, which does
> > > basically the same thing for different clock type.
> > 
> > This patch seems to break the eMMC support on Olinuxino-Lime2-eMMC boards:
> > 
> > EXT4-fs (mmcblk1p4): INFO: recovery required on readonly filesystem
> > EXT4-fs (mmcblk1p4): write access will be enabled during recovery
> > sunxi-mmc 1c11000.mmc: data error, sending stop command
> > sunxi-mmc 1c11000.mmc: send stop command failed
> > 
> 
> I'm not familiar with A20. What is interesting is that emmc clocks don't have 
> CLK_SET_RATE_PARENT flag set, so you shouldn't see any difference.
> 
> Can you post content of clk_summary with and without this patch?

In both cases I booted from FEL with rootfs on sdcard and tried to mount
partition from eMMC to /mnt. With your patch, last step it fails.

pre-patch working:
pll-ddr-other[768MHz] -> mmc2[512MHz]. (For some reason ahb-mmc2 is off?)

post-patch not working:
pll-periph[600MHz] ->  mmc2[500Mhz], (ahb-mmc2 is enabled)

Also, attached the logs.

> 
> Best regards,
> Jernej
> 
> > 
> > $ git bisect log
> > git bisect start
> > # good: [3df407b2a5346db1c48809706ece7a8616c79e0b] mmc: dw_mmc-bluefield:
> > simplify the probe() function git bisect good
> > 3df407b2a5346db1c48809706ece7a8616c79e0b
> > # bad: [00d59fde8532b2d42e80909d2e58678755e04da9] Merge tag 'mmc-v4.21' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc git bisect bad
> > 00d59fde8532b2d42e80909d2e58678755e04da9
> > # good: [01e421feec0817bb3141eaae4c517410d193d440] Merge branch 'fixes' into
> > next git bisect good 01e421feec0817bb3141eaae4c517410d193d440
> > # bad: [1eefdec18eded41833401cfd64749643ff72e7da] Merge branch
> > 'locking-core-for-linus' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip git bisect bad
> > 1eefdec18eded41833401cfd64749643ff72e7da
> > # good: [eaa76499711535fd64d747cc4ef0d78ab0fd41c6] Merge tag 'mtd/for-4.21'
> > of git://git.infradead.org/linux-mtd git bisect good
> > eaa76499711535fd64d747cc4ef0d78ab0fd41c6
> > # good: [4e4390ad067a61ce4e7607bd0df31f19a4caa36a] Merge tag
> > 'leds-for-4.21-rc1' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds git
> > bisect good 4e4390ad067a61ce4e7607bd0df31f19a4caa36a
> > # bad: [c2f1f3e0e17d94ab0c66d83e669492cb9e9a3698] Merge
> > git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next git bisect
> > bad c2f1f3e0e17d94ab0c66d83e669492cb9e9a3698
> > # bad: [e4b99d415c3908581d4703203e1e805f043a3e71] Merge branch
> > 'irq-core-for-linus' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip git bisect bad
> > e4b99d415c3908581d4703203e1e805f043a3e71
> > # bad: [ffe05540d18013db62c43627836a3638e9a2c7aa] Merge branches
> > 'clk-renesas', 'clk-allwinner', 'clk-tegra', 'clk-meson' and 'clk-rockchip'
> > into clk-next git bisect bad ffe05540d18013db62c43627836a3638e9a2c7aa
> > # good: [1a501c8defe950571316d5ddd917bf44f5ed7bd4] Merge branches
> > 'clk-managed-registration', 'clk-spdx', 'clk-remove-basic' and
> > 'clk-ops-const' into clk-next git bisect good
> > 1a501c8defe950571316d5ddd917bf44f5ed7bd4
> > # good: [e74581b79ddd9b49b8c61e2791fc4dffc0245afb] Merge tag
> > 'meson-clk-4.21-2' of https://github.com/BayLibre/clk-meson into clk-meson
> > git bisect good e74581b79ddd9b49b8c61e2791fc4dffc0245afb
> > # good: [60baf75e3f5b76043c25328ac0c5320aaef5ea41] Merge tag
> > 'clk-renesas-for-v4.21-tag2' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into
> > clk-renesas git bisect good 60baf75e3f5b76043c25328ac0c5320aaef5ea41
> > # bad: [a41f85b6017ee20952a60e4330bcae2527fe2c2a] Merge tag
> > 'sunxi-clk-for-4.21' of
> > https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into
> > clk-allwinner git bisect bad a41f85b6017ee20952a60e4330bcae2527fe2c2a
> > # bad: [ee678706e46d0d185c27cc214ad97828e0643159] clk: sunxi-ng: a64: Fix
> > gate bit of DSI DPHY git bisect bad
> > ee678706e46d0d185c27cc214ad97828e0643159
> > # bad: [65b6657672388b72822e0367f06d41c1e3ffb5bb] clk: sunxi-ng: Use u64 for
> > calculation of NM rate git bisect bad
> > 65b6657672388b72822e0367f06d41c1e3ffb5bb
> > # good: [db7548934603d9eda12649dff97ea5c29884405d] clk: sunxi-ng: sun50i:
> > h6: Fix MMC clock mux width git bisect good
> > db7548934603d9eda12649dff97ea5c29884405d
> > # bad: [3f790433c3cb27ecaf2ca0e07ac25964e4fd9f15] clk: sunxi-ng: Adjust MP
> > clock parent rate when allowed git bisect bad
> > 3f790433c3cb27ecaf2ca0e07ac25964e4fd9f15
> > # first bad commit: [3f790433c3cb27ecaf2ca0e07ac25964e4fd9f15] clk:
> > sunxi-ng: Adjust MP clock parent rate when allowed
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > > 
> > >  drivers/clk/sunxi-ng/ccu_mp.c | 64 +++++++++++++++++++++++++++++++++--
> > >  1 file changed, 62 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
> > > index 5d0af4051737..0357349eb767 100644
> > > --- a/drivers/clk/sunxi-ng/ccu_mp.c
> > > +++ b/drivers/clk/sunxi-ng/ccu_mp.c
> > > @@ -40,6 +40,61 @@ static void ccu_mp_find_best(unsigned long parent,
> > > unsigned long rate,> 
> > >  	*p = best_p;
> > >  
> > >  }
> > > 
> > > +static unsigned long ccu_mp_find_best_with_parent_adj(struct clk_hw *hw,
> > > +						      
> unsigned long *parent,
> > > +						      
> unsigned long rate,
> > > +						      
> unsigned int max_m,
> > > +						      
> unsigned int max_p)
> > > +{
> > > +	unsigned long parent_rate_saved;
> > > +	unsigned long parent_rate, now;
> > > +	unsigned long best_rate = 0;
> > > +	unsigned int _m, _p, div;
> > > +	unsigned long maxdiv;
> > > +
> > > +	parent_rate_saved = *parent;
> > > +
> > > +	/*
> > > +	 * The maximum divider we can use without overflowing
> > > +	 * unsigned long in rate * m * p below
> > > +	 */
> > > +	maxdiv = max_m * max_p;
> > > +	maxdiv = min(ULONG_MAX / rate, maxdiv);
> > > +
> > > +	for (_p = 1; _p <= max_p; _p <<= 1) {
> > > +		for (_m = 1; _m <= max_m; _m++) {
> > > +			div = _m * _p;
> > > +
> > > +			if (div > maxdiv)
> > > +				break;
> > > +
> > > +			if (rate * div == parent_rate_saved) {
> > > +				/*
> > > +				 * It's the most ideal case if 
> the requested
> > > +				 * rate can be divided from 
> parent clock without
> > > +				 * needing to change parent rate, 
> so return the
> > > +				 * divider immediately.
> > > +				 */
> > > +				*parent = parent_rate_saved;
> > > +				return rate;
> > > +			}
> > > +
> > > +			parent_rate = clk_hw_round_rate(hw, rate * 
> div);
> > > +			now = parent_rate / div;
> > > +
> > > +			if (now <= rate && now > best_rate) {
> > > +				best_rate = now;
> > > +				*parent = parent_rate;
> > > +
> > > +				if (now == rate)
> > > +					return rate;
> > > +			}
> > > +		}
> > > +	}
> > > +
> > > +	return best_rate;
> > > +}
> > > +
> > > 
> > >  static unsigned long ccu_mp_round_rate(struct ccu_mux_internal *mux,
> > >  
> > >  				       struct clk_hw *hw,
> > >  				       unsigned long 
> *parent_rate,
> > > 
> > > @@ -56,8 +111,13 @@ static unsigned long ccu_mp_round_rate(struct
> > > ccu_mux_internal *mux,> 
> > >  	max_m = cmp->m.max ?: 1 << cmp->m.width;
> > >  	max_p = cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
> > > 
> > > -	ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m, &p);
> > > -	rate = *parent_rate / p / m;
> > > +	if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
> > > +		ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m, 
> &p);
> > > +		rate = *parent_rate / p / m;
> > > +	} else {
> > > +		rate = ccu_mp_find_best_with_parent_adj(hw, parent_rate, 
> rate,
> > > +							
> max_m, max_p);
> > > +	}
> > > 
> > >  	if (cmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
> > >  	
> > >  		rate /= cmp->fixed_post_div;
> 
> 
> 
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

--o3ryd2jdq2coyz2h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pre-patch-clocks.log"

                                 enable  prepare  protect                                duty
   clock                          count    count    count        rate   accuracy phase  cycle
---------------------------------------------------------------------------------------------
 gmac_int_tx                          1        1        0   125000000          0     0  50000
    gmac_tx                           1        1        0   125000000          0     0  50000
 mii_phy_tx                           0        0        0    25000000          0     0  50000
 osc32k                               0        0        0       32768          0     0  50000
 osc24M                               2        2        1    24000000          0     0  50000
    hosc                              6        6        1    24000000          0     0  50000
       out-b                          0        0        0       32000          0     0  50000
       out-a                          0        0        0       32000          0     0  50000
       hdmi1-slow                     0        0        0    24000000          0     0  50000
       avs                            0        0        0    24000000          0     0  50000
       csi1                           0        0        0    24000000          0     0  50000
       csi0                           0        0        0    24000000          0     0  50000
       spi3                           0        0        0    24000000          0     0  50000
       keypad                         0        0        0      750000          0     0  50000
       ir1                            0        0        0    24000000          0     0  50000
       ir0                            0        0        0    24000000          0     0  50000
       pata                           0        0        0    24000000          0     0  50000
       spi2                           0        0        0    24000000          0     0  50000
       spi1                           0        0        0    24000000          0     0  50000
       spi0                           0        0        0    24000000          0     0  50000
       ts                             0        0        0    24000000          0     0  50000
       mmc3                           0        0        0    24000000          0     0  50000
          mmc3_sample                 0        0        0    24000000          0   180  50000
          mmc3_output                 0        0        0    24000000          0   180  50000
       mmc1                           0        0        0    24000000          0     0  50000
          mmc1_sample                 0        0        0    24000000          0   180  50000
          mmc1_output                 0        0        0    24000000          0   180  50000
       ms                             0        0        0    24000000          0     0  50000
       nand                           0        0        0    24000000          0     0  50000
       apb1                           3        3        0    24000000          0     0  50000
          apb1-uart7                  0        0        0    24000000          0     0  50000
          apb1-uart6                  0        0        0    24000000          0     0  50000
          apb1-uart5                  0        0        0    24000000          0     0  50000
          apb1-uart4                  0        0        0    24000000          0     0  50000
          apb1-uart3                  0        0        0    24000000          0     0  50000
          apb1-uart2                  0        0        0    24000000          0     0  50000
          apb1-uart1                  0        0        0    24000000          0     0  50000
          apb1-uart0                  1        1        0    24000000          0     0  50000
          apb1-i2c4                   0        0        0    24000000          0     0  50000
          apb1-ps21                   0        0        0    24000000          0     0  50000
          apb1-ps20                   0        0        0    24000000          0     0  50000
          apb1-scr                    0        0        0    24000000          0     0  50000
          apb1-can                    0        0        0    24000000          0     0  50000
          apb1-i2c3                   0        0        0    24000000          0     0  50000
          apb1-i2c2                   0        0        0    24000000          0     0  50000
          apb1-i2c1                   1        1        0    24000000          0     0  50000
          apb1-i2c0                   1        1        0    24000000          0     0  50000
       pll-gpu                        0        0        0  1200000000          0     0  50000
       pll-video1                     1        1        0   327000000          0     0  50000
          pll-video1-2x               1        1        0   654000000          0     0  50000
             hdmi-tmds                1        1        0    25153846          0     0  50000
                hdmi-ddc              1        1        0       89835          0     0  50000
       pll-periph-base                3        3        0  1200000000          0     0  50000
          mbus                        1        1        0   300000000          0     0  50000
          pll-periph-sata             1        1        0   100000000          0     0  50000
             sata                     1        1        0   100000000          0     0  50000
          pll-periph                  5        5        0   600000000          0     0  50000
             mmc0                     0        0        0    50000000          0     0  50000
                mmc0_sample           0        0        0    50000000          0   120  50000
                mmc0_output           0        0        0    50000000          0    90  50000
             ss                       1        1        0   150000000          0     0  50000
             usb-phy                  3        3        0   600000000          0     0  50000
             usb-ohci1                1        1        0   600000000          0     0  50000
             usb-ohci0                1        1        0   600000000          0     0  50000
             ahb                     17       17        0   300000000          0     0  50000
                ahb-gpu               0        0        0   300000000          0     0  50000
                ahb-mp                0        0        0   300000000          0     0  50000
                ahb-gmac              1        1        0   300000000          0     0  50000
                ahb-de-fe1            0        0        0   300000000          0     0  50000
                ahb-de-fe0            0        0        0   300000000          0     0  50000
                ahb-de-be1            1        1        0   300000000          0     0  50000
                ahb-de-be0            1        1        0   300000000          0     0  50000
                ahb-hdmi1             0        0        0   300000000          0     0  50000
                ahb-hdmi0             1        1        0   300000000          0     0  50000
                ahb-csi1              0        0        0   300000000          0     0  50000
                ahb-csi0              0        0        0   300000000          0     0  50000
                ahb-lcd1              1        1        0   300000000          0     0  50000
                ahb-lcd0              1        1        0   300000000          0     0  50000
                ahb-tve1              0        0        0   300000000          0     0  50000
                ahb-tve0              0        0        0   300000000          0     0  50000
                ahb-tvd               0        0        0   300000000          0     0  50000
                ahb-ve                0        0        0   300000000          0     0  50000
                ahb-hstimer           2        2        0   300000000          0     0  50000
                ahb-sata              1        1        0   300000000          0     0  50000
                ahb-pata              0        0        0   300000000          0     0  50000
                ahb-spi3              0        0        0   300000000          0     0  50000
                ahb-spi2              0        0        0   300000000          0     0  50000
                ahb-spi1              0        0        0   300000000          0     0  50000
                ahb-spi0              0        0        0   300000000          0     0  50000
                ahb-ts                0        0        0   300000000          0     0  50000
                ahb-emac              0        0        0   300000000          0     0  50000
                ahb-ace               0        0        0   300000000          0     0  50000
                ahb-sdram             1        1        0   300000000          0     0  50000
                ahb-nand              0        0        0   300000000          0     0  50000
                ahb-ms                0        0        0   300000000          0     0  50000
                ahb-mmc3              0        0        0   300000000          0     0  50000
                ahb-mmc2              0        0        0   300000000          0     0  50000
                ahb-mmc1              0        0        0   300000000          0     0  50000
                ahb-mmc0              0        0        0   300000000          0     0  50000
                ahb-bist              0        0        0   300000000          0     0  50000
                ahb-dma               1        1        0   300000000          0     0  50000
                ahb-ss                1        1        0   300000000          0     0  50000
                ahb-ohci1             1        1        0   300000000          0     0  50000
                ahb-ehci1             1        1        0   300000000          0     0  50000
                ahb-ohci0             1        1        0   300000000          0     0  50000
                ahb-ehci0             1        1        0   300000000          0     0  50000
                ahb-otg               1        1        0   300000000          0     0  50000
                apb0                  1        1        0   150000000          0     0  50000
                   apb0-keypad        0        0        0   150000000          0     0  50000
                   apb0-i2s2          0        0        0   150000000          0     0  50000
                   apb0-ir1           0        0        0   150000000          0     0  50000
                   apb0-ir0           0        0        0   150000000          0     0  50000
                   apb0-pio           1        1        0   150000000          0     0  50000
                   apb0-i2s1          0        0        0   150000000          0     0  50000
                   apb0-ac97          0        0        0   150000000          0     0  50000
                   apb0-i2s0          0        0        0   150000000          0     0  50000
                   apb0-spdif         0        0        0   150000000          0     0  50000
                   apb0-codec         0        0        0   150000000          0     0  50000
       pll-ddr-base                   2        2        0   768000000          0     0  50000
          pll-ddr-other               1        1        0   768000000          0     0  50000
             mmc2                     0        0        0    51200000          0     0  50000
                mmc2_sample           0        0        0    51200000          0   120  50000
                mmc2_output           0        0        0    51200000          0    72  50000
             de-be0                   1        1        0   256000000          0     0  50000
          pll-ddr                     4        4        0   384000000          0     0  50000
             dram-ace                 0        0        0   384000000          0     0  50000
             dram-mp                  0        0        0   384000000          0     0  50000
             dram-de-be1              1        1        0   384000000          0     0  50000
             dram-de-be0              1        1        0   384000000          0     0  50000
             dram-de-fe0              0        0        0   384000000          0     0  50000
             dram-de-fe1              0        0        0   384000000          0     0  50000
             dram-out                 1        1        0   384000000          0     0  50000
             dram-tve1                0        0        0   384000000          0     0  50000
             dram-tve0                0        0        0   384000000          0     0  50000
             dram-tvd                 0        0        0   384000000          0     0  50000
             dram-ts                  0        0        0   384000000          0     0  50000
             dram-csi1                0        0        0   384000000          0     0  50000
             dram-csi0                0        0        0   384000000          0     0  50000
             dram-ve                  0        0        0   384000000          0     0  50000
       pll-ve                         0        0        0  1200000000          0     0  50000
          ace                         0        0        0  1200000000          0     0  50000
          ve                          0        0        0  1200000000          0     0  50000
       pll-video0                     3        3        1   327000000          0     0  50000
          hdmi1                       0        0        0   327000000          0     0  50000
          gpu                         0        0        0   327000000          0     0  50000
          hdmi                        1        1        0    25153847          0     0  50000
          tcon1-ch1-sclk2             0        0        0   327000000          0     0  50000
             tcon1-ch1-sclk1          0        0        0   327000000          0     0  50000
          tcon0-ch1-sclk2             1        1        1    25153847          0     0  50000
             tcon0-ch1-sclk1          1        1        1    25153847          0     0  50000
          tvd-sclk2                   0        0        0   327000000          0     0  50000
             tvd-sclk1                0        0        0   327000000          0     0  50000
          csi-sclk                    0        0        0   327000000          0     0  50000
          tcon1-ch0-sclk              0        0        0   327000000          0     0  50000
             tcon1-pixel-clock        0        0        0   327000000          0     0  50000
          tcon0-ch0-sclk              0        0        0   327000000          0     0  50000
             tcon0-pixel-clock        0        0        0   327000000          0     0  50000
          de-mp                       0        0        0   327000000          0     0  50000
          de-fe1                      0        0        0   327000000          0     0  50000
          de-fe0                      0        0        0   327000000          0     0  50000
          de-be1                      1        1        0   327000000          0     0  50000
          pll-video0-2x               0        0        0   654000000          0     0  50000
       pll-audio-base                 0        0        0     1500000          0     0  50000
          pll-audio-8x                0        0        0     3000000          0     0  50000
             i2s2                     0        0        0     3000000          0     0  50000
             i2s1                     0        0        0     3000000          0     0  50000
             i2s0                     0        0        0     3000000          0     0  50000
          pll-audio-4x                0        0        0     1500000          0     0  50000
             spdif                    0        0        0     1500000          0     0  50000
          pll-audio-2x                0        0        0      750000          0     0  50000
          pll-audio                   0        0        0     1500000          0     0  50000
             codec                    0        0        0     1500000          0     0  50000
             ac97                     0        0        0     1500000          0     0  50000
       pll-core                       1        1        0   960000000          0     0  50000
          cpu                         1        1        0   960000000          0     0  50000
             axi                      0        0        0   320000000          0     0  50000

--o3ryd2jdq2coyz2h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="post-patch-clocks.log"

                                 enable  prepare  protect                                duty
   clock                          count    count    count        rate   accuracy phase  cycle
---------------------------------------------------------------------------------------------
 gmac_int_tx                          1        1        0   125000000          0     0  50000
    gmac_tx                           1        1        0   125000000          0     0  50000
 mii_phy_tx                           0        0        0    25000000          0     0  50000
 osc32k                               0        0        0       32768          0     0  50000
 osc24M                               2        2        1    24000000          0     0  50000
    hosc                              6        6        1    24000000          0     0  50000
       out-b                          0        0        0       32000          0     0  50000
       out-a                          0        0        0       32000          0     0  50000
       hdmi1-slow                     0        0        0    24000000          0     0  50000
       avs                            0        0        0    24000000          0     0  50000
       csi1                           0        0        0    24000000          0     0  50000
       csi0                           0        0        0    24000000          0     0  50000
       spi3                           0        0        0    24000000          0     0  50000
       keypad                         0        0        0      750000          0     0  50000
       ir1                            0        0        0    24000000          0     0  50000
       ir0                            0        0        0    24000000          0     0  50000
       pata                           0        0        0    24000000          0     0  50000
       spi2                           0        0        0    24000000          0     0  50000
       spi1                           0        0        0    24000000          0     0  50000
       spi0                           0        0        0    24000000          0     0  50000
       ts                             0        0        0    24000000          0     0  50000
       mmc3                           0        0        0    24000000          0     0  50000
          mmc3_sample                 0        0        0    24000000          0   180  50000
          mmc3_output                 0        0        0    24000000          0   180  50000
       mmc1                           0        0        0    24000000          0     0  50000
          mmc1_sample                 0        0        0    24000000          0   180  50000
          mmc1_output                 0        0        0    24000000          0   180  50000
       ms                             0        0        0    24000000          0     0  50000
       nand                           0        0        0    24000000          0     0  50000
       apb1                           3        3        0    24000000          0     0  50000
          apb1-uart7                  0        0        0    24000000          0     0  50000
          apb1-uart6                  0        0        0    24000000          0     0  50000
          apb1-uart5                  0        0        0    24000000          0     0  50000
          apb1-uart4                  0        0        0    24000000          0     0  50000
          apb1-uart3                  0        0        0    24000000          0     0  50000
          apb1-uart2                  0        0        0    24000000          0     0  50000
          apb1-uart1                  0        0        0    24000000          0     0  50000
          apb1-uart0                  1        1        0    24000000          0     0  50000
          apb1-i2c4                   0        0        0    24000000          0     0  50000
          apb1-ps21                   0        0        0    24000000          0     0  50000
          apb1-ps20                   0        0        0    24000000          0     0  50000
          apb1-scr                    0        0        0    24000000          0     0  50000
          apb1-can                    0        0        0    24000000          0     0  50000
          apb1-i2c3                   0        0        0    24000000          0     0  50000
          apb1-i2c2                   0        0        0    24000000          0     0  50000
          apb1-i2c1                   1        1        0    24000000          0     0  50000
          apb1-i2c0                   1        1        0    24000000          0     0  50000
       pll-gpu                        0        0        0  1200000000          0     0  50000
       pll-video1                     1        1        0   327000000          0     0  50000
          pll-video1-2x               1        1        0   654000000          0     0  50000
             hdmi-tmds                1        1        0    25153846          0     0  50000
                hdmi-ddc              1        1        0       89835          0     0  50000
       pll-periph-base                3        3        0  1200000000          0     0  50000
          mbus                        1        1        0   300000000          0     0  50000
          pll-periph-sata             1        1        0   100000000          0     0  50000
             sata                     1        1        0   100000000          0     0  50000
          pll-periph                  6        6        0   600000000          0     0  50000
             mmc2                     3        3        0    50000000          0     0  50000
                mmc2_sample           1        1        0    50000000          0   120  50000
                mmc2_output           1        1        0    50000000          0    60  50000
             mmc0                     0        0        0    50000000          0     0  50000
                mmc0_sample           0        0        0    50000000          0   120  50000
                mmc0_output           0        0        0    50000000          0    90  50000
             ss                       1        1        0   150000000          0     0  50000
             usb-phy                  3        3        0   600000000          0     0  50000
             usb-ohci1                1        1        0   600000000          0     0  50000
             usb-ohci0                1        1        0   600000000          0     0  50000
             ahb                     18       18        0   300000000          0     0  50000
                ahb-gpu               0        0        0   300000000          0     0  50000
                ahb-mp                0        0        0   300000000          0     0  50000
                ahb-gmac              1        1        0   300000000          0     0  50000
                ahb-de-fe1            0        0        0   300000000          0     0  50000
                ahb-de-fe0            0        0        0   300000000          0     0  50000
                ahb-de-be1            1        1        0   300000000          0     0  50000
                ahb-de-be0            1        1        0   300000000          0     0  50000
                ahb-hdmi1             0        0        0   300000000          0     0  50000
                ahb-hdmi0             1        1        0   300000000          0     0  50000
                ahb-csi1              0        0        0   300000000          0     0  50000
                ahb-csi0              0        0        0   300000000          0     0  50000
                ahb-lcd1              1        1        0   300000000          0     0  50000
                ahb-lcd0              1        1        0   300000000          0     0  50000
                ahb-tve1              0        0        0   300000000          0     0  50000
                ahb-tve0              0        0        0   300000000          0     0  50000
                ahb-tvd               0        0        0   300000000          0     0  50000
                ahb-ve                0        0        0   300000000          0     0  50000
                ahb-hstimer           2        2        0   300000000          0     0  50000
                ahb-sata              1        1        0   300000000          0     0  50000
                ahb-pata              0        0        0   300000000          0     0  50000
                ahb-spi3              0        0        0   300000000          0     0  50000
                ahb-spi2              0        0        0   300000000          0     0  50000
                ahb-spi1              0        0        0   300000000          0     0  50000
                ahb-spi0              0        0        0   300000000          0     0  50000
                ahb-ts                0        0        0   300000000          0     0  50000
                ahb-emac              0        0        0   300000000          0     0  50000
                ahb-ace               0        0        0   300000000          0     0  50000
                ahb-sdram             1        1        0   300000000          0     0  50000
                ahb-nand              0        0        0   300000000          0     0  50000
                ahb-ms                0        0        0   300000000          0     0  50000
                ahb-mmc3              0        0        0   300000000          0     0  50000
                ahb-mmc2              1        1        0   300000000          0     0  50000
                ahb-mmc1              0        0        0   300000000          0     0  50000
                ahb-mmc0              0        0        0   300000000          0     0  50000
                ahb-bist              0        0        0   300000000          0     0  50000
                ahb-dma               1        1        0   300000000          0     0  50000
                ahb-ss                1        1        0   300000000          0     0  50000
                ahb-ohci1             1        1        0   300000000          0     0  50000
                ahb-ehci1             1        1        0   300000000          0     0  50000
                ahb-ohci0             1        1        0   300000000          0     0  50000
                ahb-ehci0             1        1        0   300000000          0     0  50000
                ahb-otg               1        1        0   300000000          0     0  50000
                apb0                  1        1        0   150000000          0     0  50000
                   apb0-keypad        0        0        0   150000000          0     0  50000
                   apb0-i2s2          0        0        0   150000000          0     0  50000
                   apb0-ir1           0        0        0   150000000          0     0  50000
                   apb0-ir0           0        0        0   150000000          0     0  50000
                   apb0-pio           1        1        0   150000000          0     0  50000
                   apb0-i2s1          0        0        0   150000000          0     0  50000
                   apb0-ac97          0        0        0   150000000          0     0  50000
                   apb0-i2s0          0        0        0   150000000          0     0  50000
                   apb0-spdif         0        0        0   150000000          0     0  50000
                   apb0-codec         0        0        0   150000000          0     0  50000
       pll-ddr-base                   2        2        0   768000000          0     0  50000
          pll-ddr-other               1        1        0   768000000          0     0  50000
             de-be0                   1        1        0   256000000          0     0  50000
          pll-ddr                     4        4        0   384000000          0     0  50000
             dram-ace                 0        0        0   384000000          0     0  50000
             dram-mp                  0        0        0   384000000          0     0  50000
             dram-de-be1              1        1        0   384000000          0     0  50000
             dram-de-be0              1        1        0   384000000          0     0  50000
             dram-de-fe0              0        0        0   384000000          0     0  50000
             dram-de-fe1              0        0        0   384000000          0     0  50000
             dram-out                 1        1        0   384000000          0     0  50000
             dram-tve1                0        0        0   384000000          0     0  50000
             dram-tve0                0        0        0   384000000          0     0  50000
             dram-tvd                 0        0        0   384000000          0     0  50000
             dram-ts                  0        0        0   384000000          0     0  50000
             dram-csi1                0        0        0   384000000          0     0  50000
             dram-csi0                0        0        0   384000000          0     0  50000
             dram-ve                  0        0        0   384000000          0     0  50000
       pll-ve                         0        0        0  1200000000          0     0  50000
          ace                         0        0        0  1200000000          0     0  50000
          ve                          0        0        0  1200000000          0     0  50000
       pll-video0                     3        3        1   327000000          0     0  50000
          hdmi1                       0        0        0   327000000          0     0  50000
          gpu                         0        0        0   327000000          0     0  50000
          hdmi                        1        1        0    25153847          0     0  50000
          tcon1-ch1-sclk2             0        0        0   327000000          0     0  50000
             tcon1-ch1-sclk1          0        0        0   327000000          0     0  50000
          tcon0-ch1-sclk2             1        1        1    25153847          0     0  50000
             tcon0-ch1-sclk1          1        1        1    25153847          0     0  50000
          tvd-sclk2                   0        0        0   327000000          0     0  50000
             tvd-sclk1                0        0        0   327000000          0     0  50000
          csi-sclk                    0        0        0   327000000          0     0  50000
          tcon1-ch0-sclk              0        0        0   327000000          0     0  50000
             tcon1-pixel-clock        0        0        0   327000000          0     0  50000
          tcon0-ch0-sclk              0        0        0   327000000          0     0  50000
             tcon0-pixel-clock        0        0        0   327000000          0     0  50000
          de-mp                       0        0        0   327000000          0     0  50000
          de-fe1                      0        0        0   327000000          0     0  50000
          de-fe0                      0        0        0   327000000          0     0  50000
          de-be1                      1        1        0   327000000          0     0  50000
          pll-video0-2x               0        0        0   654000000          0     0  50000
       pll-audio-base                 0        0        0     1500000          0     0  50000
          pll-audio-8x                0        0        0     3000000          0     0  50000
             i2s2                     0        0        0     3000000          0     0  50000
             i2s1                     0        0        0     3000000          0     0  50000
             i2s0                     0        0        0     3000000          0     0  50000
          pll-audio-4x                0        0        0     1500000          0     0  50000
             spdif                    0        0        0     1500000          0     0  50000
          pll-audio-2x                0        0        0      750000          0     0  50000
          pll-audio                   0        0        0     1500000          0     0  50000
             codec                    0        0        0     1500000          0     0  50000
             ac97                     0        0        0     1500000          0     0  50000
       pll-core                       1        1        0   960000000          0     0  50000
          cpu                         1        1        0   960000000          0     0  50000
             axi                      0        0        0   320000000          0     0  50000

--o3ryd2jdq2coyz2h--
