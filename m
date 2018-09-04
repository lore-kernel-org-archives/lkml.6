Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D5CC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFF92082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFF92082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeIEDDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 23:03:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:17828 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbeIEDDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 23:03:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 15:36:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,330,1531810800"; 
   d="scan'208";a="260717626"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.255.229.157]) ([10.255.229.157])
  by fmsmga006.fm.intel.com with ESMTP; 04 Sep 2018 15:36:05 -0700
Subject: Re: [PATCH][RFC] x86/intel_rdt: Do not display size for non-CAT
 resource
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
References: <20180904174614.26682-1-yu.c.chen@intel.com>
 <8cf4c10f-68fe-04a5-029c-9cb22db413ff@intel.com>
Message-ID: <8cd8165b-c2e6-7ffc-1ef8-a7b497fab99e@intel.com>
Date:   Tue, 4 Sep 2018 15:36:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8cf4c10f-68fe-04a5-029c-9cb22db413ff@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen Yu,

On 9/4/2018 1:24 PM, Reinette Chatre wrote:
> On 9/4/2018 10:46 AM, Chen Yu wrote:
>> On a platform with MB resource enabled, a divided-by-zero
>> exception is triggered when accessing 'size':
>>
>> [  151.193447] divide error: 0000 [#1] SMP PTI
>> [  151.197743] CPU: 93 PID: 1929 Comm: cat Not tainted 4.19.0-rc2-debug-rdt+ #25
>> [  151.205070] Hardware name: Dell Inc. PowerEdge R640/0CRT1G, BIOS 1.3.7 02/08/2018
>> [  151.212783] RIP: 0010:rdtgroup_cbm_to_size+0x7e/0xa0
>> [  151.237172] RSP: 0018:ffffb3454f90bd88 EFLAGS: 00010246
>> [  151.242538] RAX: 00000000023c0000 RBX: 0000000000000000 RCX: 0000000000000003
>> [  151.249878] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
>> [  151.257213] RBP: ffff96ff0089e000 R08: 0000000000000000 R09: 0000000000aaaaaa
>> [  151.264544] R10: ffffb3454f90bd8c R11: 00000000ffffffff R12: ffffffffb5028910
>> [  151.271887] R13: ffffffffb5028910 R14: 0000000000000064 R15: ffff96ff0089e000
>> [  151.279217] FS:  00007f95a623a500(0000) GS:ffff97170f9c0000(0000) knlGS:0000000000000000
>> [  151.287532] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  151.293432] CR2: 00007f95a6217000 CR3: 00000023f696c003 CR4: 00000000007606e0
>> [  151.300766] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  151.308094] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [  151.315426] PKRU: 55555554
>> [  151.318212] Call Trace:
>> [  151.320732]  rdtgroup_size_show+0x11a/0x1d0
>> [  151.325039]  seq_read+0xd8/0x3b0
>> [  151.328363]  __vfs_read+0x36/0x170
>> [  151.331857]  vfs_read+0x89/0x130
>> [  151.335179]  ksys_read+0x52/0xc0
>> [  151.338500]  do_syscall_64+0x5b/0x180
>> [  151.342261]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> This is because for MB resource, the r->cache.cbm_len is zero, thus
>> calculating size in rdtgroup_cbm_to_size() will trigger the exception.
>>
>> Fix this issue by not exposing 'size' for non-CAT resources.
>>
>> Fixes: d9b48c86eb38 ("x86/intel_rdt: Display resource groups'
>> allocations in bytes")
>> Cc: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Fenghua Yu <fenghua.yu@intel.com>
>> Cc: Tony Luck <tony.luck@intel.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>> ---
>>  arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
>> index b799c00bef09..53fd07b2f61a 100644
>> --- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
>> @@ -1329,7 +1329,7 @@ static struct rftype res_common_files[] = {
>>  		.mode		= 0444,
>>  		.kf_ops		= &rdtgroup_kf_single_ops,
>>  		.seq_show	= rdtgroup_size_show,
>> -		.fflags		= RF_CTRL_BASE,
>> +		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
>>  	},
>>  
>>  };
>>
> 
> Thank you very much for catching this.
> 
> I think we need to change the fix a bit because from that I can tell the
> above would cause the "size" file to be relocated to the system wide
> "info" directory while we would like to have this file remain associated
> with the resource group - but just not apply to a MB resource.
> 
> A similar fix may also be needed for the resource group's "mode" file
> that was also recently introduced.
> 
> I am taking a closer look now.

The "size" file is intended to be associated with a resource group and
to list the size in bytes of the cache allocations. It does not
currently accommodate the memory bandwidth allocations as you
discovered. A system may have multiple resources to be managed via RDT,
it could include cache as well as memory, and to thus not expose the
"size" file if memory bandwidth allocation is supported is not ideal
since the user would not be able to see this information for the cache
resources.

So, instead of not exposing the "size" file when memory bandwidth
allocation is in use I think that we could just include the memory
bandwidth allocation information in the existing file. This would be in
the currently active bandwidth granularity that would essentially
duplicate the schemata information.

While looking further at how the new files (size and mode) will behave
when a MBA resource is present I think I discovered a few more issues:
- the "exclusive" mode should not apply to a MBA resource
- it should not be possible to pseudo-lock a MBA resource

I attempt to address the above issues with the change below. Could you
please try it out with what you are currently testing? I do not have
access to a system with a MBA resource - could you please let me know
what system you are testing on so I can try out more tests?

Thanks!

Reinette


-->8----
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index af358ca05160..434dd93f915a 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -200,6 +200,12 @@ static int parse_line(char *line, struct
rdt_resource *r,
        struct rdt_domain *d;
        unsigned long dom_id;

+       if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
+           r->rid == RDT_RESOURCE_MBA) {
+               rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");
+               return -EINVAL;
+       }
+
 next:
        if (!line || line[0] == '\0')
                return 0;
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index b799c00bef09..2bc4a01536bc 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1027,6 +1027,8 @@ static bool rdtgroup_mode_test_exclusive(struct
rdtgroup *rdtgrp)
        struct rdt_domain *d;

        for_each_alloc_enabled_rdt_resource(r) {
+               if (r->rid == RDT_RESOURCE_MBA)
+                       continue;
                list_for_each_entry(d, &r->domains, list) {
                        if (rdtgroup_cbm_overlaps(r, d, d->ctrl_val[closid],
                                                  rdtgrp->closid, false))
@@ -1156,7 +1158,7 @@ static int rdtgroup_size_show(struct
kernfs_open_file *of,
        struct rdt_domain *d;
        unsigned int size;
        bool sep = false;
-       u32 cbm;
+       u32 ctrl;

        rdtgrp = rdtgroup_kn_lock_live(of->kn);
        if (!rdtgrp) {
@@ -1181,8 +1183,13 @@ static int rdtgroup_size_show(struct
kernfs_open_file *of,
                        if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
                                size = 0;
                        } else {
-                               cbm = d->ctrl_val[rdtgrp->closid];
-                               size = rdtgroup_cbm_to_size(r, d, cbm);
+                               ctrl = (!is_mba_sc(r) ?
+
d->ctrl_val[rdtgrp->closid] :
+
d->mbps_val[rdtgrp->closid]);
+                               if (r->rid == RDT_RESOURCE_MBA)
+                                       size = ctrl;
+                               else
+                                       size = rdtgroup_cbm_to_size(r,
d, ctrl);
                        }
                        seq_printf(s, "%d=%u", d->id, size);
                        sep = true;

