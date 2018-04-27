Return-Path: <kernel-hardening-return-13145-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZoyz3kzVL7S3VVbCAuJ10a8J/uFoBBuYk6SvNca7WkrTNBMpcHO/O2Y+yFRdr98i+JndxKs
ARC-Seal: i=1; a=rsa-sha256; t=1524823026; cv=none;
        d=google.com; s=arc-20160816;
        b=JgNKbE+qZXle9cRNMscZ7eE56UgszyUvX+Xr2EvJKG1cubCW3huaXGKv5zTFH49+E1
         klvjZT85OvqXVPSmMHJdHLbVdZXBS4d2xgf18qXXc0A/NCwht2KdJJ/3X6tWGYTR1OP/
         oKe2S3T+jJI1tu21DDBKp/Lp/YhbRjFLKTkQ4vb7+VUXo+oj+TNh4PM48cJ59pgt22DR
         KFqu9dXzGk6WiSWgYJEDbgevMurfz1dNwhrMVIzOQ30PMXpbUjmhuVEyl1+PwCu5GMnn
         EbDlwAmFtOvoS+qe7lnQ/WPaG0pCQ0VPC0xn88xsb3pcOvn5CU0K+gpZwoi8WMEJy4hW
         kV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=e9cl2JHTu387Ar0NOLJioQpqUJRWmR+CCitRIz8prNI=;
        b=V0pW6/73DBhHxpDiLS0FVJw/TS3xungWvR5yFM922cp72mUTYPkwuhWxJYKisUaHDu
         MrlKhyzVTkQyH1pfggskkQ8syTF634O2BMOJd5Eor+TVKzjbV39w/e8OrjPWvwrcIH27
         Eo80+g4IXP8vnE4QqOiTNMh/4VSGhZsZLjM2wcxHzQg1qMBpn1mmz17Dqbh4OhCXWboE
         geVXOWb2OKeoShTnErwnD6vBnXBSJU4OhvDieUUEGkrCsZuYiK2pJ+5y6sQKaWE9gk4y
         SE6xVArBUCaGnaU/GBe5u2mJmBetbH1K0Drw2ValHxuCu2GkofL6WPazu+SugkocoAgG
         gIpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13145-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13145-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13145-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13145-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 27 Apr 2018 11:51:39 +0200
From: Christoffer Dall <christoffer.dall@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	drjones@redhat.com, arnd@arndb.de, suzuki.poulose@arm.com,
	marc.zyngier@arm.com, catalin.marinas@arm.com,
	awallis@codeaurora.org, kernel-hardening@lists.openwall.com,
	will.deacon@arm.com, linux-kernel@vger.kernel.org,
	ramana.radhakrishnan@arm.com, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCHv3 02/11] arm64/kvm: consistently handle host HCR_EL2 flags
Message-ID: <20180427095139.GH13249@C02W217FHV2R.local>
References: <20180417183735.56985-1-mark.rutland@arm.com>
 <20180417183735.56985-3-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417183735.56985-3-mark.rutland@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598019685895863114?=
X-GMAIL-MSGID: =?utf-8?q?1598892830155616510?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 07:37:26PM +0100, Mark Rutland wrote:
> In KVM we define the configuration of HCR_EL2 for a VHE HOST in
> HCR_HOST_VHE_FLAGS, but we don't ahve a similar definition for the

nit: have

> non-VHE host flags, and open-code HCR_RW. Further, in head.S we
> open-code the flags for VHE and non-VHE configurations.
> 
> In future, we're going to want to configure more flags for the host, so
> lets add a HCR_HOST_NVHE_FLAGS defintion, adn consistently use both

nit: and

> HCR_HOST_VHE_FLAGS and HCR_HOST_NVHE_FLAGS in the kvm code and head.S.
> 
> We now use mov_q to generate the HCR_EL2 value, as we use when
> configuring other registers in head.S.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> ---
>  arch/arm64/include/asm/kvm_arm.h | 1 +
>  arch/arm64/kernel/head.S         | 5 ++---
>  arch/arm64/kvm/hyp/switch.c      | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 6dd285e979c9..89b3dda7e3cb 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -86,6 +86,7 @@
>  			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
>  			 HCR_FMO | HCR_IMO)
>  #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
> +#define HCR_HOST_NVHE_FLAGS (HCR_RW)
>  #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
>  
>  /* TCR_EL2 Registers bits */
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index b0853069702f..651a06b1980f 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -494,10 +494,9 @@ ENTRY(el2_setup)
>  #endif
>  
>  	/* Hyp configuration. */
> -	mov	x0, #HCR_RW			// 64-bit EL1
> +	mov_q	x0, HCR_HOST_NVHE_FLAGS
>  	cbz	x2, set_hcr
> -	orr	x0, x0, #HCR_TGE		// Enable Host Extensions
> -	orr	x0, x0, #HCR_E2H
> +	mov_q	x0, HCR_HOST_VHE_FLAGS
>  set_hcr:
>  	msr	hcr_el2, x0
>  	isb
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index d9645236e474..cdae330e15e9 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -143,7 +143,7 @@ static void __hyp_text __deactivate_traps_nvhe(void)
>  	mdcr_el2 |= MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT;
>  
>  	write_sysreg(mdcr_el2, mdcr_el2);
> -	write_sysreg(HCR_RW, hcr_el2);
> +	write_sysreg(HCR_HOST_NVHE_FLAGS, hcr_el2);
>  	write_sysreg(CPTR_EL2_DEFAULT, cptr_el2);
>  }
>  
> -- 
> 2.11.0
> 
> 
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
