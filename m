Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbeCMNUT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:20:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752268AbeCMNUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:20:06 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/3] x86/kvm/vmx: read MSR_FS_BASE from current->thread
References: <20180312140300.6166-1-vkuznets@redhat.com>
        <20180312140300.6166-2-vkuznets@redhat.com>
        <327f3194-715c-7aa7-f1bb-9ee1073f5b99@redhat.com>
Date: Tue, 13 Mar 2018 14:20:03 +0100
In-Reply-To: <327f3194-715c-7aa7-f1bb-9ee1073f5b99@redhat.com> (Paolo
        Bonzini's message of "Mon, 12 Mar 2018 17:03:36 +0100")
Message-ID: <87ina0cdto.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

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
>> +	save_fsgs(current);
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
> 	...
>
> could probably become simply:
>
>         savesegment(fs, vmx->host_state.fs_sel);
> 	/*
> 	 * When FSGSBASE extensions are enabled, this will have to use
> 	 * RD{FS,GS}BASE instead of accessing current, and the
> 	 * corresponding WR{FS,GS}BASE should be done unconditionally,
> 	 * even if fs_reload_needed (resp. gs_ldt_reload_needed) is 1.
> 	 */
>         if (vmx->host_state.fs_sel <= 3) {
>                 vmcs_write16(HOST_FS_SELECTOR, vmx->host_state.fs_sel);
>                 vmcs_write16(HOST_FS_BASE, current->thread.fsbase);

vmcs_writel() I guess ... and, just to make sure I follow your
suggestion, this is for x86_64 only, right? x86_32 does

vmcs_writel(HOST_FS_BASE, segment_base(vmx->host_state.fs_sel));

and I think it needs to stay.

(personally, I'm rather for exporting save_fsgs(), dropping
savesegment() and getting all we need from current to avoid propagating
assumptions but I'm flexible)

-- 
  Vitaly
