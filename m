Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeCNKew (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 06:34:52 -0400
Received: from salem.gmr.ssr.upm.es ([138.4.36.7]:48362 "EHLO
        salem.gmr.ssr.upm.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbeCNKev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 06:34:51 -0400
Date: Wed, 14 Mar 2018 11:35:38 +0100
From: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC] pwm: Add Xilinx AXI Timer in PWM mode support
Message-ID: <20180314103536.GA8772@salem.gmr.ssr.upm.es>
References: <20170627100522.30447-1-alvaro.gamez@hazent.com>
 <20170706091344.GO16144@ulmo.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170706091344.GO16144@ulmo.fritz.box>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2017 at 11:13:44AM +0200, Thierry Reding wrote:
> On Tue, Jun 27, 2017 at 12:05:22PM +0200, Alvaro Gamez Machado wrote:
> > a) Changing "xlnx,axi-timer-2.0" compatible string for this device to something
> >    different like xlnx,axi-pwm-2.0?
> 
> I don't see a xlnx,axi-timer-2.0 compatible string defined in the
> kernel. There's an xlnx,xps-timer-1.00.a used in Microblaze and PowerPC,
> but it might not be related.
 

Yes, that was a mistake of mine.  I was talking about xlnx,xps-timer-1.00.a. 
XPS was the previous name of some Xilinx utility, and after they pushed for
the axi protocol, they started renaming lots of IP Cores, but the
compatibility strings were kept even in their own software; so xps-timer is
basically the same as axi-timer, thus my mistake when writing from memory
instead of looking at the code.


> > b) Is there a way to make arch/microblaze/kernel/timer.c take full posession
> >    of its axi timer device so that any further driver can't access it?
> 
> > I've tried option (a) and works flawlessly as far as I can tell (tested
> > through /sys interface), but I think option (b) would be better, if it's
> > something that can be done.
> 
> I think (a) is certainly the cleaner approach because it lets you select
> the mode via DT. However, it's probably best to get DT maintainers'
> opinion on this. Cc'ing them. Quoting in full for context.
> 
> As you point out, using a completely different compatible string is the
> easiest way to side-step the problem. However, it's also "wrong" in that
> you're still dealing with the same hardware, and consequently should be
> identified by the same compatible string.
> 
> One possible option I can think of would be to define a somewhat generic
> compatible string to identify the block as a whole and require a second
> compatible string to specify what mode to use the block in.
> 
> Another alternative would be to mark the node as PWM controller with an
> additional property (e.g. pwm-controller) and use that as the selector
> for the mode. The timer code would have to be modified to abort if it
> encounters a node marked with this property, and similarily the PWM
> driver would abort if the property is absent.

I've given this a thought and came up with the idea of adding an attribute
to the device tree -something like say xlnx,pwm-outputs- which would take
the value of 1 for timers instantiated with the PWM capability, as it is
optional.

This way, timer.c could check that xlnx,pwm-outputs equals 0 or is
undefined, so we keep old device trees compatible, whereas pwm-axi-timer.c
checks if this attribute is equal to 1. Even if it's not something that is
probable to happen, this would also leave the door open to supporting this
future versions of this IP core providing more than one pwm output.

Problem is, there should probably be a timer-axi.c driver under clocksource,
because the number of timers available on a given Microblaze/Zynq design is
unconstrained, and it'd probably be good to aim for full compatibility with
this small chunk of hardware.

The more I think about this the less sure I am about which is the best way
to go... it wouldn't make much sense having three pieces of code talking to
the same hardware, or to different instances of the same IP core
(arch/microblaze/kernel/timer.c, pwm/pwm-axi-timer.c and
clocksource/timer-axi.c).
 
> Anyway, let's see what the device tree maintainers think about it.

They haven't manifested themselves, but I think I should have pushed this a
little bit earlier, sorry for the delay!

Best regards
-- 
Alvaro G. M.
