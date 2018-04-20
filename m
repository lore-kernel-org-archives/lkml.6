Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754890AbeDTNH1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:07:27 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:46745 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754776AbeDTNHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:07:24 -0400
Date: Fri, 20 Apr 2018 18:36:34 +0530
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Young <dyoung@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Indranil Choudhury <indranil@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        Ganesh GR <ganeshgr@chelsio.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH net-next v4 0/3] kernel: add support to collect hardware
 logs in crash recovery kernel
Message-ID: <20180420130632.GA32304@chelsio.com>
References: <cover.1523950321.git.rahul.lakkireddy@chelsio.com>
 <20180418061546.GA4551@dhcp-128-65.nay.redhat.com>
 <20180418123114.GA19159@chelsio.com>
 <20180419014030.GA2340@dhcp-128-65.nay.redhat.com>
 <20180419142747.GA30274@chelsio.com>
 <87lgdjnt72.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lgdjnt72.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 04/19/18, 2018 at 20:23:37 +0530, Eric W. Biederman wrote:
> Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:
> 
> > On Thursday, April 04/19/18, 2018 at 07:10:30 +0530, Dave Young wrote:
> >> On 04/18/18 at 06:01pm, Rahul Lakkireddy wrote:
> >> > On Wednesday, April 04/18/18, 2018 at 11:45:46 +0530, Dave Young wrote:
> >> > > Hi Rahul,
> >> > > On 04/17/18 at 01:14pm, Rahul Lakkireddy wrote:
> >> > > > On production servers running variety of workloads over time, kernel
> >> > > > panic can happen sporadically after days or even months. It is
> >> > > > important to collect as much debug logs as possible to root cause
> >> > > > and fix the problem, that may not be easy to reproduce. Snapshot of
> >> > > > underlying hardware/firmware state (like register dump, firmware
> >> > > > logs, adapter memory, etc.), at the time of kernel panic will be very
> >> > > > helpful while debugging the culprit device driver.
> >> > > > 
> >> > > > This series of patches add new generic framework that enable device
> >> > > > drivers to collect device specific snapshot of the hardware/firmware
> >> > > > state of the underlying device in the crash recovery kernel. In crash
> >> > > > recovery kernel, the collected logs are added as elf notes to
> >> > > > /proc/vmcore, which is copied by user space scripts for post-analysis.
> >> > > > 
> >> > > > The sequence of actions done by device drivers to append their device
> >> > > > specific hardware/firmware logs to /proc/vmcore are as follows:
> >> > > > 
> >> > > > 1. During probe (before hardware is initialized), device drivers
> >> > > > register to the vmcore module (via vmcore_add_device_dump()), with
> >> > > > callback function, along with buffer size and log name needed for
> >> > > > firmware/hardware log collection.
> >> > > 
> >> > > I assumed the elf notes info should be prepared while kexec_[file_]load
> >> > > phase. But I did not read the old comment, not sure if it has been discussed
> >> > > or not.
> >> > > 
> >> > 
> >> > We must not collect dumps in crashing kernel. Adding more things in
> >> > crash dump path risks not collecting vmcore at all. Eric had
> >> > discussed this in more detail at:
> >> > 
> >> > https://lkml.org/lkml/2018/3/24/319
> >> > 
> >> > We are safe to collect dumps in the second kernel. Each device dump
> >> > will be exported as an elf note in /proc/vmcore.
> >> 
> >> I understand that we should avoid adding anything in crash path.  And I also
> >> agree to collect device dump in second kernel.  I just assumed device
> >> dump use some memory area to store the debug info and the memory
> >> is persistent so that this can be done in 2 steps, first register the
> >> address in elf header in kexec_load, then collect the dump in 2nd
> >> kernel.  But it seems the driver is doing some other logic to collect
> >> the info instead of just that simple like I thought. 
> >> 
> >
> > It seems simpler, but I'm concerned with waste of memory area, if
> > there are no device dumps being collected in second kernel. In
> > approach proposed in these series, we dynamically allocate memory
> > for the device dumps from second kernel's available memory.
> 
> Don't count that kernel having more than about 128MiB.
> 

If large dump is expected, Administrator can increase the memory
allocated to the second kernel (using crashkernel boot param), to
ensure device dumps get collected.

> For that reason if for no other it would be nice if it was possible to
> have the driver to not initialize the device and just stand there
> handing out the data a piece at a time as it is read from /proc/vmcore.
> 

Since cxgb4 is a network driver, it can be used to transfer the dumps
over the network. So we must ensure the dumps get collected and
stored, before device gets initialized to transfer dumps over
the network.

> The 2GiB number I read earlier concerns me for working in a limited
> environment.
> 

All dumps, including the 2GB on-chip memory dump, is compressed by
the cxgb4 driver as they are collected. The overall compressed dump
comes out at max 32 MB.

> It might even make sense to separate this into a completely separate
> module (depended upon the main driver if it makes sense to share
> the functionality) so that people performing crash dumps would not
> hesitate to include the code in their initramfs images.
> 
> I can see splitting a device up into a portion only to be used in case
> of a crash dump and a normal portion like we do for main memory but I
> doubt that makes sense in practice.
> 

This is not required, especially in case of network drivers, which
must collect underlying device dump and initialize the device to
transfer dumps over the network.

> >> > > If do this in 2nd kernel a question is driver can be loaded later than vmcore init.
> >> > 
> >> > Yes, drivers will add their device dumps after vmcore init.
> >> > 
> >> > > How to guarantee the function works if vmcore reading happens before
> >> > > the driver is loaded?
> >> > > 
> >> > > Also it is possible that kdump initramfs does not contains the driver
> >> > > module.
> >> > > 
> >> > > Am I missing something?
> >> > > 
> >> > 
> >> > Yes, driver must be in initramfs if it wants to collect and add device
> >> > dump to /proc/vmcore in second kernel.
> >> 
> >> In RH/Fedora kdump scripts we only add the things are required to
> >> bring up the dump target, so that we can use as less memory as we can.
> >> 
> >> For example, if a net driver panicked, and the dump target is rootfs
> >> which is a scsi disk, then no network related stuff will be added in
> >> initramfs.
> >> 
> >> In this case the device dump info will be not collected..
> >
> > Correct. If the driver is not present in initramfs, it can't collect
> > its underlying device's dump. Administrator is expected to add the 
> > driver to initramfs, if device dump needs to be collected.
> 
> That makes sense, as most people won't have that need.  Still if we can
> find something that can work automatically and safely without the need
> for manual configuration people are more likely to use it.
> 

Thanks,
Rahul
