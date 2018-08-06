Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4239C4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9596C21A52
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9596C21A52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387938AbeHGCsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 22:48:53 -0400
Received: from baldur.buserror.net ([165.227.176.147]:49016 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387728AbeHGCsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 22:48:52 -0400
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0] (helo=home.buserror.net)
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1fmpNj-0001xx-QK; Mon, 06 Aug 2018 18:57:48 -0500
Date:   Mon, 6 Aug 2018 18:57:45 -0500
From:   Scott Wood <oss@buserror.net>
To:     Bharat Bhushan <Bharat.Bhushan@nxp.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-ID: <20180806235745.GA25864@home.buserror.net>
References: <1532411985-17725-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532411985-17725-1-git-send-email-Bharat.Bhushan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: Bharat.Bhushan@nxp.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: powerpc/e200: Skip tlb1 entries used for kernel mapping
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 11:29:45AM +0530, Bharat Bhushan wrote:
> E200 have TLB1 only and it does not have TLB0.
> So TLB1 are used for mapping kernel and user-space both.
> TLB miss handler for E200 does not consider skipping TLBs
> used for kernel mapping. This patch ensures that we skip
> tlb1 entries used for kernel mapping (tlbcam_index).

How much more is needed to get e200 working?  What was this tested on?

> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> ---
>  arch/powerpc/kernel/head_fsl_booke.S | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
> index bf4c602..951fb96 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -801,12 +801,28 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
>  	/* Round robin TLB1 entries assignment */
>  	mfspr	r12, SPRN_MAS0
>  
> +	/* Get first free tlbcam entry */
> +	lis	r11, tlbcam_index@ha
> +	lwz	r11, tlbcam_index@l(r11)

The existing handler already loads tlbcam_index and uses that when
wrapping.  What specifically is causing that to not work (perhaps it's
just a matter of initializing NV when tlbcam_index changes?), and why
does this patch leave that code in place?

> +
> +	/* Extract MAS0(NV) */
> +	andi.	r13, r12, 0xfff
> +	cmpw	0, r13, r11
> +	blt	0, 5f
> +	b	6f
> +5:

Why these two instructions instead of "bge 6f"?  If it's for branch
prediction, does e200 pay attention to static hints?  If it doesn't,
you could move the wrap code out-of-line.

> +	/* When NV is less than first free tlbcam entry, use first free
> +	 * tlbcam entry for ESEL and set NV */
> +	rlwimi	r12, r11, 16, 4, 15
> +	addi	r11, r11, 1
> +	rlwimi	r12, r11, 0, 20, 31
> +	b	7f

The 4-argument form of rlwimi is easier to read.

BTW, The TLB miss handler would be simpler/faster if you reserve the
upper entries rather than the lower entries.  Then you would just have
one value to check (instead of using TLB1CFG[NENTRY]) to see if you wrap
back to zero.

-Scott
