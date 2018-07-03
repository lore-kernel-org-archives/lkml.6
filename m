Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01A2C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EEE20855
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2EEE20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752920AbeGCK60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:58:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752215AbeGCK6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:58:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C30E640255C9;
        Tue,  3 Jul 2018 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-173.pek2.redhat.com [10.72.12.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18E842026D76;
        Tue,  3 Jul 2018 10:58:17 +0000 (UTC)
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
From:   lijiang <lijiang@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org,
        thomas.lendacky@amd.com, dyoung@redhat.com,
        kexec@lists.infradead.org, iommu@lists.linux-foundation.org,
        bhe@redhat.com
References: <20180702072639.10110-1-lijiang@redhat.com>
 <20180702072639.10110-2-lijiang@redhat.com> <20180702101451.GB28730@zn.tnic>
 <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
Message-ID: <895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
Date:   Tue, 3 Jul 2018 18:58:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 03 Jul 2018 10:58:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 03 Jul 2018 10:58:24 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年07月03日 10:17, lijiang 写道:
> 在 2018年07月02日 18:14, Borislav Petkov 写道:
>> On Mon, Jul 02, 2018 at 03:26:35PM +0800, Lianbo Jiang wrote:
>>> @@ -131,7 +132,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>>>   * caller shouldn't need to know that small detail.
>>>   */
>>>  static void __iomem *__ioremap_caller(resource_size_t phys_addr,
>>> -		unsigned long size, enum page_cache_mode pcm, void *caller)
>>> +		unsigned long size, enum page_cache_mode pcm,
>>> +		void *caller, bool encrypted)
>>
>> So instead of sprinkling that @encrypted argument everywhere and then
>> setting it based on sme_active() ...
>>
>>>  {
>>>  	unsigned long offset, vaddr;
>>>  	resource_size_t last_addr;
>>> @@ -199,7 +201,7 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
>>>  	 * resulting mapping.
>>>  	 */
>>>  	prot = PAGE_KERNEL_IO;
>>> -	if (sev_active() && mem_flags.desc_other)
>>> +	if ((sev_active() && mem_flags.desc_other) || encrypted)
>>
>> ... why can't you simply do your checks:
>>
>> 	sme_active() && is_kdump_kernel()
>>
>> here so that __ioremap_caller() can automatically choose the proper
>> pgprot value when ioremapping the memory in the kdump kernel?
>>
>> And this way the callers don't even have to care whether the memory is
>> encrypted or not?
>>
> Thank you, Boris. I'm very glad to read your comments. That's a good idea, but it has some
> unencrypted memory in kdump mode, for example, the elfcorehdr. In fact, the elfcorehdr and
> notes call the same function(read_from_oldmem->ioremap_cache), in this case, it is very
> difficult to properly remap the memory if the caller don't care whether the memory is encrypted.
> 
Hi, Boris,
About this, maybe I should describe the more details.
For kdump, the elf header finally use the crash kernel reserved memory, it is not an old memory.
When we load the crash kernel image, kexec tools will copy the elf header from encrypted memory
region to unencrypted memory region, we know that a page of memory that is marked encrypted will
be automatically decrypted when read from DRAM if SME is enabled. This operation make us get the
plaintext, that is to say, it becomes unencrypted data, so we need to remap the elfcorehdr in un-
encrypted manners in kdump kernel, but elf notes use an old memory, it is encrypted. That is the
real reason why we need to use the different functions(ioremap_cache/ioremap_encrypted).
If the elf core header is set to be encrypted, we could need to know which part of memory is
allocated for the elfcorehdr in kernel space and change the page attribute, maybe which will have
to modify another common codes and kexec-tools.

If you agree with my explanation, i will add them to patch log and also post it again.
Welcome to review my patches again.

Thanks.
Lianbo

> Regards,
> Lianbo>>>  		prot = pgprot_encrypted(prot);
>>>  
>>>  	switch (pcm) {
>>
