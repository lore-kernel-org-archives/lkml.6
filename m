Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F56C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C47223E1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C47223E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeGBO7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:59:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752075AbeGBO7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:59:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 880EA401EF06;
        Mon,  2 Jul 2018 14:59:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-57.ams2.redhat.com [10.36.116.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54BDD2166B5D;
        Mon,  2 Jul 2018 14:59:45 +0000 (UTC)
Subject: Re: [PATCH v3 11/20] kvm: arm64: Helper for computing VTCR_EL2.SL0
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-12-git-send-email-suzuki.poulose@arm.com>
Cc:     cdall@kernel.org, kvm@vger.kernel.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, punit.agrawal@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, julien.grall@arm.com, james.morse@arm.com,
        Christoffer Dall <cdall@arm.com>, kvmarm@lists.cs.columbia.edu
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <8faab60c-3025-d37f-6dd2-4f26bc32447c@redhat.com>
Date:   Mon, 2 Jul 2018 16:59:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-12-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 02 Jul 2018 14:59:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 02 Jul 2018 14:59:47 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 06/29/2018 01:15 PM, Suzuki K Poulose wrote:
> VTCR_EL2 holds the following key stage2 translation table
> parameters:
>   SL0  - Entry level in the page table lookup.
>   T0SZ - Denotes the size of the memory addressed by the table.
> 
> We have been using fixed values for the SL0 depending on the
> page size as we have a fixed IPA size. But since we are about
> to make it dynamic, we need to calculate the SL0 at runtime
> per VM. This patch adds a helper to comput the value of SL0 for
compute
> a given IPA.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v2:
>  - Part 2 of split from VTCR & VTTBR dynamic configuration
> ---
>  arch/arm64/include/asm/kvm_arm.h | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index c557f45..11a7db0 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -153,7 +153,8 @@
>   * 2 level page tables (SL = 1)
>   */
>  #define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_64K | VTCR_EL2_SL0_LVL1)
> -#define VTTBR_X_TGRAN_MAGIC		38
> +#define VTCR_EL2_TGRAN_SL0_BASE		3UL
> +
>  #elif defined(CONFIG_ARM64_16K_PAGES)
>  /*
>   * Stage2 translation configuration:
> @@ -161,7 +162,7 @@
>   * 2 level page tables (SL = 1)
>   */
>  #define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_16K | VTCR_EL2_SL0_LVL1)
> -#define VTTBR_X_TGRAN_MAGIC		42
> +#define VTCR_EL2_TGRAN_SL0_BASE		3UL
>  #else	/* 4K */
>  /*
>   * Stage2 translation configuration:
> @@ -169,11 +170,39 @@
>   * 3 level page tables (SL = 1)
>   */
>  #define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SL0_LVL1)
> -#define VTTBR_X_TGRAN_MAGIC		37
> +#define VTCR_EL2_TGRAN_SL0_BASE		2UL
>  #endif
>  
>  #define VTCR_EL2_FLAGS			(VTCR_EL2_COMMON_BITS | VTCR_EL2_TGRAN_FLAGS)
>  /*
> + * VTCR_EL2:SL0 indicates the entry level for Stage2 translation.
> + * Interestingly, it depends on the page size.
> + * See D.10.2.110, VTCR_EL2, in ARM DDI 0487B.b
update ref to the last one?
> + *
> + *	-----------------------------------------
> + *	| Entry level		|  4K  | 16K/64K |
> + *	------------------------------------------
> + *	| Level: 0		|  2   |   -     |
> + *	------------------------------------------
> + *	| Level: 1		|  1   |   2     |
> + *	------------------------------------------
> + *	| Level: 2		|  0   |   1     |
> + *	------------------------------------------
> + *	| Level: 3		|  -   |   0     |
> + *	------------------------------------------
> + *
> + * That table roughly translates to :
> + *
> + *	SL0(PAGE_SIZE, Entry_level) = SL0_BASE(PAGE_SIZE) - Entry_Level
> + *
> + * Where SL0_BASE(4K) = 2 and SL0_BASE(16K) = 3, SL0_BASE(64K) = 3, provided
> + * we take care of ruling out the unsupported cases and
> + * Entry_Level = 4 - Number_of_levels.
> + *
> + */
> +#define VTCR_EL2_SL0(levels) \
> +	((VTCR_EL2_TGRAN_SL0_BASE - (4 - (levels))) << VTCR_EL2_SL0_SHIFT)
> +/*
>   * ARM VMSAv8-64 defines an algorithm for finding the translation table
>   * descriptors in section D4.2.8 in ARM DDI 0487B.b.
>   *
> 
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
