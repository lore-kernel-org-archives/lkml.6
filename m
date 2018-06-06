Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 729EA6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932456AbeFFIEE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:04:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:29180 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932304AbeFFID7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:03:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,482,1520924400";
   d="scan'208";a="60791403"
Subject: Re: [PATCH V3 02/17] kallsyms, x86: Export addresses of syscall
 trampolines
To: Andi Kleen <ak@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <1526986485-6562-1-git-send-email-adrian.hunter@intel.com>
 <1526986485-6562-3-git-send-email-adrian.hunter@intel.com>
 <20180605160043.GC7220@tassilo.jf.intel.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <57f1e61f-49fa-99be-6876-48775272ccec@intel.com>
Date: Wed, 6 Jun 2018 11:02:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180605160043.GC7220@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/18 19:00, Andi Kleen wrote:
>> +#ifdef CONFIG_X86_64
>> +int arch_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
>> +		     char *name)
>> +{
>> +	unsigned int cpu, ncpu;
>> +
>> +	if (symnum >= num_possible_cpus())
>> +		return -EINVAL;
>> +
>> +	for (cpu = cpumask_first(cpu_possible_mask), ncpu = 0;
>> +	     cpu < num_possible_cpus() && ncpu < symnum;
>> +	     cpu = cpumask_next(cpu, cpu_possible_mask), ncpu++)
>> +		;
> 
> That is max_t(unsigned, cpumask_last(cpu_possible_mask), symnum)

I think it should be:

-	     cpu < num_possible_cpus() && ncpu < symnum;
+	     ncpu < symnum;

Alex?

> 
> Rest and other kernel patches look good to me
> 
> Acked-by: Andi Kleen <ak@linux.intel.com>
> 
> -Andi
> 
