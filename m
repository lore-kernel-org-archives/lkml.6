Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750920AbeCICe7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:34:59 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34904 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeCICe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:34:57 -0500
X-Google-Smtp-Source: AG47ELsVlLsKx0SxkBMbVDCOFBqxIU6ukiQ2J8G8GDv3nZlm1d0YaFt377jnGFWAFKjyZ8qCZC3u9iyNjHgoNpTZC4Y=
MIME-Version: 1.0
In-Reply-To: <20180308203132.GJ12290@flask>
References: <1519897782-8124-1-git-send-email-wanpengli@tencent.com> <20180308203132.GJ12290@flask>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Fri, 9 Mar 2018 10:34:56 +0800
Message-ID: <CANRm+Cwj-s+AYrbLxYX+R076G_K0cTQPNDtmkf34vnKuRE03ig@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: X86: Provides userspace with a capability to not
 intercept MWAIT
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w292Z6I8020598

2018-03-09 4:31 GMT+08:00 Radim Krčmář <rkrcmar@redhat.com>:
>>  To check if a capability can be enabled, the KVM_CHECK_EXTENSION ioctl should
>> -be used.
>> +be used. Blindly passing the KVM_CHECK_EXTENSION result to KVM_ENABLE_CAP is
>> +a valid thing to do when vCPUs are associated to dedicated physical CPUs.
>
> This is not true even for x86 KVM_CAP_SPLIT_IRQCHIP and neither is is a
> need to limit ourselves.  Just leave it be.

https://www.spinics.net/lists/kvm/msg159524.html

>  So I think we should put in the
> documentation that blindly passing the KVM_CHECK_EXTENSION result to
> KVM_ENABLE_CAP is a valid thing to do when vCPUs are associated to
> dedicated physical CPUs.

Paolo ask this before, Paolo, what's your opinion?

>> +7.13 KVM_CAP_X86_DISABLE_EXITS
>> +
>> +Architectures: x86
>> +Parameters: args[0] defines which exits are disabled
>> +Returns: 0 on success, -EINVAL when args[0] contains invalid exits
>> +
>> +Valid exits in args[0] are
>> +
>> +#define KVM_X86_DISABLE_EXITS_MWAIT            (1 << 0)
>> +
>> +Enabling this capability on a VM provides userspace with a way to no
>> +longer intercepts some instructions for improved latency in some
>> +workloads. Not enable KVM_FEATURE_PV_UNHALT if you block HLT.
>
> The last sentence belong to the patch that enables HLT.
> KVM could in theory handle the case (although it makes no sense), so if

> it doesn't currently work, please add a check to kvm_update_cpuid() that
> forbids KVM_FEATURE_PV_UNHALT when halt exits are disabled.

Agreed.

>
> Also, it would be nicer to write that as
> "Do not enable KVM_FEATURE_PV_UNHALT if you disable HLT exits."
>
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> @@ -2780,9 +2780,15 @@ static int msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs,
>>       return r;
>>  }
>>
>> +static inline bool kvm_mwait_can_in_guest(void)
>
> I think kvm_can_mwait_in_guest would be a better name.

Agreed.

Regards,
Wanpeng Li
