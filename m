Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbeCNQMX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:12:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33467 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbeCNQMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:12:18 -0400
X-Google-Smtp-Source: AG47ELtQYzPu13/713JmsZVfJGIBXpttg3UIpOzOSqcrcm0v1fcZM8rzIMwbl91nAdGjksaBxYjkhA==
Subject: Re: [PATCH v2 0/2] x86/kvm: avoid expensive rdmsrs for FS/GS base
 MSRs
To: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
References: <20180313174805.11825-1-vkuznets@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <426fa4fd-7c4d-b6dc-cc19-b0034b7226aa@redhat.com>
Date: Wed, 14 Mar 2018 17:12:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313174805.11825-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2018 18:48, Vitaly Kuznetsov wrote:
> Changes since v1:
> - Merged patches 1 and 2, skip savesegment() for FS and FS for x86_64
>   as save_fsgs() already does that [Paolo Bonzini]
> - Rename save_current_fsgs() -> save_fsgs_for_kvm() [Andy Lutomirski]
> - Trimmed comments [Andy Lutomirski]
> - Add Andy's A-b to what is now PATCH2
> 
> Some time ago Paolo suggested to take a look at probably unneeded expensive
> rdmsrs for FS/GS base MSR in vmx_save_host_state(). This is called on every
> vcpu run when we need to handle vmexit in userspace.
> 
> vmx_save_host_state() is always called in a very well defined context
> (ioctl from userspace) so we may try to get the required values for FS/GS
> bases from in-kernel variables and avoid expensive rdmsrs.
> 
> My debug shows we're shaving off 240 cpu cycles (E5-2603 v3).
> 
> Vitaly Kuznetsov (2):
>   x86/kvm/vmx: read MSR_{FS,KERNEL_GS}_BASE from current->thread
>   x86/kvm/vmx: avoid expensive rdmsr for MSR_GS_BASE
> 
>  arch/x86/include/asm/processor.h | 10 ++++++++++
>  arch/x86/kernel/cpu/common.c     |  3 ++-
>  arch/x86/kernel/process_64.c     | 14 ++++++++++++++
>  arch/x86/kvm/vmx.c               | 16 ++++++++++++----
>  4 files changed, 38 insertions(+), 5 deletions(-)
> 

Queued, thanks.

Paolo
