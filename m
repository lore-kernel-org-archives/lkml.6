Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932356AbeCLQSS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:18:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751315AbeCLQSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:18:17 -0400
Subject: Re: [PATCH 1/3] x86/kvm/vmx: read MSR_FS_BASE from current->thread
To: Andy Lutomirski <luto@kernel.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm list <kvm@vger.kernel.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20180312140300.6166-1-vkuznets@redhat.com>
 <20180312140300.6166-2-vkuznets@redhat.com>
 <327f3194-715c-7aa7-f1bb-9ee1073f5b99@redhat.com>
 <CALCETrWmytXxC7tSiqCqFOs1Cvz_-u0=YVn7VoRSOr7k6kdkjA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <36451719-2905-22e2-6c9b-bbb676e7e663@redhat.com>
Date: Mon, 12 Mar 2018 17:18:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWmytXxC7tSiqCqFOs1Cvz_-u0=YVn7VoRSOr7k6kdkjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2018 17:13, Andy Lutomirski wrote:
>>
>>         savesegment(fs, vmx->host_state.fs_sel);
>>         /*
>>          * When FSGSBASE extensions are enabled, this will have to use
>>          * RD{FS,GS}BASE instead of accessing current, and the
>>          * corresponding WR{FS,GS}BASE should be done unconditionally,
>>          * even if fs_reload_needed (resp. gs_ldt_reload_needed) is 1.
>>          */
>>         if (vmx->host_state.fs_sel <= 3) {
>>                 vmcs_write16(HOST_FS_SELECTOR, vmx->host_state.fs_sel);
>>                 vmcs_write16(HOST_FS_BASE, current->thread.fsbase);
>>                 vmx->host_state.fs_reload_needed = 0;
>>         } else {
>>                 vmcs_write16(HOST_FS_SELECTOR, 0);
>>                 vmcs_write16(HOST_FS_BASE, 0);
>>                 vmx->host_state.fs_reload_needed = 1;
>>         }
>>         savesegment(gs, vmx->host_state.gs_sel);
>>         ...
>>
>> ?
>>
> Hmm, probably, although this still gets the case where the user writes
> 0 to %fs wrong.  Of course, save_fsgs() also gets that wrong.
> 
> I'm okay with this variant as long as you add a comment to
> save_..._legacy pointing at the KVM code.

Why in save_..._legacy?  If it is about FSGSBASE, shouldn't it be in
save_fsgs?  (Or if not I'm missing what the comment should be about).

Paolo
