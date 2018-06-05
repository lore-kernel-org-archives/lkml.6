Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751490AbeFEEoV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 00:44:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:9360 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbeFEEoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 00:44:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,477,1520924400";
   d="scan'208";a="60417433"
From: "Bae, Chang Seok" <chang.seok.bae@intel.com>
To: =?utf-8?B?TWlrYSBQZW50dGlsw6Q=?= <mika.penttila@nextfour.com>,
        "Andy Lutomirski" <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        "Thomas Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
CC: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] x86/vdso: Move out the CPU number store
Thread-Topic: [PATCH 6/6] x86/vdso: Move out the CPU number store
Thread-Index: AQHT/Dm2Eo4HTQvBLkW4xvj9vMmKVqRRbtEA//+XrwA=
Date: Tue, 5 Jun 2018 04:44:16 +0000
Message-ID: <C62C3F95-0DD4-4B66-89A8-4FAB819C8A70@intel.com>
References: <1528140269-26205-1-git-send-email-chang.seok.bae@intel.com>
 <1528140269-26205-7-git-send-email-chang.seok.bae@intel.com>
 <8a41304a-3517-003a-badf-1ba8f7ababe4@nextfour.com>
In-Reply-To: <8a41304a-3517-003a-badf-1ba8f7ababe4@nextfour.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.1.180523
x-originating-ip: [10.254.45.193]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7F5E37D78472044A328F4BA71A2EA02@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w554iQom009506

>> diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
>> index ea554f8..e716e94 100644
>> --- a/arch/x86/kernel/setup_percpu.c
>> +++ b/arch/x86/kernel/setup_percpu.c
>> @@ -155,12 +155,21 @@ static void __init pcpup_populate_pte(unsigned long addr)
>>  
>>  static inline void setup_percpu_segment(int cpu)
>>  {
>> -#ifdef CONFIG_X86_32
>> -	struct desc_struct d = GDT_ENTRY_INIT(0x8092, per_cpu_offset(cpu),
>> -					      0xFFFFF);
>> +#ifdef CONFIG_NUMA
>> +	unsigned long node = early_cpu_to_node(cpu);
>> +#else
>> +	unsigned long node = 0;
>> +#endif
>> +	struct desc_struct d = GDT_ENTRY_INIT(0x0, per_cpu_offset(cpu),
>> +			   make_lsl_tscp(cpu, node));
>> +
>> +	d.type = 5;	/* R0 data, expand down, accessed */
>> +	d.dpl = 3;	/* Visible to user code */
>> +	d.s = 1;	/* Not a system segment */
>> +	d.p = 1;	/* Present */
>> +	d.d = 1;	/* 32-bit */
>>  
>>  	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_PERCPU, &d, DESCTYPE_S);
>> -#endif
>>  }

> This won't work on X86-32 because it actually uses the segment limit with fs: access. So there 
> is a reason why the lsl based method is X86-64 only.

The limit will be consumed in X86-64 only, while the unification with i386 was suggested for a
different reason.

Thanks,
Chang
