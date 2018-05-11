Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753039AbeEKM4c (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 08:56:32 -0400
Received: from muru.com ([72.249.23.125]:41698 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752592AbeEKM4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 08:56:31 -0400
Date: Fri, 11 May 2018 05:56:27 -0700
From: Tony Lindgren <tony@atomide.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] serdev: add controller runtime PM support
Message-ID: <20180511125627.GI98604@atomide.com>
References: <20180509094419.13470-1-johan@kernel.org>
 <20180510164831.GH98604@atomide.com>
 <20180511080725.GE2285@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511080725.GE2285@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Johan Hovold <johan@kernel.org> [180511 08:09]:
> On Thu, May 10, 2018 at 09:48:31AM -0700, Tony Lindgren wrote:
> > If this solution works for GPS then this should also work for modems
> > that might produce data. And as long as the serdev consumer driver
> > can wake up the UART with pm_runtime_get(&serdev->ctrl->dev) then
> > the out of band GPIO wake interrupts will work to. And for TX,
> > the serdev consumer driver can toggle the wake GPIO, and then call
> > pm_runtime_get(&serdev->ctrl->dev).
> 
> I don't think any serdev driver action is needed for TX however. The
> serial driver itself would know that there's data in the write buffer
> and should manage PM itself until the buffer has been drained (which may
> never happen due to flow control).

Sure if the serial driver can manage TX wake directly. However, the
case I'm thinking needs few hundred milliseconds after toggling the
GPIO before we can even attempt to do TX. I guess what I'm saying
let's not try to stuff any "application specific" GPIO handling to
generic UART code :)

> But either way, the mechanism introduced by this patch is general enough
> that it could in principle be used also for something like that.

Yes I agree your patches should work for both cases.

Regards,

Tony
