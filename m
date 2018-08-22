Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8566AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3FB214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3FB214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbeHVOc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:32:26 -0400
Received: from smtprelay0228.hostedemail.com ([216.40.44.228]:50256 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728603AbeHVOc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:32:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E3CE918224D97;
        Wed, 22 Aug 2018 11:07:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rail77_b529d0c9c961
X-Filterd-Recvd-Size: 2044
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 Aug 2018 11:07:57 +0000 (UTC)
Message-ID: <e28ec4d435200be4d10dc76b17e6a4af0d71b77e.camel@perches.com>
Subject: Re: [PATCH 1/4] string: try to find const-laundering bugs
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-nfs@vger.kernel.org
Date:   Wed, 22 Aug 2018 04:07:56 -0700
In-Reply-To: <20180822110009.17583-1-linux@rasmusvillemoes.dk>
References: <20180822110009.17583-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-22 at 13:00 +0200, Rasmus Villemoes wrote:
> This wraps strchr and friends in macros that ensure the return value has
> type const char* if the passed-in string (which the return value points
> into) also has type const char*. The (s)+0 thing is to force a const
> char[] (e.g. a string literal) to decay to a const char* for the
> __same_type comparison.
[]
> diff --git a/include/linux/string.h b/include/linux/string.h
[]
> +#define strchr(s, c) (						  \
> +	__builtin_choose_expr(__same_type((s) + 0, const char *), \
> +			      (const char *)strchr(s, c),	  \
> +			      strchr(s, c)))
> +#endif
[]
> diff --git a/lib/string.c b/lib/string.c
[]
> @@ -367,7 +367,7 @@ EXPORT_SYMBOL(strncmp);
>   * @s: The string to be searched
>   * @c: The character to search for
>   */
> -char *strchr(const char *s, int c)
> +char *(strchr)(const char *s, int c)

I've tried to use this macro/function wrapping
a few times before, but it seems that it's fairly
unusual in the kernel.  I believe there may not
be any current uses of that style.

A comment explaining the form might be useful.

