Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965416AbeBMRlG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:41:06 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:57559 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965261AbeBMRlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:41:03 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>,
        <mingo@kernel.org>, <tglx@linutronix.de>, <x86@kernel.org>,
        <joro@8bytes.org>, <uobergfe@redhat.com>, <prarit@redhat.com>
References: <20180209121008.28980-1-bhe@redhat.com>
        <20180209121008.28980-3-bhe@redhat.com> <87r2pq9a60.fsf@xmission.com>
        <bb1a2eb2-335a-b789-4274-6b62dd5ef2ef@cn.fujitsu.com>
Date: Tue, 13 Feb 2018 11:40:41 -0600
In-Reply-To: <bb1a2eb2-335a-b789-4274-6b62dd5ef2ef@cn.fujitsu.com> (Dou
        Liyang's message of "Tue, 13 Feb 2018 10:43:52 +0800")
Message-ID: <87vaf03i06.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eleZh-0003Q4-3y;;;mid=<87vaf03i06.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/W+t1pil2vAjtUwFyBRnlMGjtABBghvd4=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Dou Liyang <douly.fnst@cn.fujitsu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1292 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 6 (0.4%), b_tie_ro: 4.5 (0.3%), parse: 1.71 (0.1%),
        extract_message_metadata: 33 (2.5%), get_uri_detail_list: 9 (0.7%),
        tests_pri_-1000: 9 (0.7%), tests_pri_-950: 2.3 (0.2%), tests_pri_-900: 1.90
        (0.1%), tests_pri_-400: 57 (4.4%), check_bayes: 54 (4.2%), b_tokenize: 24
        (1.8%), b_tok_get_all: 13 (1.0%), b_comp_prob: 7 (0.6%), b_tok_touch_all: 3.6
        (0.3%), b_finish: 0.88 (0.1%), tests_pri_0: 1166 (90.3%),
        check_dkim_signature: 1.27 (0.1%), check_dkim_adsp: 7 (0.5%), tests_pri_500:
        8 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 2/5] x86/apic: Fix restoring boot irq mode in reboot and kexec/kdump
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dou Liyang <douly.fnst@cn.fujitsu.com> writes:

