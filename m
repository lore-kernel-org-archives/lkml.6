Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF68CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9504123D80
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9504123D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753806AbeGCCRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:17:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753606AbeGCCRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:17:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A2D734671;
        Tue,  3 Jul 2018 02:17:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-100.pek2.redhat.com [10.72.12.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 896352026D76;
        Tue,  3 Jul 2018 02:17:24 +0000 (UTC)
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org,
        thomas.lendacky@amd.com, dyoung@redhat.com,
        kexec@lists.infradead.org, iommu@lists.linux-foundation.org,
        bhe@redhat.com
References: <20180702072639.10110-1-lijiang@redhat.com>
 <20180702072639.10110-2-lijiang@redhat.com> <20180702101451.GB28730@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
Date:   Tue, 3 Jul 2018 10:17:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180702101451.GB28730@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 03 Jul 2018 02:17:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 03 Jul 2018 02:17:30 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年07月02日 18:14, Borislav Petkov 写道:
> On Mon, Jul 02, 2018 at 03:26:35PM +0800, Lianbo Jiang wrote:
>> @@ -131,7 +132,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>>   * caller shouldn't need to know that small detail.
>>   */
>>  static void __iomem *__ioremap_caller(resource_size_t phys_addr,
>> -		unsigned long size, enum page_cache_mode pcm, void *caller)
>> +		unsigned long size, enum page_cache_mode pcm,
>> +		void *caller, bool encrypted)
> 
> So instead of sprinkling that @encrypted argument everywhere and then
> setting it based on sme_active() ...
> 
>>  {
>>  	unsigned long offset, vaddr;
>>  	resource_size_t last_addr;
>> @@ -199,7 +201,7 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
>>  	 * resulting mapping.
>>  	 */
>>  	prot = PAGE_KERNEL_IO;
>> -	if (sev_active() && mem_flags.desc_other)
>> +	if ((sev_active() && mem_flags.desc_other) || encrypted)
> 
> ... why can't you simply do your checks:
> 
> 	sme_active() && is_kdump_kernel()
> 
> here so that __ioremap_caller() can automatically choose the proper
> pgprot value when ioremapping the memory in the kdump kernel?
> 
> And this way the callers don't even have to care whether the memory is
> encrypted or not?
> 
Thank you, Boris. I'm very glad to read your comments. That's a good idea, but it has some
unencrypted memory in kdump mode, for example, the elfcorehdr. In fact, the elfcorehdr and
notes call the same function(read_from_oldmem->ioremap_cache), in this case, it is very
difficult to properly remap the memory if the caller don't care whether the memory is encrypted.

Regards,
Lianbo
>>  		prot = pgprot_encrypted(prot);
>>  
>>  	switch (pcm) {
> 
