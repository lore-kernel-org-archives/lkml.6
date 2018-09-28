Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DFCC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03837206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03837206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbeI2FJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:09:20 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:47934 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726517AbeI2FJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:09:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04389;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T9euBAu_1538174585;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T9euBAu_1538174585)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 29 Sep 2018 06:43:07 +0800
Subject: Re: [PATCH] mm: enforce THP for VM_NOHUGEPAGE dax mappings
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jan Kara <jack@suse.cz>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1538173916-95849-1-git-send-email-yang.shi@linux.alibaba.com>
 <CAPcyv4jdTWoJMSPuxso=8fu8nGOrmbBPYxkJvsuEDfJSYvsDWg@mail.gmail.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <def53b95-804d-d3c5-179c-e1862a5d8e8c@linux.alibaba.com>
Date:   Fri, 28 Sep 2018 15:43:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jdTWoJMSPuxso=8fu8nGOrmbBPYxkJvsuEDfJSYvsDWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/18 3:36 PM, Dan Williams wrote:
> On Fri, Sep 28, 2018 at 3:34 PM <yang.shi@linux.alibaba.com> wrote:
>> commit baabda261424517110ea98c6651f632ebf2561e3 ("mm: always enable thp
>> for dax mappings") says madvise hguepage policy makes less sense for
>> dax, and force enabling thp for dax mappings in all cases, even though
>> THP is set to "never".
>>
>> However, transparent_hugepage_enabled() may return false if
>> VM_NOHUGEPAGE is set even though the mapping is dax.
>>
>> So, move is_vma_dax() check to the very beginning to enforce THP for dax
>> mappings in all cases.
>>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Jan Kara <jack@suse.cz>
>> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
>> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>> I didn't find anyone mention the check should be before VM_NOHUGEPAGE in
>> the review for Dan's original patch. And, that patch commit log states
>> clearly that THP for dax mapping for all cases even though THP is never.
>> So, I'm supposed it should behave in this way.
> No, if someone explicitly does MADV_NOHUGEPAGE then the kernel should
> honor that, even if the mapping is DAX.

Thanks for confirming this. Actually, I had the same question before I 
came up with this patch. "all cases" sounds a little bit misleading.


