Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDC7C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75572073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75572073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeIFBYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:24:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:54843 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbeIFBYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:24:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 13:52:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="71913024"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.151]) ([10.24.14.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Sep 2018 13:52:10 -0700
Subject: Re: [PATCH][RFC] x86/intel_rdt: Do not display size for non-CAT
 resource
To:     Yu Chen <yu.c.chen@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
References: <20180904174614.26682-1-yu.c.chen@intel.com>
 <8cf4c10f-68fe-04a5-029c-9cb22db413ff@intel.com>
 <8cd8165b-c2e6-7ffc-1ef8-a7b497fab99e@intel.com>
 <20180905062805.GA29120@chenyu-desktop>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <c7f6f590-bfa7-7951-77df-6f009e994741@intel.com>
Date:   Wed, 5 Sep 2018 13:52:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180905062805.GA29120@chenyu-desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

On 9/4/2018 11:28 PM, Yu Chen wrote:
> On Tue, Sep 04, 2018 at 03:36:01PM -0700, Reinette Chatre wrote:
>> On 9/4/2018 1:24 PM, Reinette Chatre wrote:
>>> On 9/4/2018 10:46 AM, Chen Yu wrote:
>>>> On a platform with MB resource enabled, a divided-by-zero
>>>> exception is triggered when accessing 'size':
>>>>
>>>> [  151.193447] divide error: 0000 [#1] SMP PTI
>>>> [  151.197743] CPU: 93 PID: 1929 Comm: cat Not tainted 4.19.0-rc2-debug-rdt+ #25
>>>> [  151.205070] Hardware name: Dell Inc. PowerEdge R640/0CRT1G, BIOS 1.3.7 02/08/2018
>>>> [  151.212783] RIP: 0010:rdtgroup_cbm_to_size+0x7e/0xa0
>>>> [  151.237172] RSP: 0018:ffffb3454f90bd88 EFLAGS: 00010246
>>>> [  151.242538] RAX: 00000000023c0000 RBX: 0000000000000000 RCX: 0000000000000003
>>>> [  151.249878] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
>>>> [  151.257213] RBP: ffff96ff0089e000 R08: 0000000000000000 R09: 0000000000aaaaaa
>>>> [  151.264544] R10: ffffb3454f90bd8c R11: 00000000ffffffff R12: ffffffffb5028910
>>>> [  151.271887] R13: ffffffffb5028910 R14: 0000000000000064 R15: ffff96ff0089e000
>>>> [  151.279217] FS:  00007f95a623a500(0000) GS:ffff97170f9c0000(0000) knlGS:0000000000000000
>>>> [  151.287532] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [  151.293432] CR2: 00007f95a6217000 CR3: 00000023f696c003 CR4: 00000000007606e0
>>>> [  151.300766] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> [  151.308094] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> [  151.315426] PKRU: 55555554
>>>> [  151.318212] Call Trace:
>>>> [  151.320732]  rdtgroup_size_show+0x11a/0x1d0
>>>> [  151.325039]  seq_read+0xd8/0x3b0
>>>> [  151.328363]  __vfs_read+0x36/0x170
>>>> [  151.331857]  vfs_read+0x89/0x130
>>>> [  151.335179]  ksys_read+0x52/0xc0
>>>> [  151.338500]  do_syscall_64+0x5b/0x180
>>>> [  151.342261]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>>
>>>> This is because for MB resource, the r->cache.cbm_len is zero, thus
>>>> calculating size in rdtgroup_cbm_to_size() will trigger the exception.
>>>>
>>>> Fix this issue by not exposing 'size' for non-CAT resources.
>>>>
>>>> Fixes: d9b48c86eb38 ("x86/intel_rdt: Display resource groups'
>>>> allocations in bytes")
>>>> Cc: Reinette Chatre <reinette.chatre@intel.com>
>>>> Cc: Fenghua Yu <fenghua.yu@intel.com>
>>>> Cc: Tony Luck <tony.luck@intel.com>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>>>> ---
>>>>  arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
>>>> index b799c00bef09..53fd07b2f61a 100644
>>>> --- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
>>>> +++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
>>>> @@ -1329,7 +1329,7 @@ static struct rftype res_common_files[] = {
>>>>  		.mode		= 0444,
>>>>  		.kf_ops		= &rdtgroup_kf_single_ops,
>>>>  		.seq_show	= rdtgroup_size_show,
>>>> -		.fflags		= RF_CTRL_BASE,
>>>> +		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
>>>>  	},
>>>>  
>>>>  };
>>>>
>>>
>>> Thank you very much for catching this.
>>>
>>> I think we need to change the fix a bit because from that I can tell the
>>> above would cause the "size" file to be relocated to the system wide
>>> "info" directory 
> Okay. Just curious, if changing like this, will it be moved to resctrl/info/L3/size or
> resctrl/info/size?

This change should attempt to create this file in all cache resources
within the info subdirectory. So resctrl/info/L3/size,
resctrl/info/L2/size, etc.

Take care though that the file handling routine (rdtgroup_size_show())
assumes that it is associated with a resource group.

>>> while we would like to have this file remain associated
>>> with the resource group - but just not apply to a MB resource.
>>>
>>> A similar fix may also be needed for the resource group's "mode" file
>>> that was also recently introduced.
>>>
>>> I am taking a closer look now.
>>
>> The "size" file is intended to be associated with a resource group and
>> to list the size in bytes of the cache allocations. It does not
>> currently accommodate the memory bandwidth allocations as you
>> discovered. A system may have multiple resources to be managed via RDT,
>> it could include cache as well as memory, and to thus not expose the
>> "size" file if memory bandwidth allocation is supported is not ideal
>> since the user would not be able to see this information for the cache
>> resources.
>>
>> So, instead of not exposing the "size" file when memory bandwidth
>> allocation is in use I think that we could just include the memory
>> bandwidth allocation information in the existing file. This would be in
>> the currently active bandwidth granularity that would essentially
>> duplicate the schemata information.
>>
> I might understand incorrectly, but in this way, the size in resctrl top
> dir will display all the domain ranges within all the resources, say, the
> size for MB, L3 will be displayed in one file, right? Will the 'size' be
> displayed under each resource dir in info dir?

Yes (answering your first question), the size file is intended to
reflect the allocations of all resources associated with the associated
resource group. It does follow the display of the schemata file in this
regard and is indeed a different visualization of the same content - for
cache it is size in bytes instead of a bitmask. The top resctrl
directory is the default resource group but a user could create more
resource groups with "mkdir" in the top directory.

>> While looking further at how the new files (size and mode) will behave
>> when a MBA resource is present I think I discovered a few more issues:
>> - the "exclusive" mode should not apply to a MBA resource
>> - it should not be possible to pseudo-lock a MBA resource
>>
>> I attempt to address the above issues with the change below. Could you
>> please try it out with what you are currently testing?
> This patch works.
> Tested-by: Chen Yu <yu.c.chen@intel.com>

Thank you very much for trying it out.

>> I do not have
>> access to a system with a MBA resource - could you please let me know
>> what system you are testing on so I can try out more tests?
>>
> I'm using SKYLAKE-X, of cpu stepping 4, so l3cat might be disabled
> due to errorta.

Thank you. I now have access to a similar system and will test these
changes more before resubmitting.


> BTW, may I know the scope of CBM? It seems that in this patch all
> the other resource than MBA could leverage CBM to calculate their
> resource size. What if other resources are added in the future?

Yes, at this time I am only aware of the MBA control interface that does
not use a CBM and it is distinguished specifically because of this.
Indeed, if other non-CBM allocation/control resources are added in the
future we may consider to abstract how (if at all - like MBA) the size
is computed.

Reinette

