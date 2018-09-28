Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B934C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 03:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5659A20779
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 03:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5659A20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeI1KOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 06:14:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbeI1KOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 06:14:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A62F33001BD3;
        Fri, 28 Sep 2018 03:52:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FC345D73F;
        Fri, 28 Sep 2018 03:52:26 +0000 (UTC)
Subject: Re: [PATCH v7 RESEND 2/4] kexec: allocate unencrypted control pages
 for kdump in case SME is enabled
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com,
        jroedel@suse.de
References: <20180927071954.29615-1-lijiang@redhat.com>
 <20180927071954.29615-3-lijiang@redhat.com> <20180927165323.GC19779@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <ef91c6cd-03dd-1a72-eea8-97d05d0ad370@redhat.com>
Date:   Fri, 28 Sep 2018 11:52:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927165323.GC19779@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 28 Sep 2018 03:52:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年09月28日 00:53, Borislav Petkov 写道:
> On Thu, Sep 27, 2018 at 03:19:52PM +0800, Lianbo Jiang wrote:
>> When SME is enabled in the first kernel, we will allocate unencrypted pages
>> for kdump in order to be able to boot the kdump kernel like kexec.
> 
> This is not what the commit does - it marks the control pages as
> decrypted when SME. Why doesn't the commit message state that and why is
> this being done?
> 
Ok, i will improve this patch log.

If SME is active, we need to mark the control pages as decrypted, because
when we boot to the kdump kernel, these pages won't be accessed encrypted
at the initial stage, in order to boot the kdump kernel in the same manner
as originally booted.

>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  kernel/kexec_core.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index 23a83a4da38a..e7efcd1a977b 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -471,6 +471,16 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
>>  		}
>>  	}
>>  
>> +	if (pages) {
>> +		/*
>> +		 * For kdump, we need to ensure that these pages are
>> +		 * unencrypted pages if SME is enabled.
> 
> Remember to always call unencrypted pages "decrypted" - this is the
> convention we agreed upon and it should keep the confusion level at
> minimum to others staring at this code.
> 
Ok, i will improve this comment.

>> +		 * By the way, it is unnecessary to call the arch_
>> +		 * kexec_pre_free_pages(), which will make the code
>> +		 * become more simple.
>> +		 */
> 
> This second sentence I don't understand...
> 

There are two functions that are usually called in pairs, they are:
arch_kexec_post_alloc_pages() and arch_kexec_pre_free_pages().

One marks the pages as decrypted, another one marks the pages as encrypted.

But for the crash control pages, no need to call arch_kexec_pre_free_pages(),
there are three reasons:
1. Crash pages are reserved in memblock, these pages are only used by kdump,
   no other people uses these pages;

2. Whenever crash pages are allocated, these pages are always marked as
   decrypted(when SME is active);

3. If we plan to call the arch_kexe_pre_free_pages(), we have to store these
pages to somewhere, which will have more code changes.

So, here it is redundant to call the arch_kexe_pre_free_pages().

Thanks.
Lianbo
>> +		arch_kexec_post_alloc_pages(page_address(pages), 1 << order, 0);
>> +	}
>>  	return pages;
>>  }
>>  
>> @@ -867,6 +877,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>>  			result  = -ENOMEM;
>>  			goto out;
>>  		}
>> +		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
>>  		ptr = kmap(page);
>>  		ptr += maddr & ~PAGE_MASK;
>>  		mchunk = min_t(size_t, mbytes,
>> @@ -884,6 +895,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>>  			result = copy_from_user(ptr, buf, uchunk);
>>  		kexec_flush_icache_page(page);
>>  		kunmap(page);
>> +		arch_kexec_pre_free_pages(page_address(page), 1);
>>  		if (result) {
>>  			result = -EFAULT;
>>  			goto out;
>> -- 
>> 2.17.1
>>
> 
