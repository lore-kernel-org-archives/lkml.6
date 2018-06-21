Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1EFC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969BC20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969BC20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932508AbeFUFGN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 01:06:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932231AbeFUFGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 01:06:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 139F8400225D;
        Thu, 21 Jun 2018 05:06:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-127.pek2.redhat.com [10.72.12.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C5352156880;
        Thu, 21 Jun 2018 05:06:08 +0000 (UTC)
Subject: Re: [PATCH 2/4 V3] Allocate pages for kdump without encryption when
 SME is enabled
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        iommu@lists.linux-foundation.org, dyoung@redhat.com,
        kexec@lists.infradead.org
References: <20180616082714.32035-1-lijiang@redhat.com>
 <20180616082714.32035-3-lijiang@redhat.com>
 <20180621015306.GG29979@MiWiFi-R3L-srv>
From:   lijiang <lijiang@redhat.com>
Message-ID: <e74e94b6-97dc-23d9-6262-44a7ae8d63bd@redhat.com>
Date:   Thu, 21 Jun 2018 13:06:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180621015306.GG29979@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 21 Jun 2018 05:06:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 21 Jun 2018 05:06:12 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年06月21日 09:53, Baoquan He 写道:
> On 06/16/18 at 04:27pm, Lianbo Jiang wrote:
>> When SME is enabled in the first kernel, we will allocate pages
>> for kdump without encryption in order to be able to boot the
>> second kernel in the same manner as kexec, which helps to keep
>> the same code style.
>>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>>  kernel/kexec_core.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index 20fef1a..3c22a9b 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -471,6 +471,16 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
>>  		}
>>  	}
>>  
>> +	if (pages) {
>> +		unsigned int count, i;
>> +
>> +		pages->mapping = NULL;
>> +		set_page_private(pages, order);
>> +		count = 1 << order;
>> +		for (i = 0; i < count; i++)
>> +			SetPageReserved(pages + i);
> 
> I guess you might imitate the kexec case, however kexec get pages from
> buddy. Crash pages are reserved in memblock, these codes might make no sense.
> 
Thanks for your comments.
We have changed the attribute of pages, so the original attribute of pages will be
restored when they free.

Thanks.
Lianbo
>> +		arch_kexec_post_alloc_pages(page_address(pages), 1 << order, 0);
>> +	}
>>  	return pages;
>>  }
>>  
>> @@ -865,6 +875,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>>  			result  = -ENOMEM;
>>  			goto out;
>>  		}
>> +		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
>>  		ptr = kmap(page);
>>  		ptr += maddr & ~PAGE_MASK;
>>  		mchunk = min_t(size_t, mbytes,
>> @@ -882,6 +893,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>>  			result = copy_from_user(ptr, buf, uchunk);
>>  		kexec_flush_icache_page(page);
>>  		kunmap(page);
>> +		arch_kexec_pre_free_pages(page_address(page), 1);
>>  		if (result) {
>>  			result = -EFAULT;
>>  			goto out;
>> -- 
>> 2.9.5
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
