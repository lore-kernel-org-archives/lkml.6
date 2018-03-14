Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932315AbeCNOzE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:55:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751985AbeCNOzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:55:02 -0400
Subject: Re: [PATCH v3 7/7] x86/kvm: use Enlightened VMCS when running on
 Hyper-V
To: Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: kvm@vger.kernel.org, x86@kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
References: <20180309140249.2840-1-vkuznets@redhat.com>
 <20180309140249.2840-8-vkuznets@redhat.com>
 <alpine.DEB.2.21.1803091507300.1364@nanos.tec.linutronix.de>
 <87r2opcr6u.fsf@vitty.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6a5f2453-cf51-d491-db54-5f239caa29bc@redhat.com>
Date: Wed, 14 Mar 2018 15:54:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87r2opcr6u.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2018 15:19, Vitaly Kuznetsov wrote:
>>> Static key is being used to avoid performance penalty for non-Hyper-V
>>> deployments. Tests show we add around 3 (three) CPU cycles on each
>>> VMEXIT (1077.5 cycles before, 1080.7 cycles after for the same CPUID
>>> loop on bare metal). We can probably avoid one test/jmp in vmx_vcpu_run()
>>> but I don't see a clean way to use static key in assembly.
>> STATIC_JUMP_IF_TRUE, STATIC_JUMP_IF_FALSE are your friends.
>>
> Thanks for the tip,
> 
> with a single kernel user of these APIs it was easy to miss :-)
> 
> Unfortunately, these APIs are only present if HAVE_JUMP_LABEL and
> (afaiu) we still care about KVM on !HAVE_JUMP_LABEL builds. It would be
> nice if we can make them behave the same way static_branch_likely() and
> friends do: compile into something else when !HAVE_JUMP_LABEL so we can
> avoid nasty #ifdefs in C code.
> 
> That said I'd like to defer the question to KVM maintainers: Paolo,
> Radim, what would you like me to do? Use STATIC_JUMP_IF_TRUE/FALSE as
> they are, try to make them work for !HAVE_JUMP_LABEL and use them or
> maybe we can commit the series as-is and have it as a future
> optimization (e.g. when HAVE_JUMP_LABEL becomes mandatory)?

With a single instruction to patch, poking at the text manually might be
an option...  Otherwise, it's okay as-is.

Paolo
