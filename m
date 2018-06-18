Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803D8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261552086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261552086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934594AbeFRN7r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:59:47 -0400
Received: from icp-osb-irony-out7.external.iinet.net.au ([203.59.1.107]:29238
        "EHLO icp-osb-irony-out7.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934030AbeFRN7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:59:45 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DHAADsuSdb/4D0zssNThoBAQEBAQIBA?=
 =?us-ascii?q?QEBCAEBAQGEKoEUE4N5likIIZRxgXgqhE0Cgnw2FgECAQEBAQEBAoEJhTUBAQE?=
 =?us-ascii?q?DIxVBEAsNCwICJgICVwYNBgIBAYMhAoFyHKgLbYIcGoRBg2iBYwWBC4lcgQ8kD?=
 =?us-ascii?q?IJcgnyEeoJVApkWCAGFfIkHiB6FI4oSiQMHgXwzGggoCIJ+H4ICF4hZhVBdkFE?=
 =?us-ascii?q?BAQ?=
X-IPAS-Result: =?us-ascii?q?A2DHAADsuSdb/4D0zssNThoBAQEBAQIBAQEBCAEBAQGEKoE?=
 =?us-ascii?q?UE4N5likIIZRxgXgqhE0Cgnw2FgECAQEBAQEBAoEJhTUBAQEDIxVBEAsNCwICJ?=
 =?us-ascii?q?gICVwYNBgIBAYMhAoFyHKgLbYIcGoRBg2iBYwWBC4lcgQ8kDIJcgnyEeoJVApk?=
 =?us-ascii?q?WCAGFfIkHiB6FI4oSiQMHgXwzGggoCIJ+H4ICF4hZhVBdkFEBAQ?=
X-IronPort-AV: E=Sophos;i="5.51,239,1526313600"; 
   d="scan'208";a="90129292"
Received: from unknown (HELO [192.168.0.106]) ([203.206.244.128])
  by icp-osb-irony-out7.iinet.net.au with ESMTP; 18 Jun 2018 21:59:41 +0800
Subject: Re: [PATCH] m68k: fix "bad page state" oops on ColdFire boot
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Matthew Wilcox <mawilcox@microsoft.com>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180618060426.24497-1-gerg@linux-m68k.org>
 <CAMuHMdXSaGtremvLCRzKm68s_dUEigL-VCmM-ar=T4PPJrECLw@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <8cd9643d-0855-ac30-41cb-7de24314da00@linux-m68k.org>
Date:   Mon, 18 Jun 2018 23:59:40 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXSaGtremvLCRzKm68s_dUEigL-VCmM-ar=T4PPJrECLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 18/06/18 16:58, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Mon, Jun 18, 2018 at 8:06 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>> Booting a ColdFire m68k core with MMU enabled causes a "bad page state"
>> oops since commit 1d40a5ea01d5 ("mm: mark pages in use for page tables"):
>>
>>   BUG: Bad page state in process sh  pfn:01ce2
>>   page:004fefc8 count:0 mapcount:-1024 mapping:00000000 index:0x0
>>   flags: 0x0()
>>   raw: 00000000 00000000 00000000 fffffbff 00000000 00000100 00000200 00000000
>>   raw: 039c4000
>>   page dumped because: nonzero mapcount
>>   Modules linked in:
>>   CPU: 0 PID: 22 Comm: sh Not tainted 4.17.0-07461-g1d40a5ea01d5 #13
>>
>> Fix by calling pgtable_page_dtor() in our __pte_free_tlb() code path,
>> so that the PG_table flag is cleared before we free the pte page.
>>
>> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
>> CC: Matthew Wilcox <mawilcox@microsoft.com>
>> ---
>>   arch/m68k/include/asm/mcf_pgalloc.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> Matthew: I came across this thread at https://lkml.org/lkml/2018/6/17/163
>>           about a similar problem with openrisc. Based on that I came up
>>           with this fix for m68k/ColdFire. Fixes the issue for me.
>>
>> diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
>> index 8b707c249026..8c441eb57b80 100644
>> --- a/arch/m68k/include/asm/mcf_pgalloc.h
>> +++ b/arch/m68k/include/asm/mcf_pgalloc.h
>> @@ -44,6 +44,7 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
>>   static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t page,
>>                                    unsigned long address)
>>   {
>> +       pgtable_page_dtor(page);
>>          __free_page(page);
>>   }
> 
> Do you need a call to pgtable_page_dtor() in pte_free(), too?
> On x86 (and motorola_pgalloc.h and sun3_pgalloc.h FWIW), both functions
> call pgtable_page_dtor().

I am thinking yes, looking at those other examples.

Regards
Greg

