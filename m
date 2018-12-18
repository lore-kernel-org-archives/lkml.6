Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4ECC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DBF217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeLRKmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:42:25 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59936 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbeLRKmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:42:24 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E38086AF3A410;
        Tue, 18 Dec 2018 18:42:21 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Tue, 18 Dec 2018
 18:42:18 +0800
Subject: Re: [PATCH -next] x86/xen: Fix read buffer overflow
To:     Juergen Gross <jgross@suse.com>, <boris.ostrovsky@oracle.com>,
        <sstabellini@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <hpa@zytor.com>
References: <20181218081910.18080-1-yuehaibing@huawei.com>
 <7825d772-338a-e39e-eaff-73e666ef5c08@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <x86@kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <2fe8f6b7-b791-e7ea-6484-491e089321d5@huawei.com>
Date:   Tue, 18 Dec 2018 18:42:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <7825d772-338a-e39e-eaff-73e666ef5c08@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/18 16:31, Juergen Gross wrote:
> On 18/12/2018 09:19, YueHaibing wrote:
>> Fix smatch warning:
>>
>> arch/x86/xen/enlighten_pv.c:649 get_trap_addr() error:
>>  buffer overflow 'early_idt_handler_array' 32 <= 32
>>
>> Fixes: 42b3a4cb5609 ("x86/xen: Support early interrupts in xen pv guests")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  arch/x86/xen/enlighten_pv.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
>> index 2f6787f..81f200d 100644
>> --- a/arch/x86/xen/enlighten_pv.c
>> +++ b/arch/x86/xen/enlighten_pv.c
>> @@ -646,7 +646,7 @@ static bool __ref get_trap_addr(void **addr, unsigned int ist)
>>  
>>  	if (nr == ARRAY_SIZE(trap_array) &&
>>  	    *addr >= (void *)early_idt_handler_array[0] &&
>> -	    *addr < (void *)early_idt_handler_array[NUM_EXCEPTION_VECTORS]) {
>> +	    *addr < (void *)early_idt_handler_array[NUM_EXCEPTION_VECTORS - 1]) {
>>  		nr = (*addr - (void *)early_idt_handler_array[0]) /
>>  		     EARLY_IDT_HANDLER_SIZE;
>>  		*addr = (void *)xen_early_idt_handler_array[nr];
>>
> 
> No, this patch is wrong.
> 
> early_idt_handler_array is a 2-dimensional array:
> 
> const char
> early_idt_handler_array[NUM_EXCEPTION_VECTORS][EARLY_IDT_HANDLER_SIZE];
> 
> So above code doesn't do an out of bounds array access, but checks for
> *addr being in the array or outside of it (note the "<" used for the
> test).

Thank you for your explanation.

> 
> 
> Juergen
> 
> .
> 

