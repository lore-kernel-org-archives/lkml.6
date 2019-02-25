Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E0CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171892084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfBYFbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 00:31:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:28671 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfBYFbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 00:31:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2019 21:31:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,410,1544515200"; 
   d="scan'208";a="118805501"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.239.196.180]) ([10.239.196.180])
  by orsmga006.jf.intel.com with ESMTP; 24 Feb 2019 21:31:45 -0800
Subject: Re: [PATCH 03/11] x86 topology: Add CPUID.1F multi-die/package
 support
To:     Brice Goglin <Brice.Goglin@inria.fr>, Len Brown <lenb@kernel.org>,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <07d2908dc72bf964b27380999e1c826587d69136.1550545163.git.len.brown@intel.com>
 <3ac80787-f282-ce94-77dc-f0e6ea9d4431@inria.fr>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <415eae36-6421-749d-f28b-31657e124321@linux.intel.com>
Date:   Mon, 25 Feb 2019 13:31:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <3ac80787-f282-ce94-77dc-f0e6ea9d4431@inria.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/24 18:04, Brice Goglin wrote:
> Le 19/02/2019 à 04:40, Len Brown a écrit :
>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>> index ccd1f2a8e557..4250a87f57db 100644
>> --- a/arch/x86/kernel/smpboot.c
>> +++ b/arch/x86/kernel/smpboot.c
>> @@ -393,6 +393,7 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>>   		int cpu1 = c->cpu_index, cpu2 = o->cpu_index;
>>   
>>   		if (c->phys_proc_id == o->phys_proc_id &&
>> +		    c->cpu_die_id == o->cpu_die_id &&
>>   		    per_cpu(cpu_llc_id, cpu1) == per_cpu(cpu_llc_id, cpu2)) {
>>   			if (c->cpu_core_id == o->cpu_core_id)
>>   				return topology_sane(c, o, "smt");
>> @@ -404,6 +405,7 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>>   		}
>>   
>>   	} else if (c->phys_proc_id == o->phys_proc_id &&
>> +		   c->cpu_die_id == o->cpu_die_id &&
>>   		   c->cpu_core_id == o->cpu_core_id) {
>>   		return topology_sane(c, o, "smt");
>>   	}
>> @@ -461,7 +463,7 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>>    */
>>   static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>>   {
>> -	if (c->phys_proc_id == o->phys_proc_id)
>> +	if (c->cpu_die_id == o->cpu_die_id)
>>   		return true;
>>   	return false;
>>   }
> 
> Hello Len,
> 
> I am testing your patches in a VM with CPUID.1f QEMU patches (author Like Xu is CC'ed),
> booted to get 2 packages with 1 NUMA node each and 2 dies each:
> 
> -smp cpus=16,threads=2,cores=2,dies=2,sockets=2 -numa node,cpus=0-7,nodeid=0 -numa node,cpus=8-15,nodeid=1
> 
> sysfs files expose wrong information:
> core_siblings contains threads of the local die AND of die with same number in other processors,
> eg cpu 0-3 and 8-11 instead of 0-3 only.
> 
> The issue is that you seem to assume that die ids will always be unique across multiple packages.

I don't think the intel MCP topolohgy has this global uniqueness 
assumption for die_id according to CPUID.1F SDM.

> Is this a valid assumption? If so, QEMU patches should be fixed.
> If not, I fixed the issue by changing match_die() to check both phys_proc_id and cpu_die_id:
> 
> static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
> {
> 	if (c->phys_proc_id == o->phys_proc_id && c->cpu_die_id == o->cpu_die_id)
>   		return true;
> 	return false;
> }
> 
> Thanks
> Brice
> 
> 
> 

