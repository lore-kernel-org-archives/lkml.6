Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832BBC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA562098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA562098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeHWBXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 21:23:39 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:37620 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727353AbeHWBXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 21:23:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0T72x03g_1534974994;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T72x03g_1534974994)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Aug 2018 05:56:39 +0800
Subject: Re: [RFC v8 PATCH 3/5] mm: mmap: zap pages with read mmap_sem in
 munmap
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Vlastimil Babka <vbabka@suse.cz>, mhocko@kernel.org,
        willy@infradead.org, ldufour@linux.vnet.ibm.com,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1534358990-85530-1-git-send-email-yang.shi@linux.alibaba.com>
 <1534358990-85530-4-git-send-email-yang.shi@linux.alibaba.com>
 <e691d054-f807-80ad-9934-a1917d8e2e77@suse.cz>
 <3c62f605-2244-6a05-2dc4-34a3f1c56300@linux.alibaba.com>
 <20180822211053.qg3dlzf6pok2x4yk@kshutemo-mobl1>
 <45a5ff36-d53d-9ec3-f869-1b1b7a6de5cb@intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <a1642cf6-f458-3026-dca9-652fbb20f580@linux.alibaba.com>
Date:   Wed, 22 Aug 2018 14:56:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <45a5ff36-d53d-9ec3-f869-1b1b7a6de5cb@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/18 2:42 PM, Dave Hansen wrote:
> On 08/22/2018 02:10 PM, Kirill A. Shutemov wrote:
>>> For x86, mpx_notify_unmap() looks finally zap the VM_MPX vmas in bound table
>>> range with zap_page_range() and doesn't update vm flags, so it sounds ok to
>>> me since vmas have been detached, nobody can find those vmas. But, I'm not
>>> familiar with the details of mpx, maybe Kirill could help to confirm this?
>> I don't see anything obviously dependent on down_write() in
>> mpx_notify_unmap(), but Dave should know better.
> We need mmap_sem for write in mpx_notify_unmap().
>
> Its job is to clean up bounds tables, but bounds tables are dynamically
> allocated and destroyed by the kernel.  When we destroy a table, we also
> destroy the VMA for the bounds table *itself*, separate from the VMA
> being unmapped.

Thanks for confirming this. I didn't realize there is VMA for bounds 
table itself.

>
> But, this code is very likely to go away soon.  If it's causing a
> problem for you, let me know and I'll see if I can get to removing it
> faster.

Does it depends on unmap_region()? Or IOW, does it has to be called 
after unmap_region()? Now the calling sequence is:

detach vmas
unmap_region()
mpx_notify_unmap()

I'm wondering if it is safe to move it up before unmap_region() like:

detach vmas
mpx_notify_unmap()
unmap_region()

With this change we also can do our optimization to do unmap_region() 
with read mmap_sem. Otherwise it does cause problem.

Thanks,
Yang


