Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932425AbeCLQOG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:14:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751543AbeCLQOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:14:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F38121770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELtt4PrnL9TTIBCYZGd6ozeZ0T4uIcv6GW6NKAOscrm+l3VkTULOOy/sV3XuLfqIjnojT5Ez8h8uuSobrrMPujY=
MIME-Version: 1.0
In-Reply-To: <327f3194-715c-7aa7-f1bb-9ee1073f5b99@redhat.com>
References: <20180312140300.6166-1-vkuznets@redhat.com> <20180312140300.6166-2-vkuznets@redhat.com>
 <327f3194-715c-7aa7-f1bb-9ee1073f5b99@redhat.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 12 Mar 2018 16:13:40 +0000
X-Gmail-Original-Message-ID: <CALCETrWmytXxC7tSiqCqFOs1Cvz_-u0=YVn7VoRSOr7k6kdkjA@mail.gmail.com>
Message-ID: <CALCETrWmytXxC7tSiqCqFOs1Cvz_-u0=YVn7VoRSOr7k6kdkjA@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/kvm/vmx: read MSR_FS_BASE from current->thread
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm list <kvm@vger.kernel.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 4:03 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 12/03/2018 15:02, Vitaly Kuznetsov wrote:
>>
>> +/*
>> + * Currently, the only way for processes to change their FS/GS base is to call
>> + * ARCH_SET_FS/GS prctls and these reflect changes they make in task->thread.
>> + * There are, however, additional considerations:
>> + *
>> + * There is X86_BUG_NULL_SEG: on some CPUs writing '0' to FS/GS selectors zeroes
>> + * the base and on some it doesn't, we need to check for that
>> + * (see save_base_legacy()).
>> + *
>> + * When FSGSBASE extensions are enabled userspace processes will be able to
>> + * change their FS/GS bases without kernel intervention. save_fsgs() will
>> + * have to be updated to actually read FS and GS bases with RD[FG,GS]BASE
>> + * instructions.
>> + */
>> +void save_current_fsgs(void)
>> +{
>> +     save_fsgs(current);
>> +}
>> +EXPORT_SYMBOL_GPL(save_current_fsgs);
>
> We don't really need save_fsgs in KVM though.  We already do the
> savesegment ourselves, and we know Intel CPUs don't have
> X86_BUG_NULL_SEG.  So this:
>
>         savesegment(fs, vmx->host_state.fs_sel);
>         if (!(vmx->host_state.fs_sel & 7)) {
>                 vmcs_write16(HOST_FS_SELECTOR, vmx->host_state.fs_sel);
>                 vmx->host_state.fs_reload_needed = 0;
>         } else {
>                 vmcs_write16(HOST_FS_SELECTOR, 0);
>                 vmx->host_state.fs_reload_needed = 1;
>         }
>         savesegment(gs, vmx->host_state.gs_sel);
>         ...
>
> could probably become simply:
>
>         savesegment(fs, vmx->host_state.fs_sel);
>         /*
>          * When FSGSBASE extensions are enabled, this will have to use
>          * RD{FS,GS}BASE instead of accessing current, and the
>          * corresponding WR{FS,GS}BASE should be done unconditionally,
>          * even if fs_reload_needed (resp. gs_ldt_reload_needed) is 1.
>          */
>         if (vmx->host_state.fs_sel <= 3) {
>                 vmcs_write16(HOST_FS_SELECTOR, vmx->host_state.fs_sel);
>                 vmcs_write16(HOST_FS_BASE, current->thread.fsbase);
>                 vmx->host_state.fs_reload_needed = 0;
>         } else {
>                 vmcs_write16(HOST_FS_SELECTOR, 0);
>                 vmcs_write16(HOST_FS_BASE, 0);
>                 vmx->host_state.fs_reload_needed = 1;
>         }
>         savesegment(gs, vmx->host_state.gs_sel);
>         ...
>
> ?
>

Hmm, probably, although this still gets the case where the user writes
0 to %fs wrong.  Of course, save_fsgs() also gets that wrong.

I'm okay with this variant as long as you add a comment to
save_..._legacy pointing at the KVM code.
