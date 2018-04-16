Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753409AbeDPQWw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:22:52 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33143 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbeDPQWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:22:49 -0400
X-Google-Smtp-Source: AIpwx48ozxEchXoEMjPOnQo4K322EYL+SWA0wsxO3OT59qEjN6f/Uld5EDi+DXIoEb8EX16pJHxHNPRsY3wmp+3C1PM=
MIME-Version: 1.0
In-Reply-To: <1523545958-28059-2-git-send-email-karahmed@amazon.de>
References: <1523545958-28059-1-git-send-email-karahmed@amazon.de> <1523545958-28059-2-git-send-email-karahmed@amazon.de>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 16 Apr 2018 09:22:47 -0700
Message-ID: <CALMp9eSS4nL1-1i1Df=vyPFT1FZVprPB0Yx-JX0auknNc09Gtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kvm: nVMX: Introduce KVM_CAP_STATE
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 8:12 AM, KarimAllah Ahmed <karahmed@amazon.de> wrote:

> v2 -> v3:
> - Remove the forced VMExit from L2 after reading the kvm_state. The actual
>   problem is solved.
> - Rebase again!
> - Set nested_run_pending during restore (not sure if it makes sense yet or
>   not).

This doesn't actually make sense. Nested_run_pending should only be
set between L1 doing a VMLAUNCH/VMRESUME and the first instruction
executing in L2. That is extremely unlikely at a restore point.

To deal with nested_run_pending and nested save/restore,
nested_run_pending should be set to 1 before calling
enter_vmx_non_root_mode, as it was prior to commit 7af40ad37b3f. That
means that it has to be cleared when emulating VM-entry to the halted
state (prior to calling kvm_vcpu_halt). And all of the from_vmentry
arguments that Paolo added when rebasing commit cf8b84f48a59 should be
removed, so that nested_run_pending is propagated correctly duting a
restore.

It should be possible to eliminate this strange little wart, but I
haven't looked deeply into it.
