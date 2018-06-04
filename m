Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753903AbeFDOMY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:12:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753532AbeFDOMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:12:22 -0400
Subject: Re: [PATCH] perf/x86: read the FREEZE_WHILE_SMM bit during boot
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Donald Zickus <dzickus@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>
References: <1528050223-144925-1-git-send-email-darcari@redhat.com>
 <20180604082414.GO12217@hirez.programming.kicks-ass.net>
From: David Arcari <darcari@redhat.com>
Organization: Red Hat
Message-ID: <e420bcc1-c75d-e6a1-0ca6-b668b6818f16@redhat.com>
Date: Mon, 4 Jun 2018 10:12:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180604082414.GO12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2018 04:24 AM, Peter Zijlstra wrote:
> On Sun, Jun 03, 2018 at 02:23:43PM -0400, David Arcari wrote:
>> On some systems pressing the external NMI button is now failing to inject
>> an NMI 5-10% of the time.  This causes confusion for a user that expects
>> the NMI to dump the system.
>>
>> Commit 6089327f5424 ("perf/x86: Add sysfs entry to freeze counters on SMI")
>> does not read the firmware setting of the FREEZE_WHILE_SMM bit and will
>> always clear it when the PMU is initialized.  As a result the performance
>> counters will always run and that greatly expands the race in which
>> external NMI will not be processed if a local NMI is already being
>> processed.
>>
>> One option is to change default_do_nmi().  The code snippet below shows the
>> relevant portion of a patch that resolves the issue, but it is problematic
>> from a performance perspective and was dismissed.
>>
>> -345,7 +345,17 @@ static void default_do_nmi(struct pt_regs *regs)
>>  		 */
>>  		if (handled > 1)
>>  			__this_cpu_write(swallow_nmi, true);
>> -		return;
>> +
>> +		/*
>> +		 * Unfortunately, there is a race condition which can
>> +		 * result in a missing an external NMI.  Typically, an
>> +		 * external NMI is processed on cpu 0.  Therefore, on
>> +		 * cpu 0 check for an external NMI before returning.
>> +		 */
>> +		if (smp_processor_id() ||
>> +		    (x86_platform.get_nmi_reason() & NMI_REASON_MASK) == 0) {
>> +			return;
>> +		}
>>  	}
>>
>> Ultimately, the issue can be resolved by storing the default firmware
>> setting of FREEZE_WHILE_SMM before initializing the PMU.
> 
> I'm sorry, I know it's Monday morning, but what?! I really don't
> understand anything you write there.
> 
> Maybe if you explain the race and how your proposed fix closes it things
> will make sense. The above refers to too many things not here.
> 

Sorry.

default_do_nmi() will process both perf events (local interrupts) as well as
external interrupts (such as the NMI button).  The handler is coded such that
if a local interrupt occurs, no check is made for an external interrupt.
Therefore, if the two interrupts occur simultaneously, the external interrupt
is lost.

The code above, which was ultimately discounted, attempts to avoid this
scenario with as little performance impact as possible by reading the register
without the spinlock for cpu 0 only (currently only cpu 0 can handle an
external NMI, I verified this on my system by testing the NMI button with
cpu 0 offline).

The code above is problematic for a number of reasons not the least of which
is performance.  Furthermore, I don't see a less intrusive solution wrt
do_default_nmi().

Upstream 6089327f5424 ("perf/x86: Add sysfs entry to freeze counters on SMI")
appears to have made it relatively easy to hit this race condition.  On some
systems, this commit has resulted in a change to the default firmware setting
of DEBUGCTLMSR_FREEZE_IN_SMM_BIT (it is now cleared by the OS by default).

With this bit cleared, the following situation occurs:

1) external NMI - due to io check
2) long duration SMI (counters do not freeze)
3) NMI handler runs and misattributes interrupt to perf event

Ultimately, my solution was to restore the previous behavior by reading and
storing the firmware setting of the bit rather than to always clear it.
