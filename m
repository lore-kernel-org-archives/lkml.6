Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753051AbeEKNMT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 09:12:19 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:38282 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeEKNMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 09:12:16 -0400
X-Google-Smtp-Source: AB8JxZosLySWrK7mtn2/faVqOVOiEwaPqU3EZijttyUWh46U92P3QsZJ0/C+7OSPXbthGMMLKe1/xQ==
Date: Fri, 11 May 2018 15:12:13 +0200
From: Johan Hovold <johan@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] serdev: add controller runtime PM support
Message-ID: <20180511131213.GF2285@localhost>
References: <20180509094419.13470-1-johan@kernel.org>
 <20180510164831.GH98604@atomide.com>
 <20180511080725.GE2285@localhost>
 <20180511125627.GI98604@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511125627.GI98604@atomide.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 05:56:27AM -0700, Tony Lindgren wrote:
> * Johan Hovold <johan@kernel.org> [180511 08:09]:
> > On Thu, May 10, 2018 at 09:48:31AM -0700, Tony Lindgren wrote:
> > > If this solution works for GPS then this should also work for modems
> > > that might produce data. And as long as the serdev consumer driver
> > > can wake up the UART with pm_runtime_get(&serdev->ctrl->dev) then
> > > the out of band GPIO wake interrupts will work to. And for TX,
> > > the serdev consumer driver can toggle the wake GPIO, and then call
> > > pm_runtime_get(&serdev->ctrl->dev).
> > 
> > I don't think any serdev driver action is needed for TX however. The
> > serial driver itself would know that there's data in the write buffer
> > and should manage PM itself until the buffer has been drained (which may
> > never happen due to flow control).
> 
> Sure if the serial driver can manage TX wake directly. However, the
> case I'm thinking needs few hundred milliseconds after toggling the
> GPIO before we can even attempt to do TX. I guess what I'm saying
> let's not try to stuff any "application specific" GPIO handling to
> generic UART code :)

Ok, I think understand what you have in mind now, but that sounds like
something which should be handled by the serdev driver which is
responsible for the power state of the serial-attached device (e.g.
through a pm_runtime_get_sync(&serdev->dev)).

And you're absolutely right that that RPM reference cannot be dropped
before any written data has reached the device. But note that the serial
controller responsible for that transfer could potentially runtime
suspend before the write buffer has been drained (e.g. during long
periods without I/O due to flow control).

So I still think that TX is not directly related to this patch and RPM
support for serdev controllers.

Thanks,
Johan
