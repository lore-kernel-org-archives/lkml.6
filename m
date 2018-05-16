Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeEPE6I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 00:58:08 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35264 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeEPE6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 00:58:06 -0400
X-Google-Smtp-Source: AB8JxZrOsmwDWt27hGLT9uJe4PIvM76jiHaLk7CNoungTXOoLfzvpvweFBPeiigiuc6Lap1eLNcp4A==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 8/9] perf/breakpoint: Split breakpoint "check" and "commit"
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15E302)
In-Reply-To: <20180516031059.GA2271@lerouge>
Date: Tue, 15 May 2018 21:58:03 -0700
Cc: Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>,
        Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Message-Id: <99DA1A94-6AF6-4B9A-858A-7018D58CC38E@amacapital.net>
References: <1525634395-23380-1-git-send-email-frederic@kernel.org> <1525634395-23380-9-git-send-email-frederic@kernel.org> <20180509091703.GH12217@hirez.programming.kicks-ass.net> <20180516031059.GA2271@lerouge>
To: Frederic Weisbecker <frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4G4wEK7031012



> On May 15, 2018, at 8:11 PM, Frederic Weisbecker <frederic@kernel.org> wrote:
> 
>> On Wed, May 09, 2018 at 11:17:03AM +0200, Peter Zijlstra wrote:
>>> On Sun, May 06, 2018 at 09:19:54PM +0200, Frederic Weisbecker wrote:
>>> arch/arm/include/asm/hw_breakpoint.h     |  5 ++++-
>>> arch/arm/kernel/hw_breakpoint.c          | 22 +++-------------------
>>> arch/arm64/include/asm/hw_breakpoint.h   |  5 ++++-
>>> arch/arm64/kernel/hw_breakpoint.c        | 22 +++-------------------
>>> arch/powerpc/include/asm/hw_breakpoint.h |  5 ++++-
>>> arch/powerpc/kernel/hw_breakpoint.c      | 22 +++-------------------
>>> arch/sh/include/asm/hw_breakpoint.h |  5 ++++-
>>> arch/sh/kernel/hw_breakpoint.c           | 22 +++-------------------
>>> arch/x86/include/asm/hw_breakpoint.h     |  5 ++++-
>>> arch/x86/kernel/hw_breakpoint.c          | 23 +++--------------------
>>> arch/xtensa/include/asm/hw_breakpoint.h  |  5 ++++-
>>> arch/xtensa/kernel/hw_breakpoint.c       | 22 +++-------------------
>> 
>> Because of those ^,
>> 
>>> kernel/events/hw_breakpoint.c            | 11 ++++++-----
>> 
>> would it not make sense to have a prelimenary patch doing something
>> like:
>> 
>> __weak int hw_breakpoint_arch_check(struct perf_event *bp)
>> {
>>    return arch_validate_hwbkpt_settings(bp);
>> }
> 
> So eventually I fear I can't do that, due to linking order.
> 
> Say I convert x86 to implement hw_breakpoint_arch_check(), so I
> remove arch_validate_hwbkpt_settings(). On build time, the weak version
> is still compiled and can't find a declaration for arch_validate_hwbkpt_settings().
> 
> I tried to keep the declaration while the definition has been removed but
> it seems the weak version is linked first before it gets later replaced by
> the overriden arch version. So I get a build error.
> 
> I could keep arch_validate_hwbkpt_settings() around on all archs and remove it in
> the end with the weak version but that would defeat the purpose of removing
> the mid-state in the current patch.

How about just not using weak functions?  Weak functions have annoying issues like this, and they have trouble generating good code. I much prefer the pattern:

in arch header:
extern void arch_func(whatever);
#define arch_func arch_func

in generic header:
#ifndef arch_func
static inline void arch_func(whatever) ...
#endif
