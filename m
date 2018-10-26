Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9500CC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E9F20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E9F20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeJZRjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:39:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:6051 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbeJZRjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:39:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2018 02:03:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,427,1534834800"; 
   d="scan'208";a="91400031"
Received: from rwang-mobl4.amr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.211.80])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Oct 2018 02:03:21 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gFy1Y-0001uq-VP; Fri, 26 Oct 2018 17:03:20 +0800
Date:   Fri, 26 Oct 2018 17:03:20 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Xishi Qiu <qiuxishi@gmail.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, zwisler@kernel.org, vishal.l.verma@intel.com,
        thomas.lendacky@amd.com, akpm@linux-foundation.org,
        mhocko@suse.com, linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        ying.huang@intel.com, Xishi Qiu <qiuxishi@linux.alibaba.com>,
        zy107165@alibaba-inc.com
Subject: Re: [PATCH 0/9] Allow persistent memory to be used like normal RAM
Message-ID: <20181026090320.6eqhnpvfnwgb2buv@wfg-t540p.sh.intel.com>
References: <20181022201317.8558C1D8@viggo.jf.intel.com>
 <debe98dd-39f3-18d5-aeb4-fe94519aa0c9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <debe98dd-39f3-18d5-aeb4-fe94519aa0c9@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xishi,

I can help answer the migration and policy related questions.

On Fri, Oct 26, 2018 at 01:42:43PM +0800, Xishi Qiu wrote:
>Hi Dave,
>
>This patchset hotadd a pmem and use it like a normal DRAM, I
>have some questions here, and I think my production line may
>also concerned.
>
>1) How to set the AEP (Apache Pass) usage percentage for one
>process (or a vma)?
>e.g. there are two vms from two customers, they pay different
>money for the vm. So if we alloc and convert AEP/DRAM by global,
>the high load vm may get 100% DRAM, and the low load vm may get
>100% AEP, this is unfair. The low load is compared to another
>one, for himself, the actual low load maybe is high load.

Per VM, process, VMA policies are possible. They can be implemented
in user space migration daemon. We can dip into details when user
space code is released.

>2) I find page idle only check the access bit, _PAGE_BIT_ACCESSED,
>as we know AEP read performance is much higher than write, so I
>think we should also check the dirty bit, _PAGE_BIT_DIRTY. Test

Yeah dirty bit could be considered later. The initial version will
only check accessed bit.

>and clear dirty bit is safe for anon page, but unsafe for file
>page, e.g. should call clear_page_dirty_for_io first, right?

We'll only migrate anonymous pages in the initial version.

>3) I think we should manage the AEP memory separately instead
>of together with the DRAM.

I guess the intention of this patchset is to use different
NUMA nodes for AEP and DRAM.

>Manage them together maybe change less
>code, but it will cause some problems at high priority DRAM
>allocation if there is no DRAM, then should convert (steal DRAM)
>from another one, it takes much time.
>How about create a new zone, e.g. ZONE_AEP, and use madvise
>to set a new flag VM_AEP, which will enable the vma to alloc AEP
>memory in page fault later, then use vma_rss_stat(like mm_rss_stat)
>to control the AEP usage percentage for a vma.
>
>4) I am interesting about the conversion mechanism betweent AEP
>and DRAM. I think numa balancing will cause page fault, this is
>unacceptable for some apps, it cause performance jitter. And the

NUMA balancing can be taught to be enabled per task. I'm not sure
there is already such knob, but it looks easy to implement such a
policy.

>kswapd is not precise enough. So use a daemon kernel thread
>(like khugepaged) maybe a good solution, add the AEP used processes
>to a list, then scan the VM_AEP marked vmas, get the access state,
>and do the conversion.

If that's a desirable policy, our user space migration daemon could
possibly do that, too.

Thanks,
Fengguang

>On 2018/10/23 04:13, Dave Hansen wrote:
>> Persistent memory is cool.  But, currently, you have to rewrite
>> your applications to use it.  Wouldn't it be cool if you could
>> just have it show up in your system like normal RAM and get to
>> it like a slow blob of memory?  Well... have I got the patch
>> series for you!
>>
>> This series adds a new "driver" to which pmem devices can be
>> attached.  Once attached, the memory "owned" by the device is
>> hot-added to the kernel and managed like any other memory.  On
>> systems with an HMAT (a new ACPI table), each socket (roughly)
>> will have a separate NUMA node for its persistent memory so
>> this newly-added memory can be selected by its unique NUMA
>> node.
>>
>> This is highly RFC, and I really want the feedback from the
>> nvdimm/pmem folks about whether this is a viable long-term
>> perversion of their code and device mode.  It's insufficiently
>> documented and probably not bisectable either.
>>
>> Todo:
>> 1. The device re-binding hacks are ham-fisted at best.  We
>>    need a better way of doing this, especially so the kmem
>>    driver does not get in the way of normal pmem devices.
>> 2. When the device has no proper node, we default it to
>>    NUMA node 0.  Is that OK?
>> 3. We muck with the 'struct resource' code quite a bit. It
>>    definitely needs a once-over from folks more familiar
>>    with it than I.
>> 4. Is there a better way to do this than starting with a
>>    copy of pmem.c?
>>
>> Here's how I set up a system to test this thing:
>>
>> 1. Boot qemu with lots of memory: "-m 4096", for instance
>> 2. Reserve 512MB of physical memory.  Reserving a spot a 2GB
>>    physical seems to work: memmap=512M!0x0000000080000000
>>    This will end up looking like a pmem device at boot.
>> 3. When booted, convert fsdax device to "device dax":
>> 	ndctl create-namespace -fe namespace0.0 -m dax
>> 4. In the background, the kmem driver will probably bind to the
>>    new device.
>> 5. Now, online the new memory sections.  Perhaps:
>>
>> grep ^MemTotal /proc/meminfo
>> for f in `grep -vl online /sys/devices/system/memory/*/state`; do
>> 	echo $f: `cat $f`
>> 	echo online > $f
>> 	grep ^MemTotal /proc/meminfo
>> done
>>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Ross Zwisler <zwisler@kernel.org>
>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: linux-nvdimm@lists.01.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: Huang Ying <ying.huang@intel.com>
>> Cc: Fengguang Wu <fengguang.wu@intel.com>
>>
>
