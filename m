Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx49Hr4BV+sn9MyP/0hCJSSLsJVP6UA4wdKpQJzYtbUnJ22WGfAl1/3I71SpCsTqEEFqJj9S6
ARC-Seal: i=1; a=rsa-sha256; t=1522978516; cv=none;
        d=google.com; s=arc-20160816;
        b=QnMtYVFUzqu0MMW9AZTGt4qEI60j1lCtVFSw24lGNWyWP59OVH6fxM1UTH3UdJdJ7n
         OcaNDURK73c72acoDV1DK6Cg3N4SdiOWqSHklFN5SFL8WL7Nf7L+ejfyHMfpu5RJXPpK
         jasfQM/igOr7gaKua4jGbAZ72Iazj6NNiysNouIqtqs4+yJDgkb/W6fD5YJS8kt2RJzX
         FBfBufS9S/Qj/xKCmnebom9GWi0YM4R7OVVDuZIzrR5dxKzzAYdsSkDOT1sl6bFszXwB
         AksCJ8fGeOsh2DhuKo+bRlRukC43RIsX6csRNvRc86z9+cgN1wyKCS6oKccO+R+d340v
         y65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=jM/Ebh+8I8f/8CZBTRQ1ck2dELwjn9Qr+/5BpjLRJuk=;
        b=gJT3/4HO3OD9hWFUuAuEEOqCs2n7yn4xCuf74jCaDtLJoDSjdvSBxHJ7YE8hcs/Tox
         wKLmJrLC0tF0YqoTVnaf69vne2mS7LD83ufmQKPmxpKdZUXv6EatBrWi4w6Yq1lvsADy
         EYtUOI3PKswH35F2qbBL56W0bthiQiYR7ZOxCJwRLx6U5WBqyaXmuIjgfo10KC87lwMt
         ZJfWrbr7lYAF0rNzCJtrbTRudOjPRfvXCR1jedTtzu7ilSvOa3/Z8D89sQwNDVZDdfzI
         umnx6oCKuPuZzyKKK4i+GGHFfgIGXsH8pmBuJcZgFLrK4wDr7OZe5rEuhtMg1tEsA6Qz
         h9Yw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=o2sU71Zf;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=JJvntSk3;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=o2sU71Zf;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=JJvntSk3;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B519B607A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] alpha: io: reorder barriers to guarantee writeX() and
 iowriteX() ordering
To: linux-alpha@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: arnd@arndb.de, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-kernel@vger.kernel.org
References: <1522691281-21593-1-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <3c28281e-de52-abbe-36bc-06f5527da921@codeaurora.org>
Date: Thu, 5 Apr 2018 21:35:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1522691281-21593-1-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596657541952033644?=
X-GMAIL-MSGID: =?utf-8?q?1596958720512359044?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/2/2018 1:48 PM, Sinan Kaya wrote:
> memory-barriers.txt has been updated with the following requirement.
> 
> "When using writel(), a prior wmb() is not needed to guarantee that the
> cache coherent memory writes have completed before writing to the MMIO
> region."
> 
> Current writeX() and iowriteX() implementations on alpha are not
> satisfying this requirement as the barrier is after the register write.
> 
> Move mb() in writeX() and iowriteX() functions to guarantee that HW
> observes memory changes before performing register operations.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/alpha/include/asm/io.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
> index d123ff9..4c533fc 100644
> --- a/arch/alpha/include/asm/io.h
> +++ b/arch/alpha/include/asm/io.h
> @@ -341,14 +341,14 @@ extern inline unsigned int ioread16(void __iomem *addr)
>  
>  extern inline void iowrite8(u8 b, void __iomem *addr)
>  {
> -	IO_CONCAT(__IO_PREFIX,iowrite8)(b, addr);
>  	mb();
> +	IO_CONCAT(__IO_PREFIX, iowrite8)(b, addr);
>  }
>  
>  extern inline void iowrite16(u16 b, void __iomem *addr)
>  {
> -	IO_CONCAT(__IO_PREFIX,iowrite16)(b, addr);
>  	mb();
> +	IO_CONCAT(__IO_PREFIX, iowrite16)(b, addr);
>  }
>  
>  extern inline u8 inb(unsigned long port)
> @@ -382,8 +382,8 @@ extern inline unsigned int ioread32(void __iomem *addr)
>  
>  extern inline void iowrite32(u32 b, void __iomem *addr)
>  {
> -	IO_CONCAT(__IO_PREFIX,iowrite32)(b, addr);
>  	mb();
> +	IO_CONCAT(__IO_PREFIX, iowrite32)(b, addr);
>  }
>  
>  extern inline u32 inl(unsigned long port)
> @@ -434,14 +434,14 @@ extern inline u16 readw(const volatile void __iomem *addr)
>  
>  extern inline void writeb(u8 b, volatile void __iomem *addr)
>  {
> -	__raw_writeb(b, addr);
>  	mb();
> +	__raw_writeb(b, addr);
>  }
>  
>  extern inline void writew(u16 b, volatile void __iomem *addr)
>  {
> -	__raw_writew(b, addr);
>  	mb();
> +	__raw_writew(b, addr);
>  }
>  #endif
>  
> @@ -482,14 +482,14 @@ extern inline u64 readq(const volatile void __iomem *addr)
>  
>  extern inline void writel(u32 b, volatile void __iomem *addr)
>  {
> -	__raw_writel(b, addr);
>  	mb();
> +	__raw_writel(b, addr);
>  }
>  
>  extern inline void writeq(u64 b, volatile void __iomem *addr)
>  {
> -	__raw_writeq(b, addr);
>  	mb();
> +	__raw_writeq(b, addr);
>  }
>  #endif
>  
> 


Can we get these merged to 4.17? 

There was a consensus to fix the architectures having API violation issues.
https://www.mail-archive.com/netdev@vger.kernel.org/msg225971.html



-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
