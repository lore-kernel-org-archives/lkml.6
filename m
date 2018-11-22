Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ACAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B301206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B301206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389279AbeKVOCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:02:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:55062 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732521AbeKVOCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:02:31 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 08802516;
        Thu, 22 Nov 2018 03:25:07 +0000 (UTC)
Date:   Wed, 21 Nov 2018 19:25:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Crt Mori <cmo@melexis.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v4 1/3] kernel.h: disable type-checks in container_of()
 for Sparse
Message-Id: <20181121192507.5199cf95fd2da9573a18ca80@linux-foundation.org>
In-Reply-To: <1542856462-18836-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542856462-18836-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 12:14:20 +0900 Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> When I tried to enable BUILD_BUG_ON for Sparse, the kbuild test robot
> reported lots of "unknown expression" warnings from container_of(),
> which seemed false positive.
> 
> I addressed this in [1], but fixing Sparse is the right thing to do.
> 
> The issue was fixed by Sparse commit 0eb8175d3e9c ("fix expansion of
> function designator"), but it will take time until the fixed version
> of Sparse is widely available.
> 
> Disable the container_of() type checks for Sparse for now.
> 
> [1] https://lore.kernel.org/lkml/1542623503-3755-1-git-send-email-yamada.masahiro@socionext.com/
> 
> ...
>
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -985,6 +985,21 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
>  #define __CONCAT(a, b) a ## b
>  #define CONCATENATE(a, b) __CONCAT(a, b)
>  
> +/*
> + * TODO:
> + * Sparse emits "unknown expression" warnings.
> + * It was fixed by commit 0eb8175d3e9c0d20354763d07ce3d4c0e543d988 in Sparse.
> + * Remove the following workaround when the fixed Sparse is widely available.
> + */
> +#ifdef __CHECKER__
> +#define TYPE_CHECK_CONTAINER_OF(ptr, type, member)	do {} while (0)
> +#else
> +#define TYPE_CHECK_CONTAINER_OF(ptr, type, member) \
> +	BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&	\
> +			 !__same_type(*(ptr), void),			\
> +			 "pointer type mismatch in container_of()")
> +#endif

I think that's OK.  A few years hence, someone will happen upon this
comment and will perform the obvious cleanup.

