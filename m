Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984D9C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E80279A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E80279A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967662AbeF2Czm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 22:55:42 -0400
Received: from ozlabs.org ([203.11.71.1]:39223 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966362AbeF2Czl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 22:55:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41H1VM6ClLz9s01;
        Fri, 29 Jun 2018 12:55:39 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, malat@debian.org,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: fix always true/false warning in slice.c
In-Reply-To: <63b696ab7be8b941fa1e1589f28260320d12a32a.1529589640.git.christophe.leroy@c-s.fr>
References: <63b696ab7be8b941fa1e1589f28260320d12a32a.1529589640.git.christophe.leroy@c-s.fr>
Date:   Fri, 29 Jun 2018 12:55:39 +1000
Message-ID: <871scqwbbo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> This patch fixes the following warnings (obtained with make W=1).
>
> arch/powerpc/mm/slice.c: In function 'slice_range_to_mask':
> arch/powerpc/mm/slice.c:73:12: error: comparison is always true due to limited range of data type [-Werror=type-limits]
>   if (start < SLICE_LOW_TOP) {

Presumably only on 32-bit ?

> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 9530c6db406a..17c57760e06c 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -79,7 +86,7 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
>  			- (1u << GET_LOW_SLICE_INDEX(start));
>  	}
>  
> -	if ((start + len) > SLICE_LOW_TOP) {
> +	if (!slice_addr_is_low(end)) {
>  		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
>  		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
>  		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;

This worries me.

By casting before the comparison in the helper you squash the compiler
warning, but the code is still broken if (start + len) overflows.

Presumably that "never happens", but it just seems fishy.

The other similar check in that file does:

  if (SLICE_NUM_HIGH && ((start + len) > SLICE_LOW_TOP)) {

Where SLICE_NUM_HIGH == 0 on 32-bit.


Could we fix the less than comparisons with SLICE_LOW_TOP with something
similar, eg:

	if (!SLICE_NUM_HIGH || start < SLICE_LOW_TOP) {

ie. limit them to the 64-bit code?

cheers
