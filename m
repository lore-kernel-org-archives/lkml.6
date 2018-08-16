Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7F6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CFC214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CFC214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390683AbeHPNJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:09:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43362 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbeHPNJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:09:48 -0400
Received: from localhost (unknown [37.170.164.166])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6F5EF40B;
        Thu, 16 Aug 2018 10:12:16 +0000 (UTC)
Date:   Thu, 16 Aug 2018 12:12:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Byron Stanoszek <gandalf@winds.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.18 00/79] 4.18.1-stable review
Message-ID: <20180816101212.GF9141@kroah.com>
References: <alpine.LNX.2.21.1808151306290.29065@winds.org>
 <20180815173254.GB22317@kroah.com>
 <alpine.LNX.2.21.1808152259230.10088@winds.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1808152259230.10088@winds.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 12:39:29AM -0400, Byron Stanoszek wrote:
> On Wed, 15 Aug 2018, Greg Kroah-Hartman wrote:
> 
> > On Wed, Aug 15, 2018 at 01:24:25PM -0400, Byron Stanoszek wrote:
> > > Hi Greg & Thomas,
> > > 
> > > I'd like to report a regression in Linux 4.18.1 regarding the L1TF patches.
> > > 
> > > The kernel no longer thinks I have SMT enabled in the BIOS. This works fine in
> > > 4.18.0.
> > > 
> > > Not sure if this matters, but in my particular 4-core system, my third core is
> > > broken (core #2). So I must boot using "maxcpus=2" and then online the other
> > > cores & SMT threads at startup using:
> > > 
> > > echo 1 > /sys/devices/system/cpu/cpu3/online
> > > echo 1 > /sys/devices/system/cpu/cpu4/online
> > > echo 1 > /sys/devices/system/cpu/cpu5/online
> > > echo 1 > /sys/devices/system/cpu/cpu7/online
> > > 
> > > In 4.18.0, dmesg shows:
> > > 
> > > smpboot: Booting Node 0 Processor 3 APIC 0x6
> > > smpboot: Booting Node 0 Processor 4 APIC 0x1
> > > smpboot: Booting Node 0 Processor 5 APIC 0x3
> > > smpboot: Booting Node 0 Processor 7 APIC 0x7
> > > 
> > > In 4.18.1, dmesg shows:
> > > 
> > > smpboot: Booting Node 0 Processor 3 APIC 0x6
> > > smpboot: Booting Node 0 Processor 4 APIC 0x1
> > > smpboot: CPU 4 is now offline
> > > smpboot: Booting Node 0 Processor 5 APIC 0x3
> > > smpboot: CPU 5 is now offline
> > > smpboot: Booting Node 0 Processor 7 APIC 0x7
> > > smpboot: CPU 7 is now offline
> > > 
> > > and I get an "Operation cancelled" error in the shell when trying to online 4,
> > > 5, and 7.
> > > 
> > > In 4.18.1, /sys/devices/system/cpu/smt/control says "notsupported".
> > > 
> > >  - - -
> > > 
> > > A possible second regression is the following:
> > > 
> > > My CPU normally runs at 3600 MHz. I usually run my CPU at 2800 MHz to keep from
> > > overheating under full load (it is a fanless system). I do this by running
> > > "echo 1 > /sys/class/thermal/cooling_device5/cur_state", and confirm with "cat
> > > /proc/cpuinfo" (shows 2800).
> > > 
> > > This works in 4.18.0 but not in 4.18.1. I get no error from the "echo" command
> > > (and the state reads back as "1"), but the CPU remains running at 3600 MHz.
> > 
> > How about Linus's tree at the moment, is it ok there?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> It also fails in Linus's tree. Seems like this logic is to blame:
> 
> /*
>  * If SMT was disabled by BIOS, detect it here, after the CPUs have been
>  * brought online. This ensures the smt/l1tf sysfs entries are consistent
>  * with reality. cpu_smt_available is set to true during the bringup of non
>  * boot CPUs when a SMT sibling is detected. Note, this may overwrite
>  * cpu_smt_control's previous setting.
>  */
> void __init cpu_smt_check_topology(void)
> {
>         if (!cpu_smt_available)
>                 cpu_smt_control = CPU_SMT_NOT_SUPPORTED;
> }
> 
> SMT is enabled in my BIOS, but because I booted with maxcpus=2, the init code
> never officially booted any SMT thread yet--just primary threads. I suspect the
> line 'cpu_smt_available = true;' in kernel/cpu.c function cpu_smt_allowed() is
> never being reached.
> 
> It is then impossible to boot any SMT thread after init is done, since
> 'cpu_smt_available' is false.
> 
> The following test patch makes everything work for me on both mainline and
> 4.18.1, but we might as well throw out 'cpu_smt_available' altogether then (or
> find another way to set it appropriately). Just because we didn't boot any SMT
> threads at init shouldn't mean that SMT is disabled by the BIOS.
> 
> ---
> 
> x86/l1tf: Fix booting with low maxcpus=# causes SMT to be disabled
> 
> If maxcpus=# is given on the kernel command line where # is too low for
> any SMT CPU (thread) to be booted during init, then the kernel thinks
> SMT is disabled by the BIOS. SMT threads are then unable to be manually
> brought online later after init.
> 
> Set 'cpu_smt_available' early on in init instead, if
> topology_smt_supported() returns true.
> 
> Fixes: 958f338e96f8 ("Merge branch 'l1tf-final' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Byron Stanoszek <gandalf@winds.org>
> ---
>  kernel/cpu.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Thomas is out for at least the rest of this week, so it might be a bit
before he sees this :(

greg k-h
