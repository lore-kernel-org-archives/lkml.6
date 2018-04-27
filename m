Return-Path: <kernel-hardening-return-13147-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZpBuL6ClcBC9NgZzO1x0EieTkxm7Tg4iEesFfckh2b0WRLtq7fixauN2g6weFAUFGof/zGr
ARC-Seal: i=1; a=rsa-sha256; t=1524823040; cv=none;
        d=google.com; s=arc-20160816;
        b=nblmhKS3E3a0dekPG9BFnoHMwm05e4p0joNjQFy2890kS7CrWAfIBNQoE0eSPww4Y8
         UnLaJ6qAvp8Eyjdb/+4YNp8twVwl6T/3MIJd/Jm1+XIW82S+Mtj99gzdfp45szd1gYCL
         xNetOfiFZgzYKhzlHHBnsoYJOSAjR9D7FfzJr1tC71vb8eyLKvsq0RRUoT6/MWLFPW+b
         Ce7BRGw3BNPWgMFzt5h9NomjLTTHCG8xoE55siEd0ufngw+lkcnhZLP7egQyyfTvU2+A
         aNtqwheNN9zGp/h7TJCJKLvmCpB85W84m7FQ1WjTbq2snvfHyEOodks9ifn90m33j7Hd
         ajJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=2MjfCulBrV4pTZsJoyumoQ04d6D6hybe8s1QQ9+KkMk=;
        b=Oxf2qCODr0cmkAEPB5HL31uWsndHNyzfKTz1/Iro2pxTnq6lBjkFSQqXlE8w0p9bI8
         HwYbL3J8IDHsjJFttEc1EoWUzb6koo/wPlga/9yPbgoIqguPFgncatVXzqiuXNQH/W1r
         8Goxcsq/IfMt7PaFj6W+lSEZ5KwRwhArAmXA46+EYk6/RvJXY2Efhqnx0cGqZmrkxvmx
         g0EOi+1CXCqrRgei4l6Zu54EwSwtzSlEkaI4MgBeutVzbHD5Gz57N00fYfcJ9DxbbYTp
         yMCQTz9U82V6YVWr1Vep7VNhekk9zkJZNyFRRraQ+4JTJevuCw/TJN2bCVa883zm5AP0
         WrZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13147-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13147-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13147-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13147-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 27 Apr 2018 11:52:05 +0200
From: Christoffer Dall <christoffer.dall@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	arnd@arndb.de, marc.zyngier@arm.com, catalin.marinas@arm.com,
	awallis@codeaurora.org, kernel-hardening@lists.openwall.com,
	will.deacon@arm.com, linux-kernel@vger.kernel.org,
	ramana.radhakrishnan@arm.com, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCHv3 04/11] arm64: Don't trap host pointer auth use to EL2
Message-ID: <20180427095205.GJ13249@C02W217FHV2R.local>
References: <20180417183735.56985-1-mark.rutland@arm.com>
 <20180417183735.56985-5-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417183735.56985-5-mark.rutland@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598019703538856592?=
X-GMAIL-MSGID: =?utf-8?q?1598892844558812505?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 07:37:28PM +0100, Mark Rutland wrote:
> To allow EL0 (and/or EL1) to use pointer authentication functionality,
> we must ensure that pointer authentication instructions and accesses to
> pointer authentication keys are not trapped to EL2.
> 
> This patch ensures that HCR_EL2 is configured appropriately when the
> kernel is booted at EL2. For non-VHE kernels we set HCR_EL2.{API,APK},
> ensuring that EL1 can access keys and permit EL0 use of instructions.
> For VHE kernels host EL0 (TGE && E2H) is unaffected by these settings,
> and it doesn't matter how we configure HCR_EL2.{API,APK}, so we don't
> bother setting them.
> 
> This does not enable support for KVM guests, since KVM manages HCR_EL2
> itself when running VMs.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu

FWIW: Acked-by: Christoffer Dall <christoffer.dall@arm.com>

> ---
>  arch/arm64/include/asm/kvm_arm.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 89b3dda7e3cb..4d57e1e58323 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -23,6 +23,8 @@
>  #include <asm/types.h>
>  
>  /* Hyp Configuration Register (HCR) bits */
> +#define HCR_API		(UL(1) << 41)
> +#define HCR_APK		(UL(1) << 40)
>  #define HCR_TEA		(UL(1) << 37)
>  #define HCR_TERR	(UL(1) << 36)
>  #define HCR_TLOR	(UL(1) << 35)
> @@ -86,7 +88,7 @@
>  			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
>  			 HCR_FMO | HCR_IMO)
>  #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
> -#define HCR_HOST_NVHE_FLAGS (HCR_RW)
> +#define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK)
>  #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
>  
>  /* TCR_EL2 Registers bits */
> -- 
> 2.11.0
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
