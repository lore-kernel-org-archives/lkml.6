Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751806AbeCZGks (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 02:40:48 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:50875 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbeCZGkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 02:40:46 -0400
X-Google-Smtp-Source: AIpwx4+e5dkc726fhjoMprdAxs6wtAhx9fIrG4o1Z1hKqgkr93UFTaWaFX8YeuRDfBnrYswc93hptg==
Date: Mon, 26 Mar 2018 08:40:42 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
        Eric Dumazet <edumazet@google.com>, x86 <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v3 1/2] x86, msr: allow rdmsr_safe_on_cpu() to schedule
Message-ID: <20180326064042.c6xod5n24kqttdiw@gmail.com>
References: <20180323215818.127774-1-edumazet@google.com>
 <20180324080946.3db4xdkl5i6jx2rc@gmail.com>
 <336355a3-c11d-44fc-0642-671670980ac0@gmail.com>
 <20180325141242.GC21878@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180325141242.GC21878@pd.tnic>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Sat, Mar 24, 2018 at 07:29:48AM -0700, Eric Dumazet wrote:
> > It is named gsysd, "Google System Tool", a daemon+cli that is run 
> > on all machines in production to provide a generic interface
> > for interacting with the system hardware.
> 
> So I'm wondering if poking at the hardware like that is a really optimal
> design. Maybe it would be cleaner if the OS would provide properly
> abstracted sysfs interfaces instead of raw MSRs.

It's not ideal to read /dev/msr.

A SysFS interface to enumerate 'system statistics' MSRs already exists via perf, 
under:

  /sys/bus/event_source/devices/msr/events/

This is for simple platform specific hardware statistics counters.

This is implemented in arch/x86/events/msr.c, with a number of MSRs already 
abstracted out:

enum perf_msr_id {
        PERF_MSR_TSC                    = 0,
        PERF_MSR_APERF                  = 1,
        PERF_MSR_MPERF                  = 2,
        PERF_MSR_PPERF                  = 3,
        PERF_MSR_SMI                    = 4,
        PERF_MSR_PTSC                   = 5,
        PERF_MSR_IRPERF                 = 6,
        PERF_MSR_THERM                  = 7,
        PERF_MSR_THERM_SNAP             = 8,
        PERF_MSR_THERM_UNIT             = 9,
        PERF_MSR_EVENT_MAX,
};

It's very easy to add new MSRs:

 9ae21dd66b97: perf/x86/msr: Add support for MSR_IA32_THERM_STATUS
 aaf248848db5: perf/x86/msr: Add AMD IRPERF (Instructions Retired) performance counter
 8a2242618477: perf/x86/msr: Add AMD PTSC (Performance Time-Stamp Counter) support

This commit added an MSR to msr-index and added MSR event support for it as well 
with proper CPU-ID dependent enumeration:

 8a2242618477: perf/x86/msr: Add AMD PTSC (Performance Time-Stamp Counter) support

 arch/x86/events/msr.c              | 8 ++++++++
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/include/asm/msr-index.h   | 1 +
 3 files changed, 10 insertions(+)

More complex MSR value encodings are supported as well - see for example 
MSR_IA32_THERM_STATUS, which is encoded as:

               /* if valid, extract digital readout, other set to -1 */
               now = now & (1ULL << 31) ? (now >> 16) & 0x3f :  -1;
               local64_set(&event->count, now);

If an MSR counter is a plain integer counter then no such code has to be added.

Only those MSRs that are valid on a system are 'live', and thus tooling can 
enumerate them programmatically and has easy symbolic access to them:

  galatea:~> perf list | grep msr/

  msr/aperf/                                         [Kernel PMU event]
  msr/cpu_thermal_margin/                            [Kernel PMU event]
  msr/mperf/                                         [Kernel PMU event]
  msr/smi/                                           [Kernel PMU event]
  msr/tsc/                                           [Kernel PMU event]

These can be used as simple counters that are read - and it's using perf not 
/dev/msr so they are fast and scalable - but the full set of perf features is also 
available, so we can do:

 galatea:~> perf stat -a -e msr/aperf/ sleep 1

 Performance counter stats for 'system wide':

       354,442,500      msr/aperf/                                                  

       1.001918252 seconds time elapsed

This interface is vastly superior to /dev/msr: it does not have the various 
usability, scalability and security limitations of /dev/msr.

/dev/msr is basically for debugging.

If performance matters then the relevant MSR events should be added and gsysd 
should be updated to support MSR events.

Thanks,

	Ingo
