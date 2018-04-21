Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753339AbeDUULn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 16:11:43 -0400
Received: from avasout06.plus.net ([212.159.14.18]:46024 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753192AbeDUULl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 16:11:41 -0400
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fL8XI6Se c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10 a=IGXwa3FO1arsD67qNjIA:9 a=CjuIK1q_8ugA:10
Date: Sat, 21 Apr 2018 21:11:37 +0100
From: Nick Dyer <nick@shmanahar.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Ezequiel Garcia <ezequiel@collabora.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] Input: atmel_mxt_ts - fix reset-gpio for level based irqs
Message-ID: <20180421201137.fyr6eqzjuob765ie@hairyalien>
References: <20180420172408.26164-1-sebastian.reichel@collabora.co.uk>
 <7b4976b0a8a642767bd4e0a5e9d7fb6c9dc86ec9.camel@collabora.com>
 <20180420194207.i2zo235duknjsjjd@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420194207.i2zo235duknjsjjd@earth.universe>
User-Agent: NeoMutt/20170609 (1.8.3)
X-CMAE-Envelope: MS4wfDUn01I+f2Zc8zUU1Ia2n++amZfxXikIqBUe3ZG+BDxszyjkBYShftVlbHiplstxIBsZZXjyRJBFLNhH5B2znZJyIWfxka2j0f0V01u/RTV08KmSZFG5
 OuxKkMk0i8i8cuQnc78IEnJKqihkudXzCW4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 09:42:07PM +0200, Sebastian Reichel wrote:
> On Fri, Apr 20, 2018 at 02:44:02PM -0300, Ezequiel Garcia wrote:
> > Hi Sebastian,
> > 
> > On Fri, 2018-04-20 at 19:24 +0200, Sebastian Reichel wrote:
> > > The current reset-gpio support triggers an interrupt storm on platforms
> > > using the maxtouch with level based interrupt. The Motorola Droid 4,
> > > which I used for some of the tests is not affected, since it uses a level
> > > based interrupt.
> > > 
> > 
> > I found this confusing. Interrupt storm happen with level-based interrupts,
> > but the Droid4 is not affected?

Can I ask what happens during the interrupt storm. Are you getting lots
of the "failed to read T44 and T5" message, or something else?

> > > This change avoids the interrupt storm by enabling the device while
> > > its interrupt is disabled. The following mxt_initialize() requires,
> > > that the device is responsive (at least mxt224E is unresponsive for
> > > ~22ms), so we wait some time. We don't wait for leaving bootloader
> > > mode anymore, since mxt_initialize() checks for it anyways.
> > > 
> > 
> > IMHO, having some more or less arbritrary sleeps is almost
> > always a problem. This value might be enough for some platform,
> > might be too short for some other, and then it might get too large
> > for someone else.
> 
> The 22ms chip-being-unresponsive are not newly introduced. The
> same 22ms are also required for soft-reset. I did introduce a
> new time (MXT_RESET_GPIO_TIME) for the "chip being reset" state,
> since my randomly chosen 200ms from before were exaggerated
> considering all mxt datasheets I checked stated only a few nano
> seconds.

According to the data sheets there is a period after a reset where the
CHG line is temporarily set as an input, during which the host should
ignore it. If you don't, you might get a stray interrupt and try and
communicate with the device, which might leave it in a bad state. I
think you mentioned that later in your email.

The reset time varies per chip, but the 100ms in mxt_soft_reset() was
based on discussions with app support at Atmel, so should be correct in
most cases.
