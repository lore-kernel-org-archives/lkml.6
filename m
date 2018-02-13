Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965397AbeBMRpK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:45:10 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:34754 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965057AbeBMRpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:45:09 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        x86@kernel.org, douly.fnst@cn.fujitsu.com, joro@8bytes.org,
        uobergfe@redhat.com, prarit@redhat.com
References: <20180209121008.28980-1-bhe@redhat.com>
        <20180209121008.28980-3-bhe@redhat.com> <87r2pq9a60.fsf@xmission.com>
        <20180213074355.GD13253@localhost.localdomain>
Date: Tue, 13 Feb 2018 11:44:47 -0600
In-Reply-To: <20180213074355.GD13253@localhost.localdomain> (Baoquan He's
        message of "Tue, 13 Feb 2018 15:43:55 +0800")
Message-ID: <87h8qk3htc.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1elede-0008Fy-Jm;;;mid=<87h8qk3htc.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+PAk5k+E7GigmMs9jWgGbUKWJc8kAc7Ko=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Baoquan He <bhe@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 302 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.7 (1.2%), b_tie_ro: 2.5 (0.8%), parse: 1.45 (0.5%),
        extract_message_metadata: 6 (2.0%), get_uri_detail_list: 3.4 (1.1%),
        tests_pri_-1000: 6 (1.8%), tests_pri_-950: 1.79 (0.6%), tests_pri_-900: 1.48
        (0.5%), tests_pri_-400: 29 (9.6%), check_bayes: 28 (9.2%), b_tokenize: 12
        (3.9%), b_tok_get_all: 8 (2.6%), b_comp_prob: 3.1 (1.0%), b_tok_touch_all:
        2.9 (1.0%), b_finish: 0.73 (0.2%), tests_pri_0: 232 (77.0%),
        check_dkim_signature: 0.64 (0.2%), check_dkim_adsp: 3.4 (1.1%),
        tests_pri_500: 8 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 2/5] x86/apic: Fix restoring boot irq mode in reboot and kexec/kdump
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:

> Hi Eric,
>
> On 02/11/18 at 09:08pm, Eric W. Biederman wrote:
>> Baoquan He <bhe@redhat.com> writes:
>> 
>> > This is a regression fix.
>> >
>> > Before, to fix erratum AVR31, commit 522e66464467 ("x86/apic: Disable
>> > I/O APIC before shutdown of the local APIC") moved lapic_shutdown()
>> > calling after disable_IO_APIC(). This introdued a regression. The
>> > root cause is that disable_IO_APIC() not only clears IO_APIC, also
>> > restore boot irq mode by setting LAPIC/APIC/IMCR, lapic_shutdown()
>> > after disable_IO_APIC() will disable LAPIC and ruin the possible
>> > virtual wire mode setting which the code has been trying to do all
>> > along.
>> > To fix this, just break down disable_IO_APIC(), then call
>> > clear_IO_APIC() to stop IO_APIC where disable_IO_APIC() was called,
>> > and call restore_boot_irq_mode() to restore boot irq mode before
>> > reboot or kexec/kdump jump.
>> 
>> Two things here.
>> a) This is missing a fixes tag and a CC stable.
>> b) What makes your change to the KEXEC_JUMP code path safe?
>>    Have the lapic and ioapic already been shut down?
>> 
>> The KEXEC_JUMP changes to machine_kexec_32.c and machine_kexec_64.c
>> either need to be documented in the change long why they are safe
>> so that this change becomes obviously safe and correct.
>
> Re-read the code, I have to admit I didn't check the KEXEC_JUMP code
> path carefully. 
>
> kernel_kexec() {
> 	if (kexec_image->preserve_context) {
> 		...
> 		freeze_processes();
> 		...
> 		disable_nonboot_cpus();
> 		...
> 		
> 	else {
> 		...
> 		machine_shutdown();
> 		...
> 	}
> 	machine_kexec(kexec_image);
> 	...
> }
>
>   --machine_shutdown()
>     --native_machine_shutdown()
>       --disable_IO_APIC()
>       --lapic_shutdown()
>
> machine_kexec() {
> 	...
> 	if (image->preserve_context) {
> 		disable_IO_APIC();
> 	}
> 	...
> }
>
> KEXEC_JUMP code path is different than kexec/kdump, it doesn't call
> lapic_shutdown() before jump. So commit 522e66464467
> ("x86/apic: Disable I/O APIC before shutdown of the local APIC") didn't
> impact it. And here I break down disable_IO_APIC() and change to only
> call restore_boot_irq_mode() to make a possible danger. I am not an
> expert on KEXEC_JUMP, and don't know how to test it, so will keep the
> code implementation consistent as before. For now, I plan to change it
> as below if you don't object. As you pointed out, I will describe this
> in patch log. 
>
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 1f790cf9d38f..cb0c2d0a4c99 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -297,7 +297,7 @@ void machine_kexec(struct kimage *image)
>                  * one form or other. kexec jump path also need
>                  * one.
>                  */
> -               disable_IO_APIC();
> +		clear_IO_APIC();
> +               restore_boot_irq_mode();
>  #endif
>         }
>
>

Let me give a very concrete suggestion:
Patch 1) Replace "disable_IO_APIC();" with "clear_IO_APIC(); restore_boot_irq_mode();"
Patch 2) Move restore_boot_irq_mode(); to fix the regression.

I think that will be a slightly shorter patch sequence than what you are
dealing with and one that is slightly easier to read.

We need to sort out KEXEC_JUMP but that is something for another time.

Eric
