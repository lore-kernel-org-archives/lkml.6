Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2FAECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192002150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192002150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbeISPce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:32:34 -0400
Received: from mail5.windriver.com ([192.103.53.11]:55678 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbeISPce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:32:34 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w8J9pnS5003017
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 19 Sep 2018 02:52:25 -0700
Received: from [128.224.162.216] (128.224.162.216) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 19 Sep
 2018 02:51:45 -0700
Subject: Re: [PATCH] mm/page_alloc: Fix panic caused by passing
 debug_guardpage_minorder or kernelcore to command line
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <mhocko@suse.com>, <vbabka@suse.cz>, <pasha.tatashin@oracle.com>,
        <mgorman@techsingularity.net>, <aaron.lu@intel.com>,
        <osalvador@suse.de>, <iamjoonsoo.kim@lge.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1537284788-428784-1-git-send-email-zhe.he@windriver.com>
 <20180918141917.2cb16b01c122dbe1ead2f657@linux-foundation.org>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <1c32c1d2-a54a-30f7-1afb-ad6d3282f54a@windriver.com>
Date:   Wed, 19 Sep 2018 17:51:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918141917.2cb16b01c122dbe1ead2f657@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.216]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月19日 05:19, Andrew Morton wrote:
> On Tue, 18 Sep 2018 23:33:08 +0800 <zhe.he@windriver.com> wrote:
>
>> From: He Zhe <zhe.he@windriver.com>
>>
>> debug_guardpage_minorder_setup and cmdline_parse_kernelcore do not check
>> input argument before using it. The argument would be a NULL pointer if
>> "debug_guardpage_minorder" or "kernelcore", without its value, is set in
>> command line and thus causes the following panic.
>>
>> PANIC: early exception 0xe3 IP 10:ffffffffa08146f1 error 0 cr2 0x0
>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc4-yocto-standard+ #1
>> [    0.000000] RIP: 0010:parse_option_str+0x11/0x90
>> ...
>> [    0.000000] Call Trace:
>> [    0.000000]  cmdline_parse_kernelcore+0x19/0x41
>> [    0.000000]  do_early_param+0x57/0x8e
>> [    0.000000]  parse_args+0x208/0x320
>> [    0.000000]  ? rdinit_setup+0x30/0x30
>> [    0.000000]  parse_early_options+0x29/0x2d
>> [    0.000000]  ? rdinit_setup+0x30/0x30
>> [    0.000000]  parse_early_param+0x36/0x4d
>> [    0.000000]  setup_arch+0x336/0x99e
>> [    0.000000]  start_kernel+0x6f/0x4ee
>> [    0.000000]  x86_64_start_reservations+0x24/0x26
>> [    0.000000]  x86_64_start_kernel+0x6f/0x72
>> [    0.000000]  secondary_startup_64+0xa4/0xb0
> >From my quick reading, more than half of the __setup handlers in mm/
> will crash in the same way if misused in this fashion.
>
>> This patch adds a check to prevent the panic and adds KBUILD_MODNAME to
>> prints.
> So a better solution might be to add a check into the calling code
> (presumably in init/main.c) to print a warning if we have kernel
> command line arguments such as "kernelcore=".  That way, users will see
> the warning immediately before the oops and will know how to fix things
> up.

Thank you for your suggestion.

"kernelcore=" would not cause crash, "kernelcore' would. Andmany users of
early_param, e.g. the following two, depend on the validity of the "xxx"
format. If we fixed in the calling code, those parameters would become
invalid and need to be changed to a new format. That might affect too much.
Soit might be better to correct the users who misuse it.


static int __init cmdline_parse_movable_node(char *p)                           
{                                                                                   
#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP                                            
        movable_node_enabled = true;                                            
#else                                                                           
        pr_warn("movable_node parameter depends on CONFIG_HAVE_MEMBLOCK_NODE_MAP to work properly\n");
#endif                                                                          
        return 0;                                                               
}                                                                               
early_param("movable_node", cmdline_parse_movable_node);


static int __init parse_alloc_mptable_opt(char *p)                                 
{                                                                               
        enable_update_mptable = 1;                                                 
#ifdef CONFIG_PCI                                                               
        pci_routeirq = 1;                                                       
#endif                                                                          
        alloc_mptable = 1;                                                      
        if (!p)                                                                 
                return 0;                                                       
        mpc_new_length = memparse(p, &p);                                          
        return 0;                                                               
}                                                                               
early_param("alloc_mptable", parse_alloc_mptable_opt);

>
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -14,6 +14,8 @@
>>   *          (lots of bits borrowed from Ingo Molnar & Andrew Morton)
>>   */
>>  
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>>  #include <linux/stddef.h>
>>  #include <linux/mm.h>
>>  #include <linux/swap.h>
>> @@ -630,6 +632,11 @@ static int __init debug_guardpage_minorder_setup(char *buf)
>>  {
>>  	unsigned long res;
>>  
>> +	if (!buf) {
>> +		pr_err("Config string not provided\n");
> If were going to do it this way, we should tell the operator which
> argument was bad.  pr_err("kernel option debug_guardpage_minorder
> requires an argument").

Yes, this makes it more clear for users.I'd like to do in this way.

>
> And then perhaps we should just let the kernel crash anyway.  That
> seems better than hoping that the user will notice that line in the
> logs one day.  

If we want the PANIC info for these early parameters when crashing,
the parameter earlyprintk needs to be set correctly, especially in
embedded scenarios. Otherwise the system will hang without any error
info. Letting it boot up with an invalid parameter seems better than
that. And the owner of the parameter may give more errors to the
users if they don't get a valid value.

Thanks,
Zhe

>
> And note that the preceding two paragraphs will produce the same result
> as my do-it-in-init/main.c suggestion!
>
>

