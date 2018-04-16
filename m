Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4+NYksWnkhvbd5y7Md8WheFPu4JQI0doQktrCiuDqS7cwOuiCPq37xaE5vuudV8vJneUeIW
ARC-Seal: i=1; a=rsa-sha256; t=1523920541; cv=none;
        d=google.com; s=arc-20160816;
        b=XBJoUc1dAEeS2ADPTxWW70QaFA1GsrRRi8CDLRihwtLy/Phpgc/Uwe/pflG0oTj2wC
         s0o8VghxoyMr5bvy3XKcEDSNqtmmL5qkAJFYKjtSRHRsM5n1oKMDuuzOKPdaWwyvRri3
         l9E56xTP9gA3JJrDhhojgeh7R5nmSP2lOYWK1eRTgXuAw8+SXUX4776fY4b4QIXliW80
         Dv7TQsj6r1fCJGziKNxw91/gC+7usoKKVWygZnnNUduNHZhkq+N4M6/NM0ms9knDGq0R
         CqLI+pensRvI8Fun2bx1LIdNfxBq+1ooL7AmTgbuDb1jNdX87nv8vrfV0ixk7tp22owg
         oSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=aDsT9DzQ0iwKX3JIlU4WtPlw9sMyO0dexIu/k+bhw1Y=;
        b=YPTV3HC9jxCF5rn0uOLgxOMQZtgW2GiA1fF6YUFdFaftJyb846LUsW7zv88Y3iijae
         J3yTHtTJAHbhwh7Apsc9WRdg2ZkDTSSLcYxC0HOkfEubOVl1xuOsZUPz9WhjH+Uy3yth
         uJOKwuZCw5FRuXyDD962iOM0Ds9b/iWzpL8hGZ7vuB5EbVhg6hrvKbKxA8sBdsjZq3Re
         EMMojPI0mXyAuPPKLdSTM5oaH/bUjsvH0CHVPHAe/UdhawM3KrQ1+gPUiVJPTTN+qVQR
         j9YfxbLdccPy29NmXUDonprFa+jWGYkqPSmGRMfDHEvxgwe9l9pj1Bf1IFO+dFZqSzYM
         WFyg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZvbPYexC;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZvbPYexC;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZvbPYexC;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZvbPYexC;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F97F60310
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH 1/2] parisc: use the asm-generic version for writeX()
To: John David Anglin <dave.anglin@bell.net>, arnd@arndb.de,
 timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller
 <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523916078-23049-1-git-send-email-okaya@codeaurora.org>
 <a727e74f-610c-4722-76e9-c1aca2f9e9bd@bell.net>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <a7b59f43-cea5-0ead-f528-61899570e353@codeaurora.org>
Date: Mon, 16 Apr 2018 19:15:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a727e74f-610c-4722-76e9-c1aca2f9e9bd@bell.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597941834039295294?=
X-GMAIL-MSGID: =?utf-8?q?1597946505748303996?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/16/2018 7:09 PM, John David Anglin wrote:
> On 2018-04-16 6:01 PM, Sinan Kaya wrote:
>> parisc architecture seems to be mapping writeX() and writeX_relaxed() APIs
>> to __raw_writeX() API.
>>
>> __raw_writeX() API doesn't provide any kind of ordering guarantees.
>> commit 755bd04aaf4b ("io: define stronger ordering for the default writeX()
>> implementation") changed asm-generic implementation to use a more
>> conservative approach towards the writeX() API.
>>
>> Drop the arch specific version and rely on the asm-generic version for
>> parisc since parisc version doesn't seem to do anything special with these
>> macros.
>   HOSTLD  scripts/mod/modpost
> In file included from ./arch/parisc/include/asm/hardirq.h:13:0,
>                  from ./include/linux/hardirq.h:9,
>                  from arch/parisc/kernel/asm-offsets.c:34:
> ./include/linux/irq.h: In function 'irq_reg_writel':
> ./include/linux/irq.h:1114:3: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
>    writel(val, gc->reg_base + reg_offset);
>    ^~~~~~
> ./include/linux/irq.h: In function 'irq_reg_readl':
> ./include/linux/irq.h:1123:10: error: implicit declaration of function 'readl' [-Werror=implicit-function-declaration]
>    return readl(gc->reg_base + reg_offset);
>           ^~~~~
> cc1: some warnings being treated as errors
> make[1]: *** [Kbuild:58: arch/parisc/kernel/asm-offsets.s] Error 1
> 
> Dave
> 

Thanks for testing. Can you add this on top and see if it helps?

--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -259,6 +259,7 @@ extern void outsl (unsigned long port, const void *src, unsigned long count);
  * value for either 32 or 64 bit mode */
 #define F_EXTEND(x) ((unsigned long)((x) | (0xffffffff00000000ULL)))
 
+#include <asm-generic/io.h>
 #include <asm-generic/iomap.h>


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
