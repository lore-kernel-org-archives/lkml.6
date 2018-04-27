Return-Path: <catalin.marinas@arm.com>
X-Google-Smtp-Source: AB8JxZr6fHYJZlr6G869PxqAqEJSf0zDwHViXaCCiaBM+lKt96r/ensjqjedEfkTiyYji3ddvHpV
ARC-Seal: i=1; a=rsa-sha256; t=1524824946; cv=none;
        d=google.com; s=arc-20160816;
        b=oi0+zfqcACUy1rJzvdLF7m7GGkXjxAiRFyoKD3ip5FlcYFtDonthL2v+2flPLCa22e
         gyMccK7uZQFz58GlYDbWd2EmWb+K2o+5zzk4cU5uk0g0EGsneDWgB2t0Pqq3cBwoEEa8
         dxb5UBRlq8q9o9psgLy4qo5ic78cHHrsW5vZMWgpl4l6ZthP7ENs4a2qnnITV0dCc7l9
         mEPzYQP96U0O2d1rMQ8M9YhOgHdNIXfeHweoGLJ6tSzjZp5E8s65pYlyA923phT9MCEB
         obXLM43u4U+ET8i9IeDaLRWC4IAmp4NWdshau4EynNzDaIBtUjM9t22OgxDPsCFzN1lE
         4SuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ZQpUvBqyuA6DAt8wRiAv6A7+tDPlESZxhWNuj1pDMYo=;
        b=daRtaC3mj1HNZEu9t4Oxqp5+fs3hj89bUfIaFBKLbJgEGrx8jNIrFv0Kx+SAXA3k3z
         4IgMYsuykvPrJzYhrNOmbl7Zfp55iELKGY+9C8SJJEOuAeMjnfkAj6VFcoj9RH36dpF+
         FwRTX3/bWhS2Kr/SUOtULa+yETHX1H4gnLZHOyNWnPNpFfKcZbkFib3tUJdi0sSufumC
         iP27jaEsot6k6N3JJ1W10AlZD+XZ5eVEJ48ZZvk9TyZgNTQDazEE76RMvpECYo75bTDI
         QTbfVfnOm7ux8grkzt2/Dm2uVAQnR2IeC90m/16hPkVKVazdgouB9CSHtEQe/gTwnuLh
         9TgA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of catalin.marinas@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=catalin.marinas@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of catalin.marinas@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=catalin.marinas@arm.com
Date: Fri, 27 Apr 2018 11:29:01 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: will.deacon@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com,
	linux-arch@vger.kernel.org, arnd@arndb.de,
	ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	kristina.martsenko@arm.com, takahiro.akashi@linaro.org,
	james.morse@arm.com, tglx@linutronix.de, akpm@linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 2/4] arm64: tlbflush: Introduce
 __flush_tlb_kernel_pgtable
Message-ID: <20180427102900.4e63lo4eksk23vtn@armageddon.cambridge.arm.com>
References: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
 <1522742446-5084-3-git-send-email-cpandya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522742446-5084-3-git-send-email-cpandya@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596711273338425981?=
X-GMAIL-MSGID: =?utf-8?q?1598894843410318312?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 01:30:44PM +0530, Chintan Pandya wrote:
> Add an interface to invalidate intermediate page tables
> from TLB for kernel.
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>  arch/arm64/include/asm/tlbflush.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 9e82dd7..6a4816d 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -209,6 +209,12 @@ static inline void __flush_tlb_pgtable(struct mm_struct *mm,
>  	dsb(ish);
>  }
>  
> +static inline void __flush_tlb_kernel_pgtable(unsigned long addr)
> +{
> +	addr >>= 12;
> +	__tlbi(vaae1is, addr);
> +	dsb(ish);
> +}
>  #endif

Please use __TLBI_VADDR here as it does some additional masking.

-- 
Catalin
