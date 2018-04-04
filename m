Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbeDDJlv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:41:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750812AbeDDJlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 05:41:50 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] KVM: x86: hyperv: simplistic HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} implementation
References: <20180402161059.8488-1-vkuznets@redhat.com>
        <20180402161059.8488-4-vkuznets@redhat.com>
        <20180403191508.GA7386@flask> <87d0zfcoed.fsf@vitty.brq.redhat.com>
Date: Wed, 04 Apr 2018 11:41:46 +0200
In-Reply-To: <87d0zfcoed.fsf@vitty.brq.redhat.com> (Vitaly Kuznetsov's message
        of "Wed, 04 Apr 2018 11:27:22 +0200")
Message-ID: <878ta3cnqd.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Radim Krčmář <rkrcmar@redhat.com> writes:
>
>> 2018-04-02 18:10+0200, Vitaly Kuznetsov:
>>> +		if (vcpu != current_vcpu)
>>> +			kvm_vcpu_kick(vcpu);
>>
>> The spec says that
>>
>>  "This call guarantees that by the time control returns back to the
>>   caller, the observable effects of all flushes on the specified virtual
>>   processors have occurred."
>>
>> Other KVM code doesn't assume that kvm_vcpu_kick() and a delay provides
>> that guarantee;  kvm_make_all_cpus_request waits for the target CPU to
>> exit before saying that TLB has been flushed.
>>
>> I am leaning towards the safer variant here as well.  (Anyway, it's a
>> good time to figure out if we really need it.)
>
> Ha, it depends on how we define "observable effects" :-)
>
> I think kvm_vcpu_kick() is enough as the corresponding vCPU can't
> actually observe old mapping after being kicked (even if we didn't flush
> yet we're not running). Or do you see any possible problem with such
> definition?
>

Oh, now I see it myself -- native_smp_send_reschedule() only does
apic->send_IPI() so this is indeed unsafe. We need something like
kvm_make_all_cpus_request() with a mask (and, to make it fast, we'll
probably have to pre-allocate these).

Will do in v2, thanks!

-- 
  Vitaly
