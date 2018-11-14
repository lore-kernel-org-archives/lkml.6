Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA4DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6115B21582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6115B21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388163AbeKOIjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:39:54 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52368 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeKOIjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:39:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2874B80D;
        Wed, 14 Nov 2018 14:34:47 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D711A3F5A0;
        Wed, 14 Nov 2018 14:34:46 -0800 (PST)
Date:   Wed, 14 Nov 2018 22:34:43 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, al.cooperx@gmail.com, tony@atomide.com,
        linux@armlinux.org.uk
Subject: Re: ARM builtin perf tests for breakpoint failures
Message-ID: <20181114223442.GA4399@brain-police>
References: <2433ea10-8bdc-f9bc-8d53-f6bda4018564@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2433ea10-8bdc-f9bc-8d53-f6bda4018564@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Wed, Nov 14, 2018 at 12:21:12PM -0800, Florian Fainelli wrote:
> I have been trying to debug some perf builtin tests on ARM 32-bit and
> found that "Breakpoint overflow signal handler" and "Breakpoint overflow
> sampling" were failing, but there are a number of reasons for that and
> they may fail in seemingly unexpected ways.
> 
> My perf binary is built in Thumb2 because that is what the toolchain
> produces by default. Going through the rabbit hole, I found the
> following failure scenarios.
> 
> 1) If __test_function()'s addresss has the Thumb bit set, then we set a
> breakpoint length (bp_len = sizeof(long)) which makes us fail to
> validate the event in hw_breakpoint_arch_parse() and we return -EINVAL
> from SYS_perf_event_open(). This is because the offset computed has a
> value of 1 (function address is e.g:  0x0004c169), but we requested a
> bp_len of 4. The test fails right away.
> 
> 2) If we correct the test such that if addr & 1 == true then we set
> bp_len = 2, then we can see that the test runs to completion, but the
> perf breakpoint event count returns 0 and indeed, no SIGIO is ever
> delivered. This is presumably because of the alignment_mask value of 0x3
> in hw_breakpoint_arch_parse() which would strip the Thumb bit and not
> allow matching it when set assign info->address &= ~alignment_mask. We
> would indeed not have the HW hit that breakpoint at all.
> 
> 3) If we keep the fix from 2) and also change the the alignment_mask to
> 0x2 to preserve the Thumb bit, then we can run into what is described as
> 4) below.
> 
> 4) if __test_function()'s address does not have the Thumb bit set (which
> surprisingly can happen even if test_function does, go figure), then we
> will set a bp_len = 4, and then we are just stuck in an infinite SIGIO
> delivery that looks like this:
> 
> [pid  1859] perf_event_open(0xbebee790, 0, -1, -1, 0x8 /* PERF_FLAG_???
> */) = 3
> [pid  1859] fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK|O_ASYNC) = 0
> [pid  1859] fcntl64(3, F_SETSIG, 0x1d)  = 0
> [pid  1859] fcntl64(3, F_SETOWN, 1859)  = 0
> [pid  1859] ioctl(3, PERF_EVENT_IOC_RESET, 0) = 0
> [pid  1859] ioctl(3, PERF_EVENT_IOC_ENABLE, 0) = 0
> [pid  1859] --- SIGIO {si_signo=SIGIO, si_code=POLL_IN, si_band=65} ---
> [pid  1859] rt_sigreturn()
> 
> and on and on, we can't even see gettimeofday() begin called in that case.
> 
> This is observable on both 4.9.135 and 4.19 on ARMv7 and ARMv8 CPUs
> running in AArch32.
> 
> I am not clear how to fix that properly, since there appears to be a
> nesting of problems here.

This came up a few years ago iirc and I think most of this boils down to the
fact that we require the overflow handler to do the stepping on arm/arm64,
which is relied upon by GDB/ptrace. The hw_breakpoint code is a complete
disaster so my preference would be to rip out the perf part and just
implement something directly in ptrace, but it's a pretty horrible job.

Are you actually using the perf interface to hw_breakpoint for something
useful?

Will
