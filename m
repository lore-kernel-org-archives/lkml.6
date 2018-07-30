Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F116713F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B346920893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B346920893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeG3PWI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:22:08 -0400
Received: from ozlabs.org ([203.11.71.1]:34137 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbeG3PWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:22:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41fLTd5D1Zz9rxx;
        Mon, 30 Jul 2018 23:47:01 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org,
        paulus@samba.org, npiggin@gmail.com
Subject: Re: [PATCH 3/3] powerpc/pseries/mm: call H_BLOCK_REMOVE
In-Reply-To: <1532699493-10883-4-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1532699493-10883-1-git-send-email-ldufour@linux.vnet.ibm.com> <1532699493-10883-4-git-send-email-ldufour@linux.vnet.ibm.com>
Date:   Mon, 30 Jul 2018 23:47:01 +1000
Message-ID: <877elcj0oa.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Just one comment below.

Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:
> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
> index 96b8cd8a802d..41ed03245eb4 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -418,6 +418,73 @@ static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long vpn,
>  	BUG_ON(lpar_rc != H_SUCCESS);
>  }
>  
> +
> +/*
> + * As defined in the PAPR's section 14.5.4.1.8
> + * The control mask doesn't include the returned reference and change bit from
> + * the processed PTE.
> + */
> +#define HBLKR_AVPN		0x0100000000000000UL
> +#define HBLKR_CTRL_MASK		0xf800000000000000UL
> +#define HBLKR_CTRL_SUCCESS	0x8000000000000000UL
> +#define HBLKR_CTRL_ERRNOTFOUND	0x8800000000000000UL
> +#define HBLKR_CTRL_ERRBUSY	0xa000000000000000UL
> +
> +/**
> + * H_BLOCK_REMOVE caller.
> + * @idx should point to the latest @param entry set with a PTEX.
> + * If PTE cannot be processed because another CPUs has already locked that
> + * group, those entries are put back in @param starting at index 1.
> + * If entries has to be retried and @retry_busy is set to true, these entries
> + * are retried until success. If @retry_busy is set to false, the returned
> + * is the number of entries yet to process.
> + */
> +static unsigned long call_block_remove(unsigned long idx, unsigned long *param,
> +				       bool retry_busy)
> +{
> +	unsigned long i, rc, new_idx;
> +	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
> +
> +again:
> +	new_idx = 0;
> +	BUG_ON((idx < 2) || (idx > PLPAR_HCALL9_BUFSIZE));

I count 1 ..

> +	if (idx < PLPAR_HCALL9_BUFSIZE)
> +		param[idx] = HBR_END;
> +
> +	rc = plpar_hcall9(H_BLOCK_REMOVE, retbuf,
> +			  param[0], /* AVA */
> +			  param[1],  param[2],  param[3],  param[4], /* TS0-7 */
> +			  param[5],  param[6],  param[7],  param[8]);
> +	if (rc == H_SUCCESS)
> +		return 0;
> +
> +	BUG_ON(rc != H_PARTIAL);

2 ...

> +	/* Check that the unprocessed entries were 'not found' or 'busy' */
> +	for (i = 0; i < idx-1; i++) {
> +		unsigned long ctrl = retbuf[i] & HBLKR_CTRL_MASK;
> +
> +		if (ctrl == HBLKR_CTRL_ERRBUSY) {
> +			param[++new_idx] = param[i+1];
> +			continue;
> +		}
> +
> +		BUG_ON(ctrl != HBLKR_CTRL_SUCCESS
> +		       && ctrl != HBLKR_CTRL_ERRNOTFOUND);

3 ...

BUG_ON()s.

I know the code in this file is already pretty liberal with the use of
BUG_ON() but I'd prefer if we don't make it any worse.

Given this is an optimisation it seems like we should be able to fall
back to the existing implementation in the case of error (which will
probably then BUG_ON() 😂)

If there's some reason we can't then I guess I can live with it.

cheers
