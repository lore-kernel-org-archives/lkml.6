Return-Path: <mark.rutland@arm.com>
X-Google-Smtp-Source: AG47ELvs9NqyLsL9d+ZpyZYhcAVqvaUZsoAhwIlUQfUN2QS3Zgo750ZS2YAfrG5lqddrZXk429Cy
ARC-Seal: i=1; a=rsa-sha256; t=1522058147; cv=none;
        d=google.com; s=arc-20160816;
        b=WaZsmBY/CRn4+mdbTpvZBTBnxfsLOIdfr8dwtrxbH7yHN6ta0RRvUzTmIZxRfvky+p
         rcK2KLVBbTdvjLVMgCfdRjhbtMwjza4/m0noZVDZFNO3oYd9OgsIWwIRr4GT+g8361Js
         rmr2AFHNMMW2IsO45zTkLo3J+xzCraSF8vHijpmKhxYlvAHWmfboK1yNCs6ZWFYKxaPk
         541KumA/6UHyQqVs8Zv9IuXUGvoeovo29CBBoUy3emdnAtopiM1kya6ahqSVBS/J3gwO
         2kRrj6Y8h/0qEv1oloOPaKeZDbjOCRZ91SZmJ2D7aCtzW//N1Rn2zcqsY6q8F0asF6g1
         TXwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=C0y9YrmK16tOBuS3nnZg9hdGXq6kUltKpYDhtMkifI8=;
        b=L/8IuADOA9nLzQWuH6A/2ZfNA+WaEA8CS2oDTXJKweH2OlwGMengUOH+7qdN1wPAiJ
         XC5QGl11GKg7BcO5fo5/xckri9384vGt+uuXX28P8Tbalz98zOMLdC3uMYg438p4FCtt
         kBRZb4T1/DCkRtXhVEEpLNTsFUZP/GYW/jQpy/NPPwFcd1kW8KGbeY+aMJIM6jUkmB3E
         faoOE8BM3H7pJgwBLRkcwluhbGxZqPiojfaSTMuHwgzXQ6G3ZFo9+4D8x7Moil5VN51l
         7MqkxxEcQKP2izkZIM/aBW6Q7wF8hERAwL+tjlq5pY28B20J/5CW7y7i+drD/hdqUKQn
         RKHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Date: Mon, 26 Mar 2018 10:55:41 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
	ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
	james.morse@arm.com, kristina.martsenko@arm.com,
	takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
	tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	akpm@linux-foundation.org, toshi.kani@hpe.com
Subject: Re: [PATCH v4 2/3] arm64: Implement page table free interfaces
Message-ID: <20180326095541.izogc4iak6d7nerm@lakrids.cambridge.arm.com>
References: <1521546314-31753-1-git-send-email-cpandya@codeaurora.org>
 <1521546314-31753-3-git-send-email-cpandya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521546314-31753-3-git-send-email-cpandya@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007777008930452?=
X-GMAIL-MSGID: =?utf-8?q?1595993643677264036?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 05:15:13PM +0530, Chintan Pandya wrote:
> +static int __pmd_free_pte_page(pmd_t *pmd, unsigned long addr, bool tlb_inv)
> +{
> +	pmd_t *table;
> +
> +	if (pmd_val(*pmd)) {
> +		table = __va(pmd_val(*pmd));
> +		pmd_clear(pmd);
> +		/*
> +		 * FIXME: __flush_tlb_pgtable(&init_mm, addr) is
> +		 *        ideal candidate here, which exactly
> +		 *        flushes intermediate pgtables. But,
> +		 *        this is broken (evident from tests).
> +		 *        So, use safe TLB op unless that is fixed.
> +		 */
> +		if (tlb_inv)
> +			flush_tlb_kernel_range(addr, addr + PMD_SIZE);

I don't think that __flush_tlb_pgtable() is broken. It's only valid to
call it for user page tables, since it doesn't affect all ASIDs.

We can add a simlar helper for kernel mappings, which affects all ASIDs,
e.g.

static inline void __flush_tlb_kernel_pgtable(unsigned long addr)
{
	addr >>= 12;
	__tlbi(vaae1is, addr);
	dsb(ish);
}

Thanks,
Mark.
