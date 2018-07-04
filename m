Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B07C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0EB2173C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0EB2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753249AbeGDN1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:27:18 -0400
Received: from ozlabs.org ([203.11.71.1]:46587 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752634AbeGDN1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:27:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41LMGr1sQRz9s29;
        Wed,  4 Jul 2018 23:27:16 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Bharat Bhushan <Bharat.Bhushan@nxp.com>, benh@kernel.crashing.org,
        paulus@samba.org, robh@kernel.org, geoff@infradead.org,
        tyreld@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: Re: [PATCH] powerpc/mpic: Cleanup irq vector accounting
In-Reply-To: <1530267872-31244-1-git-send-email-Bharat.Bhushan@nxp.com>
References: <1530267872-31244-1-git-send-email-Bharat.Bhushan@nxp.com>
Date:   Wed, 04 Jul 2018 23:27:15 +1000
Message-ID: <87efgjku6k.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bharat Bhushan <Bharat.Bhushan@nxp.com> writes:

> Available vector space accounts ipis and timer interrupts
> while spurious vector was not accounted.

OK. What is the symptom of that? Nothing? Total system crash?

Looks like this can be tagged:

Fixes: 0a4081641d72 ("powerpc/mpic: FSL MPIC error interrupt support.")

Which added the code that uses "12".

> Also later
> mpic_setup_error_int() escape one more vector, seemingly it
> assumes one spurious vector.

Ah right, I get it now.

So there is no bug. It's just a disagreement about whether the "intvec"
argument to mpic_setup_error_int() indicates the first number that's
free to use or the last number that has been allocated.

Right?

cheers

> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> ---
>  arch/powerpc/sysdev/fsl_mpic_err.c | 2 +-
>  arch/powerpc/sysdev/mpic.c         | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/fsl_mpic_err.c b/arch/powerpc/sysdev/fsl_mpic_err.c
> index 488ec45..2a98837 100644
> --- a/arch/powerpc/sysdev/fsl_mpic_err.c
> +++ b/arch/powerpc/sysdev/fsl_mpic_err.c
> @@ -76,7 +76,7 @@ int mpic_setup_error_int(struct mpic *mpic, int intvec)
>  	mpic->flags |= MPIC_FSL_HAS_EIMR;
>  	/* allocate interrupt vectors for error interrupts */
>  	for (i = MPIC_MAX_ERR - 1; i >= 0; i--)
> -		mpic->err_int_vecs[i] = --intvec;
> +		mpic->err_int_vecs[i] = intvec--;
>  
>  	return 0;
>  }
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 1d4e0ef6..e098d1e 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1380,12 +1380,12 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  		 * global vector number space, as in case of ipis
>  		 * and timer interrupts.
>  		 *
> -		 * Available vector space = intvec_top - 12, where 12
> +		 * Available vector space = intvec_top - 13, where 13
>  		 * is the number of vectors which have been consumed by
> -		 * ipis and timer interrupts.
> +		 * ipis, timer interrupts and spurious.
>  		 */
>  		if (fsl_version >= 0x401) {
> -			ret = mpic_setup_error_int(mpic, intvec_top - 12);
> +			ret = mpic_setup_error_int(mpic, intvec_top - 13);
>  			if (ret)
>  				return NULL;
>  		}
> -- 
> 1.9.3
