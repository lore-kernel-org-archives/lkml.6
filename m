Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954C4C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E1324897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oDKxY+nD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E1324897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753012AbeGCU0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:26:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43232 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeGCU0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vobmshzvhyVr3X2oUlxY2PRL4/kmtAnQaJ5589PlVUg=; b=oDKxY+nDPjgvV9FmvKJHjFfwy
        7t3AIOGKlUhGaB+Rd9yACbjP9uHr4UIooegIghd+TWptUz5BTS3jzV4P19U0W+PosSy5RSpqVFi8R
        cci5cSaOUztHptYmig2+bwHKDJOXMHiDWx/fxrdWt8YcK1gSjaRD3J2+dI7p+iWtmmbwsKzKaOVEO
        NWUtm/SUm4rghDyHZ52QbGn4dJfRsASIeBn78+TNqCbFB6F2PlKLPeKaZ84IC9rxnHdbYdKlV+WVd
        YiH8hQTgFdWLi9XypHH0Hkce4zzwOZYjwuBzRGWVJ4G1fJg+Uu+sjsrHtS7EbvbIEIl7U++1KHq9I
        bk/b2q+DQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faRsL-00026s-Ad; Tue, 03 Jul 2018 20:26:13 +0000
Subject: Re: [PATCH v12 07/13] x86/sgx: data structures for tracking available
 EPC pages
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
 <20180703182118.15024-8-jarkko.sakkinen@linux.intel.com>
 <alpine.DEB.2.21.1807032110460.1816@nanos.tec.linutronix.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <00ca61d5-5a1d-5c83-3b49-62c899a87041@infradead.org>
Date:   Tue, 3 Jul 2018 13:26:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807032110460.1816@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/18 12:46, Thomas Gleixner wrote:
> On Tue, 3 Jul 2018, Jarkko Sakkinen wrote:
> 
>> SGX has a set of data structures to maintain information about the enclaves
>> and their security properties. BIOS reserves a fixed size region of
>> physical memory for these structures by setting Processor Reserved Memory
>> Range Registers (PRMRR). This memory area is called Enclave Page Cache
>> (EPC).
>>
>> This commit adds a database of EPC banks for kernel to easily access the

what kind of database?  How does one query it?

>> diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
>> index 2130e639ab49..77b2294fcfb0 100644
>> --- a/arch/x86/include/asm/sgx.h
>> +++ b/arch/x86/include/asm/sgx.h


>> +/**
>> + * sgx_get_page - pin an EPC page
> 
> Description starts with an uppercase letter.

How would someone know that?  It's not documented anywhere.
I happen to disagree with it.


>> +static __init int sgx_page_cache_init(void)
>> +{
>> +	unsigned long size;
>> +	unsigned int eax;
>> +	unsigned int ebx;
>> +	unsigned int ecx;
>> +	unsigned int edx;
>> +	unsigned long pa;
>> +	int i;
>> +	int ret;
> 
> Please aggregate the declarations of the same type. No point in wasting all
> the screen space. And please use 'u32' for ea-dx
> 
>> +
>> +	for (i = 0; i < SGX_MAX_EPC_BANKS; i++) {
>> +		cpuid_count(SGX_CPUID, i + SGX_CPUID_EPC_BANKS, &eax, &ebx,
>> +			    &ecx, &edx);
>> +		if (!(eax & 0xf))
>> +			break;
>> +
>> +		pa = ((u64)(ebx & 0xfffff) << 32) + (u64)(eax & 0xfffff000);
>> +		size = ((u64)(edx & 0xfffff) << 32) + (u64)(ecx & 0xfffff000);
> 
> These magic constants should be 'U', using uppercase 'F' and defines. Plus
> this wants a comment how pa and size are cobbled together from the cpuid
> regs.

Why the uppercase 'F'?

thnx,
-- 
~Randy
