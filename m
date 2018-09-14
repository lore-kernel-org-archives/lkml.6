Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340E3FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D655520866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D655520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeINNCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:02:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbeINNCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:02:50 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1EB181DE3;
        Fri, 14 Sep 2018 07:49:35 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82ACA308BDA5;
        Fri, 14 Sep 2018 07:49:33 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Liran Alon <liran.alon@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 09/12] x86/kvm/nVMX: allow bare VMXON state migration
References: <20180913170522.24876-1-vkuznets@redhat.com>
        <20180913170522.24876-10-vkuznets@redhat.com>
        <CALMp9eTTK67npZLjpCYA=6EPpvF8nZZq7fH=e7NQRhDYXZ=UNQ@mail.gmail.com>
Date:   Fri, 14 Sep 2018 09:49:32 +0200
In-Reply-To: <CALMp9eTTK67npZLjpCYA=6EPpvF8nZZq7fH=e7NQRhDYXZ=UNQ@mail.gmail.com>
        (Jim Mattson's message of "Thu, 13 Sep 2018 12:21:13 -0700")
Message-ID: <87o9d08qnn.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 14 Sep 2018 07:49:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Thu, Sep 13, 2018 at 10:05 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> It is perfectly valid for a guest to do VMXON and not do VMPTRLD. This
>> state needs to be preserved on migration.
>>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/vmx.c | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index d3297fadf7ed..25a25fff8dd9 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -14482,13 +14482,6 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
>>         if (!page_address_valid(vcpu, kvm_state->vmx.vmxon_pa))
>>                 return -EINVAL;
>>
>> -       if (kvm_state->size < sizeof(kvm_state) + sizeof(*vmcs12))
>> -               return -EINVAL;
>> -
>> -       if (kvm_state->vmx.vmcs_pa == kvm_state->vmx.vmxon_pa ||
>> -           !page_address_valid(vcpu, kvm_state->vmx.vmcs_pa))
>> -               return -EINVAL;
>> -
>>         if ((kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_GUEST_MODE) &&
>>             (kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE))
>>                 return -EINVAL;
>> @@ -14510,6 +14503,14 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
>>         if (ret)
>>                 return ret;
>>
>> +       /* Empty 'VMXON' state is permitted */
>> +       if (kvm_state->size < sizeof(kvm_state) + sizeof(*vmcs12))
>> +               return 0;
>
> In the original version of this code, the early exit is:
>
> if (kvm_state.vmcs_pa == -1ull)
>         return 0;

Time to restore the status quo :-)

In any case this early exit should be done after enter_vmx_operation()
as even without a valid VMCS we need to preserve VMXON state (e.g. Linux
with loaded KVM but without any guests running).

-- 
  Vitaly
