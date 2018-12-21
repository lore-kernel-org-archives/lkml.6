Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D81AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE63E21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390543AbeLUUqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:46:52 -0500
Received: from smtprelay0105.hostedemail.com ([216.40.44.105]:60454 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731379AbeLUUqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:46:52 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id C8BEE21FA;
        Fri, 21 Dec 2018 20:46:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: coach68_1e6f4544b801b
X-Filterd-Recvd-Size: 3099
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Dec 2018 20:46:49 +0000 (UTC)
Message-ID: <077eeb8b09baebe78822819b5f15d671b738a2b2.camel@perches.com>
Subject: Re: [for-next][PATCH 23/24] string.h: Add strncmp_prefix() helper
 macro
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Fri, 21 Dec 2018 12:46:47 -0800
In-Reply-To: <20181221153526.5e6055ca@gandalf.local.home>
References: <20181221175618.968519903@goodmis.org>
         <20181221175659.208858193@goodmis.org>
         <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
         <20181221144054.20bdeb33@gandalf.local.home>
         <CAHk-=wgSvRhj6KNRdn9gbK9RJVAswdtKSNjAxdf9O9vn04T5XQ@mail.gmail.com>
         <20181221153526.5e6055ca@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-21 at 15:35 -0500, Steven Rostedt wrote:
> At first I thought this would have issues, but with a slight change...
> 
> #define have_prefix(str, prefix) ({ \
> 	const char *__pfx = (const char *)prefix; \
> 
> 
> And the rest the same, it appears to work.
> 
> Need the cast because if for some reason someone passed in something
> like "const unsigned char" then it wouldn't work. But that's just a nit.
> 
> So something like this then?
> 
> -- Steve
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
[]
> @@ -14,6 +14,28 @@ extern void *memdup_user(const void __user *, size_t);
>  extern void *vmemdup_user(const void __user *, size_t);
>  extern void *memdup_user_nul(const void __user *, size_t);
>  
> +/**
> + * have_prefix - Test if a string has a given prefix

There is a naming mismatch of have/has here
and has_prefix is probably too generic a name.

How about str_has_prefix?

> + * @str: The string to test
> + * @prefix: The string to see if @str starts with
> + *
> + * A common way to test a prefix of a string is to do:
> + *  strncmp(str, prefix, sizeof(prefix) - 1)
> + *
> + * But this can lead to bugs due to typos, or if prefix is a pointer
> + * and not a constant. Instead use has_prefix().
> + *
> + * Returns: 0 if @str does not start with @prefix
> +         strlen(@prefix) if @str does start with @prefix
> + */
> +#define has_prefix(str, prefix)						\
> +	({								\
> +		const char *____prefix____ = (const char *)(prefix);	\
> +		int ____len____ = strlen(____prefix____);		\
> +		strncmp(str, ____prefix____, ____len____) == 0 ?	\
> +			____len____ : 0;				\
> +	}) 

I think all the underscores are unnecessary and confusing.


