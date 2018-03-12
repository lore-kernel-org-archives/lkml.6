Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932594AbeCLRA2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 13:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932190AbeCLRA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 13:00:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A21A208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELv0AqFOS+Qtw844tpeHOD3iOosW+hAJ0mINpq4abS+OJPLXSvCu9r6d5R/6a8rFjj8HPGJq1w15SFYjWAjOs08=
MIME-Version: 1.0
In-Reply-To: <36451719-2905-22e2-6c9b-bbb676e7e663@redhat.com>
References: <20180312140300.6166-1-vkuznets@redhat.com> <20180312140300.6166-2-vkuznets@redhat.com>
 <327f3194-715c-7aa7-f1bb-9ee1073f5b99@redhat.com> <CALCETrWmytXxC7tSiqCqFOs1Cvz_-u0=YVn7VoRSOr7k6kdkjA@mail.gmail.com>
 <36451719-2905-22e2-6c9b-bbb676e7e663@redhat.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 12 Mar 2018 17:00:05 +0000
X-Gmail-Original-Message-ID: <CALCETrWmAhHijX9O1HzD0Jp=Rgawrx9jiYQh5MrXHfA0=15iuw@mail.gmail.com>
Message-ID: <CALCETrWmAhHijX9O1HzD0Jp=Rgawrx9jiYQh5MrXHfA0=15iuw@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/kvm/vmx: read MSR_FS_BASE from current->thread
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm list <kvm@vger.kernel.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 4:18 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 12/03/2018 17:13, Andy Lutomirski wrote:
>>>
>>>         savesegment(fs, vmx->host_state.fs_sel);
>>>         /*
>>>          * When FSGSBASE extensions are enabled, this will have to use
>>>          * RD{FS,GS}BASE instead of accessing current, and the
>>>          * corresponding WR{FS,GS}BASE should be done unconditionally,
>>>          * even if fs_reload_needed (resp. gs_ldt_reload_needed) is 1.
>>>          */
>>>         if (vmx->host_state.fs_sel <= 3) {
>>>                 vmcs_write16(HOST_FS_SELECTOR, vmx->host_state.fs_sel);
>>>                 vmcs_write16(HOST_FS_BASE, current->thread.fsbase);
>>>                 vmx->host_state.fs_reload_needed = 0;
>>>         } else {
>>>                 vmcs_write16(HOST_FS_SELECTOR, 0);
>>>                 vmcs_write16(HOST_FS_BASE, 0);
>>>                 vmx->host_state.fs_reload_needed = 1;
>>>         }
>>>         savesegment(gs, vmx->host_state.gs_sel);
>>>         ...
>>>
>>> ?
>>>
>> Hmm, probably, although this still gets the case where the user writes
>> 0 to %fs wrong.  Of course, save_fsgs() also gets that wrong.
>>
>> I'm okay with this variant as long as you add a comment to
>> save_..._legacy pointing at the KVM code.
>
> Why in save_..._legacy?  If it is about FSGSBASE, shouldn't it be in
> save_fsgs?  (Or if not I'm missing what the comment should be about).

It could be in save_fsgs(), I guess.  The main point is to make it
clear to readers of the code in save_fsgs(), the legacy helpers, etc
that there's another piece of code in KVM that makes the same set of
somewhat problematic assumptions and that will need updating for
FSGSBASE.

I'm moderately confident that someone from Intel is currently working
on FSGSBASE, but all I've seen lately is a bunch of kbuild bot errors
:(

--Amdy
