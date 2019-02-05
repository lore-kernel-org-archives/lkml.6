Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F92C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624452080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PN4OZauR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfBEOoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:44:54 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42054 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfBEOoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:44:54 -0500
Received: from zn.tnic (p200300EC2BCB6B00244CCF9C8D56D337.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:6b00:244c:cf9c:8d56:d337])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2AC9B1EC056D;
        Tue,  5 Feb 2019 15:44:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549377892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZlpHSnZbHAmNeyPP2R4MuO6HoqgK7DIV3kf5lVJLKoU=;
        b=PN4OZauRg3jE8oHccsxO83PdFDJEBZEbVko/SfqOTAMtnakPZ/VI4HabJdgjG3JE/A36Ya
        5OXTk8wTqCZDaJRPZQeainzl6IrBo2PHGO9OKHVVS1miZGmYMVzacLwSQmdCyNYxC0oGwY
        xyfAjK1QdoXdpVAJKJMYk+UXtwXWdX8=
Date:   Tue, 5 Feb 2019 15:44:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Julian Stecklina <js@alien8.de>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jschoenh@amazon.de,
        Julian Stecklina <jsteckli@amazon.de>,
        Dave Jiang <dave.jiang@intel.com>,
        Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] x86/boot: increase maximum number of avoided KASLR
 regions
Message-ID: <20190205144441.GS21801@zn.tnic>
References: <1548866403-13390-1-git-send-email-js@alien8.de>
 <1548866403-13390-2-git-send-email-js@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1548866403-13390-2-git-send-email-js@alien8.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 05:40:03PM +0100, Julian Stecklina wrote:
> From: Julian Stecklina <jsteckli@amazon.de>
> 
> The boot code has a limit of 4 "non-standard" regions to avoid for
> KASLR. This limit is easy to reach when supplying memmap= parameters to
> the kernel. In this case, KASLR would be disabled.
> 
> Increase the limit to avoid turning off KASLR even when the user is
> heavily manipulating the memory map.
> 
> Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
> ---
>  arch/x86/boot/compressed/kaslr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 5657e34..f078d60 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -92,8 +92,8 @@ struct mem_vector {
>  	unsigned long long size;
>  };
>  
> -/* Only supporting at most 4 unusable memmap regions with kaslr */
> -#define MAX_MEMMAP_REGIONS	4
> +/* Only supporting at most this many unusable memmap regions with kaslr */
> +#define MAX_MEMMAP_REGIONS	16
>  
>  static bool memmap_too_large;
>  
> @@ -213,7 +213,7 @@ static void mem_avoid_memmap(char *str)
>  		i++;
>  	}
>  
> -	/* More than 4 memmaps, fail kaslr */
> +	/* Can't store all regions, fail kaslr */
>  	if ((i >= MAX_MEMMAP_REGIONS) && str)
>  		memmap_too_large = true;
>  }
> -- 

Lemme add some of the folks from
f28442497b5caf7bf573ade22a7f8d3559e3ef56 to Cc.

It all looks arbitrary to me: first 4 unusable memmap regions, this
patch raises it to 16. Why are we even imposing such a limit?

Hmm.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
