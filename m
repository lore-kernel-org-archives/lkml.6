Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D836C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2A521580
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2A521580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeI0VMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:12:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbeI0VMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:12:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34C6630001D9;
        Thu, 27 Sep 2018 14:54:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 36262721F3;
        Thu, 27 Sep 2018 14:53:50 +0000 (UTC)
Subject: Re: [PATCH v7 RESEND 1/4] x86/ioremap: add a function
 ioremap_encrypted() to remap kdump old memory
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com,
        jroedel@suse.de
References: <20180927071954.29615-1-lijiang@redhat.com>
 <20180927071954.29615-2-lijiang@redhat.com> <20180927131737.GA19779@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <6306eaa9-d81e-2fa4-8978-63503a7ecce4@redhat.com>
Date:   Thu, 27 Sep 2018 22:53:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927131737.GA19779@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 27 Sep 2018 14:54:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年09月27日 21:17, Borislav Petkov 写道:
> On Thu, Sep 27, 2018 at 03:19:51PM +0800, Lianbo Jiang wrote:
>> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
>> index 6de64840dd22..f8795f9581c7 100644
>> --- a/arch/x86/include/asm/io.h
>> +++ b/arch/x86/include/asm/io.h
>> @@ -192,6 +192,9 @@ extern void __iomem *ioremap_cache(resource_size_t offset, unsigned long size);
>>  #define ioremap_cache ioremap_cache
>>  extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size, unsigned long prot_val);
>>  #define ioremap_prot ioremap_prot
>> +extern void __iomem *ioremap_encrypted(resource_size_t phys_addr,
>> +					unsigned long size);
> 
> No need to break this line - see how the other externs don't.
> 
Ok, i will fix it. 

If no need to break this line, it will cause a warning of exceeding 80 characters per line.

>> +#define ioremap_encrypted ioremap_encrypted
>>  
>>  /**
>>   * ioremap     -   map bus memory into CPU space
>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>> index c63a545ec199..e01e6c695add 100644
>> --- a/arch/x86/mm/ioremap.c
>> +++ b/arch/x86/mm/ioremap.c
>> @@ -24,6 +24,7 @@
>>  #include <asm/pgalloc.h>
>>  #include <asm/pat.h>
>>  #include <asm/setup.h>
>> +#include <linux/crash_dump.h>
> 
> What is that include for and why is it not up there with the <linux/...
> includes instead here with the <asm/..> ones?
> 
Thank you for pointing out this issue, i forgot to remove this header file. 

I will get rid of this header file and post this patch again.

Regards,
Lianbo
