Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx49Bpcieuq5j5Tuvky5inHp271j9GbT81/A77yFDUB34OdMIT1XOyXaWGbQgFhguHyzhbOa4
ARC-Seal: i=1; a=rsa-sha256; t=1522239035; cv=none;
        d=google.com; s=arc-20160816;
        b=s18+WvKjoiLIvFSSySvrWiHkRwJgTlkAqmGW+Cay40rj/fBCtoC7FcFn3coOcI2O3J
         1RNOkI359+fyC7D+yzVK3Ws7jceVIShrEJCYaimLbHACOjcu87+6jwwvsCW90AYx/62j
         sel/FTEF2Z20Ap0Igqy0OcGrpfah4hVdmEYOUyJQpwkHtCLjRoTPixcmJO8DMB/XXJYP
         TCR9ZOnqqU4BAf8FhaEMGAnpv5gMkRKRk0Ik3ujMH2Qi0nX28nVDjz5E83cOulD9kb81
         K6hWBtOzTkiZAy00Xff459YKv210ywWybLPXo17ivALyESBwwu+/cqAvFi+SxoaLJuzM
         WHIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=4MjRjeWNp613awh8hqk+KmcBUmpGjqIAtu7LRiPmNCQ=;
        b=yyz8qOboPR8Ason7xZByVthuDmE6cNzohlHQdEmB9p0/tqysMeqYQ9UdOmfzu8hDtm
         rMA1yAmtxe14Fs1lqN+Ekbft4XVGphN9qYHvgISa66A/c2N/gN216wn8u9u80mVSSCDj
         ppzo89mQqajpCFJPj9uKgpRF3Qe5s5lKmvpd2f1qY+nJJXEOBG7h0p9I82xczP78nBJ2
         9CuEynWPZ5DSd8Oxbt0AqAtZk694sKfyTPp12BitsQPoX8mTCIl2ab7nLshYXrjGFRxT
         PRoNP2eud6WiLJodXOMlKBYibc4e659DSqXReiuMxKpUuiLn9O9I4azxyVDZo0Uy7I//
         4ZxA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=SEPg7Xux;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=i1ChSNZq;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=SEPg7Xux;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=i1ChSNZq;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF03760224
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v6 0/4] Fix issues with huge mapping in ioremap for ARM64
To: catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
 toshi.kani@hpe.com
Cc: arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
 james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org,
 gregkh@linuxfoundation.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, akpm@linux-foundation.org
References: <1522234731-27397-1-git-send-email-cpandya@codeaurora.org>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <f0b3057e-dc8c-d0ef-cffb-87b0f01c80aa@codeaurora.org>
Date: Wed, 28 Mar 2018 17:40:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522234731-27397-1-git-send-email-cpandya@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596178825691273824?=
X-GMAIL-MSGID: =?utf-8?q?1596183318650538069?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I goofed up in making a patch file so enumeration is wrong.
I'll upload v7

On 3/28/2018 4:28 PM, Chintan Pandya wrote:
> This series of patches are follow up work (and depends on)
> Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
> panic in ioremap huge pages".
> 
> This series of patches are tested on 4.9 kernel with Cortex-A75
> based SoC.
> 
> These patches can also go into '-stable' branch (if accepted)
> for 4.6 onwards.
> 
>  From V5->V6:
>   - Use __flush_tlb_kernel_pgtable() for both PUD and PMD. Remove
>     "bool tlb_inv" based variance as it is not need now
>   - Re-naming for consistency
> 
>  From V4->V5:
>   - Add new API __flush_tlb_kernel_pgtable(unsigned long addr)
>     for kernel addresses
> 
>  From V3->V4:
>   - Add header for 'addr' in x86 implementation
>   - Re-order pmd/pud clear and table free
>   - Avoid redundant TLB invalidatation in one perticular case
> 
>  From V2->V3:
>   - Use the exisiting page table free interface to do arm64
>     specific things
> 
>  From V1->V2:
>   - Rebased my patches on top of "[PATCH v2 1/2] mm/vmalloc:
>     Add interfaces to free unmapped page table"
>   - Honored BBM for ARM64
> 
> Chintan Pandya (4):
>    ioremap: Update pgtable free interfaces with addr
>    arm64: tlbflush: Introduce __flush_tlb_kernel_pgtable
>    arm64: Implement page table free interfaces
>    Revert "arm64: Enforce BBM for huge IO/VMAP mappings"
> 
>   arch/arm64/include/asm/tlbflush.h |  6 ++++++
>   arch/arm64/mm/mmu.c               | 37 +++++++++++++++++++++++++------------
>   arch/x86/mm/pgtable.c             |  6 ++++--
>   include/asm-generic/pgtable.h     |  8 ++++----
>   lib/ioremap.c                     |  4 ++--
>   5 files changed, 41 insertions(+), 20 deletions(-)
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
