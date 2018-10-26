Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C862DC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E42020824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E42020824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeJZVJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 17:09:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbeJZVJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 17:09:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0AB2E30820C8;
        Fri, 26 Oct 2018 12:32:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-142.pek2.redhat.com [10.72.12.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4E8165F54;
        Fri, 26 Oct 2018 12:32:16 +0000 (UTC)
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
To:     Boris Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, bhe@redhat.com, dyoung@redhat.com
References: <20181026093630.8520-1-lijiang@redhat.com>
 <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
From:   lijiang <lijiang@redhat.com>
Message-ID: <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
Date:   Fri, 26 Oct 2018 20:32:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 26 Oct 2018 12:32:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年10月26日 17:43, Boris Petkov 写道:
> On October 26, 2018 10:36:30 AM GMT+01:00, Lianbo Jiang <lijiang@redhat.com> wrote:
>> For AMD machine with SME feature, makedumpfile tools need to know
>> whether the crash kernel was encrypted or not. 
> 
> Why?
> 

If SME is enabled in the first kernel, the crash kernel's page table(pgd/pud/pmd/pte)
contains the memory encryption mask, so i have to remove the sme mask to obtain the
true physical address when dump vmcore. 

>> So it is necessary
>> to write the sme_me_mask to vmcoreinfo.
>>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>> arch/x86/kernel/machine_kexec_64.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/x86/kernel/machine_kexec_64.c
>> b/arch/x86/kernel/machine_kexec_64.c
>> index 4c8acdfdc5a7..dcfdb64d1097 100644
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -357,6 +357,8 @@ void arch_crash_save_vmcoreinfo(void)
>> 	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
>> 			pgtable_l5_enabled());
>>
>> +	VMCOREINFO_NUMBER(sme_me_mask);
> 
> No we're not going to expose a kernel-internal mask to userspace. 
> 

If so, can i set a variable flag for the 'sme_me_mask' and export the
variable flag? For example:

void arch_crash_save_vmcoreinfo(void) {

    ....

    if (sme_active())
        sme_enabled = 1;

    VMCOREINFO_NUMBER(sme_enabled);
....
}

> If at all needed, add functions to kexec which figure out whether we are encrypted or not and export that result as a kexec variable.
> 
> 

For AMD machine with the SME feature, the msr 'MSR_K8_SYSCFG' can examine
whether SME is enabled in kernel, but the kexec is also userspace tool,
it has no permission to access the msr.

Furthermore, i also tried to read the "/dev/cpu/cpu[number]/msr", but
the value depends on BIOS's configuration. That is to say, if SME is
set in BIOS, the value of msr is always 0xF40000 whatever the kernel
commandline parameter is "mem_encrypt=on" or "mem_encrypt=off".

If i made a mistake, please help to point it out.

Thanks.
Lianbo
