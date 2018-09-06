Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B941C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38D12075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38D12075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeIFQtU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:49:20 -0400
Received: from [195.159.176.226] ([195.159.176.226]:54818 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbeIFQtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:49:20 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1fxt8c-0008Hp-VX
        for linux-kernel@vger.kernel.org; Thu, 06 Sep 2018 14:11:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Marcel Ziswiler <marcel@ziswiler.com>
Subject: Re: [PATCH v2 2/2] clk: tegra20: Enable lock-status polling for PLLs
Date:   Thu, 06 Sep 2018 14:13:37 +0200
Message-ID: <1536236017.25080.8.camel@ziswiler.com>
References: <20180830184210.5369-1-digetx@gmail.com>
         <20180830184210.5369-2-digetx@gmail.com>
         <20180831092948.GP1636@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Complaints-To: usenet@blaine.gmane.org
In-Reply-To: <20180831092948.GP1636@tbergstrom-lnx.Nvidia.com>
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-31 at 12:29 +0300, Peter De Schrijver wrote:
> On Thu, Aug 30, 2018 at 09:42:10PM +0300, Dmitry Osipenko wrote:
> > Currently all PLL's on Tegra20 use a hardcoded delay despite of
> > having
> > a lock-status bit. The lock-status polling was disabled ~7 years
> > ago
> > because PLLE was failing to lock and was a suspicion that other
> > PLLs
> > might be faulty too. Other PLLs are okay, hence enable the lock-
> > status
> > polling for them. This reduces delay of any operation that require
> > PLL
> > to lock.
> > 
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> > 
> > Changelog:
> > 
> > v2:	Don't enable polling for PLLE as it known to not being
> > able to lock.
> > 
> 
> This isn't correct. The lock bit of PLLE can declare lock too early,
> but the
> PLL itself does lock.

Is there an errata documenting this? As I could not really find any
mentioning of this anywhere at least up to the v11 from Dec 21, 2010 I
still have access to.

BTW: It looks like also PLLA may not always lock properly with those
changes. Is there anything known about that as well? Here is what I get
on various Colibri T20 modules (while random other ones seem to work
fine):

[    0.232591] clk_pll_wait_for_lock: Timed out waiting for pll pll_a
lock
[    0.232614] tegra_init_from_table: Failed to enable pll_a
[    0.232627] ------------[ cut here ]------------
[    0.232655] WARNING: CPU: 0 PID: 1 at
/run/media/zim/Build/Sources/linux-next.git/drivers/clk/tegra/clk.c:285 
tegra_init_from_table+0x168/0x174
[    0.232676] Modules linked in:
[    0.232696] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc2-
next-20180903-00214-g5618a0514cf1-dirty #183
[    0.232714] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[    0.232753] [<c0113644>] (unwind_backtrace) from [<c010dc0c>]
(show_stack+0x10/0x14)
[    0.232783] [<c010dc0c>] (show_stack) from [<c0aa66f4>]
(dump_stack+0x8c/0xa0)
[    0.232808] [<c0aa66f4>] (dump_stack) from [<c0125428>]
(__warn+0xe0/0xf8)
[    0.232828] [<c0125428>] (__warn) from [<c0125558>]
(warn_slowpath_null+0x40/0x48)
[    0.232849] [<c0125558>] (warn_slowpath_null) from [<c0f2f284>]
(tegra_init_from_table+0x168/0x174)
[    0.232874] [<c0f2f284>] (tegra_init_from_table) from [<c0f2f03c>]
(tegra_clocks_apply_init_table+0x1c/0x2c)
[    0.232901] [<c0f2f03c>] (tegra_clocks_apply_init_table) from
[<c0102fa0>] (do_one_initcall+0x54/0x278)
[    0.232926] [<c0102fa0>] (do_one_initcall) from [<c0f01128>]
(kernel_init_freeable+0x2c0/0x354)
[    0.232949] [<c0f01128>] (kernel_init_freeable) from [<c0abb1f0>]
(kernel_init+0x8/0x10c)
[    0.232970] [<c0abb1f0>] (kernel_init) from [<c01010e8>]
(ret_from_fork+0x14/0x2c)
[    0.232987] Exception stack(0xc4c8ffb0 to 0xc4c8fff8)
[    0.233001] ffa0:                                     00000000
00000000 00000000 00000000
[    0.233021] ffc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    0.233040] ffe0: 00000000 00000000 00000000 00000000 00000013
00000000
[    0.233059] ---[ end trace 3f40fa49530610b9 ]---

