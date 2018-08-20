Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B1EC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B5A2154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B5A2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeHTQls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:41:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55421 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeHTQls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:41:48 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1frkC7-0005ry-Nc; Mon, 20 Aug 2018 15:26:07 +0200
Date:   Mon, 20 Aug 2018 15:26:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Juergen Gross <jgross@suse.com>
cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, boris.ostrovsky@oracle.com, hpa@zytor.com,
        mingo@redhat.com
Subject: Re: [PATCH 2/2] x86/pae: use 64 bit atomic xchg function in
 native_ptep_get_and_clear
In-Reply-To: <20180820051456.20779-3-jgross@suse.com>
Message-ID: <alpine.DEB.2.21.1808201519270.1551@nanos.tec.linutronix.de>
References: <20180820051456.20779-1-jgross@suse.com> <20180820051456.20779-3-jgross@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018, Juergen Gross wrote:
> In case adding about 6 cycles for native_ptep_get_and_clear() is believed
> to be too bad I can modify the patch to add a paravirt function for that
> purpose in order to add the overhead for Xen guests only (in fact the
> overhead for Xen guests will be less, as only one instruction writing to
> the PTE has to be emulated by the hypervisor).

I doubt that its worth the trouble of yet another paravirt thingy.

> ---
>  arch/x86/include/asm/pgtable-3level.h | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
> index a564084c6141..7919ae4e27d8 100644
> --- a/arch/x86/include/asm/pgtable-3level.h
> +++ b/arch/x86/include/asm/pgtable-3level.h
> @@ -2,6 +2,8 @@
>  #ifndef _ASM_X86_PGTABLE_3LEVEL_H
>  #define _ASM_X86_PGTABLE_3LEVEL_H
>  
> +#include <asm/atomic64_32.h>
> +
>  /*
>   * Intel Physical Address Extension (PAE) Mode - three-level page
>   * tables on PPro+ CPUs.
> @@ -148,14 +150,14 @@ static inline void pud_clear(pud_t *pudp)
>  #ifdef CONFIG_SMP
>  static inline pte_t native_ptep_get_and_clear(pte_t *ptep)
>  {
> -	pte_t res;
> +	union {
> +		pte_t pte;
> +		long long val;
> +	} res;
>  
> -	/* xchg acts as a barrier before the setting of the high bits */
> -	res.pte_low = xchg(&ptep->pte_low, 0);
> -	res.pte_high = ptep->pte_high;
> -	ptep->pte_high = 0;
> +	res.val = arch_atomic64_xchg((atomic64_t *)ptep, 0);

Couldn't you just keep

	 pte_t res;

and do:

	res.pte = (pteval_t) arch_atomic64_xchg((atomic64_t *)ptep, 0);

Hmm?

Thanks,

	tglx
