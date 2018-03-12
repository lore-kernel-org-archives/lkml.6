Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751780AbeCLOTM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:19:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751232AbeCLOTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:19:11 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: kvm@vger.kernel.org, x86@kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] x86/kvm: use Enlightened VMCS when running on Hyper-V
References: <20180309140249.2840-1-vkuznets@redhat.com>
        <20180309140249.2840-8-vkuznets@redhat.com>
        <alpine.DEB.2.21.1803091507300.1364@nanos.tec.linutronix.de>
Date: Mon, 12 Mar 2018 15:19:05 +0100
In-Reply-To: <alpine.DEB.2.21.1803091507300.1364@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Fri, 9 Mar 2018 15:08:34 +0100 (CET)")
Message-ID: <87r2opcr6u.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Fri, 9 Mar 2018, Vitaly Kuznetsov wrote:
>
>> Enlightened VMCS is just a structure in memory, the main benefit
>> besides avoiding somewhat slower VMREAD/VMWRITE is using clean field
>> mask: we tell the underlying hypervisor which fields were modified
>> since VMEXIT so there's no need to inspect them all.
>> 
>> Tight CPUID loop test shows significant speedup:
>> Before: 18890 cycles
>> After: 8304 cycles
>> 
>> Static key is being used to avoid performance penalty for non-Hyper-V
>> deployments. Tests show we add around 3 (three) CPU cycles on each
>> VMEXIT (1077.5 cycles before, 1080.7 cycles after for the same CPUID
>> loop on bare metal). We can probably avoid one test/jmp in vmx_vcpu_run()
>> but I don't see a clean way to use static key in assembly.
>
> STATIC_JUMP_IF_TRUE, STATIC_JUMP_IF_FALSE are your friends.
>

Thanks for the tip,

with a single kernel user of these APIs it was easy to miss :-)

Unfortunately, these APIs are only present if HAVE_JUMP_LABEL and
(afaiu) we still care about KVM on !HAVE_JUMP_LABEL builds. It would be
nice if we can make them behave the same way static_branch_likely() and
friends do: compile into something else when !HAVE_JUMP_LABEL so we can
avoid nasty #ifdefs in C code.

That said I'd like to defer the question to KVM maintainers: Paolo,
Radim, what would you like me to do? Use STATIC_JUMP_IF_TRUE/FALSE as
they are, try to make them work for !HAVE_JUMP_LABEL and use them or
maybe we can commit the series as-is and have it as a future
optimization (e.g. when HAVE_JUMP_LABEL becomes mandatory)?

-- 
  Vitaly
