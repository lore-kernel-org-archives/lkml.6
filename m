Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA74C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2772085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="GmwoFhY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfAUNej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:34:39 -0500
Received: from plaes.org ([188.166.43.21]:38522 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728648AbfAUNei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:34:38 -0500
Received: from plaes.org (localhost [127.0.0.1])
        by plaes.org (Postfix) with ESMTPSA id 390F640220;
        Mon, 21 Jan 2019 13:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1548077674; bh=bMQZvsD9R61G9HN+jUt2Ub5WZ8DnEcp+hYzzEgzQ9sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GmwoFhY+G/IZeCMZSH7DePP69qqqDzul1xPf2eT8KJRc7ZdZEyxlNvWSknwQgduGQ
         d/H/6V5QpwYxLGTjOOUiZXvkGz+FrbaAHvqi+RYa2vAXW7q30ODX44wMHu5odvOghJ
         EMuTJ0bdFfulctZ0HMuumCbUVNldXfW1j+LQKMe9IrLF7JNwKLGThfKIIA/LS1GfSe
         de8BxOfY5wcLfJEIbh1nGISVnspJuJIKG+ZEKB23ZUr7rvP7mps5mdRDeBO25khr/s
         8Ib0E9o+y0iNBmSCw/nGFibxut2bkfvASQ9wlrtIMzoqJwV3NRxfVnTWvX1LUAdswZ
         SXQaAuqnK1wDQ==
Date:   Mon, 21 Jan 2019 13:34:33 +0000
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
Message-ID: <20190121133433.lryqz7ivrj5cxu3g@plaes.org>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
 <11550554.k1qAFTnke5@jernej-laptop>
 <20190117072402.ognqxsxewjg3kyyg@plaes.org>
 <3212171.R3YZLKKLtu@jernej-laptop>
 <20190121083729.7qsmj7drxvmnjoye@plaes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190121083729.7qsmj7drxvmnjoye@plaes.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 08:37:29AM +0000, Priit Laes wrote:
> On Fri, Jan 18, 2019 at 10:51:10PM +0100, Jernej Škrabec wrote:
> > Dne četrtek, 17. januar 2019 ob 08:24:02 CET je Priit Laes napisal(a):
> > > On Wed, Jan 16, 2019 at 06:00:32PM +0100, Jernej Škrabec wrote:
> > > > Dne sreda, 16. januar 2019 ob 13:09:58 CET je Priit Laes napisal(a):
> > > > > On Thu, Jan 10, 2019 at 06:10:59PM +0100, Jernej Škrabec wrote:
> > > > > > Dne četrtek, 10. januar 2019 ob 10:15:48 CET je Priit Laes napisal(a):
> > > > > > > On Sun, Nov 04, 2018 at 07:26:39PM +0100, Jernej Skrabec wrote:
> > > > > > > > Currently MP clocks don't consider adjusting parent rate even if
> > > > > > > > they
> > > > > > > > are allowed to do so. Such behaviour considerably lowers amount of
> > > > > > > > possible rates, which is very inconvenient when such clock is used
> > > > > > > > for
> > > > > > > > pixel clock, for example.
> > > > > > > > 
> > > > > > > > In order to improve the situation, adjusting parent rate is
> > > > > > > > considered
> > > > > > > > when allowed.
> > > > > > > > 
> > > > > > > > This code is inspired by clk_divider_bestdiv() function, which
> > > > > > > > does
> > > > > > > > basically the same thing for different clock type.
> > > > > > > 
> > > > > > > This patch seems to break the eMMC support on Olinuxino-Lime2-eMMC
> > > > > > > boards:
> > > > > > > 
> > > > > > > EXT4-fs (mmcblk1p4): INFO: recovery required on readonly filesystem
> > > > > > > EXT4-fs (mmcblk1p4): write access will be enabled during recovery
> > > > > > > sunxi-mmc 1c11000.mmc: data error, sending stop command
> > > > > > > sunxi-mmc 1c11000.mmc: send stop command failed
> > > > > > 
> > > > > > I'm not familiar with A20. What is interesting is that emmc clocks
> > > > > > don't
> > > > > > have CLK_SET_RATE_PARENT flag set, so you shouldn't see any
> > > > > > difference.
> > > > > > 
> > > > > > Can you post content of clk_summary with and without this patch?
> > > > > 
> > > > > In both cases I booted from FEL with rootfs on sdcard and tried to mount
> > > > > partition from eMMC to /mnt. With your patch, last step it fails.
> > > > > 
> > > > > pre-patch working:
> > > > > pll-ddr-other[768MHz] -> mmc2[512MHz]. (For some reason ahb-mmc2 is
> > > > > off?)
> > > > > 
> > > > > post-patch not working:
> > > > > pll-periph[600MHz] ->  mmc2[500Mhz], (ahb-mmc2 is enabled)
> > > > > 
> > > > > Also, attached the logs.
> > > > 
> > > > Thanks. Just one more request. Can you enable debug messages in mmc
> > > > driver?
> > > > I'm interested in output of this line:
> > > > 
> > > > dev_dbg(mmc_dev(mmc), "setting clk to %d, rounded %ld\n",
> > > > 
> > > > 		clock, rate);
> > > 
> > > 1c11000 is eMMC:
> > > [snip]
> > > [    1.961644] sunxi-mmc 1c11000.mmc: setting clk to 400000, rounded 400000
> > > [    2.004091] sunxi-mmc 1c11000.mmc: setting clk to 400000, rounded 400000
> > > [    2.020296] sunxi-mmc 1c11000.mmc: setting clk to 400000, rounded 400000
> > > [    2.039917] sunxi-mmc 1c11000.mmc: setting clk to 400000, rounded 400000
> > > [    2.047847] sunxi-mmc 1c11000.mmc: setting clk to 400000, rounded 400000
> > > [    2.055053] sunxi-mmc 1c11000.mmc: setting clk to 400000, rounded 400000
> > > [    2.065256] sunxi-mmc 1c11000.mmc: setting clk to 400000, rounded 400000
> > > [    2.092351] sunxi-mmc 1c11000.mmc: setting clk to 400000, rounded 400000
> > > [    2.168725] sunxi-mmc 1c11000.mmc: setting clk to 400000, rounded 400000
> > > [    2.189403] sunxi-mmc 1c11000.mmc: setting clk to 52000000, rounded
> > > 52000000 [    2.203340] sunxi-mmc 1c11000.mmc: setting clk to 52000000,
> > > rounded 52000000 [    2.211412] sunxi-mmc 1c11000.mmc: setting clk to
> > > 52000000, rounded 52000000 [    4.967865] sunxi-mmc 1c11000.mmc: setting
> > > clk to 52000000, rounded 52000000 [    8.755345] sunxi-mmc 1c11000.mmc:
> > > setting clk to 52000000, rounded 52000000 [    9.082510] sunxi-mmc
> > > 1c11000.mmc: setting clk to 52000000, rounded 52000000
> > > 
> > > Here I tried to mount partition from eMMC...
> > > 
> > > [   72.167311] sunxi-mmc 1c11000.mmc: setting clk to 52000000, rounded
> > > 52000000 [   72.269629] sunxi-mmc 1c11000.mmc: data error, sending stop
> > > command [   73.268999] sunxi-mmc 1c11000.mmc: send stop command failed
> > > [/snip]
> > > 
> > > And clock tree:
> > > [snip]
> > > pll-periph-base                3        3        0  1200000000          0   
> > >  0  50000 pll-periph                  6        6        0   600000000      
> > >    0     0  50000 mmc2                     3        3        0    50000000 
> > >         0     0  50000 mmc2_sample           1        1        0   
> > > 50000000          0   120  50000 mmc2_output           1        1        0 
> > >   50000000          0    60  50000 ahb                     18       18     
> > >   0   300000000          0     0  50000 ahb-mmc2              1        1   
> > >     0   300000000          0     0  50000 [/snip]
> > > 
> > > 
> > > And without patch:
> > > [snip]
> > > [    2.003341] sunxi-mmc 1c11000.mmc: XXX: setting clk to 400000, rounded
> > > 400000 [    2.019479] sunxi-mmc 1c11000.mmc: XXX: setting clk to 400000,
> > > rounded 400000 [    2.039144] sunxi-mmc 1c11000.mmc: XXX: setting clk to
> > > 400000, rounded 400000 [    2.047129] sunxi-mmc 1c11000.mmc: XXX: setting
> > > clk to 400000, rounded 400000 [    2.054324] sunxi-mmc 1c11000.mmc: XXX:
> > > setting clk to 400000, rounded 400000 [    2.064481] sunxi-mmc 1c11000.mmc:
> > > XXX: setting clk to 400000, rounded 400000 [    2.091624] sunxi-mmc
> > > 1c11000.mmc: XXX: setting clk to 400000, rounded 400000 [    2.168067]
> > > sunxi-mmc 1c11000.mmc: XXX: setting clk to 400000, rounded 400000 [   
> > > 2.188239] sunxi-mmc 1c11000.mmc: XXX: setting clk to 52000000, rounded
> > > 51200000 [    2.202779] sunxi-mmc 1c11000.mmc: XXX: setting clk to
> > > 52000000, rounded 51200000 [    2.210817] sunxi-mmc 1c11000.mmc: XXX:
> > > setting clk to 52000000, rounded 51200000 [    5.103358] sunxi-mmc
> > > 1c11000.mmc: XXX: setting clk to 52000000, rounded 51200000 [    8.950237]
> > > sunxi-mmc 1c11000.mmc: XXX: setting clk to 52000000, rounded 51200000 [   
> > > 9.376201] sunxi-mmc 1c11000.mmc: XXX: setting clk to 52000000, rounded
> > > 51200000 [  113.618387] sunxi-mmc 1c11000.mmc: XXX: setting clk to
> > > 52000000, rounded 51200000 [  113.707979] EXT4-fs (mmcblk1p4): recovery
> > > complete
> > > [  113.728162] EXT4-fs (mmcblk1p4): mounted filesystem with ordered data
> > > mode. Opts: (null) [/snip]
> > > 
> > > And clock tree:
> > > [snip]
> > > pll-ddr-base                   2        2        0   768000000          0   
> > >  0  50000 pll-ddr-other               1        1        0   768000000      
> > >    0     0  50000 mmc2                     0        0        0    51200000 
> > >         0     0  50000 mmc2_sample           0        0        0   
> > > 51200000          0   120  50000 mmc2_output           0        0        0 
> > >   51200000          0    72  50000 [/snip]
> > > 
> > 
> > It seems to me that clock rate is set properly. It's even better than before 
> > since there is no error between wanted and real clock. I bet that if you call 
> > clk_get_rate() directly behind clk_set_rate() in mmc driver, you'll get 
> > correct value.
> > 
> > However, it seems that at some point some other peripheral changes it's parent 
> > clock rate, which inadvertely changes emmc2 clock rate too. The only possible 
> > clock which could interfere is sata. Can you disable driver in you kernel 
> > config and try again?
> 
> OK, tried following things in succession, but SATA disabling does not work:
> 
> a) Marked all ahci stuff in devicetree as disabled
> b) Disable CONFIG_AHCI_SUNXI in kernel
> c) Even disabled SATA stuff in u-boot

