Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeDBMcL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 08:32:11 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:47797 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbeDBMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 08:32:05 -0400
Date: Mon, 2 Apr 2018 18:00:45 +0530
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Ganesh GR <ganeshgr@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Indranil Choudhury <indranil@chelsio.com>
Subject: Re: [PATCH net-next v2 1/2] fs/crashdd: add API to collect hardware
 dump in second kernel
Message-ID: <20180402123044.GA31231@chelsio.com>
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <296ffbd47fd4f30238689e636bd2480683224227.1521888444.git.rahul.lakkireddy@chelsio.com>
 <20180330103907.GC3313@nanopsycho>
 <20180330105156.GA24344@chelsio.com>
 <87k1tt2yo7.fsf@xmission.com>
 <20180402091143.GD3313@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180402091143.GD3313@nanopsycho>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 04/02/18, 2018 at 14:41:43 +0530, Jiri Pirko wrote:
> Fri, Mar 30, 2018 at 08:42:00PM CEST, ebiederm@xmission.com wrote:
> >Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:
> >
> >> On Friday, March 03/30/18, 2018 at 16:09:07 +0530, Jiri Pirko wrote:
> >>> Sat, Mar 24, 2018 at 11:56:33AM CET, rahul.lakkireddy@chelsio.com wrote:
> >>> >Add a new module crashdd that exports the /sys/kernel/crashdd/
> >>> >directory in second kernel, containing collected hardware/firmware
> >>> >dumps.
> >>> >
> >>> >The sequence of actions done by device drivers to append their device
> >>> >specific hardware/firmware logs to /sys/kernel/crashdd/ directory are
> >>> >as follows:
> >>> >
> >>> >1. During probe (before hardware is initialized), device drivers
> >>> >register to the crashdd module (via crashdd_add_dump()), with
> >>> >callback function, along with buffer size and log name needed for
> >>> >firmware/hardware log collection.
> >>> >
> >>> >2. Crashdd creates a driver's directory under
> >>> >/sys/kernel/crashdd/<driver>. Then, it allocates the buffer with
> >>> 
> >>> This smells. I need to identify the exact ASIC instance that produced
> >>> the dump. To identify by driver name does not help me if I have multiple
> >>> instances of the same driver. This looks wrong to me. This looks like
> >>> a job for devlink where you have 1 devlink instance per 1 ASIC instance.
> >>> 
> >>> Please see:
> >>> http://patchwork.ozlabs.org/project/netdev/list/?series=36524
> >>> 
> >>> I bevieve that the solution in the patchset could be used for
> >>> your usecase too.
> >>> 
> >>> 
> >>
> >> The sysfs approach proposed here had been dropped in favour exporting
> >> the dumps as ELF notes in /proc/vmcore.
> >>
> >> Will be posting the new patches soon.
> >
> >The concern was actually how you identify which device that came from.
> >Where you read the identifier changes but sysfs or /proc/vmcore the
> >change remains valid.
> 
> Yeah. I still don't see how you link the dump and the device.

In our case, the dump and the device are being identified by the
driver’s name followed by its corresponding pci bus id.  I’ve posted an
example in my v3 series:

https://www.spinics.net/lists/netdev/msg493781.html

Here’s an extract from the link above:

# readelf -n /proc/vmcore

Displaying notes found at file offset 0x00001000 with length 0x04003288:
Owner                 Data size     Description
VMCOREDD_cxgb4_0000:02:00.4 0x02000fd8      Unknown note type:(0x00000700)
VMCOREDD_cxgb4_0000:04:00.4 0x02000fd8      Unknown note type:(0x00000700)
CORE                 0x00000150     NT_PRSTATUS (prstatus structure)
CORE                 0x00000150     NT_PRSTATUS (prstatus structure)
CORE                 0x00000150     NT_PRSTATUS (prstatus structure)
CORE                 0x00000150     NT_PRSTATUS (prstatus structure)
CORE                 0x00000150     NT_PRSTATUS (prstatus structure)
CORE                 0x00000150     NT_PRSTATUS (prstatus structure)
CORE                 0x00000150     NT_PRSTATUS (prstatus structure)
CORE                 0x00000150     NT_PRSTATUS (prstatus structure)
VMCOREINFO           0x0000074f     Unknown note type: (0x00000000)

Here, for my two devices, the dump’s names are
VMCOREDD_cxgb4_0000:02:00.4 and VMCOREDD_cxgb4_0000:04:00.4.

It’s really up to the callers to write their own unique name for the
dump.  The name is appended to “VMCOREDD_” string.

> Rahul, did you look at the patchset I pointed out?

For devlink, I think the dump name would be identified by
bus_type/device_name; i.e. “pci/0000:02:00.4” for my example.
Is my understanding correct?

Thanks,
Rahul
