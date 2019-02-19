Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E50C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E25021773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbfBSQzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:55:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:34126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726244AbfBSQzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:55:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29031AAA9;
        Tue, 19 Feb 2019 16:55:35 +0000 (UTC)
Subject: Re: [PATCH] mm/cma: cma_declare_contiguous: correct err handling
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peng Fan <peng.fan@nxp.com>
Cc:     "labbott@redhat.com" <labbott@redhat.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20190214125704.6678-1-peng.fan@nxp.com>
 <20190214123824.fe95cc2e603f75382490bfb4@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <b78470e8-b204-4a7e-f9cc-eff9c609f480@suse.cz>
Date:   Tue, 19 Feb 2019 17:55:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214123824.fe95cc2e603f75382490bfb4@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 9:38 PM, Andrew Morton wrote:
> On Thu, 14 Feb 2019 12:45:51 +0000 Peng Fan <peng.fan@nxp.com> wrote:
> 
>> In case cma_init_reserved_mem failed, need to free the memblock allocated
>> by memblock_reserve or memblock_alloc_range.
>>
>> ...
>>
>> --- a/mm/cma.c
>> +++ b/mm/cma.c
>> @@ -353,12 +353,14 @@ int __init cma_declare_contiguous(phys_addr_t base,
>>  
>>  	ret = cma_init_reserved_mem(base, size, order_per_bit, name, res_cma);
>>  	if (ret)
>> -		goto err;
>> +		goto free_mem;
>>  
>>  	pr_info("Reserved %ld MiB at %pa\n", (unsigned long)size / SZ_1M,
>>  		&base);
>>  	return 0;
>>  
>> +free_mem:
>> +	memblock_free(base, size);
>>  err:
>>  	pr_err("Failed to reserve %ld MiB\n", (unsigned long)size / SZ_1M);
>>  	return ret;
> 
> This doesn't look right to me.  In the `fixed==true' case we didn't
> actually allocate anything and in the `fixed==false' case, the
> allocated memory is at `addr', not at `base'.

I think it's ok as the fixed==true path has "memblock_reserve()", but
better leave this to the memblock maintainer :)

There's also 'kmemleak_ignore_phys(addr)' which should probably be
undone (or not called at all) in the failure case. But it seems to be
missing from the fixed==true path?