> Hi Baoquan,
>
> At 02/12/2018 11:08 AM, Eric W. Biederman wrote:
>> Baoquan He <bhe@redhat.com> writes:
>>
>>> This is a regression fix.
>>>
>>> Before, to fix erratum AVR31, commit 522e66464467 ("x86/apic: Disable
>>> I/O APIC before shutdown of the local APIC") moved lapic_shutdown()
>>> calling after disable_IO_APIC(). This introdued a regression. The
>>> root cause is that disable_IO_APIC() not only clears IO_APIC, also
>>> restore boot irq mode by setting LAPIC/APIC/IMCR, lapic_shutdown()
>>> after disable_IO_APIC() will disable LAPIC and ruin the possible
>>> virtual wire mode setting which the code has been trying to do all
>>> along.
>>>
>>> The consequence is, in KVM guest kernel always prints warning as below
>>> during kexec/kdump kernel boots up. That happened in setup_local_APIC()
>>> since 'do { xxx } while (queued && max_loops > 0)' loop does not function
>
> I am not sure another thing here
>
> AFAIK, according to the order of SMP machine shutdown, other CPUs will
> be stopped firstly, then the last CPU disable its local apic.
>
>  --machine_shutdown
>    |----......
>    |----stop_other_cpus()
>    |----local_shutdown()
>
> So, the pending interrupts exist only in BSP and only be ACKed by
> BSP. is it right?(I validated this by print the value of APIC_IRR/ISR of
> all CPUs, found only BSP had the non-zero value).

We don't know.  In the kexec on panic case we try and shutdown the other
cpus but we have a timeout because we might fail.

Further you have to be careful with the concept of boot cpu.  In the
normal kexec case shutdown on the boot cpu and leave it running.  In the
kexec on panic case we shutdown on an arbitrary cpu.

> If it is right, We will do not need check the pending interrupt for each
> cpus.

It is also cheap if there are no pending interrupts as there is nothing
to do.

> BTW, the pending interrupt check code is mixed with the local
> APIC setup code, that looks messy. How about extracting the code which
> related to the crash interrupt check, put it into a new function and
> only invoked it when the CPU is BSP?

Moving it into it's own function makes sense.  Let's not taint the
concept with ``crash''.  We don't know that the only way this will
ever happen is from kexec on panic.   We only know it was easy to
trigger the condition from kexec on panic.

There are a lot of cases I can think of that interrupts might fire while
interrupts are disabled because the kernel is booting.  A normal kexec
is also possible.

Throw in MSI interrupts and transitioning from one state to another in
non-legacy apic mode and we might be more likely to get some irqs in
a pending state.

Your patch makes me nervous as it is not just code motion but a much
more substantial change.


As much as I agree that we need to fix the regression in the apic
shutdown code that is causing problems.  What we really need to do
is to completely remove the apic shutdown code from the kexec on panic
code path.  Over the long term that will provide us with a much more
robust path to getting crash dumps and the like.


Eric


> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 3fc259b4dd2d..0350528b320d 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -1408,6 +1408,57 @@ static void lapic_setup_esr(void)
>                         oldvalue, value);
>  }
>
> +
> +static void clear_crash_pending_intr(void)
> +{
> +       long long max_loops = cpu_khz ? cpu_khz : 1000000;
> +       unsigned long long tsc = 0, ntsc;
> +       unsigned int value, queued;
> +       int i, j, acked = 0;
> +
> +       if (boot_cpu_has(X86_FEATURE_TSC))
> +               tsc = rdtsc();
> +       /*
> +        * After a crash, we no longer service the interrupts and a pending
> +        * interrupt from previous kernel might still have ISR bit set.
> +        *
> +        * Most probably by now CPU has serviced that pending interrupt and
> +        * it might not have done the ack_APIC_irq() because it thought,
> +        * interrupt came from i8259 as ExtInt. LAPIC did not get EOI so it
> +        * does not clear the ISR bit and cpu thinks it has already serivced
> +        * the interrupt. Hence a vector might get locked. It was noticed
> +        * for timer irq (vector 0x31). Issue an extra EOI to clear ISR.
> +        */
> +       do {
> +               queued = 0;
> +               for (i = APIC_ISR_NR - 1; i >= 0; i--)
> +                       queued |= apic_read(APIC_IRR + i*0x10);
> +
> +               for (i = APIC_ISR_NR - 1; i >= 0; i--) {
> +                       value = apic_read(APIC_ISR + i*0x10);
> +                       for (j = 31; j >= 0; j--) {
> +                               if (value & (1<<j)) {
> +                                       ack_APIC_irq();
> +                                       acked++;
> +                               }
> +                       }
> +               }
> +               if (acked > 256) {
> +                       printk(KERN_ERR "LAPIC pending interrupts after %d
> EOI\n",
> +                              acked);
> +                       break;
> +               }
> +               if (queued) {
> +                       if (boot_cpu_has(X86_FEATURE_TSC) && cpu_khz) {
> +                               ntsc = rdtsc();
> +                               max_loops = (cpu_khz << 10) - (ntsc - tsc);
> +                       } else
> +                               max_loops--;
> +               }
> +       } while (queued && max_loops > 0);
> +       WARN_ON(max_loops <= 0);
> +}
> +
>  /**
>   * setup_local_APIC - setup the local APIC
>   *
> @@ -1417,13 +1468,7 @@ static void lapic_setup_esr(void)
>  void setup_local_APIC(void)
>  {
>         int cpu = smp_processor_id();
> -       unsigned int value, queued;
> -       int i, j, acked = 0;
> -       unsigned long long tsc = 0, ntsc;
> -       long long max_loops = cpu_khz ? cpu_khz : 1000000;
> -
> -       if (boot_cpu_has(X86_FEATURE_TSC))
> -               tsc = rdtsc();
> -               tsc = rdtsc();
> +       unsigned int value;
>
>         if (disable_apic) {
>                 disable_ioapic_support();
> @@ -1475,45 +1520,8 @@ void setup_local_APIC(void)
>         value &= ~APIC_TPRI_MASK;
>         apic_write(APIC_TASKPRI, value);
>
> -       /*
> -        * After a crash, we no longer service the interrupts and a pending
> -        * interrupt from previous kernel might still have ISR bit set.
> -        *
> -        * Most probably by now CPU has serviced that pending interrupt and
> -        * it might not have done the ack_APIC_irq() because it thought,
> -        * interrupt came from i8259 as ExtInt. LAPIC did not get EOI so it
> -        * does not clear the ISR bit and cpu thinks it has already serivced
> -        * the interrupt. Hence a vector might get locked. It was noticed
> -        * for timer irq (vector 0x31). Issue an extra EOI to clear ISR.
> -        */
> -       do {
> -               queued = 0;
> -               for (i = APIC_ISR_NR - 1; i >= 0; i--)
> -                       queued |= apic_read(APIC_IRR + i*0x10);
> -
> -               for (i = APIC_ISR_NR - 1; i >= 0; i--) {
> -                       value = apic_read(APIC_ISR + i*0x10);
> -                       for (j = 31; j >= 0; j--) {
> -                               if (value & (1<<j)) {
> -                                       ack_APIC_irq();
> -                                       acked++;
> -                               }
> -                       }
> -               }
> -               if (acked > 256) {
> -                       printk(KERN_ERR "LAPIC pending interrupts after %d
> EOI\n",
> -                              acked);
> -                       break;
> -               }
> -               if (queued) {
> -                       if (boot_cpu_has(X86_FEATURE_TSC) && cpu_khz) {
> -                               ntsc = rdtsc();
> -                               max_loops = (cpu_khz << 10) - (ntsc - tsc);
> -                       } else
> -                               max_loops--;
> -               }
> -       } while (queued && max_loops > 0);
> -       WARN_ON(max_loops <= 0);
> +       if (!cpu)
> +               clear_crash_pending_intr();
>
>         /*
>          * Now that we are all set up, enable the APIC
>
>
> Thanks,
> 	dou.
