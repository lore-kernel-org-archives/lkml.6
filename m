Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFD5C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D4B21471
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D4B21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeJIArH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:47:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbeJIArH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:47:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 529E331500B8;
        Mon,  8 Oct 2018 17:34:20 +0000 (UTC)
Received: from treble (ovpn-121-208.rdu2.redhat.com [10.10.121.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BE6960C62;
        Mon,  8 Oct 2018 17:34:19 +0000 (UTC)
Date:   Mon, 8 Oct 2018 12:34:17 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: unwind_init() takes 100 ms
Message-ID: <20181008173417.crlfndi3p5pevnx3@treble>
References: <81a1ff79-b303-c384-f926-c9618afac8f0@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81a1ff79-b303-c384-f926-c9618afac8f0@molgen.mpg.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 08 Oct 2018 17:34:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 11:52:46AM +0200, Paul Menzel wrote:
> Dear Josh, dear Linux folks,
> 
> 
> Trying to decrease the boot time of the 64-bit Linux kernel (Linux 4.19-rc7
> (0238df64)) on a Asus F2A85-M PRO with an AMD processor, I noticed
> `unwind_init()` called from `setup_arch()` `arch/x86/kernel/setup.c` takes
> over 100 ms to initialize according to Linux time stamps (which are present
> for early boot now).
> 
> ```
> […]
> [    0.047650] ACPI: HPET id: 0x10228210 base: 0xfed00000
> [    0.047653] smpboot: Allowing 4 CPUs, 2 hotplug CPUs
> [    0.047670] [mem 0x8f000000-0xfebfffff] available for PCI devices
> [    0.047672] clocksource: refined-jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 1910969940391419 ns
> [    0.151426] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:4
> nr_node_ids:1
> [    0.151892] percpu: Embedded 44 pages/cpu @(____ptrval____) s142552 r8192
> d29480 u524288
> […]
> ```
> 
> That’s a third of the time to get to unpacking the initramfs.
> 
> Therefore, I have several questions.
> 
> 1.  Can you reproduce that on your systems?

I haven't tried to reproduce, but it wouldn't surprise me because it
sorts the big ORC table during boot.

> 2.  Can this be decreased or moved out of the “hot path”?

It would be better to sort it at build time, but I haven't had a chance
to implement that yet.  I'll try to get to it one of these days...

> 3.  If not, how can this be disabled? I was unable to do so in the
> configuration menu. I could always select an unwinder under *Kernel
> hacking*, and was not able to disable it.

If you select CONFIG_UNWINDER_FRAME_POINTER, the boot time penalty
should go away.

Or do CONFIG_EXPERT and CONFIG_UNWINDER_GUESS if you don't want the
general slowdown caused by frame pointers.

> 4.  Would a command line parameter be reasonable `disable_unwind`, so people
> could decrease their boot time with distribution kernels, and easily turn it
> back on, when they need a stacktrace without having to rebuild the Linux
> kernel?

I think a boot cmdline option to disable ORC would be ok.  However,
disabling ORC would need to fall back to the "guess" unwinder.
Otherwise it would make debugging impossible.  That shouldn't be too
hard, but it would require restructuring the code a bit.

I'm not sure about a runtime toggle though.  It might be racy and I'd
rather avoid that completely, unless there's a solid justification for
it.

-- 
Josh
