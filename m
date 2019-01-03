Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43A3C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99AB2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfACHz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 02:55:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:17890 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfACHz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 02:55:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 23:55:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,434,1539673200"; 
   d="scan'208";a="132577598"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jan 2019 23:55:25 -0800
Message-ID: <5C2DC132.9050103@intel.com>
Date:   Thu, 03 Jan 2019 16:00:50 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Jim Mattson <jmattson@google.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        like.xu@intel.com, Jann Horn <jannh@google.com>,
        arei.gonglei@huawei.com
Subject: Re: [PATCH v4 05/10] KVM/x86: expose MSR_IA32_PERF_CAPABILITIES to
 the guest
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com> <1545816338-1171-6-git-send-email-wei.w.wang@intel.com> <CALMp9eTOV3Twep9gL-9S+Pe_k-=v17CcJTLb5=+7_pjvWf9RfQ@mail.gmail.com>
In-Reply-To: <CALMp9eTOV3Twep9gL-9S+Pe_k-=v17CcJTLb5=+7_pjvWf9RfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2019 07:40 AM, Jim Mattson wrote:
> On Wed, Dec 26, 2018 at 2:01 AM Wei Wang <wei.w.wang@intel.com> wrote:
>> Bits [0, 5] of MSR_IA32_PERF_CAPABILITIES tell about the format of
>> the addresses stored in the LBR stack. Expose those bits to the guest
>> when the guest lbr feature is enabled.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> ---
>>   arch/x86/include/asm/perf_event.h | 2 ++
>>   arch/x86/kvm/cpuid.c              | 2 +-
>>   arch/x86/kvm/vmx.c                | 9 +++++++++
>>   3 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
>> index 2f82795..eee09b7 100644
>> --- a/arch/x86/include/asm/perf_event.h
>> +++ b/arch/x86/include/asm/perf_event.h
>> @@ -87,6 +87,8 @@
>>   #define ARCH_PERFMON_BRANCH_MISSES_RETIRED             6
>>   #define ARCH_PERFMON_EVENTS_COUNT                      7
>>
>> +#define X86_PERF_CAP_MASK_LBR_FMT                      0x3f
>> +
>>   /*
>>    * Intel "Architectural Performance Monitoring" CPUID
>>    * detection/enumeration details:
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 7bcfa61..3b8a57b 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -365,7 +365,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>>                  F(XMM3) | F(PCLMULQDQ) | 0 /* DTES64, MONITOR */ |
>>                  0 /* DS-CPL, VMX, SMX, EST */ |
>>                  0 /* TM2 */ | F(SSSE3) | 0 /* CNXT-ID */ | 0 /* Reserved */ |
>> -               F(FMA) | F(CX16) | 0 /* xTPR Update, PDCM */ |
>> +               F(FMA) | F(CX16) | 0 /* xTPR Update*/ | F(PDCM) |
>>                  F(PCID) | 0 /* Reserved, DCA */ | F(XMM4_1) |
>>                  F(XMM4_2) | F(X2APIC) | F(MOVBE) | F(POPCNT) |
>>                  0 /* Reserved*/ | F(AES) | F(XSAVE) | 0 /* OSXSAVE */ | F(AVX) |
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index 8d5d984..ee02967 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -4161,6 +4161,13 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>                          return 1;
>>                  msr_info->data = vcpu->arch.ia32_xss;
>>                  break;
>> +       case MSR_IA32_PERF_CAPABILITIES:
>> +               if (!boot_cpu_has(X86_FEATURE_PDCM))
>> +                       return 1;
>> +               msr_info->data = native_read_msr(MSR_IA32_PERF_CAPABILITIES);
> Since this isn't guarded by vcpu->kvm->arch.lbr_in_guest, it breaks
> backwards compatibility, doesn't it?

Right, thanks. Probably better to change it to below:

msr_info->data = 0;
data = native_read_msr(MSR_IA32_PERF_CAPABILITIES);
if (vcpu->kvm->arch.lbr_in_guest)
     msr_info->data |= (data & X86_PERF_CAP_MASK_LBR_FMT);

Best,
Wei
