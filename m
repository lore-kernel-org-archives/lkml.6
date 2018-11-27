Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D6DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05486205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQgD0/EX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05486205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbeK1EvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:51:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbeK1EvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:51:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70054205C9;
        Tue, 27 Nov 2018 17:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543341141;
        bh=rwhmpAWxWWct4bGQuE6jgb/dGuzJ4FR+ekSAgXnWakw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QQgD0/EXpV9hVDZXD+D7w8zOflAxZMZBhbC96jGZeA5nFodeF9rSSGnxR95Rcqwnx
         Me+4LWQIZGVkjgPmQKcoPOPdnKDa3fp2yzUGWoxHx31p8X73OEn/+JW7kZDMukgfTS
         i9SD/xQ018+gaO8Zj5oE8RAd7mTc5wC91h39x/OE=
Date:   Tue, 27 Nov 2018 18:52:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Guenter Roeck <groeck@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v3 8/8] mfd: cros_ec: add a dev_release empty method.
Message-ID: <20181127175219.GA30900@kroah.com>
References: <20181127121849.23975-1-enric.balletbo@collabora.com>
 <20181127121849.23975-9-enric.balletbo@collabora.com>
 <CABXOdTeL6ZC4mfGdU52bkz3-5g-EUL7wMvd-nDjmeBHWM2XSuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTeL6ZC4mfGdU52bkz3-5g-EUL7wMvd-nDjmeBHWM2XSuA@mail.gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 09:29:38AM -0800, Guenter Roeck wrote:
> Hi Enric,
> 
> On Tue, Nov 27, 2018 at 4:19 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > Devices are required to provide a release method. This patch fixes the
> > following WARN():
> >
> > [   47.218707] ------------[ cut here ]------------
> > [   47.223901] Device 'cros_ec' does not have a release() function, it is broken and must be fixed.
> > [   47.234430] WARNING: CPU: 0 PID: 3585 at drivers/base/core.c:895 device_release+0x80/0x90
> > [   47.243560] Modules linked in: btusb btrtl btintel btbcm bluetooth ecdh_generic [...]
> > [   47.323851] CPU: 0 PID: 3585 Comm: rmmod Not tainted 4.20.0-rc2+ #29
> > [   47.330947] Hardware name: Google Kevin (DT)
> > [   47.335714] pstate: 40000005 (nZcv daif -PAN -UAO)
> > [   47.341063] pc : device_release+0x80/0x90
> > [   47.345537] lr : device_release+0x80/0x90
> > [   47.350001] sp : ffff00000b17bc70
> > [   47.353698] x29: ffff00000b17bc70 x28: ffff8000e48e9a80
> > [   47.359629] x27: 0000000000000000 x26: 0000000000000000
> > [   47.365561] x25: 0000000056000000 x24: 0000000000000015
> > [   47.371492] x23: ffff8000f0248060 x22: ffff000000b700a0
> > [   47.377414] x21: ffff8000edf56100 x20: ffff8000edd13028
> > [   47.383346] x19: ffff8000edd13018 x18: 0000000000000095
> > [   47.389278] x17: 0000000000000000 x16: 0000000000000000
> > [   47.395209] x15: 0000000000000400 x14: 0000000000000400
> > [   47.401131] x13: 00000000000001a7 x12: 0000000000000000
> > [   47.407053] x11: 0000000000000001 x10: 0000000000000960
> > [   47.412976] x9 : ffff00000b17b9b0 x8 : ffff8000e48ea440
> > [   47.418898] x7 : ffff8000ee9090c0 x6 : ffff8000f7d0b0b8
> > [   47.424830] x5 : ffff8000f7d0b0b8 x4 : 0000000000000000
> > [   47.430752] x3 : ffff8000f7d11e68 x2 : ffff8000e48e9a80
> > [   47.436674] x1 : 37d859939c964800 x0 : 0000000000000000
> > [   47.442597] Call trace:
> > [   47.445324]  device_release+0x80/0x90
> > [   47.449414]  kobject_put+0x74/0xe8
> > [   47.453210]  device_unregister+0x20/0x30
> > [   47.457592]  ec_device_remove+0x34/0x48 [cros_ec_dev]
> > [   47.463233]  platform_drv_remove+0x28/0x48
> > [   47.467805]  device_release_driver_internal+0x1a8/0x240
> > [   47.473630]  driver_detach+0x40/0x80
> > [   47.477609]  bus_remove_driver+0x54/0xa8
> > [   47.481986]  driver_unregister+0x2c/0x58
> > [   47.486355]  platform_driver_unregister+0x10/0x18
> > [   47.491599]  cros_ec_dev_exit+0x1c/0x258 [cros_ec_dev]
> > [   47.497338]  __arm64_sys_delete_module+0x16c/0x1f8
> > [   47.502689]  el0_svc_common+0x84/0xd8
> > [   47.506776]  el0_svc_handler+0x2c/0x80
> > [   47.510960]  el0_svc+0x8/0xc
> > [   47.514171] ---[ end trace 9087279fc8c03450 ]---
> >
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >
> > Changes in v3: None
> > Changes in v2:
> > - Fix WARN when unloading. This is new in these series.
> >
> >  drivers/mfd/cros_ec_dev.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > index 1ba98a32715e..cdb941c6db98 100644
> > --- a/drivers/mfd/cros_ec_dev.c
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -35,9 +35,14 @@
> >  #define CROS_MAX_DEV 128
> >  static int ec_major;
> >
> > +static void cros_ec_dev_release(struct device *dev)
> > +{
> > +}

Yeah, as part of the in-kernel documentation, I now get to make fun of
you in public!

You did read the documentation, right?

{sigh}

Step back and think about _why_ the kernel is telling you this is not
ok, and ponder the process that came to you that resulted in, "I know,
let me trick the kernel, I know better than it!".  I didn't just put
that warning there for no good reason, I was trying to save yourself
from a major bug.  And here you go working around it, and making that
bug almost impossible to now find.

The kernel told you this, look:

> > [   47.223901] Device 'cros_ec' does not have a release() function, it is broken and must be fixed.

How much more blatent and obvious can I make it in a single sentance
without it being rude?

Anyway, no, this is not what to do.  You have to actually realease the
memory you created for your device in this function.  If you do not do
that, you have a major bug.  Please fix this properly and next time, do
not ignore what the kernel is trying to tell you.

thanks,

greg k-h
