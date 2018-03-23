Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeCWPEY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:04:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35628 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeCWPEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:04:22 -0400
Date: Fri, 23 Mar 2018 16:04:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robdclark@gmail.com,
        s.hauer@pengutronix.de, l.stach@pengutronix.de, shawnguo@kernel.org,
        fabio.estevam@nxp.com, nm@ti.com, xuwei5@hisilicon.com,
        robh+dt@kernel.org, olof@lixom.net, georgi.djakov@linaro.org
Subject: Re: [PATCH V7 00/13] drivers: Boot Constraint core
Message-ID: <20180323150420.GA21152@kroah.com>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
 <20180322012606.vuaemu3pvpeojtwr@vireshk-mac-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322012606.vuaemu3pvpeojtwr@vireshk-mac-ubuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 09:26:06AM +0800, Viresh Kumar wrote:
> On 23-02-18, 15:53, Viresh Kumar wrote:
> > Problem statement:
> > 
> > Some devices are powered ON by the bootloader before the bootloader
> > handovers control to Linux. It maybe important for some of those devices
> > to keep working until the time a Linux device driver probes the device
> > and reconfigure its resources.
> > 
> > A typical example of that can be the LCD controller, which is used by
> > the bootloaders to show image(s) while the platform is booting into
> > Linux.  The LCD controller can be using some resources, like clk,
> > regulators, etc, that are shared between several devices. These shared
> > resources should be configured to satisfy need of all the users.  If
> > another device's (X) driver gets probed before the LCD controller driver
> > in this case, then it may end up disabling or reconfiguring these
> > resources to ranges satisfying the current users (only device X) and
> > that can make the LCD screen unstable.
> > 
> > Another case can be a debug serial port enabled from the bootloader.
> > 
> > Of course we can have more complex cases where the same resource is
> > getting used by two devices while the kernel boots and the order in
> > which devices get probed wouldn't matter as the other device will surely
> > break then.
> 
> And we have a _real_ use case for this complex scenario as well.
> 
> Georgi (cc'd) is currently working[1] on implementing generic support for the
> interconnect bus, which tries to play with the bandwidth of the bus based on how
> much are the requirements from different parts of the SoC. The 4th version was
> posted recently by him, and things are looking good/positive.
> 
> The bootloader configures the interconnect to provide sufficient bandwidth for
> all the devices which are used during boot, few of them are the CPUs, serial and
> the LCD controller. As the kernel starts taking control of things, the drivers
> being probed start putting their requirements on the interconnect bus.  Because
> the interconnect doesn't have any representation from the devices which are not
> yet initialized by the kernel, the interconnect core incorrectly reduces the
> bandwidth of the bus to a level unacceptable to the devices running currently,
> like the CPUs and this makes kernel boot awfully slow. This is not an ordering
> problem as no matter which device we probe first, we are going to break
> something else.
> 
> Georgi already tried using the boot constraint patches to solve this complex
> problem, and its a perfect fit.

I'm delaying this as I still don't see that "perfect fit" yet.  If there
are add-on patches that take better advantage of this, great, let's see
those, but right now, it feels like you are the only one wanting this.
And the increased complexity overall seems not really worth it yet :(

greg k-h
