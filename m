Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB64C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924E020863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfBHRLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:11:23 -0500
Received: from smtprelay0176.hostedemail.com ([216.40.44.176]:39162 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726522AbfBHRLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:11:22 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 68FEB181D341D;
        Fri,  8 Feb 2019 17:11:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: books23_7ff9cc438be45
X-Filterd-Recvd-Size: 2659
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri,  8 Feb 2019 17:11:19 +0000 (UTC)
Message-ID: <f308ab312810d538a79c2f54f49edba32c60b561.camel@perches.com>
Subject: Re: [PATCH v6 5/9] vsprintf: Factor out %pV handler as va_format()
From:   Joe Perches <joe@perches.com>
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 08 Feb 2019 09:11:17 -0800
In-Reply-To: <20190208152310.29531-6-pmladek@suse.com>
References: <20190208152310.29531-1-pmladek@suse.com>
         <20190208152310.29531-6-pmladek@suse.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-08 at 16:23 +0100, Petr Mladek wrote:
> Move the code from the long pointer() function. We are going to improve
> error handling that will make it more complicated.
> 
> This patch does not change the existing behavior.

But doesn't this increase stack use?
%pV is recursive and increasing the stack is undesired
for this use.

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
[]
> @@ -1519,6 +1519,17 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
>  	return buf;
>  }
>  
> +static char *va_format(char *buf, char *end, struct va_format *va_fmt)
> +{
> +	va_list va;
> +
> +	va_copy(va, *va_fmt->va);
> +	buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
> +	va_end(va);
> +
> +	return buf;
> +}
> +
>  static noinline_for_stack
>  char *uuid_string(char *buf, char *end, const u8 *addr,
>  		  struct printf_spec spec, const char *fmt)
> @@ -2046,15 +2057,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  	case 'U':
>  		return uuid_string(buf, end, ptr, spec, fmt);
>  	case 'V':
> -		{
> -			va_list va;
> -
> -			va_copy(va, *((struct va_format *)ptr)->va);
> -			buf += vsnprintf(buf, end > buf ? end - buf : 0,
> -					 ((struct va_format *)ptr)->fmt, va);
> -			va_end(va);
> -			return buf;
> -		}
> +		return va_format(buf, end, ptr);
>  	case 'K':
>  		return restricted_pointer(buf, end, ptr, spec);
>  	case 'N':

