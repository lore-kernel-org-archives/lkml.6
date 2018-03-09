Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbeCIGTo convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 01:19:44 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:56070 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750848AbeCIGTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 01:19:40 -0500
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: =?utf-8?B?T25kxZllag==?= Jirman <megi@xff.cz>
Cc: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH v3 06/16] drm/sun4i: Release exclusive clock lock when disabling TCON
Date: Fri, 09 Mar 2018 07:19:33 +0100
Message-ID: <2311763.nDsHW3lYFU@jernej-laptop>
In-Reply-To: <20180309004455.5s2ohse4jpwinre5@core.my.home>
References: <20180301213442.16677-1-jernej.skrabec@siol.net> <20180309001314.bu3zcv5gyqsc52fx@core.my.home> <20180309004455.5s2ohse4jpwinre5@core.my.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dne petek, 09. marec 2018 ob 01:44:55 CET je Ondřej Jirman napisal(a):
> Hi,
> 
> I've debugged this further and it seems that the code has incorrect
> assumptions. See docs for mode_set_nofb.
> 
> https://elixir.bootlin.com/linux/v4.16-rc4/source/include/drm/drm_modeset_he
> lper_vtables.h#L209
>

Does this happen with https://github.com/jernejsk/linux-1/tree/h3_hdmi_v3 ?

I also tested running X, but I don't remember having the issue.
 
> I've added traces to a few functions that call clk_.*exclusive.*()
> functions, and I see this after a few restarts of Xorg server:
> 
> [    0.783842] *** sun4i_tcon1_mode_set()
> [    0.783886] *** sun4i_tcon_channel_set_status(..., 1, true)
> [    6.881690] *** sun4i_tcon_channel_set_status(..., 1, false)
> [    6.881758] *** sun4i_tcon_channel_set_status(..., 1, true)
> [   52.335085] *** sun4i_tcon_channel_set_status(..., 1, false)
> [   52.335343] *** sun4i_tcon_channel_set_status(..., 1, true)
> [   68.921079] *** sun4i_tcon_channel_set_status(..., 1, false)
> [   68.921337] *** sun4i_tcon_channel_set_status(..., 1, true)
> 
> mode_set_nofb is called just once, yet sun4i_tcon_channel_set_status(..., 1,
> false) is called multiple times, which leads to unbalanced calls to
> clk_set_rate_exclusive and clk_rate_exclusive_put.
> 
> I don't know how to fix this.

Since there is no function to check if clock is protected, flag can be 
introduced within TCON which is set when clock rate is protected and unset 
when it is unprotected. That way we could track if clk_rate_exclusive_put() 
needs to be called or not.

Best regards,
Jernej

