Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF69CC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899FF206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899FF206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeILEhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:37:01 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:43918 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbeILEhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:37:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0T8TLWB6_1536708903;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T8TLWB6_1536708903)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Sep 2018 07:35:06 +0800
Subject: Re: [RFC v9 PATCH 2/4] mm: mmap: zap pages with read mmap_sem in
 munmap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     mhocko@kernel.org, ldufour@linux.vnet.ibm.com, vbabka@suse.cz,
        akpm@linux-foundation.org, dave.hansen@intel.com, oleg@redhat.com,
        srikar@linux.vnet.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1536699493-69195-1-git-send-email-yang.shi@linux.alibaba.com>
 <1536699493-69195-3-git-send-email-yang.shi@linux.alibaba.com>
 <20180911211645.GA12159@bombadil.infradead.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <b69d3f7d-e9ba-b95c-45cd-44489950751b@linux.alibaba.com>
Date:   Tue, 11 Sep 2018 16:35:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180911211645.GA12159@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/18 2:16 PM, Matthew Wilcox wrote:
> On Wed, Sep 12, 2018 at 04:58:11AM +0800, Yang Shi wrote:
>>   mm/mmap.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
> I really think you're going about this the wrong way by duplicating
> vm_munmap().

If we don't duplicate vm_munmap() or do_munmap(), we need pass an extra 
parameter to them to tell when it is fine to downgrade write lock or if 
the lock has been acquired outside it (i.e. in mmap()/mremap()), right? 
But, vm_munmap() or do_munmap() is called not only by mmap-related, but 
also some other places, like arch-specific places, which don't need 
downgrade write lock or are not safe to do so.

Actually, I did this way in the v1 patches, but it got pushed back by 
tglx who suggested duplicate the code so that the change could be done 
in mm only without touching other files, i.e. arch-specific stuff. I 
didn't have strong argument to convince him.

And, Michal prefers have VM_HUGETLB and VM_PFNMAP handled separately for 
safe and bisectable sake, which needs call the regular do_munmap().

In addition to this, I just found mpx code may call do_munmap() 
recursively when I was looking into the mpx code.

We might be able to handle these by the extra parameter, but it sounds 
it make the code hard to understand and error prone.

Thanks,
Yang


