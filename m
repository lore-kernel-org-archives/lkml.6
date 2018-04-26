Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754777AbeDZW2R (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:28:17 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:33790 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753881AbeDZW2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:28:15 -0400
X-Google-Smtp-Source: AB8JxZqpF5taSygaFFbTgssbrnKLtHepdC59HjQrIX2C0Z3HsXunpO1v3l5ZGHxn+V/gJJKchcaYDkY5P2v+7bq0lOw=
MIME-Version: 1.0
In-Reply-To: <1523898937.22952.13.camel@amazon.de>
References: <1523545958-28059-1-git-send-email-karahmed@amazon.de>
 <1523545958-28059-2-git-send-email-karahmed@amazon.de> <CALMp9eSS4nL1-1i1Df=vyPFT1FZVprPB0Yx-JX0auknNc09Gtg@mail.gmail.com>
 <1523898937.22952.13.camel@amazon.de>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 26 Apr 2018 15:28:13 -0700
Message-ID: <CALMp9eS6D4pfbGEfcz7MpRncTte5weUJE9g-C_qMVxnaGd+RtQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kvm: nVMX: Introduce KVM_CAP_STATE
To: "Raslan, KarimAllah" <karahmed@amazon.de>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll send out a patch to deal with nested_run_pending.

The other thing that comes to mind is that there are some new fields
in the VMCS12 since I first implemented this. One potentially
troublesome field is the VMX preemption timer. If the current timer
value is not saved on VM-exit, then it won't be stashed in the shadow
VMCS12 by sync_vmcs12. Post-migration, the timer will be reset to its
original value.

Do we care? Is this any different from what happens on real hardware
when there's an SMI? According to the SDM, this appears to be exacty
what happens when the dual-monitor treatment of SMIs and SMM is
active, but it's not clear what happens with the default treatment of
SMIs and SMM.

On Mon, Apr 16, 2018 at 10:15 AM, Raslan, KarimAllah <karahmed@amazon.de> wrote:
> On Mon, 2018-04-16 at 09:22 -0700, Jim Mattson wrote:
>> On Thu, Apr 12, 2018 at 8:12 AM, KarimAllah Ahmed <karahmed@amazon.de> wrote:
>>
>> >
>> > v2 -> v3:
>> > - Remove the forced VMExit from L2 after reading the kvm_state. The actual
>> >   problem is solved.
>> > - Rebase again!
>> > - Set nested_run_pending during restore (not sure if it makes sense yet or
>> >   not).
>>
>> This doesn't actually make sense. Nested_run_pending should only be
>> set between L1 doing a VMLAUNCH/VMRESUME and the first instruction
>> executing in L2. That is extremely unlikely at a restore point.
>
> Yeah, I am afraid I put very little thought into it as I was focused
> on the TSC issue :)
>
> Will handle it properly in next version.
>
>>
>> To deal with nested_run_pending and nested save/restore,
>> nested_run_pending should be set to 1 before calling
>> enter_vmx_non_root_mode, as it was prior to commit 7af40ad37b3f. That
>> means that it has to be cleared when emulating VM-entry to the halted
>> state (prior to calling kvm_vcpu_halt). And all of the from_vmentry
>> arguments that Paolo added when rebasing commit cf8b84f48a59 should be
>> removed, so that nested_run_pending is propagated correctly duting a
>> restore.
>>
>> It should be possible to eliminate this strange little wart, but I
>> haven't looked deeply into it.
>>
> Amazon Development Center Germany GmbH
> Berlin - Dresden - Aachen
> main office: Krausenstr. 38, 10117 Berlin
> Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
> Ust-ID: DE289237879
> Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
