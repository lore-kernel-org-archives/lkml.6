Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELtBc1551exMoYkodVoHaLVGPgBnNNL2osQIIbo7AtaeoTqEjmMZxqtsGMqNyHyAvq4qHGdo
ARC-Seal: i=1; a=rsa-sha256; t=1522125494; cv=none;
        d=google.com; s=arc-20160816;
        b=B/ot5+1nI4KvBk9Z9JXcoQa/Z3CzAEiwOaaNuerGxZpxyzKCsShG1GsDr1f977f9ZO
         wqLIxWjAiv9jOc9/xFQabAT45EeTYufbtRhczrU+cC0VzrIN/r0k92HpWcqt1mq+I/TU
         eSTS8/1bWMRsn7rAthZEYN6VhIcoJhAV7sDAJbm4/8intqsAy/Sjbf8XHG59FuPkDVX/
         Yex/FwVGUbOXi6xm9nCLB8pP4spixXD1h+O51epKrBWiQ6Yk+wDF/zUh19OpUKBjMdG5
         7AuJbXWPsjh8jZXd15aeiyEuGnHxicS1tas26gVGQQHAWZPRt0V7EwLwFoORtLbjLF3J
         N0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=8ukCtcfUwFUfeHrPkGoUVB+Pkd3M/265nwtm8Z9eTpE=;
        b=Ju7YYk5MZ0InosdIcUPP5E8Ec3DllQ0V09m5htocf6i0BD2X5TZOB1TwBgfzYpYAl0
         ro12yinwncGrEnydaSzbfZCRQ/TSpbRyd4Ulw0M7BjZCzwBiTxaMNOyGU6yRF0+KmfIF
         0a1q50PJPKg94b/pr8zOjRFLXhyi5IM0i9i713386+L6BxTaHjzbl627Y4bJ/LNFDfJF
         ALlPH7wRKxezmHzPak66pfNpt4k5WcP6QThP7OV0JamGdOEaqY7FLq7Vtnb50T3YjjTN
         hDgN0eOkdkFbKfDt9pxIs4Uk0KhAEwaoaa2x4Q8m7AgQFXJU5ooGqByFzTXsRUIqrwYc
         ZT1w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=SwlF84w2;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=miMv6e8h;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=SwlF84w2;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=miMv6e8h;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE5FA6070A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v4 2/3] arm64: Implement page table free interfaces
To: Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
 ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com,
 kristina.martsenko@arm.com, takahiro.akashi@linaro.org,
 gregkh@linuxfoundation.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com
References: <1521546314-31753-1-git-send-email-cpandya@codeaurora.org>
 <1521546314-31753-3-git-send-email-cpandya@codeaurora.org>
 <20180326095541.izogc4iak6d7nerm@lakrids.cambridge.arm.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <b5427cbd-28f8-e561-cfca-751006e60da1@codeaurora.org>
Date: Tue, 27 Mar 2018 10:08:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326095541.izogc4iak6d7nerm@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007777008930452?=
X-GMAIL-MSGID: =?utf-8?q?1596064262690224906?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/26/2018 3:25 PM, Mark Rutland wrote:
> On Tue, Mar 20, 2018 at 05:15:13PM +0530, Chintan Pandya wrote:
>> +static int __pmd_free_pte_page(pmd_t *pmd, unsigned long addr, bool tlb_inv)
>> +{
>> +	pmd_t *table;
>> +
>> +	if (pmd_val(*pmd)) {
>> +		table = __va(pmd_val(*pmd));
>> +		pmd_clear(pmd);
>> +		/*
>> +		 * FIXME: __flush_tlb_pgtable(&init_mm, addr) is
>> +		 *        ideal candidate here, which exactly
>> +		 *        flushes intermediate pgtables. But,
>> +		 *        this is broken (evident from tests).
>> +		 *        So, use safe TLB op unless that is fixed.
>> +		 */
>> +		if (tlb_inv)
>> +			flush_tlb_kernel_range(addr, addr + PMD_SIZE);
> 
> I don't think that __flush_tlb_pgtable() is broken. It's only valid to
> call it for user page tables, since it doesn't affect all ASIDs.
> 
> We can add a simlar helper for kernel mappings, which affects all ASIDs,
> e.g.
> 
Okay. I will test it and update v5.

> static inline void __flush_tlb_kernel_pgtable(unsigned long addr)
> {
> 	addr >>= 12;
> 	__tlbi(vaae1is, addr);
> 	dsb(ish);
> }
> 
> Thanks,
> Mark.
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
