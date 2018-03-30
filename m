Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbeC3KxS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 06:53:18 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:54713 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeC3KxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 06:53:16 -0400
Date: Fri, 30 Mar 2018 16:21:57 +0530
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Ganesh GR <ganeshgr@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Indranil Choudhury <indranil@chelsio.com>
Subject: Re: [PATCH net-next v2 1/2] fs/crashdd: add API to collect hardware
 dump in second kernel
Message-ID: <20180330105156.GA24344@chelsio.com>
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <296ffbd47fd4f30238689e636bd2480683224227.1521888444.git.rahul.lakkireddy@chelsio.com>
 <20180330103907.GC3313@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330103907.GC3313@nanopsycho>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 03/30/18, 2018 at 16:09:07 +0530, Jiri Pirko wrote:
> Sat, Mar 24, 2018 at 11:56:33AM CET, rahul.lakkireddy@chelsio.com wrote:
> >Add a new module crashdd that exports the /sys/kernel/crashdd/
> >directory in second kernel, containing collected hardware/firmware
> >dumps.
> >
> >The sequence of actions done by device drivers to append their device
> >specific hardware/firmware logs to /sys/kernel/crashdd/ directory are
> >as follows:
> >
> >1. During probe (before hardware is initialized), device drivers
> >register to the crashdd module (via crashdd_add_dump()), with
> >callback function, along with buffer size and log name needed for
> >firmware/hardware log collection.
> >
> >2. Crashdd creates a driver's directory under
> >/sys/kernel/crashdd/<driver>. Then, it allocates the buffer with
> 
> This smells. I need to identify the exact ASIC instance that produced
> the dump. To identify by driver name does not help me if I have multiple
> instances of the same driver. This looks wrong to me. This looks like
> a job for devlink where you have 1 devlink instance per 1 ASIC instance.
> 
> Please see:
> http://patchwork.ozlabs.org/project/netdev/list/?series=36524
> 
> I bevieve that the solution in the patchset could be used for
> your usecase too.
> 
> 

The sysfs approach proposed here had been dropped in favour exporting
the dumps as ELF notes in /proc/vmcore.

Will be posting the new patches soon.

> >requested size and invokes the device driver's registered callback
> >function.
> >
> >3. Device driver collects all hardware/firmware logs into the buffer
> >and returns control back to crashdd.
> >
> >4. Crashdd exposes the buffer as a binary file via
> >/sys/kernel/crashdd/<driver>/<dump_file>.
> >
