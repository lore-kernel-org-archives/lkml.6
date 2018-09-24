Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB15ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F295B206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F295B206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbeIXQvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:51:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60372 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbeIXQvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:51:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE22480D;
        Mon, 24 Sep 2018 03:50:15 -0700 (PDT)
Received: from [10.4.13.92] (e112298-lin.Emea.Arm.com [10.4.13.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32CB23F5B3;
        Mon, 24 Sep 2018 03:50:14 -0700 (PDT)
Subject: Re: [PATCH 02/10] irqchip/gic-v3-its: Consolidate LPI_PENDBASE_SZ
 usage
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
 <20180921195954.21574-3-marc.zyngier@arm.com>
 <e267123d-af92-0871-455c-cb74a2bc4103@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <cab043d8-c9bb-6975-8304-ff80dbe62027@arm.com>
Date:   Mon, 24 Sep 2018 11:50:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e267123d-af92-0871-455c-cb74a2bc4103@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/09/18 11:33, Suzuki K Poulose wrote:
> Hi Marc,
> 
> On 21/09/18 20:59, Marc Zyngier wrote:
>> LPI_PENDING_SZ is always used in conjunction with a max(). Let's
>> factor this in the definition of the macro, and simplify the rest
>> of the code.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 12 ++++--------
>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index c2df341ff6fa..ed6aab11e019 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -62,7 +62,7 @@ static u32 lpi_id_bits;
>>    */
>>   #define LPI_NRBITS        lpi_id_bits
>>   #define LPI_PROPBASE_SZ        ALIGN(BIT(LPI_NRBITS), SZ_64K)
>> -#define LPI_PENDBASE_SZ        ALIGN(BIT(LPI_NRBITS) / 8, SZ_64K)
>> +#define LPI_PENDBASE_SZ        max_t(u32, SZ_64K, 
>> ALIGN(BIT(LPI_NRBITS) / 8, SZ_64K))
> 
> minor nit: The ALIGN() already aligns the given value up to the required
> alignment. So, if the LPI_NRBITS is guaranteed to be non-zero,
> we could simply drop the max_t().
> 

Hmmm, Doesn't ALIGN only aligns down? So if "BIT(LPI_NR_BITS) / 8 < 
SZ_64K" (i.e. LPI_NRBITS < 20) The ALIGN(..., SZ_64K) would give 0.

Thanks,

> Rest looks good to me.
> 
> Suzuki
> 
>>   #define LPI_PROP_DEFAULT_PRIO    0xa0
>> @@ -1924,12 +1924,9 @@ static int its_alloc_collections(struct 
>> its_node *its)
>>   static struct page *its_allocate_pending_table(gfp_t gfp_flags)
>>   {
>>       struct page *pend_page;
>> -    /*
>> -     * The pending pages have to be at least 64kB aligned,
>> -     * hence the 'max(LPI_PENDBASE_SZ, SZ_64K)' below.
>> -     */
>> +
>>       pend_page = alloc_pages(gfp_flags | __GFP_ZERO,
>> -                get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
>> +                get_order(LPI_PENDBASE_SZ));
>>       if (!pend_page)
>>           return NULL;
>> @@ -1941,8 +1938,7 @@ static struct page 
>> *its_allocate_pending_table(gfp_t gfp_flags)
>>   static void its_free_pending_table(struct page *pt)
>>   {
>> -    free_pages((unsigned long)page_address(pt),
>> -           get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
>> +    free_pages((unsigned long)page_address(pt), 
>> get_order(LPI_PENDBASE_SZ));
>>   }
>>   static void its_cpu_init_lpis(void)
>>

-- 
Julien Thierry
