Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC16C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A869208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A869208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbeHOU0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:26:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37598 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbeHOU0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:26:01 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7B19CC23;
        Wed, 15 Aug 2018 17:32:56 +0000 (UTC)
Date:   Wed, 15 Aug 2018 19:32:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Byron Stanoszek <gandalf@winds.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4.18 00/79] 4.18.1-stable review
Message-ID: <20180815173254.GB22317@kroah.com>
References: <alpine.LNX.2.21.1808151306290.29065@winds.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1808151306290.29065@winds.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 01:24:25PM -0400, Byron Stanoszek wrote:
> Hi Greg & Thomas,
> 
> I'd like to report a regression in Linux 4.18.1 regarding the L1TF patches.
> 
> The kernel no longer thinks I have SMT enabled in the BIOS. This works fine in
> 4.18.0.
> 
> Not sure if this matters, but in my particular 4-core system, my third core is
> broken (core #2). So I must boot using "maxcpus=2" and then online the other
> cores & SMT threads at startup using:
> 
> echo 1 > /sys/devices/system/cpu/cpu3/online
> echo 1 > /sys/devices/system/cpu/cpu4/online
> echo 1 > /sys/devices/system/cpu/cpu5/online
> echo 1 > /sys/devices/system/cpu/cpu7/online
> 
> In 4.18.0, dmesg shows:
> 
> smpboot: Booting Node 0 Processor 3 APIC 0x6
> smpboot: Booting Node 0 Processor 4 APIC 0x1
> smpboot: Booting Node 0 Processor 5 APIC 0x3
> smpboot: Booting Node 0 Processor 7 APIC 0x7
> 
> In 4.18.1, dmesg shows:
> 
> smpboot: Booting Node 0 Processor 3 APIC 0x6
> smpboot: Booting Node 0 Processor 4 APIC 0x1
> smpboot: CPU 4 is now offline
> smpboot: Booting Node 0 Processor 5 APIC 0x3
> smpboot: CPU 5 is now offline
> smpboot: Booting Node 0 Processor 7 APIC 0x7
> smpboot: CPU 7 is now offline
> 
> and I get an "Operation cancelled" error in the shell when trying to online 4,
> 5, and 7.
> 
> In 4.18.1, /sys/devices/system/cpu/smt/control says "notsupported".
> 
>  - - -
> 
> A possible second regression is the following:
> 
> My CPU normally runs at 3600 MHz. I usually run my CPU at 2800 MHz to keep from
> overheating under full load (it is a fanless system). I do this by running
> "echo 1 > /sys/class/thermal/cooling_device5/cur_state", and confirm with "cat
> /proc/cpuinfo" (shows 2800).
> 
> This works in 4.18.0 but not in 4.18.1. I get no error from the "echo" command
> (and the state reads back as "1"), but the CPU remains running at 3600 MHz.

How about Linus's tree at the moment, is it ok there?

thanks,

greg k-h
