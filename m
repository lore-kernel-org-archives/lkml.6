Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DA4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C77208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="FgUQgKoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C77208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389862AbeKQADt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 19:03:49 -0500
Received: from a9-46.smtp-out.amazonses.com ([54.240.9.46]:56166 "EHLO
        a9-46.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727727AbeKQADt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 19:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1542376279;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=usYbOKfN2P/GqanvYtRo1vgK3cIqT07zZDpAGdpu0aQ=;
        b=FgUQgKoebQpEHj494IqY1Js1NtQ+sUo84c83SUQwUkIQByIJjAYvB7EN7Q6wJDuM
        cqymUisNjCwg2e1j6sBKLpP2N1f6vHC6AP9ElwkebPQR1ORocKSdVjl+fdyuGwwTfTE
        vtJChkEWQbLN6LL1bApvJ/Ulnox77Wg7mqVcIC28=
Date:   Fri, 16 Nov 2018 13:51:19 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: fix 'dubious: x & !y' warning from Sparse
In-Reply-To: <1542346829-31063-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <010001671cca4b8b-2333373d-6b28-44e1-bca3-24570b8e0d2b-000000@email.amazonses.com>
References: <1542346829-31063-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.11.16-54.240.9.46
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018, Masahiro Yamada wrote:

> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 918f374..d395c73 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -329,7 +329,7 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
>  	 * If an allocation is both __GFP_DMA and __GFP_RECLAIMABLE, return
>  	 * KMALLOC_DMA and effectively ignore __GFP_RECLAIMABLE
>  	 */
> -	return type_dma + (is_reclaimable & !is_dma) * KMALLOC_RECLAIM;
> +	return type_dma + (is_reclaimable && !is_dma) * KMALLOC_RECLAIM;
>  }

Ok then lets revert the initial patch whose point was to avoid a branch.
&& causes a branch again.

