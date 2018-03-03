Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbeCCKny (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 05:43:54 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:60094 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeCCKnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 05:43:52 -0500
Date: Sat, 3 Mar 2018 16:13:08 +0530
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kexec@lists.infradead.org, davem@davemloft.net,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        Ganesh GR <ganeshgr@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Indranil Choudhury <indranil@chelsio.com>
Subject: Re: [RFC 0/2] kernel: add support to collect hardware logs in panic
Message-ID: <20180303104307.GA17150@chelsio.com>
References: <cover.1519911559.git.rahul.lakkireddy@chelsio.com>
 <87lgfad32y.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lgfad32y.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 03/02/18, 2018 at 18:52:45 +0530, Eric W. Biederman wrote:
> Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:
> 
> > On production servers running variety of workloads over time, kernel
> > panic can happen sporadically after days or even months. It is
> > important to collect as much debug logs as possible to root cause
> > and fix the problem, that may not be easy to reproduce. Snapshot of
> > underlying hardware/firmware state (like register dump, firmware
> > logs, adapter memory, etc.), at the time of kernel panic will be very
> > helpful while debugging the culprit device driver.
> >
> > This series of patches add new generic framework that enable device
> > drivers to collect device specific snapshot of the hardware/firmware
> > state of the underlying device at the time of kernel panic. The
> > collected logs are appended to vmcore along with details, such as
> > start address and length of the logs, which are required for
> > extraction during post-analysis.
> >
> > Device drivers can use crash_driver_dump_register() to register their
> > callback that collects underlying device specific hardware/firmware
> > logs during kernel panic (i.e. before booting into the second kernel).
> > Drivers can unregister with crash_driver_dump_unregister().
> >
> > To extract the device specific hardware/firmware logs using crash:
> >
> > crash> help -D | grep DRIVERDUMP
> > DRIVERDUMP=(cxgb4_0000:02:00.4, ffffb131090bd000, 37782968)
> >
> > crash> rd ffffb131090bd000 37782968 -r hardware.log
> > 37782968 bytes copied from 0xffffb131090bd000 to hardware.log
> >
> > Patch 1 adds API to allow drivers to register callback to
> > collect the device specific hardware/firmware logs.
> >
> > Patch 2 shows a cxgb4 driver example using the API to collect
> > hardware/firmware logs during kernel panic.
> >
> > Suggestions and feedback will be much appreciated.
> 
> I strongly suggest you figure out how to run this code in the
> crash recovery kernel before your hardware is initialized.
> That will give you a known good kernel to perform your collection from.
> 
> Every line of code we add to the kexec on panic code path tends to add
> to it's fragility and increase the chance you won't get any information
> at all.
> 
> When the assumption is it is something wrong with your driver/hardware
> that caused the crash, calling into your driver is a very bad idea.
> Especially running code that does callbacks and all kinds of other cute
> things.
> 
> Doing this as the crash recover kernel boots up before much if any
> hardware is initialized seems like a fine thing to do, and just
> needs a little coordination with userspace to ensure the information
> gets saved when a vmcore is computed.
> 

Thanks for the feedback and suggestions. I will work on achieving
this from the crash recover kernel.

Thanks,
Rahul
