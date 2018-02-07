Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbeBGRfh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:35:37 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:54634 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753721AbeBGRfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:35:34 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, douly.fnst@cn.fujitsu.com,
        joro@8bytes.org, uobergfe@redhat.com, prarit@redhat.com
References: <20180125141134.25053-1-bhe@redhat.com>
        <20180125141134.25053-2-bhe@redhat.com> <87h8qsd8s8.fsf@xmission.com>
Date: Wed, 07 Feb 2018 11:35:20 -0600
In-Reply-To: <87h8qsd8s8.fsf@xmission.com> (Eric W. Biederman's message of
        "Wed, 07 Feb 2018 11:11:35 -0600")
Message-ID: <877erobt47.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ejTd7-0002j2-6s;;;mid=<877erobt47.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+z+fNSgp5tSKTc5LWG5YH8bnNBf4WfyH4=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Baoquan He <bhe@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 405 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.2 (0.6%), b_tie_ro: 1.45 (0.4%), parse: 0.74 (0.2%),
        extract_message_metadata: 12 (3.0%), get_uri_detail_list: 2.3 (0.6%),
        tests_pri_-1000: 8 (1.9%), tests_pri_-950: 1.60 (0.4%), tests_pri_-900: 1.37
        (0.3%), tests_pri_-400: 39 (9.7%), check_bayes: 38 (9.3%), b_tokenize: 15
        (3.7%), b_tok_get_all: 13 (3.2%), b_comp_prob: 4.2 (1.0%), b_tok_touch_all:
        3.6 (0.9%), b_finish: 0.60 (0.1%), tests_pri_0: 330 (81.5%),
        check_dkim_signature: 0.69 (0.2%), check_dkim_adsp: 2.9 (0.7%),
        tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 1/2] x86/apic/kexec: Enable legacy irq mode before jump to kexec/kdump kernel
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Baoquan He <bhe@redhat.com> writes:
>
>> On kvm guest, kernel always prints warning during kdump kernel boots as
>> below.
>>
>> [    0.001000] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/apic/apic.c:1467 setup_local_APIC+0x228/0x330
>> [    0.001000] Modules linked in:
>> [    0.001000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.15.0-rc5+ #3
>> [    0.001000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1.fc26 04/01/2014
>> [    0.001000] RIP: 0010:setup_local_APIC+0x228/0x330
>> [    0.001000] RSP: 0000:ffffffffb6e03eb8 EFLAGS: 00010286
>> [    0.001000] RAX: 0000009edb4c4d84 RBX: 0000000000000000 RCX: 00000000b099d800
>> [    0.001000] RDX: 0000009e00000000 RSI: 0000000000000000 RDI: 0000000000000810
>> [    0.001000] RBP: 0000000000000000 R08: ffffffffffffffff R09: 0000000000000001
>> [    0.001000] R10: ffff98ce6a801c00 R11: 0761076d072f0776 R12: 0000000000000001
>> [    0.001000] R13: 00000000000000f0 R14: 0000000000004000 R15: ffffffffffffc6ff
>> [    0.001000] FS:  0000000000000000(0000) GS:ffff98ce6bc00000(0000) knlGS:0000000000000000
>> [    0.001000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    0.001000] CR2: 00000000ffffffff CR3: 0000000022209000 CR4: 00000000000406b0
>> [    0.001000] Call Trace:
>> [    0.001000]  apic_bsp_setup+0x56/0x74
>> [    0.001000]  x86_late_time_init+0x11/0x16
>> [    0.001000]  start_kernel+0x3c9/0x486
>> [    0.001000]  secondary_startup_64+0xa5/0xb0
>> [    0.001000] Code: 00 85 c9 74 2d 0f 31 c1 e1 0a 48 c1 e2 20 41 89 cf 4c 03 7c 24 08 48 09 d0 49 29 c7 4c 89 3c 24 48 83 3c 24 00 0f 8f 8f fe ff
>> ff <0f> ff e9 10 ff ff ff 48 83 2c 24 01 eb e7 48 83 c4 18 5b 5d 41
>> [    0.001000] ---[ end trace b88e71b9a6ebebdd ]---
>> [    0.001000] masked ExtINT on CPU#0
>>
>> The root cause is the legacy irq mode is disabled before jump to kexec/kdump
>> kernel since commit 522e66464467 ("x86/apic: Disable I/O APIC before shutdown
>> of the local APIC"). In that commit, lapic_shutdown() calling was moved after
>> disable_IO_APIC(). In fact in disable_IO_APIC(), it not only calls
>> clear_IO_APIC() to disable IO-APIC, and also sets LAPIC and IO-APIC to make
>> system be PIC or Virtual wire mode. Hence local APIC is disabled completely
>> by the calling of lapic_shutdown().
>
> The actions of lapic_shutdown do not depend on the actions of
> disable_IO_APIC so this description and justificaiton are nonsense.
>
> Further we don't hardware disable the local APIC except when we hardware
> enable it.  And only on 32bit at that.
>
> I keep wondering if the above oops is due to an emulation bug in kvm.
> If that is the case it might be better to fix kvm.

Sigh.  Reading a little deeper I see where the local apic is affected.
It is the work of disconnect_bsp_APIC called from disable_IO_APIC.

Calling lapic_shutdown (which clears the local apic) after the local
apic has been placed into virtual wire mode would indeed be a problem.

Now that I see that I agree in essence with this patch series.
I don't agree with the implemenation details.

Can you please split disable_IO_APIC and switch_to_legacy_irq_mode
in a single patch.

In a second patch just perform the code motion and place
switch_to_legacy_irq_mode after lapic_shutdown() where disable_IO_APIC
used to be.

If you do just that the code will make much more sense and will be a
candidate for backporting to stable.  As it is a fix for an old
regression.

With a patch title that restores the ordering and achieves this affect
something like: "Fix enabling legacy irq mode in reboot and kexec/kdump"

You subject line above makes it sounds like enabling legacy irq mode is
something new when in fact it is what the code has been trying to do all
along.  All that happened is that a bug slipped in, and you are fixing
it.

Eric
