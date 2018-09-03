Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A893FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BB820652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BB820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbeIDCcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 22:32:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55858 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeIDCcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 22:32:46 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=[192.168.0.145])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fwx3I-0001of-OV; Tue, 04 Sep 2018 00:10:32 +0200
Date:   Tue, 4 Sep 2018 00:10:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bin Yang <bin.yang@intel.com>
cc:     mingo@kernel.org, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        dave.hansen@intel.com, mark.gross@intel.com
Subject: Re: [PATCH v3 3/5] x86/mm: add help function to check specific
 protection flags in range
In-Reply-To: <1534814186-37067-4-git-send-email-bin.yang@intel.com>
Message-ID: <alpine.DEB.2.21.1809032357430.1462@nanos.tec.linutronix.de>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com> <1534814186-37067-4-git-send-email-bin.yang@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018, Bin Yang wrote:
>  /*
> + * static_protections() "forces" page protections for some address
> + * ranges.  Return true if any part of the address/len range is forced
> + * to change from 'prot'.
> + */
> +static inline bool
> +needs_static_protections(pgprot_t prot, unsigned long address,
> +		unsigned long len, unsigned long pfn)
> +{
> +	int i;
> +
> +	address &= PAGE_MASK;
> +	len = PFN_ALIGN(len);
> +	for (i = 0; i < (len >> PAGE_SHIFT); i++, address += PAGE_SIZE, pfn++) {
> +		pgprot_t chk_prot = static_protections(prot, address, pfn);
> +
> +		if (pgprot_val(chk_prot) != pgprot_val(prot))
> +			return true;
> +	}
> +
> +	/* Does static_protections() demand a change ? */
> +	return false;
> +}

...

>  	if (cpa->force_split)
> @@ -660,14 +684,8 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
>  	 * static_protection() requires a different pgprot for one of
>  	 * the pages in the range we try to preserve:
>  	 */
> -	pfn = old_pfn;
> -	for (i = 0; i < (psize >> PAGE_SHIFT); i++, addr += PAGE_SIZE, pfn++) {
> -		pgprot_t chk_prot = static_protections(req_prot, addr, pfn);
> -
> -		if (pgprot_val(chk_prot) != pgprot_val(new_prot))
> -			goto out_unlock;
> -	}
> -
> +	if (needs_static_protections(new_prot, addr, psize, old_pfn))
> +		goto out_unlock;

This is not the same. The existing code does:

     new_prot = static_protections(req_prot, address, pfn);

which is the protection updated pgprot for the base of the address range
which should be modified. The loop does:

    chk_prot = static_protections(req_prot, addr, pfn);

    if (chk_prot != new_prot)
    	   goto split;

Now mapping your new function back and then the loop becomes:

    chk_prot = static_protections(new_prot, addr, pfn);

    if (chk_prot != new_prot)
    	   goto split;

which is broken in case that after the initial static protections
invocation

	new_prot = static_protections(req_prot, address, pfn);

the result is:

   new_prot != req_prot

and in the loop

   new_prot is valid for _ALL_ pages in the large page because the static
   protection which got applied for the first address can be applied to the
   complete range, i.e. new_prot it is not further modified by
   static_protections() for any page.

That again can cause wrong large page preservations.

Thanks,

	tglx

