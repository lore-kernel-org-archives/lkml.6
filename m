Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeEDM7i (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:59:38 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:56216 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbeEDM7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:59:36 -0400
Subject: Re: [RFC PATCH] MIPS: Oprofile: Drop support
To: Robert Richter <rric@kernel.org>
CC: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, Huacai Chen <chenhc@lemote.com>,
        <linux-kernel@vger.kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, <oprofile-list@lists.sf.net>
References: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
 <20180424130511.GB28813@saruman>
 <5e464a40-4e4d-dde4-b5b5-ceb637dc5f38@mips.com>
 <20180504093002.GC4493@rric.localdomain>
 <dd951d1e-206d-78dd-49ae-3a16cad9ebcc@mips.com>
 <20180504102600.GD4493@rric.localdomain>
 <294858af-9164-f0c3-62d3-d6b643e89e09@mips.com>
 <20180504122750.GE4493@rric.localdomain>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <4b4943e5-bc87-3981-1d6c-28171e56c907@mips.com>
Date: Fri, 4 May 2018 13:59:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180504122750.GE4493@rric.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1525438751-531715-9753-78178-1
X-BESS-VER: 2018.5-r1804261738
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192689
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On 04/05/18 13:27, Robert Richter wrote:
> On 04.05.18 12:03:12, Matt Redfearn wrote:
>>> As said, oprofile version 0.9.x is still available for cpus that do
>>> not support perf. What is the breakage?
>>
>> The breakage I originally set out to fix was the MT support in perf.
>> https://www.linux-mips.org/archives/linux-mips/2018-04/msg00259.html
>>
>> Since the perf code shares so much copied code from oprofile, those same
>> issues exist in oprofile and ought to be addressed. But as newer oprofile
>> userspace does not use the (MIPS) kernel oprofile code, then we could,
>> perhaps, just remove it (as per the RFC). That would break legacy tools
>> (0.9.x) though...
> 
> Those support perf:
> 
>   (CPU_MIPS32 || CPU_MIPS64 || CPU_R10000 || CPU_SB1 || CPU_CAVIUM_OCTEON || CPU_XLP || CPU_LOONGSON3)
> 
> Here is the total list of CPU_*:
> 
>   $ git grep -h config.CPU_ arch/mips/ | sort -u | wc -l
>   79

To be fair, that list for oprofile is not much different:

arch/mips/oprofile/Makefile:

oprofile-$(CONFIG_CPU_MIPS32)		+= op_model_mipsxx.o
oprofile-$(CONFIG_CPU_MIPS64)		+= op_model_mipsxx.o
oprofile-$(CONFIG_CPU_R10000)		+= op_model_mipsxx.o
oprofile-$(CONFIG_CPU_SB1)		+= op_model_mipsxx.o
oprofile-$(CONFIG_CPU_XLR)		+= op_model_mipsxx.o
oprofile-$(CONFIG_CPU_LOONGSON2)	+= op_model_loongson2.o
oprofile-$(CONFIG_CPU_LOONGSON3)	+= op_model_loongson3.o

However, since those are generally CPU families rather than individual 
CPUs, the number of models supported by each framework tells a different 
story:

git grep -h ops.cpu_type arch/mips/oprofile | wc -l
20

git grep -h pmu.name arch/mips/kernel/perf_event* | wc -l
17

The difference is mainly older CPUs - M14Kc, 20K, loongson1, etc. But 
yes you are right dropping it would kill profiling for them - that being 
the case I guess oprofile should remain and instead just remove support 
for the MT capable CPUs (34K, interAptiv) which are all supported by perf.

Thanks,
Matt


> 
> The comparisation might not be accurate, but at least gives a hint
> that there are many cpus not supporting perf. You would drop profiling
> support at al to them.
> 
> If it is too hard to also fix the oprofile code (code duplication
> seems the main issue here), then it would be also ok to blacklist
> newer cpus to enable oprofile kernel code (where it is broken).
> 
> -Robert
> 
