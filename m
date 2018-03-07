Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754312AbeCGNPs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:15:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751156AbeCGNPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:15:44 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC 1/3] x86/kvm/vmx: read MSR_FS_BASE from current->thread
References: <20180302105503.24428-1-vkuznets@redhat.com>
        <20180302105503.24428-2-vkuznets@redhat.com>
        <CALCETrX0CB_+QvDH3B8fYdH+ekRRX-i=jZU7zQ8qYbGzDrM-uQ@mail.gmail.com>
Date: Wed, 07 Mar 2018 14:15:41 +0100
In-Reply-To: <CALCETrX0CB_+QvDH3B8fYdH+ekRRX-i=jZU7zQ8qYbGzDrM-uQ@mail.gmail.com>
        (Andy Lutomirski's message of "Fri, 2 Mar 2018 20:18:18 +0000")
Message-ID: <87po4gxc02.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> On Fri, Mar 2, 2018 at 10:55 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> vmx_save_host_state() is only called from kvm_arch_vcpu_ioctl_run() so
>> the context is pretty well defined
>>
>
> True.
>
>> and MSR_FS_BASE should always be
>> equal to current->thread.fsbase.
>
> Not true.  current->thread.fsbase is almost entirely undefined in this
> context.  What you *could* do is export save_fsgs() and call it first.
> When FSGSBASE support lands (which will happen eventually!), the code
> in your patch will be completely wrong.
>
> Admittedly, your patch isn't 100% bogus, but the reason is subtle and
> you need lots of comments there *and* in save_fsgs().

Just to make sure I understand the reason,

Currently, the only way for processes to change FS/GS base is to call
ARCH_SET_FS/GS prctls and these reflect the changes they make in
thread.fs/gsbase so *conceptually* reading them is OK now.

Now there's so called X86_BUG_NULL_SEG: on Intel CPUs writing '0' to
FS/GS selectors zeroes the base (and on AMDs it doesn't). save_fsgs()
checks fs/gs selectors and adjusts thread.fs/gsbase
accordingly. (de-facto no-issue for my patch as it only touches Intel's
VMX but we don't want to rely on vendor, detect_null_seg_behavior() does
real check of the behavior).

Now FSGSBASE support comes to play. Userspace will start changing FS/GS
base without kernel's intervention so we really need to do read if we
want to figure out what's there. Luckily, reads are now cheaper thanks
to new instructions.

So what I think we need to do here is introduce "sync_process_fs_gs()"
('save_fsgs' now) api which we will call from both __switch_to() and
KVM's vmx_save_host_state() before reading thread.fs/gsbase.

-- 
  Vitaly
