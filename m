Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B12C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A414214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeLRHez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:34:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbeLRHey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:34:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 666C5C02E632;
        Tue, 18 Dec 2018 07:34:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-60.pek2.redhat.com [10.72.12.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D3D7100190E;
        Tue, 18 Dec 2018 07:34:47 +0000 (UTC)
Subject: Re: [PATCH 2/2 v3] kdump,vmcoreinfo: Export the value of sme mask to
 vmcoreinfo
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        linux-doc@vger.kernel.org
References: <20181216131617.2612-1-lijiang@redhat.com>
 <20181216131617.2612-3-lijiang@redhat.com> <20181217130129.GE12165@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <da8c3af8-40c4-f912-7e27-2f17ea6a58a9@redhat.com>
Date:   Tue, 18 Dec 2018 15:34:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181217130129.GE12165@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 18 Dec 2018 07:34:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年12月17日 21:01, Borislav Petkov 写道:
> On Sun, Dec 16, 2018 at 09:16:17PM +0800, Lianbo Jiang wrote:
>> For AMD machine with SME feature, makedumpfile tools need to know
>> whether the crash kernel was encrypted or not. If SME is enabled
>> in the first kernel, the crash kernel's page table(pgd/pud/pmd/pte)
>> contains the memory encryption mask, so need to remove the sme mask
>> to obtain the true physical address.
>>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>>  arch/x86/kernel/machine_kexec_64.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>> index 4c8acdfdc5a7..1860fe24117d 100644
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -352,10 +352,24 @@ void machine_kexec(struct kimage *image)
>>  
>>  void arch_crash_save_vmcoreinfo(void)
>>  {
>> +	u64 sme_mask = sme_me_mask;
>> +
>>  	VMCOREINFO_NUMBER(phys_base);
>>  	VMCOREINFO_SYMBOL(init_top_pgt);
>>  	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
>>  			pgtable_l5_enabled());
>> +	/*
>> +	 * Currently, the local variable 'sme_mask' stores the value of
>> +	 * sme_me_mask(bit 47), and also write the value of sme_mask to
>> +	 * the vmcoreinfo.
>> +	 * If need, the bit(sme_mask) might be redefined in the future,
>> +	 * but the 'bit63' will be reserved.
>> +	 * For example:
>> +	 * [ misc	   ][ enc bit  ][ other misc SME info       ]
>> +	 * 0000_0000_0000_0000_1000_0000_0000_0000_0000_0000_..._0000
>> +	 * 63   59   55   51   47   43   39   35   31   27   ... 3
>> +	 */
> 
> This text belongs into the document.
> 
Ok, i will move it into VMCOREINFO document.

Thanks.
