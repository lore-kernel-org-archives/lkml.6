Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932345AbeCSJEm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:04:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33627 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755022AbeCSJEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:04:40 -0400
X-Google-Smtp-Source: AG47ELtaeyev4k3DZWwC65TC8keSKAeVqOfL/avq9MWlYyCnOFN91pp2bLA2qg4vNuKclnTx3TK3DQ==
Subject: Re: [PATCH v5 03/11] perf/x86/intel/pt: Introduce a new function to
 get the capability of Intel PT
To: "Kang, Luwei" <luwei.kang@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>
References: <1520165241-15819-1-git-send-email-luwei.kang@intel.com>
 <1520165241-15819-4-git-send-email-luwei.kang@intel.com>
 <98515f5f-9c8a-8e1a-4fef-c9a8a0e9e8f5@redhat.com>
 <82D7661F83C1A047AF7DC287873BF1E167EFC0C8@SHSMSX101.ccr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb8e3e2b-b8d8-7bc6-c12e-cea5e9faefc3@redhat.com>
Date: Mon, 19 Mar 2018 10:04:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <82D7661F83C1A047AF7DC287873BF1E167EFC0C8@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2018 08:17, Kang, Luwei wrote:
>>> +u32 pt_cap_get_ex(u32 *caps, enum pt_capabilities cap) {
>>> +	struct pt_cap_desc *cd = &pt_caps[cap];
>>> +	u32 c = caps[cd->leaf * PT_CPUID_REGS_NUM + cd->reg];
>>> +	unsigned int shift = __ffs(cd->mask);
>>> +
>>> +	return (c & cd->mask) >> shift;
>>> +}
>>> +EXPORT_SYMBOL_GPL(pt_cap_get_ex);
>>> +
>>
>> You should change pt_cap_get to use this function.  Also, "_ex" is not a very common suffix, so perhaps you can call it
>> __pt_cap_get.
>>
>> I don't have any other comments on patches 1-3, so when you resend we can ask the x86 maintainers for approval.
>>
> 
> Hi Paolo,
>     Is that like this?

Yes, thanks.

Paolo

> --- a/arch/x86/events/intel/pt.c
> +++ b/arch/x86/events/intel/pt.c
> @@ -76,14 +76,20 @@
>         PT_CAP(psb_periods,             1, CPUID_EBX, 0xffff0000),
>  };
> 
> -u32 pt_cap_get(enum pt_capabilities cap)
> +u32 __pt_cap_get(u32 *caps, enum pt_capabilities cap)
>  {
>         struct pt_cap_desc *cd = &pt_caps[cap];
> -       u32 c = pt_pmu.caps[cd->leaf * PT_CPUID_REGS_NUM + cd->reg];
> +       u32 c = caps[cd->leaf * PT_CPUID_REGS_NUM + cd->reg];
>         unsigned int shift = __ffs(cd->mask);
> 
>         return (c & cd->mask) >> shift;
>  }
> +EXPORT_SYMBOL_GPL(__pt_cap_get);
> +
> +u32 pt_cap_get(enum pt_capabilities cap)
> +{
> +       return __pt_cap_get(pt_pmu.caps, cap);
> +}
>  EXPORT_SYMBOL_GPL(pt_cap_get);
> 
>  static ssize_t pt_cap_show(struct device *cdev,
> diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
> index 2de4db0..3a4f524 100644
> --- a/arch/x86/include/asm/intel_pt.h
> +++ b/arch/x86/include/asm/intel_pt.h
> @@ -27,9 +27,11 @@ enum pt_capabilities {
>  #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
>  void cpu_emergency_stop_pt(void);
>  extern u32 pt_cap_get(enum pt_capabilities cap);
> +extern u32 __pt_cap_get(u32 *caps, enum pt_capabilities cap);
>  #else
>  static inline void cpu_emergency_stop_pt(void) {}
>  static inline u32 pt_cap_get(enum pt_capabilities cap) { return 0; }
> +static u32 __pt_cap_get(u32 *caps, enum pt_capabilities cap) { return 0; }
> 
> 
> Thanks,
> Luwei Kang
> 
