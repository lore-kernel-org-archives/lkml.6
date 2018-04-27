Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AB8JxZoAXPS+IsbYtpL2IL+BkhI7FGXw0L6S8J1Mp1sJ74hCknsIclgPscALDd3rnSxxwRoSVUg1
ARC-Seal: i=1; a=rsa-sha256; t=1524832232; cv=none;
        d=google.com; s=arc-20160816;
        b=JdYhTwdoBlCEJNI/BHtwx63k2wHdjBUiCBtYqzm/s6Atma+yN+tlDKPtf0tF3hjbMD
         gYGfuzklbZ2jXawHbwsbgohsmtdfysxNkwcPb2+b4OijfgMQymg6XCMogJ1/IzrHkvVl
         MPfH84WchLXEb+kZ+fAHxvNps935mwVEch/27jZibfGm145NHtX9P7O8ufhptXG26QfL
         V4oA41IRkBvziUtHdG0Sfw1M7IWo7owC9+MJ/2JgOsxSe3Onxo2G8Yec6CdWvBpgBHCt
         VgctSyerfdz0LCF1Yb64q96Qf7XhzrWMW75xY71uj93BFxV3mroxHYv06ArxYeUnEZsj
         LmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=gaMfdUArnvWO7+SOnsRpOZo00oud7eGlEdVLaaYNw90=;
        b=qmkAiNqVJZqHijN54Lnq+ya0Hm8MSpiQvN2rO5HMgIY88xBpkPpANApjPzCbArJb8M
         QhQlmiVF+F2tkrJcLtvZMT2lgPqkwvt2k6bDG1If+PpmCV2Ci9Q8bbIVsV2SIFV+SvVr
         WfGo+zpRi7E7qlG5N6ENJGfsWLBonmlyag3Cjkf209l1OmviOD8fvGL1lv7BTKgyw20B
         eMIjqJvHS3Lof9aawOKcYvM8+uX9SGEoF8SQGP1MVv4yBu1DOhouPKm2CYgnV9P4hLEC
         zXx5zMNXXDvUDj3qlFt80S/aWXHIoaIVqUyt9lMOT/vMMz93brIIB7Crs94tzRmnLZLg
         Q5XA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UNO30LRf;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eHS9sCUD;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UNO30LRf;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eHS9sCUD;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5CB66034E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v8 2/4] arm64: tlbflush: Introduce
 __flush_tlb_kernel_pgtable
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will.deacon@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com,
 linux-arch@vger.kernel.org, arnd@arndb.de, ard.biesheuvel@linaro.org,
 marc.zyngier@arm.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, kristina.martsenko@arm.com,
 takahiro.akashi@linaro.org, james.morse@arm.com, tglx@linutronix.de,
 akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
References: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
 <1522742446-5084-3-git-send-email-cpandya@codeaurora.org>
 <20180427102900.4e63lo4eksk23vtn@armageddon.cambridge.arm.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <26d3696d-a298-fe1b-c686-0f12ea94d5a6@codeaurora.org>
Date: Fri, 27 Apr 2018 18:00:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427102900.4e63lo4eksk23vtn@armageddon.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596711273338425981?=
X-GMAIL-MSGID: =?utf-8?q?1598902483090004518?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 4/27/2018 3:59 PM, Catalin Marinas wrote:
> On Tue, Apr 03, 2018 at 01:30:44PM +0530, Chintan Pandya wrote:
>> Add an interface to invalidate intermediate page tables
>> from TLB for kernel.
>>
>> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
>> ---
>>   arch/arm64/include/asm/tlbflush.h | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index 9e82dd7..6a4816d 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -209,6 +209,12 @@ static inline void __flush_tlb_pgtable(struct mm_struct *mm,
>>   	dsb(ish);
>>   }
>>   
>> +static inline void __flush_tlb_kernel_pgtable(unsigned long addr)
>> +{
>> +	addr >>= 12;
>> +	__tlbi(vaae1is, addr);
>> +	dsb(ish);
>> +}
>>   #endif
> 
> Please use __TLBI_VADDR here as it does some additional masking.
> 
Sure.

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
