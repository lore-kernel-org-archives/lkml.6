Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63902C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B07120859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbfAGJnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:43:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfAGJnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:43:08 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 600ED356FE;
        Mon,  7 Jan 2019 09:43:08 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5643119745;
        Mon,  7 Jan 2019 09:42:58 +0000 (UTC)
Subject: Re: [PATCH 2/2 v5] kdump,vmcoreinfo: Export the value of sme mask to
 vmcoreinfo
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        akpm@linux-foundation.org, dyoung@redhat.com,
        linux-doc@vger.kernel.org, k-hagio@ab.jp.nec.com,
        anderson@redhat.com
References: <20190107014734.9730-1-lijiang@redhat.com>
 <20190107014734.9730-3-lijiang@redhat.com>
 <20190107022925.GF30750@MiWiFi-R3L-srv>
From:   lijiang <lijiang@redhat.com>
Message-ID: <4a922a68-8513-51ab-b887-e367f627f688@redhat.com>
Date:   Mon, 7 Jan 2019 17:42:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190107022925.GF30750@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 07 Jan 2019 09:43:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年01月07日 10:29, Baoquan He 写道:
> On 01/07/19 at 09:47am, Lianbo Jiang wrote:
>> For AMD machine with SME feature, makedumpfile tools need to know
>> whether the crash kernel was encrypted or not. If SME is enabled
>               ^ crashed
>> in the first kernel, the crash kernel's page table(pgd/pud/pmd/pte)
>                            ^ crashed
>> contains the memory encryption mask, so need to remove the sme mask
>                                         "makedumpfile needs" or
>                                        in makedumpfile need to remove...

Thanks for your comment.

This will be modified in next post.

Regards,
Lianbo

>> to obtain the true physical address.
>>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>>  arch/x86/kernel/machine_kexec_64.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>> index 4c8acdfdc5a7..bc4108096b18 100644
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -352,10 +352,13 @@ void machine_kexec(struct kimage *image)
>>  
>>  void arch_crash_save_vmcoreinfo(void)
>>  {
>> +	u64 sme_mask = sme_me_mask;
>> +
>>  	VMCOREINFO_NUMBER(phys_base);
>>  	VMCOREINFO_SYMBOL(init_top_pgt);
>>  	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
>>  			pgtable_l5_enabled());
>> +	VMCOREINFO_NUMBER(sme_mask);
>>  
>>  #ifdef CONFIG_NUMA
>>  	VMCOREINFO_SYMBOL(node_data);
>> -- 
>> 2.17.1
>>
