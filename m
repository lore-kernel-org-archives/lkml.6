Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeDSO2q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:28:46 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:19675 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751325AbeDSO2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:28:44 -0400
Date: Thu, 19 Apr 2018 19:57:48 +0530
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: Dave Young <dyoung@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Indranil Choudhury <indranil@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        Ganesh GR <ganeshgr@chelsio.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH net-next v4 0/3] kernel: add support to collect hardware
 logs in crash recovery kernel
Message-ID: <20180419142747.GA30274@chelsio.com>
References: <cover.1523950321.git.rahul.lakkireddy@chelsio.com>
 <20180418061546.GA4551@dhcp-128-65.nay.redhat.com>
 <20180418123114.GA19159@chelsio.com>
 <20180419014030.GA2340@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419014030.GA2340@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 04/19/18, 2018 at 07:10:30 +0530, Dave Young wrote:
> On 04/18/18 at 06:01pm, Rahul Lakkireddy wrote:
> > On Wednesday, April 04/18/18, 2018 at 11:45:46 +0530, Dave Young wrote:
> > > Hi Rahul,
> > > On 04/17/18 at 01:14pm, Rahul Lakkireddy wrote:
> > > > On production servers running variety of workloads over time, kernel
> > > > panic can happen sporadically after days or even months. It is
> > > > important to collect as much debug logs as possible to root cause
> > > > and fix the problem, that may not be easy to reproduce. Snapshot of
> > > > underlying hardware/firmware state (like register dump, firmware
> > > > logs, adapter memory, etc.), at the time of kernel panic will be very
> > > > helpful while debugging the culprit device driver.
> > > > 
> > > > This series of patches add new generic framework that enable device
> > > > drivers to collect device specific snapshot of the hardware/firmware
> > > > state of the underlying device in the crash recovery kernel. In crash
> > > > recovery kernel, the collected logs are added as elf notes to
> > > > /proc/vmcore, which is copied by user space scripts for post-analysis.
> > > > 
> > > > The sequence of actions done by device drivers to append their device
> > > > specific hardware/firmware logs to /proc/vmcore are as follows:
> > > > 
> > > > 1. During probe (before hardware is initialized), device drivers
> > > > register to the vmcore module (via vmcore_add_device_dump()), with
> > > > callback function, along with buffer size and log name needed for
> > > > firmware/hardware log collection.
> > > 
> > > I assumed the elf notes info should be prepared while kexec_[file_]load
> > > phase. But I did not read the old comment, not sure if it has been discussed
> > > or not.
> > > 
> > 
> > We must not collect dumps in crashing kernel. Adding more things in
> > crash dump path risks not collecting vmcore at all. Eric had
> > discussed this in more detail at:
> > 
> > https://lkml.org/lkml/2018/3/24/319
> > 
> > We are safe to collect dumps in the second kernel. Each device dump
> > will be exported as an elf note in /proc/vmcore.
> 
> I understand that we should avoid adding anything in crash path.  And I also
> agree to collect device dump in second kernel.  I just assumed device
> dump use some memory area to store the debug info and the memory
> is persistent so that this can be done in 2 steps, first register the
> address in elf header in kexec_load, then collect the dump in 2nd
> kernel.  But it seems the driver is doing some other logic to collect
> the info instead of just that simple like I thought. 
> 

It seems simpler, but I'm concerned with waste of memory area, if
there are no device dumps being collected in second kernel. In
approach proposed in these series, we dynamically allocate memory
for the device dumps from second kernel's available memory.

> > 
> > > If do this in 2nd kernel a question is driver can be loaded later than vmcore init.
> > 
> > Yes, drivers will add their device dumps after vmcore init.
> > 
> > > How to guarantee the function works if vmcore reading happens before
> > > the driver is loaded?
> > > 
> > > Also it is possible that kdump initramfs does not contains the driver
> > > module.
> > > 
> > > Am I missing something?
> > > 
> > 
> > Yes, driver must be in initramfs if it wants to collect and add device
> > dump to /proc/vmcore in second kernel.
> 
> In RH/Fedora kdump scripts we only add the things are required to
> bring up the dump target, so that we can use as less memory as we can.
> 
> For example, if a net driver panicked, and the dump target is rootfs
> which is a scsi disk, then no network related stuff will be added in
> initramfs.
> 
> In this case the device dump info will be not collected..

Correct. If the driver is not present in initramfs, it can't collect
its underlying device's dump. Administrator is expected to add the 
driver to initramfs, if device dump needs to be collected.

> > 
> > > > 
> > > > 2. vmcore module allocates the buffer with requested size. It adds
> > > > an elf note and invokes the device driver's registered callback
> > > > function.
> > > > 
> > > > 3. Device driver collects all hardware/firmware logs into the buffer
> > > > and returns control back to vmcore module.
> > > > 
> > > > The device specific hardware/firmware logs can be seen as elf notes:
> > > > 
> > > > # readelf -n /proc/vmcore
> > > > 
> > > > Displaying notes found at file offset 0x00001000 with length 0x04003288:
> > > >   Owner                 Data size	Description
> > > >   VMCOREDD_cxgb4_0000:02:00.4 0x02000fd8	Unknown note type: (0x00000700)
> > > >   VMCOREDD_cxgb4_0000:04:00.4 0x02000fd8	Unknown note type: (0x00000700)
> > > >   CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
> > > >   CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
> > > >   CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
> > > >   CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
> > > >   CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
> > > >   CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
> > > >   CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
> > > >   CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
> > > >   VMCOREINFO           0x0000074f	Unknown note type: (0x00000000)
> > > > 
> > > > Patch 1 adds API to vmcore module to allow drivers to register callback
> > > > to collect the device specific hardware/firmware logs.  The logs will
> > > > be added to /proc/vmcore as elf notes.
> > > > 
> > > > Patch 2 updates read and mmap logic to append device specific hardware/
> > > > firmware logs as elf notes.
> > > > 
> > > > Patch 3 shows a cxgb4 driver example using the API to collect
> > > > hardware/firmware logs in crash recovery kernel, before hardware is
> > > > initialized.
> > > > 
> > > > Thanks,
> > > > Rahul
> > > > 
> > > > RFC v1: https://lkml.org/lkml/2018/3/2/542
> > > > RFC v2: https://lkml.org/lkml/2018/3/16/326
> > > > 

Thanks,
Rahul