> 
> regards,
>   o.
> 
> On Fri, Mar 09, 2018 at 01:13:14AM +0100, 'Ondřej Jirman' via linux-sunxi 
wrote:
> > Hi Jernej,
> > 
> > On Thu, Mar 08, 2018 at 11:57:40PM +0100, Jernej Škrabec wrote:
> > > Hi,
> > > 
> > > Dne četrtek, 08. marec 2018 ob 23:47:17 CET je Ondřej Jirman napisal(a):
> > > > Hi,
> > > > 
> > > > On Thu, Mar 01, 2018 at 10:34:32PM +0100, Jernej Skrabec wrote:
> > > > > Currently exclusive TCON clock lock is never released, which, for
> > > > > example, prevents changing resolution on HDMI.
> > > > > 
> > > > > In order to fix that, release clock when disabling TCON. TCON is
> > > > > always
> > > > > disabled first before new mode is set.
> > > > > 
> > > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > > ---
> > > > > 
> > > > >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 6 ++++--
> > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > > b/drivers/gpu/drm/sun4i/sun4i_tcon.c index
> > > > > 1d714c06ec9d..7f6c4125c89f
> > > > > 100644
> > > > > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > > @@ -102,10 +102,12 @@ static void
> > > > > sun4i_tcon_channel_set_status(struct
> > > > > sun4i_tcon *tcon, int channel,>
> > > > > 
> > > > >  		return;
> > > > >  	
> > > > >  	}
> > > > > 
> > > > > -	if (enabled)
> > > > > +	if (enabled) {
> > > > > 
> > > > >  		clk_prepare_enable(clk);
> > > > > 
> > > > > -	else
> > > > > +	} else {
> > > > > +		clk_rate_exclusive_put(clk);
> > > > > 
> > > > >  		clk_disable_unprepare(clk);
> > > > > 
> > > > > +	}
> > > > > 
> > > > >  }
> > > > 
> > > > At least in the linux-next/master I can't see clk_rate_exclusive_get 
call:
> > > It is in drm-misc/drm-misc-fixes:
> > > https://cgit.freedesktop.org/drm/drm-misc/commit/?h=drm-misc-fixes&id=79
> > > d103a565d16b1893d990b2ee5e0fe71767759f
> > > 
> > > My patch is also applied in same branch, so there should be no issues
> > > while
> > > merging all those branches.
> > > 
> > > linux-next doesn't have either patches currently:
> > > https://git.kernel.org/pub/
> > > scm/linux/kernel/git/next/linux-next.git/log/drivers/gpu/drm/sun4i
> > > 
> > > This is issue only if you manually apply one patch without the other.
> > 
> > I have (and had) both patches applied. There's perhaps some code path,
> > where sun4i_tcon_channel_set_status(..., false) is called in unbalanced
> > way with regards to clk_set_rate_exclusive().
> > 
> > The issue occurs when starting Xorg. But Xorg works fine.
> > 
> > regards,
> > 
> >   o.
> >   
> > > Best regards,
> > > Jernej
> > > 
> > > > $ git grep 'exclusive' linux-next/master -- drivers/gpu/drm/sun4i
> > > > 
> > > > linux-next/master:sun4i_hdmi.h:    * On sun5i the threshold is
> > > > exclusive,
> > > > i.e. does not include, linux-next/master:sun4i_tcon.c:
> > > > clk_rate_exclusive_put(clk); linux-next/master:sun4i_tcon.c:
> > > > clk_set_rate_exclusive(tcon->dclk, mode->crtc_clock * 1000);
> > > > linux-next/master:sun4i_tcon.c:   clk_set_rate_exclusive(tcon->sclk1,
> > > > mode->crtc_clock * 1000);
> > > > 
> > > > and the kernel complains too:
> > > > 
> > > > [  841.915161] ------------[ cut here ]------------
> > > > [  841.915187] WARNING: CPU: 0 PID: 273 at
> > > > /workspace/megous.com/orangepi-pc/linux-4.16/drivers/clk/clk.c:608
> > > > clk_rate_exclusive_put+0x48/0x4c [  841.915194] CPU: 0 PID: 273 Comm:
> > > > Xorg
> > > > Not tainted 4.16.0-rc4-00268-gbac2ecf73ed0 #13 [  841.915196] Hardware
> > > > name: Allwinner sun8i Family
> > > > [  841.915217] [<c0228440>] (unwind_backtrace) from [<c0225b90>]
> > > > (show_stack+0x10/0x14) [  841.915228] [<c0225b90>] (show_stack) from
> > > > [<c0b094bc>] (dump_stack+0x88/0x9c) [  841.915237] [<c0b094bc>]
> > > > (dump_stack) from [<c0240294>] (__warn+0xd4/0xf0) [  841.915244]
> > > > [<c0240294>] (__warn) from [<c0240380>] (warn_slowpath_null+0x40/0x48)
> > > > [
> > > > 841.915250] [<c0240380>] (warn_slowpath_null) from [<c0619b6c>]
> > > > (clk_rate_exclusive_put+0x48/0x4c) [  841.915261] [<c0619b6c>]
> > > > (clk_rate_exclusive_put) from [<c0694624>]
> > > > (sun4i_tcon_set_status+0x178/0x2f0) [  841.915269] [<c0694624>]
> > > > (sun4i_tcon_set_status) from [<c06930c0>]
> > > > (sun4i_crtc_atomic_disable+0x7c/0xe4) [  841.915279] [<c06930c0>]
> > > > (sun4i_crtc_atomic_disable) from [<c06637fc>]
> > > > (drm_atomic_helper_commit_modeset_disables+0x390/0x46c) [  841.915288]
> > > > [<c06637fc>] (drm_atomic_helper_commit_modeset_disables) from
> > > > [<c0664df4>]
> > > > (drm_atomic_helper_commit_tail_rpm+0x18/0x64) [  841.915295]
> > > > [<c0664df4>]
> > > > (drm_atomic_helper_commit_tail_rpm) from [<c0664da8>]
> > > > (commit_tail+0x40/0x6c) [  841.915302] [<c0664da8>] (commit_tail) from
> > > > [<c06652b0>] (drm_atomic_helper_commit+0xbc/0x128) [  841.915311]
> > > > [<c06652b0>] (drm_atomic_helper_commit) from [<c0668d40>]
> > > > (restore_fbdev_mode_atomic+0x100/0x1fc) [  841.915319] [<c0668d40>]
> > > > (restore_fbdev_mode_atomic) from [<c0668f1c>]
> > > > (drm_fb_helper_dpms+0x50/0x130) [  841.915328] [<c0668f1c>]
> > > > (drm_fb_helper_dpms) from [<c0669e9c>] (drm_fb_helper_blank+0x54/0x90)
> > > > [
> > > > 841.915337] [<c0669e9c>] (drm_fb_helper_blank) from [<c06088cc>]
> > > > (fb_blank+0x54/0xa8) [  841.915343] [<c06088cc>] (fb_blank) from
> > > > [<c0608c80>] (do_fb_ioctl+0x360/0x62c) [  841.915351] [<c0608c80>]
> > > > (do_fb_ioctl) from [<c0362648>] (do_vfs_ioctl+0x9c/0x774) [ 
> > > > 841.915358]
> > > > [<c0362648>] (do_vfs_ioctl) from [<c0362d54>] (SyS_ioctl+0x34/0x58) [
> > > > 841.915364] [<c0362d54>] (SyS_ioctl) from [<c0201120>]
> > > > (ret_fast_syscall+0x0/0x4c) [  841.915368] Exception stack(0xe5fc5fa8
> > > > to
> > > > 0xe5fc5ff0)
> > > > [  841.915373] 5fa0:                   00674f10 00675460 0000000b
> > > > 00004611
> > > > 00000001 00000000 [  841.915379] 5fc0: 00674f10 00675460 00000001
> > > > 00000036
> > > > 00650474 00000000 006504a4 00675df8 [  841.915382] 5fe0: b61a502c
> > > > be8acb2c
> > > > b6192c38 b6b152ec
> > > > [  841.915386] ---[ end trace fa81b956197707f8 ]---
> > > > 
> > > > It looks like clk_rate_exclusive_put inside
> > > > sun4i_tcon_channel_set_status is called without first calling some
> > > > function that would call
> > > > clk_set_rate_exclusive, leading to unbalanced get/put calls.
> > > > 
> > > > regards,
> > > > 
> > > >   o.
> > > >   
> > > > >  static void sun4i_tcon_lvds_set_status(struct sun4i_tcon *tcon,
> > > > > 
> > > > > --
> > > > > 2.16.2
> > > > > 
> > > > > --
> > > > > You received this message because you are subscribed to the Google
> > > > > Groups
> > > > > "linux-sunxi" group. To unsubscribe from this group and stop
> > > > > receiving
> > > > > emails from it, send an email to
> > > > > linux-sunxi+unsubscribe@googlegroups.com. For more options, visit
> > > > > https://groups.google.com/d/optout.
> > > 
> > > --
> > > You received this message because you are subscribed to the Google
> > > Groups "linux-sunxi" group. To unsubscribe from this group and stop
> > > receiving emails from it, send an email to
> > > linux-sunxi+unsubscribe@googlegroups.com. For more options, visit
> > > https://groups.google.com/d/optout.
> > 
> > --
> > You received this message because you are subscribed to the Google Groups
> > "linux-sunxi" group. To unsubscribe from this group and stop receiving
> > emails from it, send an email to
> > linux-sunxi+unsubscribe@googlegroups.com. For more options, visit
> > https://groups.google.com/d/optout.
