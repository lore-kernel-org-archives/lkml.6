Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E3DC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D4E2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D4E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932899AbeFUFmd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 01:42:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932583AbeFUFmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 01:42:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EEE78401C96A;
        Thu, 21 Jun 2018 05:42:31 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-127.pek2.redhat.com [10.72.12.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C4C4178B9;
        Thu, 21 Jun 2018 05:42:27 +0000 (UTC)
Subject: Re: [PATCH 3/4 V3] Remap the device table of IOMMU in encrypted
 manner for kdump
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, kexec@lists.infradead.org,
        dyoung@redhat.com
References: <20180616082714.32035-1-lijiang@redhat.com>
 <20180616082714.32035-4-lijiang@redhat.com>
 <60c6f00e-0eb3-d39c-6a1e-8a1dc1e095af@amd.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <c591dec2-2135-2e96-8ace-87cbf4b055bf@redhat.com>
Date:   Thu, 21 Jun 2018 13:42:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <60c6f00e-0eb3-d39c-6a1e-8a1dc1e095af@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 21 Jun 2018 05:42:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 21 Jun 2018 05:42:32 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年06月21日 00:42, Tom Lendacky 写道:
> On 6/16/2018 3:27 AM, Lianbo Jiang wrote:
>> In kdump mode, it will copy the device table of IOMMU from the old
>> device table, which is encrypted when SME is enabled in the first
>> kernel. So we must remap it in encrypted manner in order to be
>> automatically decrypted when we read.
>>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>> Some changes:
>> 1. add some comments
>> 2. clean compile warning.
>>
>>  drivers/iommu/amd_iommu_init.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
>> index 904c575..a20af4c 100644
>> --- a/drivers/iommu/amd_iommu_init.c
>> +++ b/drivers/iommu/amd_iommu_init.c
>> @@ -889,11 +889,24 @@ static bool copy_device_table(void)
>>  	}
>>  
>>  	old_devtb_phys = entry & PAGE_MASK;
>> +
>> +	/*
>> +	 *  When sme enable in the first kernel, old_devtb_phys includes the
>> +	 *  memory encryption mask(sme_me_mask), we must remove the memory
>> +	 *  encryption mask to obtain the true physical address in kdump mode.
>> +	 */
>> +	if (mem_encrypt_active() && is_kdump_kernel())
>> +		old_devtb_phys = __sme_clr(old_devtb_phys);
>> +
> 
> You can probably just use "if (is_kdump_kernel())" here, since memory
> encryption is either on in both the first and second kernel or off in
> both the first and second kernel.  At which point __sme_clr() will do
> the proper thing.
> 
> Actually, this needs to be done no matter what.  When doing either the
> ioremap_encrypted() or the memremap(), the physical address should not
> include the encryption bit/mask.
> 
> Thanks,
> Tom
> 
Thanks for your comments. If we don't remove the memory encryption mask, it will
return false because the 'old_devtb_phys >= 0x100000000ULL' may become true.

Lianbo
>>  	if (old_devtb_phys >= 0x100000000ULL) {
>>  		pr_err("The address of old device table is above 4G, not trustworthy!\n");
>>  		return false;
>>  	}
>> -	old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
>> +	old_devtb = (mem_encrypt_active() && is_kdump_kernel())
>> +		    ? (__force void *)ioremap_encrypted(old_devtb_phys,
>> +							dev_table_size)
>> +		    : memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);> +
>>  	if (!old_devtb)
>>  		return false;
>>  
>>
