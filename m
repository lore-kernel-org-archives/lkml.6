Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110A8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA2320844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="InWmeGfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA2320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbeGYB4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 21:56:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38922 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbeGYB4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 21:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Xe7Prntm0L+fJga8OakbHg6P9tNpejHuz028ZBBM4w4=; b=InWmeGfBA0mJlfe64j95JwM6dX
        UNwetkqTvrt9mx3T9z9Ny2sNRAsnsgBvvzckoQuHVv7//iXskrMPVPKpsCcpI51lNeB0F2glHZcaW
        ThGod4puSQBiW+ekwOxcxFYJFVUJLo1oLVFZgUTBZnd2YmvizTRx/ju/tAWNhSy+vzyoVpZVw3Xur
        e15l+ML4up4kExWt1hHPC8Az3MskUkLXcheO78Lza0i3BNYfqlRqBuekQduD667knqdlognYdocDz
        UhhfwMMG9lbs2UXFD82RxeN57rWUHsiv06dwQjsH5xabuLpJGfAq1aNR50QRJ7s92B4vkB3mHUrQn
        7AZ55Meg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fi7x9-00062G-82; Wed, 25 Jul 2018 00:46:55 +0000
Subject: Re: [PATCH 2/4] arc: fix type warnings in arc/mm/cache.c
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Randy Dunlap <rd.dunlab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
References: <20180724204622.2366-1-rd.dunlab@gmail.com>
 <20180724204622.2366-3-rd.dunlab@gmail.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B0839C0@us01wembx1.internal.synopsys.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8fc4281e-604b-46e3-a6ad-320b370fea91@infradead.org>
Date:   Tue, 24 Jul 2018 17:46:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B0839C0@us01wembx1.internal.synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 05:02 PM, Vineet Gupta wrote:
> On 07/24/2018 01:46 PM, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> ../arch/arc/mm/cache.c: In function 'flush_anon_page':
>> ../arch/arc/mm/cache.c:1062:55: warning: passing argument 2 of '__flush_dcache_page' makes integer from pointer without a cast [-Wint-conversion]
>>   __flush_dcache_page((phys_addr_t)page_address(page), page_address(page));
>>                                                        ^~~~~~~~~~~~~~~~~~
>> ../arch/arc/mm/cache.c:1013:59: note: expected 'long unsigned int' but argument is of type 'void *'
>>  void __flush_dcache_page(phys_addr_t paddr, unsigned long vaddr)
>>                                              ~~~~~~~~~~~~~~^~~~~
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Vineet Gupta <vgupta@synopsys.com>
>> Cc: Ofer Levi <oferle@mellanox.com>
>> Cc: linux-snps-arc@lists.infradead.org
>> ---
>>  arch/arc/mm/cache.c |   11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> --- linux-next-20180723.orig/arch/arc/mm/cache.c
>> +++ linux-next-20180723/arch/arc/mm/cache.c
>> @@ -1038,7 +1038,7 @@ void flush_cache_mm(struct mm_struct *mm
>>  void flush_cache_page(struct vm_area_struct *vma, unsigned long u_vaddr,
>>  		      unsigned long pfn)
>>  {
>> -	unsigned int paddr = pfn << PAGE_SHIFT;
>> +	phys_addr_t paddr = pfn << PAGE_SHIFT;
>>  
>>  	u_vaddr &= PAGE_MASK;
>>  
>> @@ -1058,8 +1058,9 @@ void flush_anon_page(struct vm_area_stru
>>  		     unsigned long u_vaddr)
>>  {
>>  	/* TBD: do we really need to clear the kernel mapping */
>> -	__flush_dcache_page(page_address(page), u_vaddr);
>> -	__flush_dcache_page(page_address(page), page_address(page));
>> +	__flush_dcache_page((phys_addr_t)page_address(page), u_vaddr);
>> +	__flush_dcache_page((phys_addr_t)page_address(page),
>> +			    (phys_addr_t)page_address(page));
> 
> CONFIG_ARC_CACHE_VIPT_ALIASING is a total bitrot and I'm considering removing it
> as no sane systems should use it. There's none which I know are using it.
> But for now this will do.
> 
> 
>>  
>>  }
>>  
>> @@ -1084,7 +1085,7 @@ void copy_user_highpage(struct page *to,
>>  	 * addr_not_cache_congruent() is 0
>>  	 */
>>  	if (page_mapcount(from) && addr_not_cache_congruent(kfrom, u_vaddr)) {
>> -		__flush_dcache_page((unsigned long)kfrom, u_vaddr);
>> +		__flush_dcache_page((phys_addr_t)kfrom, u_vaddr);
> 
> Was this needed really ? I can't seem to trigger any warnings here.

Nope.. glad you caught that.  I can't explain it.  :(

I can only say that if I had _meant_ to patch that, I would have also included
the warning messages from gcc.

> All of this (original code before your change) is technically incorrect due to the
> combination of CONFIG_ARC_CACHE_VIPT_ALIASING and CONFIG_HIGHMEM. @kfrom is
> returned by kmap_atomic() and in highmem regime it could be a kernel virtual
> address, so calling the low level cache flush interface with a kvaddr, pretending
> it is paddr (whethe runsigned long or phys_addr_t) is just not right. This
> combinations needs to be disallowed from Kconfig !
> 
>>  		clean_src_k_mappings = 1;
>>  	}
>>  
>> @@ -1105,7 +1106,7 @@ void copy_user_highpage(struct page *to,
>>  	 * sync the kernel mapping back to physical page
>>  	 */
>>  	if (clean_src_k_mappings) {
>> -		__flush_dcache_page((unsigned long)kfrom, (unsigned long)kfrom);
>> +		__flush_dcache_page((phys_addr_t)kfrom, (unsigned long)kfrom);
>>  		set_bit(PG_dc_clean, &from->flags);
>>  	} else {
>>  		clear_bit(PG_dc_clean, &from->flags);
>>
> 
> Ditto !
> 

Thanks.
-- 
~Randy
