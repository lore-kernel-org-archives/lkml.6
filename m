Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5451316256F0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1110020870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1110020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbeG3SFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:05:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41502 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeG3SFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:05:14 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KDLgMYo83hC0; Mon, 30 Jul 2018 18:29:28 +0200 (CEST)
Received: from nazgul.tnic (95-42-131-245.ip.btc-net.bg [95.42.131.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 534551EC00F4;
        Mon, 30 Jul 2018 18:29:28 +0200 (CEST)
Date:   Mon, 30 Jul 2018 18:29:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Cannon Matthews <cannonmatthews@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andres Lagar-Cavilla <andreslc@google.com>,
        Salman Qazi <sqazi@google.com>, Paul Turner <pjt@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Alain Trinh <nullptr@google.com>
Subject: Re: [PATCH v2] RFC: clear 1G pages with streaming stores on x86
Message-ID: <20180730162926.GD11890@nazgul.tnic>
References: <20180724210923.GA20168@bombadil.infradead.org>
 <20180725023728.44630-1-cannonmatthews@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180725023728.44630-1-cannonmatthews@google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 07:37:28PM -0700, Cannon Matthews wrote:
> diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
> index 88acd349911b..81a39804ac72 100644
> --- a/arch/x86/lib/clear_page_64.S
> +++ b/arch/x86/lib/clear_page_64.S
> @@ -49,3 +49,23 @@ ENTRY(clear_page_erms)
>  	ret
>  ENDPROC(clear_page_erms)
>  EXPORT_SYMBOL_GPL(clear_page_erms)
> +
> +/*
> + * Zero memory using non temporal stores, bypassing the cache.
> + * Requires an `sfence` (wmb()) afterwards.
> + * %rdi - destination.
> + * %rsi - page size. Must be 64 bit aligned.
> +*/
> +ENTRY(__clear_page_nt)
> +	leaq	(%rdi,%rsi), %rdx
> +	xorl	%eax, %eax
> +	.p2align 4,,10
> +	.p2align 3
> +.L2:
> +	movnti	%rax, (%rdi)
> +	addq	$8, %rdi
> +	cmpq	%rdx, %rdi
> +	jne	.L2
> +	ret
> +ENDPROC(__clear_page_nt)
> +EXPORT_SYMBOL(__clear_page_nt)

EXPORT_SYMBOL_GPL like the other functions in that file.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
