Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932914AbeCPCvy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 22:51:54 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:55487 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932651AbeCPCvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:51:52 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37866834"
Subject: Re: [RFC PATCH v2] ACPI / processor: Fix possible CPUs map
To: Thomas Gleixner <tglx@linutronix.de>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <rafael@kernel.org>,
        <dedekind1@gmail.com>, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20180315030756.5548-1-douly.fnst@cn.fujitsu.com>
 <alpine.DEB.2.21.1803151436200.1525@nanos.tec.linutronix.de>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <cb79c370-8c6f-2ef7-9a0a-ed33bd485113@cn.fujitsu.com>
Date: Fri, 16 Mar 2018 10:51:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803151436200.1525@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 78D7248AE761.AA798
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

At 03/15/2018 09:45 PM, Thomas Gleixner wrote:
[...]

> I tested this on a machine which claims to have gazillion of hotplugable
> CPUs:

I really appreciate your test.

> 
> 	smpboot: Allowing 152 CPUs, 120 hotplug CPUs
> 	setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:152 nr_node_ids:2
> 	smp: Brought up 2 nodes, 32 CPUs
> 
> Now with your patch applied it's still saying:
> 
> 	smpboot: Allowing 152 CPUs, 120 hotplug CPUs
> 	setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:152 nr_node_ids:2
> 	smp: Brought up 2 nodes, 32 CPUs
> 
> and the above code runs later on and the result is:
> 
> 	nr_unique_ids 1 nr_cpu_ids 152
> 	Allowing 1 possible CPU
> 
> which subsequently causes the machine to die as we have already 32 CPUs
> online.
> 

That is so interesting, it proofs that this strategy is risky.

I've been wondering how to determine the number of possible CPUs. Due to
the diversity of ACPI in different systems, that seems impossible. Why 
don't I change my mind? Here is a new strategy and I think it is more
reasonable and minimally invasive.

   As we all know, we reset possible CPUs in the prefill_possible_map(),
   If CONFIG_HOTPLUG_CPU = y :
       nr_possible_CPUs = num_processors + disabled_cpus.

   Before the prefill_possible_map(), *Fix the inaccurate disabled_cpus*:

     1) For each disabled CPUs, get it's processor id from ACPI MADT

     2) Check whether this processor id is existed in ACPI namespace or not.
        If false, disabled_cpus--;

I will show you the code and test it later. And IMO, the code logic in
prefill_possible_map() is a little mess, will try to sort it out first.

> So nr_unique_ids is not what it should be and even if it would be the code
> runs way too late. It needs to run _before_ setup_percpu() is invoked to
> scale everything correctly.
> 

Yes, Got it.

Thanks,
	dou

> Thanks,
> 
> 	tglx
> 
> 
> 
> 
> 
> 
