Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523BEC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1487F2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BBiCVq/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1487F2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeLJQsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:48:40 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46865 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeLJQsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:48:39 -0500
Received: by mail-qk1-f193.google.com with SMTP id q1so6836576qkf.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jIu/NQdLrU30oMjYFo1Dv8/5GvUAOK5LaTrL/MaVmCg=;
        b=BBiCVq/uyLE8Mcbj3/85rQLeTaF8vub5hoz5Kc5iSMv1QCR16Ef7AVjcegACWoNq2f
         b9FdakseRmRV12Sg5KE2z2Tgr+3eYXlQss/vCtI7sbVB6qPTTYbOmgUDuEDF3HntoBcd
         UQljs+6XDQ2PKvNkHy2raDh7Bhs4JA8gCN9E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jIu/NQdLrU30oMjYFo1Dv8/5GvUAOK5LaTrL/MaVmCg=;
        b=T+uT+4MxkGdnIbgMoPNj/SpCutfYimrKCvNZ7l6T9BdUDAtGcMwh7JyfsIGB6bZe88
         daWOpI6YVgAMAG7tZN+ieqVCt0lGf/yeXA99B6xObRI9b/WXTuviyQKr+doHUdDr69lG
         N2Q5YTGFA0QnldyKf//mmQsLoarTnC1B4YQv2sRFhau02FgzE6VqwKudhja0hWwrtWgd
         ZcuhQd0t+f5qAyxRrRv43RMCeURsl4MDYa/yh5+3suY68TazHlcxHP5Ppfb4956I5lTg
         enA42Hg2uc1SxTngBVO2+2CyX3LB/pTJxbbEzaARf2XBpxIUqieBo+11/uDEh5hdowPs
         xnxg==
X-Gm-Message-State: AA+aEWYZ4+STcV/vbq0VmgqU0Aqbdz9Dh/IcjJbblBnefh7X4tUrBljL
        n1CAtvQ5YRTiXnnXb9R41cvlDQ==
X-Google-Smtp-Source: AFSGD/VfFUo4Nn/T94zhYEFli0jTOMHkAuEvRfT+ju+BCOJQSu7CmgpI09H1hfGJ0mz5hl9C98/w6Q==
X-Received: by 2002:a37:1f44:: with SMTP id f65mr11166603qkf.33.1544460517260;
        Mon, 10 Dec 2018 08:48:37 -0800 (PST)
Received: from [192.168.49.18] ([138.204.25.7])
        by smtp.gmail.com with ESMTPSA id l15sm6158986qtr.25.2018.12.10.08.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:48:36 -0800 (PST)
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Joerg Roedel <jroedel@suse.de>,
        Juergen Gross <jgross@suse.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/zsmalloc.c: Fix zsmalloc 32-bit PAE support
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
References: <20181210142105.6750-1-rafael.tinoco@linaro.org>
 <20181210151506.phyjkfcg3skogtyh@kshutemo-mobl1>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <32747ea1-7437-8055-a4f5-9f22378e57ae@linaro.org>
Date:   Mon, 10 Dec 2018 14:48:25 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181210151506.phyjkfcg3skogtyh@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/18 1:15 PM, Kirill A. Shutemov wrote:
> On Mon, Dec 10, 2018 at 12:21:05PM -0200, Rafael David Tinoco wrote:
>> diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
>> index 84bd9bdc1987..d808cfde3d19 100644
>> --- a/arch/x86/include/asm/pgtable_64_types.h
>> +++ b/arch/x86/include/asm/pgtable_64_types.h
>> @@ -64,8 +64,6 @@ extern unsigned int ptrs_per_p4d;
>>  #define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
>>  #define P4D_MASK		(~(P4D_SIZE - 1))
>>  
>> -#define MAX_POSSIBLE_PHYSMEM_BITS	52
>> -
>>  #else /* CONFIG_X86_5LEVEL */
>>  
>>  /*
>> @@ -154,4 +152,6 @@ extern unsigned int ptrs_per_p4d;
>>  
>>  #define PGD_KERNEL_START	((PAGE_SIZE / 2) / sizeof(pgd_t))
>>  
>> +#define MAX_POSSIBLE_PHYSMEM_BITS (pgtable_l5_enabled() ? 52 : 46)
>> +
> 
> ...
> 
>>  #endif /* _ASM_X86_PGTABLE_64_DEFS_H */
>> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
>> index 0787d33b80d8..132c20b6fd4f 100644
>> --- a/mm/zsmalloc.c
>> +++ b/mm/zsmalloc.c
> 
> ...
> 
>> @@ -116,6 +100,25 @@
>>   */
>>  #define OBJ_ALLOCATED_TAG 1
>>  #define OBJ_TAG_BITS 1
>> +
>> +/*
>> + * MAX_POSSIBLE_PHYSMEM_BITS should be defined by all archs using zsmalloc:
>> + * Trying to guess it from MAX_PHYSMEM_BITS, or considering it BITS_PER_LONG,
>> + * proved to be wrong by not considering PAE capabilities, or using SPARSEMEM
>> + * only headers, leading to bad object encoding due to object index overflow.
>> + */
>> +#ifndef MAX_POSSIBLE_PHYSMEM_BITS
>> + #define MAX_POSSIBLE_PHYSMEM_BITS BITS_PER_LONG
>> + #error "MAX_POSSIBLE_PHYSMEM_BITS HAS to be defined by arch using zsmalloc";
>> +#else
>> + #ifndef CONFIG_64BIT
>> +  #if (MAX_POSSIBLE_PHYSMEM_BITS >= (BITS_PER_LONG + PAGE_SHIFT - OBJ_TAG_BITS))
>> +   #error "MAX_POSSIBLE_PHYSMEM_BITS is wrong for this arch";
>> +  #endif
>> + #endif
>> +#endif
>> +
>> +#define _PFN_BITS (MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)
>>  #define OBJ_INDEX_BITS	(BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
>>  #define OBJ_INDEX_MASK	((_AC(1, UL) << OBJ_INDEX_BITS) - 1)
> 
> Have you tested it with CONFIG_X86_5LEVEL=y?
> 
> ASAICS, the patch makes OBJ_INDEX_BITS and what depends from it dynamic --
> it depends what paging mode we are booting in. ZS_SIZE_CLASSES depends
> indirectly on OBJ_INDEX_BITS and I don't see how struct zs_pool definition
> can compile with dynamic ZS_SIZE_CLASSES.
> 
> Hm?
> 

You're right, terribly sorry. This was a last time change.

mm/zsmalloc.c:256:21: error: variably modified ‘size_class’ at file scope

I'll revisit the patch. Any other comments are welcome.

Thank you

