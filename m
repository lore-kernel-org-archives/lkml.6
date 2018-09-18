Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73800ECE568
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B3D2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B3D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbeIRPwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:52:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbeIRPwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:52:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16602307D857;
        Tue, 18 Sep 2018 10:20:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-52.pek2.redhat.com [10.72.12.52])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B0052A33A;
        Tue, 18 Sep 2018 10:20:30 +0000 (UTC)
Subject: Re: [PATCH 2/2] x86/kexec_file: add reserved e820 ranges to 2nd
 kernel e820 table
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, akpm@linux-foundation.org
References: <20180918024837.17710-1-lijiang@redhat.com>
 <20180918024837.17710-3-lijiang@redhat.com>
 <20180918032024.GA22528@dhcp-128-65.nay.redhat.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <a89c3f5e-1d6b-c464-730e-8c3a8234a1f0@redhat.com>
Date:   Tue, 18 Sep 2018 18:20:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918032024.GA22528@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 18 Sep 2018 10:20:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年09月18日 11:20, Dave Young 写道:
> On 09/18/18 at 10:48am, Lianbo Jiang wrote:
>> e820 reserved ranges is useful in kdump kernel, we have added this in
>> kexec-tools code.
>>
>> One reason is PCI mmconf (extended mode) requires reserved region
>> otherwise it falls back to legacy mode.
>>
>> When AMD SME kdump support, it needs to map dmi table area as unencrypted.
>> For normal boot these ranges sit in e820 reserved ranges thus the early
>> ioremap code naturally map them as unencrypted. So if we have same e820
>> reserve setup in kdump kernel then it will just work like normal kernel.
>>
>> Signed-off-by: Dave Young <dyoung@redhat.com>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>>  arch/x86/kernel/crash.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 3c113e6545a3..db453e9c117b 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -384,6 +384,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>>  	walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1, &cmd,
>>  			memmap_entry_callback);
>>  
>> +	/* Add all reserved ranges */
>> +	cmd.type = E820_TYPE_RESERVED;
>> +	flags = IORESOURCE_MEM;
> 
> Lianbo, rethink about this, we will miss other io resource types if only
> match IORESOURCE_MEM here, can you redo the patch with just using "0"
> for the passing flags?
> 

This patches align on kexec-tools for e820 reserved ranges, if so, the kexec-tools also need to
be improved for the other type, such as IORESOURCE_IO/BUS/DMA(...), right?

I will improve these patches and post v2 tomorrow.

Thanks.

>> +	walk_iomem_res_desc(IORES_DESC_NONE, flags, 0, -1, &cmd,
>> +			memmap_entry_callback);
>> +
>>  	/* Add crashk_low_res region */
>>  	if (crashk_low_res.end) {
>>  		ei.addr = crashk_low_res.start;
>> -- 
>> 2.17.1
>>
