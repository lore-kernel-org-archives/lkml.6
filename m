Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2846FC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D716A20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="XhNdG6LN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbfAQHYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:24:09 -0500
Received: from plaes.org ([188.166.43.21]:48896 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbfAQHYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:24:08 -0500
Received: from plaes.org (localhost [127.0.0.1])
        by plaes.org (Postfix) with ESMTPSA id C3D834026C;
        Thu, 17 Jan 2019 07:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1547709843; bh=G1lpEd13+ID3OA7ZBnWqcKeUtEavubrk+iQEhzNm6+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XhNdG6LN0i649yue9kX2LC8Lxlpyzdo+7OrOrbnUW2440POgwC6BgIHPJunD8Z1zo
         yKpznQ6zzCurfNTOM/TySHzI2uqUHz0AtXK0riQQsSf1/AC7yoUYKxZIkAR7GJMkAy
         yIWa3ahOv7OnxUHPrx57/ebMCddK3bbbJgIkFGU/RjC8xMGD8jibSqDq56dRWEG4Xc
         IAtKE+DozwUC9oaaza9OP5tayXIv47SAsytCraVxuWrkAFHxT9CAe3xgn+WgGyoRlZ
         5WqW6iqR2K/y5rKizJrpT9ieXrxXCK8Z/LFqvy48L85OC+JSkdzNKPtnwGT541/+tP
         cRXgmk5NnwePg==
Date:   Thu, 17 Jan 2019 07:24:02 +0000
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
Message-ID: <20190117072402.ognqxsxewjg3kyyg@plaes.org>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
 <2085880.8AFF3nNMGQ@jernej-laptop>
 <20190116120958.gvxr6tpstvhjpe5a@plaes.org>
 <11550554.k1qAFTnke5@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11550554.k1qAFTnke5@jernej-laptop>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 06:00:32PM +0100, Jernej Škrabec wrote:
> Dne sreda, 16. januar 2019 ob 13:09:58 CET je Priit Laes napisal(a):
> > On Thu, Jan 10, 2019 at 06:10:59PM +0100, Jernej Škrabec wrote:
> > > Dne četrtek, 10. januar 2019 ob 10:15:48 CET je Priit Laes napisal(a):
> > > > On Sun, Nov 04, 2018 at 07:26:39PM +0100, Jernej Skrabec wrote:
> > > > > Currently MP clocks don't consider adjusting parent rate even if they
> > > > > are allowed to do so. Such behaviour considerably lowers amount of
> > > > > possible rates, which is very inconvenient when such clock is used for
> > > > > pixel clock, for example.
> > > > > 
> > > > > In order to improve the situation, adjusting parent rate is considered
> > > > > when allowed.
> > > > > 
> > > > > This code is inspired by clk_divider_bestdiv() function, which does
> > > > > basically the same thing for different clock type.
> > > > 
> > > > This patch seems to break the eMMC support on Olinuxino-Lime2-eMMC
> > > > boards:
> > > > 
> > > > EXT4-fs (mmcblk1p4): INFO: recovery required on readonly filesystem
> > > > EXT4-fs (mmcblk1p4): write access will be enabled during recovery
> > > > sunxi-mmc 1c11000.mmc: data error, sending stop command
> > > > sunxi-mmc 1c11000.mmc: send stop command failed
> > > 
> > > I'm not familiar with A20. What is interesting is that emmc clocks don't
> > > have CLK_SET_RATE_PARENT flag set, so you shouldn't see any difference.
> > > 
> > > Can you post content of clk_summary with and without this patch?
> > 
> > In both cases I booted from FEL with rootfs on sdcard and tried to mount
> > partition from eMMC to /mnt. With your patch, last step it fails.
> > 
> > pre-patch working:
> > pll-ddr-other[768MHz] -> mmc2[512MHz]. (For some reason ahb-mmc2 is off?)
> > 
> > post-patch not working:
> > pll-periph[600MHz] ->  mmc2[500Mhz], (ahb-mmc2 is enabled)
> > 
> > Also, attached the logs.
> 
> Thanks. Just one more request. Can you enable debug messages in mmc driver? 
> I'm interested in output of this line:
> 
> dev_dbg(mmc_dev(mmc), "setting clk to %d, rounded %ld\n",
> 		clock, rate);

1c11000 is eMMC:
[snip]
[    1.961644] sunxi-mmc 1c11000.mmc: setting clk to 400000, rounded 400000
[    2.004091] sunxi-mmc 1c11000.mmc: setting clk to 400000, rounded 400000
[    2.020296] sunxi-mmc 1c11000.mmc: setting clk to 400000, rounded 400000
[    2.039917] sunxi-mmc 1c11000.mmc: setting clk to 400000, rounded 400000
[    2.047847] sunxi-mmc 1c11000.mmc: setting clk to 400000, rounded 400000
[    2.055053] sunxi-mmc 1c11000.mmc: setting clk to 400000, rounded 400000
[    2.065256] sunxi-mmc 1c11000.mmc: setting clk to 400000, rounded 400000
[    2.092351] sunxi-mmc 1c11000.mmc: setting clk to 400000, rounded 400000
[    2.168725] sunxi-mmc 1c11000.mmc: setting clk to 400000, rounded 400000
[    2.189403] sunxi-mmc 1c11000.mmc: setting clk to 52000000, rounded 52000000
[    2.203340] sunxi-mmc 1c11000.mmc: setting clk to 52000000, rounded 52000000
[    2.211412] sunxi-mmc 1c11000.mmc: setting clk to 52000000, rounded 52000000
[    4.967865] sunxi-mmc 1c11000.mmc: setting clk to 52000000, rounded 52000000
[    8.755345] sunxi-mmc 1c11000.mmc: setting clk to 52000000, rounded 52000000
[    9.082510] sunxi-mmc 1c11000.mmc: setting clk to 52000000, rounded 52000000

Here I tried to mount partition from eMMC...

[   72.167311] sunxi-mmc 1c11000.mmc: setting clk to 52000000, rounded 52000000
[   72.269629] sunxi-mmc 1c11000.mmc: data error, sending stop command
[   73.268999] sunxi-mmc 1c11000.mmc: send stop command failed
[/snip]

And clock tree:
[snip]
pll-periph-base                3        3        0  1200000000          0     0  50000
   pll-periph                  6        6        0   600000000          0     0  50000
      mmc2                     3        3        0    50000000          0     0  50000
         mmc2_sample           1        1        0    50000000          0   120  50000
         mmc2_output           1        1        0    50000000          0    60  50000
      ahb                     18       18        0   300000000          0     0  50000
         ahb-mmc2              1        1        0   300000000          0     0  50000
[/snip]


And without patch:
[snip]
[    2.003341] sunxi-mmc 1c11000.mmc: XXX: setting clk to 400000, rounded 400000
[    2.019479] sunxi-mmc 1c11000.mmc: XXX: setting clk to 400000, rounded 400000
[    2.039144] sunxi-mmc 1c11000.mmc: XXX: setting clk to 400000, rounded 400000
[    2.047129] sunxi-mmc 1c11000.mmc: XXX: setting clk to 400000, rounded 400000
[    2.054324] sunxi-mmc 1c11000.mmc: XXX: setting clk to 400000, rounded 400000
[    2.064481] sunxi-mmc 1c11000.mmc: XXX: setting clk to 400000, rounded 400000
[    2.091624] sunxi-mmc 1c11000.mmc: XXX: setting clk to 400000, rounded 400000
[    2.168067] sunxi-mmc 1c11000.mmc: XXX: setting clk to 400000, rounded 400000
[    2.188239] sunxi-mmc 1c11000.mmc: XXX: setting clk to 52000000, rounded 51200000
[    2.202779] sunxi-mmc 1c11000.mmc: XXX: setting clk to 52000000, rounded 51200000
[    2.210817] sunxi-mmc 1c11000.mmc: XXX: setting clk to 52000000, rounded 51200000
[    5.103358] sunxi-mmc 1c11000.mmc: XXX: setting clk to 52000000, rounded 51200000
[    8.950237] sunxi-mmc 1c11000.mmc: XXX: setting clk to 52000000, rounded 51200000
[    9.376201] sunxi-mmc 1c11000.mmc: XXX: setting clk to 52000000, rounded 51200000
[  113.618387] sunxi-mmc 1c11000.mmc: XXX: setting clk to 52000000, rounded 51200000
[  113.707979] EXT4-fs (mmcblk1p4): recovery complete
[  113.728162] EXT4-fs (mmcblk1p4): mounted filesystem with ordered data mode. Opts: (null)
[/snip]

And clock tree:
[snip]
pll-ddr-base                   2        2        0   768000000          0     0  50000
   pll-ddr-other               1        1        0   768000000          0     0  50000
      mmc2                     0        0        0    51200000          0     0  50000
         mmc2_sample           0        0        0    51200000          0   120  50000
         mmc2_output           0        0        0    51200000          0    72  50000
[/snip]


> 
> Just wondering what it should be.
> 
> Best regards,
> Jernej
> 
> > 
> > > Best regards,
> > > Jernej
> > > 
> > > > $ git bisect log
> > > > git bisect start
> > > > # good: [3df407b2a5346db1c48809706ece7a8616c79e0b] mmc:
> > > > dw_mmc-bluefield:
> > > > simplify the probe() function git bisect good
> > > > 3df407b2a5346db1c48809706ece7a8616c79e0b
> > > > # bad: [00d59fde8532b2d42e80909d2e58678755e04da9] Merge tag 'mmc-v4.21'
> > > > of
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc git bisect bad
> > > > 00d59fde8532b2d42e80909d2e58678755e04da9
> > > > # good: [01e421feec0817bb3141eaae4c517410d193d440] Merge branch 'fixes'
> > > > into next git bisect good 01e421feec0817bb3141eaae4c517410d193d440
> > > > # bad: [1eefdec18eded41833401cfd64749643ff72e7da] Merge branch
> > > > 'locking-core-for-linus' of
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip git bisect bad
> > > > 1eefdec18eded41833401cfd64749643ff72e7da
> > > > # good: [eaa76499711535fd64d747cc4ef0d78ab0fd41c6] Merge tag
> > > > 'mtd/for-4.21'
> > > > of git://git.infradead.org/linux-mtd git bisect good
> > > > eaa76499711535fd64d747cc4ef0d78ab0fd41c6
> > > > # good: [4e4390ad067a61ce4e7607bd0df31f19a4caa36a] Merge tag
> > > > 'leds-for-4.21-rc1' of
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds
> > > > git
> > > > bisect good 4e4390ad067a61ce4e7607bd0df31f19a4caa36a
> > > > # bad: [c2f1f3e0e17d94ab0c66d83e669492cb9e9a3698] Merge
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next git
> > > > bisect
> > > > bad c2f1f3e0e17d94ab0c66d83e669492cb9e9a3698
> > > > # bad: [e4b99d415c3908581d4703203e1e805f043a3e71] Merge branch
> > > > 'irq-core-for-linus' of
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip git bisect bad
> > > > e4b99d415c3908581d4703203e1e805f043a3e71
> > > > # bad: [ffe05540d18013db62c43627836a3638e9a2c7aa] Merge branches
> > > > 'clk-renesas', 'clk-allwinner', 'clk-tegra', 'clk-meson' and
> > > > 'clk-rockchip'
> > > > into clk-next git bisect bad ffe05540d18013db62c43627836a3638e9a2c7aa
> > > > # good: [1a501c8defe950571316d5ddd917bf44f5ed7bd4] Merge branches
> > > > 'clk-managed-registration', 'clk-spdx', 'clk-remove-basic' and
> > > > 'clk-ops-const' into clk-next git bisect good
> > > > 1a501c8defe950571316d5ddd917bf44f5ed7bd4
> > > > # good: [e74581b79ddd9b49b8c61e2791fc4dffc0245afb] Merge tag
> > > > 'meson-clk-4.21-2' of https://github.com/BayLibre/clk-meson into
> > > > clk-meson
> > > > git bisect good e74581b79ddd9b49b8c61e2791fc4dffc0245afb
> > > > # good: [60baf75e3f5b76043c25328ac0c5320aaef5ea41] Merge tag
> > > > 'clk-renesas-for-v4.21-tag2' of
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into
> > > > clk-renesas git bisect good 60baf75e3f5b76043c25328ac0c5320aaef5ea41
> > > > # bad: [a41f85b6017ee20952a60e4330bcae2527fe2c2a] Merge tag
> > > > 'sunxi-clk-for-4.21' of
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into
> > > > clk-allwinner git bisect bad a41f85b6017ee20952a60e4330bcae2527fe2c2a
> > > > # bad: [ee678706e46d0d185c27cc214ad97828e0643159] clk: sunxi-ng: a64:
> > > > Fix
> > > > gate bit of DSI DPHY git bisect bad
> > > > ee678706e46d0d185c27cc214ad97828e0643159
> > > > # bad: [65b6657672388b72822e0367f06d41c1e3ffb5bb] clk: sunxi-ng: Use u64
> > > > for calculation of NM rate git bisect bad
> > > > 65b6657672388b72822e0367f06d41c1e3ffb5bb
> > > > # good: [db7548934603d9eda12649dff97ea5c29884405d] clk: sunxi-ng:
> > > > sun50i:
> > > > h6: Fix MMC clock mux width git bisect good
> > > > db7548934603d9eda12649dff97ea5c29884405d
> > > > # bad: [3f790433c3cb27ecaf2ca0e07ac25964e4fd9f15] clk: sunxi-ng: Adjust
> > > > MP
> > > > clock parent rate when allowed git bisect bad
> > > > 3f790433c3cb27ecaf2ca0e07ac25964e4fd9f15
> > > > # first bad commit: [3f790433c3cb27ecaf2ca0e07ac25964e4fd9f15] clk:
> > > > sunxi-ng: Adjust MP clock parent rate when allowed
> > > > 
> > > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > > ---
> > > > > 
> > > > >  drivers/clk/sunxi-ng/ccu_mp.c | 64
> > > > >  +++++++++++++++++++++++++++++++++--
> > > > >  1 file changed, 62 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/clk/sunxi-ng/ccu_mp.c
> > > > > b/drivers/clk/sunxi-ng/ccu_mp.c
> > > > > index 5d0af4051737..0357349eb767 100644
> > > > > --- a/drivers/clk/sunxi-ng/ccu_mp.c
> > > > > +++ b/drivers/clk/sunxi-ng/ccu_mp.c
> > > > > @@ -40,6 +40,61 @@ static void ccu_mp_find_best(unsigned long parent,
> > > > > unsigned long rate,>
> > > > > 
> > > > >  	*p = best_p;
> > > > >  
> > > > >  }
> > > > > 
> > > > > +static unsigned long ccu_mp_find_best_with_parent_adj(struct clk_hw
> > > > > *hw,
> > > > > +
> > > 
> > > unsigned long *parent,
> > > 
> > > > > +
> > > 
> > > unsigned long rate,
> > > 
> > > > > +
> > > 
> > > unsigned int max_m,
> > > 
> > > > > +
> > > 
> > > unsigned int max_p)
> > > 
> > > > > +{
> > > > > +	unsigned long parent_rate_saved;
> > > > > +	unsigned long parent_rate, now;
> > > > > +	unsigned long best_rate = 0;
> > > > > +	unsigned int _m, _p, div;
> > > > > +	unsigned long maxdiv;
> > > > > +
> > > > > +	parent_rate_saved = *parent;
> > > > > +
> > > > > +	/*
> > > > > +	 * The maximum divider we can use without overflowing
> > > > > +	 * unsigned long in rate * m * p below
> > > > > +	 */
> > > > > +	maxdiv = max_m * max_p;
> > > > > +	maxdiv = min(ULONG_MAX / rate, maxdiv);
> > > > > +
> > > > > +	for (_p = 1; _p <= max_p; _p <<= 1) {
> > > > > +		for (_m = 1; _m <= max_m; _m++) {
> > > > > +			div = _m * _p;
> > > > > +
> > > > > +			if (div > maxdiv)
> > > > > +				break;
> > > > > +
> > > > > +			if (rate * div == parent_rate_saved) {
> > > > > +				/*
> > > > > +				 * It's the most ideal case if
> > > 
> > > the requested
> > > 
> > > > > +				 * rate can be divided from
> > > 
> > > parent clock without
> > > 
> > > > > +				 * needing to change parent 
> rate,
> > > 
> > > so return the
> > > 
> > > > > +				 * divider immediately.
> > > > > +				 */
> > > > > +				*parent = parent_rate_saved;
> > > > > +				return rate;
> > > > > +			}
> > > > > +
> > > > > +			parent_rate = clk_hw_round_rate(hw, rate *
> > > 
> > > div);
> > > 
> > > > > +			now = parent_rate / div;
> > > > > +
> > > > > +			if (now <= rate && now > best_rate) {
> > > > > +				best_rate = now;
> > > > > +				*parent = parent_rate;
> > > > > +
> > > > > +				if (now == rate)
> > > > > +					return rate;
> > > > > +			}
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	return best_rate;
> > > > > +}
> > > > > +
> > > > > 
> > > > >  static unsigned long ccu_mp_round_rate(struct ccu_mux_internal *mux,
> > > > >  
> > > > >  				       struct clk_hw *hw,
> > > > >  				       unsigned long
> > > 
> > > *parent_rate,
> > > 
> > > > > @@ -56,8 +111,13 @@ static unsigned long ccu_mp_round_rate(struct
> > > > > ccu_mux_internal *mux,>
> > > > > 
> > > > >  	max_m = cmp->m.max ?: 1 << cmp->m.width;
> > > > >  	max_p = cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
> > > > > 
> > > > > -	ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m, &p);
> > > > > -	rate = *parent_rate / p / m;
> > > > > +	if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
> > > > > +		ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m,
> > > 
> > > &p);
> > > 
> > > > > +		rate = *parent_rate / p / m;
> > > > > +	} else {
> > > > > +		rate = ccu_mp_find_best_with_parent_adj(hw, 
> parent_rate,
> > > 
> > > rate,
> > > 
> > > > > +
> > > 
> > > max_m, max_p);
> > > 
> > > > > +	}
> > > > > 
> > > > >  	if (cmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
> > > > >  	
> > > > >  		rate /= cmp->fixed_post_div;
> 
> 
> 
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