> >  drivers/clk/tegra/clk-tegra20.c | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/clk/tegra/clk-tegra20.c
> > b/drivers/clk/tegra/clk-tegra20.c
> > index cc857d4d4a86..cfde3745a0db 100644
> > --- a/drivers/clk/tegra/clk-tegra20.c
> > +++ b/drivers/clk/tegra/clk-tegra20.c
> > @@ -298,7 +298,8 @@ static struct tegra_clk_pll_params pll_c_params
> > = {
> >  	.lock_enable_bit_idx = PLL_MISC_LOCK_ENABLE,
> >  	.lock_delay = 300,
> >  	.freq_table = pll_c_freq_table,
> > -	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
> > +	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
> > +		 TEGRA_PLL_USE_LOCK,
> >  };
> >  
> >  static struct tegra_clk_pll_params pll_m_params = {
> > @@ -314,7 +315,8 @@ static struct tegra_clk_pll_params pll_m_params
> > = {
> >  	.lock_enable_bit_idx = PLL_MISC_LOCK_ENABLE,
> >  	.lock_delay = 300,
> >  	.freq_table = pll_m_freq_table,
> > -	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
> > +	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
> > +		 TEGRA_PLL_USE_LOCK,
> >  };
> >  
> >  static struct tegra_clk_pll_params pll_p_params = {
> > @@ -331,7 +333,7 @@ static struct tegra_clk_pll_params pll_p_params
> > = {
> >  	.lock_delay = 300,
> >  	.freq_table = pll_p_freq_table,
> >  	.flags = TEGRA_PLL_FIXED | TEGRA_PLL_HAS_CPCON |
> > -		 TEGRA_PLL_HAS_LOCK_ENABLE,
> > +		 TEGRA_PLL_HAS_LOCK_ENABLE | TEGRA_PLL_USE_LOCK,
> >  	.fixed_rate =  216000000,
> >  };
> >  
> > @@ -348,7 +350,8 @@ static struct tegra_clk_pll_params pll_a_params
> > = {
> >  	.lock_enable_bit_idx = PLL_MISC_LOCK_ENABLE,
> >  	.lock_delay = 300,
> >  	.freq_table = pll_a_freq_table,
> > -	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
> > +	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
> > +		 TEGRA_PLL_USE_LOCK,
> >  };
> >  
> >  static struct tegra_clk_pll_params pll_d_params = {
> > @@ -364,7 +367,8 @@ static struct tegra_clk_pll_params pll_d_params
> > = {
> >  	.lock_enable_bit_idx = PLLDU_MISC_LOCK_ENABLE,
> >  	.lock_delay = 1000,
> >  	.freq_table = pll_d_freq_table,
> > -	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
> > +	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
> > +		 TEGRA_PLL_USE_LOCK,
> >  };
> >  
> >  static const struct pdiv_map pllu_p[] = {
> > @@ -387,7 +391,8 @@ static struct tegra_clk_pll_params pll_u_params
> > = {
> >  	.lock_delay = 1000,
> >  	.pdiv_tohw = pllu_p,
> >  	.freq_table = pll_u_freq_table,
> > -	.flags = TEGRA_PLLU | TEGRA_PLL_HAS_CPCON |
> > TEGRA_PLL_HAS_LOCK_ENABLE,
> > +	.flags = TEGRA_PLLU | TEGRA_PLL_HAS_CPCON |
> > TEGRA_PLL_HAS_LOCK_ENABLE |
> > +		 TEGRA_PLL_USE_LOCK,
> >  };
> >  
> >  static struct tegra_clk_pll_params pll_x_params = {
> > @@ -403,7 +408,8 @@ static struct tegra_clk_pll_params pll_x_params
> > = {
> >  	.lock_enable_bit_idx = PLL_MISC_LOCK_ENABLE,
> >  	.lock_delay = 300,
> >  	.freq_table = pll_x_freq_table,
> > -	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
> > +	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
> > +		 TEGRA_PLL_USE_LOCK,
> >  };
> >  
> >  static struct tegra_clk_pll_params pll_e_params = {
> > -- 
> > 2.18.0

