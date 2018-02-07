Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754836AbeBGTtM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 14:49:12 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:52826 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754822AbeBGTtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 14:49:09 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, douly.fnst@cn.fujitsu.com,
        joro@8bytes.org, uobergfe@redhat.com, prarit@redhat.com
References: <20180125141134.25053-1-bhe@redhat.com>
        <20180125141134.25053-2-bhe@redhat.com> <87h8qsd8s8.fsf@xmission.com>
        <877erobt47.fsf@xmission.com>
Date: Wed, 07 Feb 2018 13:48:54 -0600
In-Reply-To: <877erobt47.fsf@xmission.com> (Eric W. Biederman's message of
        "Wed, 07 Feb 2018 11:35:20 -0600")
Message-ID: <87eflwa8d5.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ejViN-0004xS-Si;;;mid=<87eflwa8d5.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/+xxsHNY8lzhNo5Sycypzh9tzhO9DfzL0=
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
X-Spam-Timing: total 306 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.6 (0.9%), b_tie_ro: 1.87 (0.6%), parse: 0.84 (0.3%),
        extract_message_metadata: 11 (3.5%), get_uri_detail_list: 2.3 (0.7%),
        tests_pri_-1000: 5 (1.8%), tests_pri_-950: 1.26 (0.4%), tests_pri_-900: 0.99
        (0.3%), tests_pri_-400: 27 (8.9%), check_bayes: 26 (8.5%), b_tokenize: 9
        (2.9%), b_tok_get_all: 9 (2.9%), b_comp_prob: 2.7 (0.9%), b_tok_touch_all:
        3.8 (1.2%), b_finish: 0.59 (0.2%), tests_pri_0: 250 (81.9%),
        check_dkim_signature: 0.48 (0.2%), check_dkim_adsp: 2.8 (0.9%),
        tests_pri_500: 3.8 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 1/2] x86/apic/kexec: Enable legacy irq mode before jump to kexec/kdump kernel
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> Baoquan He <bhe@redhat.com> writes:
>>
>>> On kvm guest, kernel always prints warning during kdump kernel boots as
>>> below.
>>>
>>> [    0.001000] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/apic/apic.c:1467 setup_local_APIC+0x228/0x330
>>> [    0.001000] Modules linked in:
>>> [    0.001000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.15.0-rc5+ #3
>>> [    0.001000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1.fc26 04/01/2014
>>> [    0.001000] RIP: 0010:setup_local_APIC+0x228/0x330
>>> [    0.001000] RSP: 0000:ffffffffb6e03eb8 EFLAGS: 00010286
>>> [    0.001000] RAX: 0000009edb4c4d84 RBX: 0000000000000000 RCX: 00000000b099d800
>>> [    0.001000] RDX: 0000009e00000000 RSI: 0000000000000000 RDI: 0000000000000810
>>> [    0.001000] RBP: 0000000000000000 R08: ffffffffffffffff R09: 0000000000000001
>>> [    0.001000] R10: ffff98ce6a801c00 R11: 0761076d072f0776 R12: 0000000000000001
>>> [    0.001000] R13: 00000000000000f0 R14: 0000000000004000 R15: ffffffffffffc6ff
>>> [    0.001000] FS:  0000000000000000(0000) GS:ffff98ce6bc00000(0000) knlGS:0000000000000000
>>> [    0.001000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [    0.001000] CR2: 00000000ffffffff CR3: 0000000022209000 CR4: 00000000000406b0
>>> [    0.001000] Call Trace:
>>> [    0.001000]  apic_bsp_setup+0x56/0x74
>>> [    0.001000]  x86_late_time_init+0x11/0x16
>>> [    0.001000]  start_kernel+0x3c9/0x486
>>> [    0.001000]  secondary_startup_64+0xa5/0xb0
>>> [    0.001000] Code: 00 85 c9 74 2d 0f 31 c1 e1 0a 48 c1 e2 20 41 89 cf 4c 03 7c 24 08 48 09 d0 49 29 c7 4c 89 3c 24 48 83 3c 24 00 0f 8f 8f fe ff
>>> ff <0f> ff e9 10 ff ff ff 48 83 2c 24 01 eb e7 48 83 c4 18 5b 5d 41
>>> [    0.001000] ---[ end trace b88e71b9a6ebebdd ]---
>>> [    0.001000] masked ExtINT on CPU#0
>>>
>>> The root cause is the legacy irq mode is disabled before jump to kexec/kdump
>>> kernel since commit 522e66464467 ("x86/apic: Disable I/O APIC before shutdown
>>> of the local APIC"). In that commit, lapic_shutdown() calling was moved after
>>> disable_IO_APIC(). In fact in disable_IO_APIC(), it not only calls
>>> clear_IO_APIC() to disable IO-APIC, and also sets LAPIC and IO-APIC to make
>>> system be PIC or Virtual wire mode. Hence local APIC is disabled completely
>>> by the calling of lapic_shutdown().
>>
>> The actions of lapic_shutdown do not depend on the actions of
>> disable_IO_APIC so this description and justificaiton are nonsense.
>>
>> Further we don't hardware disable the local APIC except when we hardware
>> enable it.  And only on 32bit at that.
>>
>> I keep wondering if the above oops is due to an emulation bug in kvm.
>> If that is the case it might be better to fix kvm.
>
> Sigh.  Reading a little deeper I see where the local apic is affected.
> It is the work of disconnect_bsp_APIC called from disable_IO_APIC.
>
> Calling lapic_shutdown (which clears the local apic) after the local
> apic has been placed into virtual wire mode would indeed be a problem.
>
> Now that I see that I agree in essence with this patch series.
> I don't agree with the implemenation details.
>
> Can you please split disable_IO_APIC and switch_to_legacy_irq_mode
> in a single patch.

Now that I think about it can you call the function not
switch_to_legacy_irq_mode but restore_boot_irq_mode.  And the
corresponding x86_io_apic_ops not .disable but .restore.

That should make the purpose of the code clearer, and help avoid
mistakes like the one that led to this regression.

Eric
