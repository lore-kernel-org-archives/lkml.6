Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033464AbeEXQFl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:05:41 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39308 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030546AbeEXQFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:05:36 -0400
X-Google-Smtp-Source: AB8JxZoyAC8D3EeRMUD1TD/u39jP4ui0zx7CYZLaUoTHsexh5FGbjURMnlLpjYbd14tO9TPJwF27ww==
Date: Fri, 25 May 2018 00:05:32 +0800
From: Martin Liu <liumartin@google.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jenhaochen@google.com
Subject: Re: [RFC] driver core: don't hold dev's parent lock when using async
 probe
Message-ID: <20180524160532.GA4803@google.com>
References: <20180524140021.GA214888@google.com>
 <Pine.LNX.4.44L0.1805241100000.1871-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1805241100000.1871-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 11:02:57AM -0400, Alan Stern wrote:
> On Thu, 24 May 2018, Martin Liu wrote:
> 
> > On Tue, May 22, 2018 at 01:09:44PM -0400, Alan Stern wrote:
> > > On Tue, 22 May 2018, martin_liu wrote:
> > > 
> > > > not sure if we still need 'bf74ad5bc417 ("[PATCH] Hold the
> > > > device's parent's lock during probe and remove")' since it has
> > > > been there over 10 years. If we still need it and hard to fix it
> > > > , the simple way is to find a place not to allow USB subsystem
> > > > drivers to have async probe capability. Any suggestion is welcome.
> > > 
> > > I don't think the "allows_async_probing" attribute is the best way to 
> > > attack this.  Some other approach, like a special-purpose flag, might 
> > > be better.
> > > 
> > > Yes, USB still needs to have parent's locks held during probing.  
> > > Here's the reason.  A USB device can have multiple interfaces, each
> > > bound to its own driver.  A driver may sometimes need to issue a reset,
> > > but in USB there's no way to reset a single interface.  Only the entire
> > > device can be reset, and of course this affects all the interfaces.  
> > > Therefore a driver needs to acquire the device lock before it can issue
> > > a reset.
> > > 
> > > The problem is that the driver's thread may already hold the device
> > > lock.  During a normal probe sequence, for example, the interfaces get
> > > probed by the hub driver while it owns the device lock.  But for probes
> > > under other circumstances (for example, if the user writes to the
> > > driver's "bind" attribute in sysfs), the device lock might not be held.
> > > 
> > > A driver cannot tell these two cases apart.  The only way to make it
> > > work all the time is to have the caller _always_ hold the device lock
> > > while the driver is probed (or the removed, for that matter).
> > > 
> > > Alan Stern
> > 
> > Thanks for the reply and more detail about the backgroud. I'd like to
> > have a conclusion about it. Please kindly correct me if my understanding
> > is wrong. Regarding to the "special-purpose flag", do you mean we could
> > find a place in USB subsystem to have the flag set (not sure if it's
> > easy to find it). Driver core would be base on the flag to decide if we
> > need to hold the device's parent's lock.
> 
> Yes, except that the flag would not be in the USB subsystem.  It would 
> be in the device, device_type, or bus_type structure, so that the 
> driver core could access it.
> 
> Alan Stern

Thanks for the quick feedback and the suggestion. will try to figure out how
it works.

Martin
