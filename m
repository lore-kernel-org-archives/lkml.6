Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932543AbeCFKQ6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 05:16:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750947AbeCFKQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 05:16:57 -0500
Subject: Re: [PATCH RFC 0/3] x86/kvm: avoid expensive rdmsrs for FS/GS base
 MSRs
To: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
References: <20180302105503.24428-1-vkuznets@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ed6b5fb-91fd-67c5-5adb-6206a24d643e@redhat.com>
Date: Tue, 6 Mar 2018 11:16:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302105503.24428-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2018 11:55, Vitaly Kuznetsov wrote:
> Some time ago Paolo suggested to take a look at probably unneeded expensive
> rdmsrs for FS/GS base MSR in vmx_save_host_state(). This is called on every
> vcpu run when we need to handle vmexit in userspace.
> 
> I have to admit I got a bit lost in our kernel FS/GS magic. I managed to 
> convince myself that in the well defined context (ioctl from userspace)
> we can always get the required values from in-kernel variables and avoid
> rdmsrs. But I may have missed something really important, thus RFC.
> 
> My debug shows we're shaving off 240 cpu cycles (E5-2603 v3).
> 
> In case these patches turn out to be worthwile AMD SVM can probably be
> optimized the ame way.

SVM is a bit different, because it uses VMLOAD/VMSAVE and so it doesn't
have an equivalent of vmx_save_host_state().  Unfortunately, you cannot
really eliminate VMLOAD/VMSAVE because it's the only way to load the
hidden state of TR and LDTR---so you might as well use it to load FS and
GS, even in 64-bit mode.

In order to decrease the cost of vmload/vmsave, we could single out the
simplest vmexit handlers and process them without even getting out of
svm_vcpu_run, thus skipping all four of stgi/vmload/vmsave/clgi.
However, this probably couldn't be done for the really common vmexits
such as nested page fault, PIO or most MSR accesses.  We _could_ do it
for nested virt-related vmexits, but the advantage of that is getting
smaller too, since Zen provides hardware support for nested GIF and
nested VMLOAD/VMSAVE.

Paolo

> Vitaly Kuznetsov (3):
>   x86/kvm/vmx: read MSR_FS_BASE from current->thread
>   x86/kvm/vmx: read MSR_KERNEL_GS_BASE from current->thread
>   x86/kvm/vmx: avoid expensive rdmsr for MSR_GS_BASE
> 
>  arch/x86/kernel/cpu/common.c | 1 +
>  arch/x86/kvm/vmx.c           | 7 ++++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