But it works, when I allow mmc2 clock to set parent rate:

pll-periph-base                3        3        0   312000000          0     0  50000
   mbus                        1        1        0    78000000          0     0  50000
   pll-periph-sata             1        1        0    26000000          0     0  50000
      sata                     1        1        0    26000000          0     0  50000
   pll-periph                  5        5        0   156000000          0     0  50000
      mmc2                     0        0        0    52000000          0     0  50000
         mmc2_sample           0        0        0    52000000          0   120  50000
         mmc2_output           0        0        0    52000000          0   120  50000
      mmc0                     0        0        0    39000000          0     0  50000
         mmc0_sample           0        0        0    39000000          0    90  50000
         mmc0_output           0        0        0    39000000          0    90  50000


Now, what I don't understand is why the `enable count` does not increase :(

---
diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
index 129ebd2588fd..605e13b4ef90 100644
--- a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
+++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
@@ -498,7 +498,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_clk, "mmc2", mod0_default_parents, 0x090,
                                  16, 2,        /* P */
                                  24, 2,        /* mux */
                                  BIT(31),      /* gate */
-                                 0);
+                                 CLK_SET_RATE_PARENT);
 
 /* MMC output and sample clocks are not present on A10 */
 static SUNXI_CCU_PHASE(mmc2_output_clk, "mmc2_output", "mmc2",


> 
> > 
> > Best regards,
> > Jernej
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
