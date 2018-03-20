Return-Path: <dietmar.eggemann@arm.com>
X-Google-Smtp-Source: AG47ELvFVRUvBNdfvjHRXYwOiC2lMig1mKCnKslygVFUT3cU+gZ4fjT2Hm8+ZIR8NXUvGs/edaG2
ARC-Seal: i=1; a=rsa-sha256; t=1521559261; cv=none;
        d=google.com; s=arc-20160816;
        b=NUs2BSOZDIe/mfm66RkhoGB5zF6TODMIXM9BDM7PCMMCACTqdam4c661xsqPRlr7G/
         8lOAH+84/diGzsQg7h8DlTozlVIFJZdh4VPFVNfyDZBHGibBqDjZsnefIkzR/zbghJp5
         i9bAzDtdGsB0p+QWrQLHIrPRP1+xUCMgfUQmZPhiCK96Pc4iU3Td9zPDNXlgU9OJLZhF
         759mp+oAxs2HqCOJgQ2vpVasm2/ze7ePBz0W6P3PUp+cM3B1VwxSV8K5V4hF4KSsHgyr
         ANfLUH3xiaeyuXjoaZ6WwMiy3Eva85emAaxgapBODCtyJQb5rANpg/RDdvpVEgd1sg/P
         2p5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=DSNGsT478uA2h3zKb5j3sj7uWp5qci5ZTHi4zjR+SVw=;
        b=iAyAFs2O+1BUy16J9IcCkbB2pHGbURnNqvw4bzW3d35p+vLGNX9sFq1pCe1PSY/+dR
         zstYgWLvlJEIIf4LeH0LpJ8ie+YHntTqwcXNGTIx4x0VRO4ilfJ95r4q49i3CO6xBRXY
         9A17tHe5ItXG61ymcz2bhvZ9DBWrTKf0Px8iMRr5E3HL/La6vwB3qxMwKvFfHdrKBefF
         0m17Ym/Y9fq3CYTThy4Xfs/0iwOf2wLdLZFDxNLqchrCjFmLI870iDlbn/tdLLU8qPnn
         tIJt+tDKwjpcRiugpD+Ib4CWf3VR7Lpitcel5zPkBD5IPZLU38HRFjX6QGWsZ2HuE99z
         +KYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH 6/6] drivers: base: arch_topology.c: Enable EAS for
 arm/arm64 platforms
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Quentin Perret <quentin.perret@arm.com>,
 Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Chris Redpath <chris.redpath@arm.com>,
 Patrick Bellasi <patrick.bellasi@arm.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>,
 Joel Fernandes <joelaf@google.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-7-dietmar.eggemann@arm.com>
 <20180320094932.GA23359@kroah.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c4af4a06-864b-b6e4-358f-4c0223855a9c@arm.com>
Date: Tue, 20 Mar 2018 16:20:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180320094932.GA23359@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449345498208449?=
X-GMAIL-MSGID: =?utf-8?q?1595470524127763277?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/20/2018 10:49 AM, Greg Kroah-Hartman wrote:
> On Tue, Mar 20, 2018 at 09:43:12AM +0000, Dietmar Eggemann wrote:
>> From: Quentin Perret <quentin.perret@arm.com>
>>
>> Energy Aware Scheduling (EAS) has to be started from the arch code.
> 
> Ok, but:
> 
>> This commit enables it from the arch topology driver for arm/arm64
>> systems, hence enabling a better support for Arm big.LITTLE and future
>> DynamIQ architectures.
> 
> Why does this have to be in the driver core code just for those specific
> types of cpus?

The arch_topology driver is shared functionality between arm and arm64 
arch. So far it handles the correct setting of per-cpu cpu_scale values 
which are then used by the task scheduler to set the correct cpu 
capacity values. This allows to provide cpu invariant load tracking for 
arm and arm64 big.LITTLE systems.

The driver was initially created so that we didn't had to duplicate the 
exact code in the arm and arm64 arch.

Big.Little platforms have to set appropriate cpu node capacity-dmips-mhz 
properties (e.g. arch/arm64/boot/dts/arm/juno.dts) to enable the start 
the functionality of the driver. The cpu_scale value depends on the 
capacity-dmips-mhz property as well as on the max frequency of a logical 
cpu (hence the dependency to cpufreq).

A corner case would be a big.little platform purely based on max 
frequency differences (e.g. Google Pixel, Qualcomm MSM8996 Snapdragon 
821, Quad-core (2x2.15 GHz Kryo & 2x1.6 GHz Kryo)). For such a system 
capacity-dmips-mhz should be set to the same value for all logical cpus 
(e.g. 1024).

We would like to use the same code (shared between arm and arm64) to 
initialize the energy model and start EAS for arm and arm64 systems.

>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
>> ---
>>   drivers/base/arch_topology.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index 52ec5174bcb1..e2206ea16538 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/string.h>
>>   #include <linux/sched/topology.h>
>> +#include <linux/sched/energy.h>
>>   
>>   DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
>>   
>> @@ -204,6 +205,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
>>   		free_raw_capacity();
>>   		pr_debug("cpu_capacity: parsing done\n");
>>   		schedule_work(&parsing_done_work);
>> +		init_sched_energy();
> 
> This is not arch-specific code only for arm.

The driver requires CONFIG_GENERIC_ARCH_TOPOLOGY which is currently only 
set in arch/arm/Kconfig and arch/arm64/Kconfig.

> Don't you have a ARM cpu bringup code somewhere?  Shouldn't this call be
> in there?  It feels odd that this scheduler change is buried way down
> here...

The big benefit is that we don't have to duplicate code for arm and 
arm64. In the current form, EAS should only be started when cpufreq is 
initialized for all possible cpus. And we don't have to signal back from 
the driver to the arch that cpufreq is initialized for all possible cpus.

I agree that none of this is obvious so the patch should explain the 
requirements and design better.

-- Dietmar

[...]
