Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB86ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB03214DD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB03214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeIRBTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:19:03 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:50794 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727176AbeIRBTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:19:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0T8vMmOy_1537213792;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T8vMmOy_1537213792)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Sep 2018 03:49:56 +0800
Subject: Re: [RFC v10 PATCH 1/3] mm: mmap: zap pages with read mmap_sem in
 munmap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     mhocko@kernel.org, ldufour@linux.vnet.ibm.com, vbabka@suse.cz,
        kirill@shutemov.name, akpm@linux-foundation.org,
        dave.hansen@intel.com, oleg@redhat.com, srikar@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1536957299-43536-1-git-send-email-yang.shi@linux.alibaba.com>
 <1536957299-43536-2-git-send-email-yang.shi@linux.alibaba.com>
 <20180915092101.GA31572@bombadil.infradead.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <578efe1c-0de0-d71d-ac14-cf5b74e2a713@linux.alibaba.com>
Date:   Mon, 17 Sep 2018 12:49:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180915092101.GA31572@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/18 2:21 AM, Matthew Wilcox wrote:
> On Sat, Sep 15, 2018 at 04:34:57AM +0800, Yang Shi wrote:
>> Suggested-by: Michal Hocko <mhocko@kernel.org>
>> Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
>> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Reviewed-by: Matthew Wilcox <willy@infradead.org>
>
> Looks good!  Thanks for sticking with this patch series.

Thanks for reviewing this patch series. I'm going to wait for one or two 
days to see whether anyone else has more comments before I have the 
spelling error fixed.

Yang

>
> Minor spelling fixes:
>
>> -	/*
>> -	 * Remove the vma's, and unmap the actual pages
>> -	 */
>> +	/* Detatch vmas from rbtree */
> "Detach"
>
>> +	/*
>> +	 * mpx unmap need to be handled with write mmap_sem. It is safe to
>> +	 * deal with it before unmap_region().
>> +	 */
> 	 * mpx unmap needs to be called with mmap_sem held for write.
> 	 * It is safe to call it before unmap_region()
>
>> +	ret = __do_munmap(mm, start, len, &uf, downgrade);
>> +	/*
>> +	 * Returning 1 indicates mmap_sem is down graded.
>> +	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
>> +	 * it to 0 before return.
>> +	 */
> "downgraded" is one word.

