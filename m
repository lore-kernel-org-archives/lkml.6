Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752855AbeEKIHf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:07:35 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:42836 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbeEKIHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:07:30 -0400
X-Google-Smtp-Source: AB8JxZqKAcWChdfgKVVa9vS8UmKUNHCRHCqfDEb/+gjr4V8bRqJvXcHJGKZZjENb3xLaMeh8LzZP3A==
Date: Fri, 11 May 2018 10:07:25 +0200
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
Message-ID: <20180511080725.GE2285@localhost>
References: <20180509094419.13470-1-johan@kernel.org>
 <20180510164831.GH98604@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510164831.GH98604@atomide.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 09:48:31AM -0700, Tony Lindgren wrote:
> * Johan Hovold <johan@kernel.org> [180509 09:46]:
> > Add support for controller runtime power management to serdev core. This
> > is needed to allow slave drivers to manage the runtime PM state of the
> > underlying serial controller when its driver, in turn, implements more
> > aggressive runtime power management (e.g. using autosuspend).
> > 
> > For some applications, for example, where loss off initial data after a
> > remote-wakeup event is acceptable or where rx is not used at all,
> > aggressive serial controller runtime PM may be used without further
> > involvement of the slave driver. But when this is not the case, the
> > slave driver must be able to indicate when incoming data is expected in
> > order to avoid data loss.
> > 
> > To facilitate the common case, where the serial controller power state
> > is active whenever the port is open (which is the case with just about
> > every serial driver), and where data loss is not acceptable and cannot
> > even be prevented by explicit controller runtime power management, an
> > RPM reference is taken in serdev open and put again at close. This
> > reference can later be balanced by any serdev driver which wants and/or
> > can handle aggressive controller runtime PM.
> > 
> > Note that the .ignore_children flag is set for the serdev controller to
> > allow the underlying hardware to idle when no I/O is expected, regardless
> > of the slave device RPM state.
> 
> If this solution works for GPS then this should also work for modems
> that might produce data. And as long as the serdev consumer driver
> can wake up the UART with pm_runtime_get(&serdev->ctrl->dev) then
> the out of band GPIO wake interrupts will work to. And for TX,
> the serdev consumer driver can toggle the wake GPIO, and then call
> pm_runtime_get(&serdev->ctrl->dev).

I don't think any serdev driver action is needed for TX however. The
serial driver itself would know that there's data in the write buffer
and should manage PM itself until the buffer has been drained (which may
never happen due to flow control).

But either way, the mechanism introduced by this patch is general enough
that it could in principle be used also for something like that.

> So yeah, looks nice to me:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks,
Johan
