Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32115C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFC621929
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391868AbeLUUyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:54:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:60040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730307AbeLUUyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:54:38 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B8F121929;
        Fri, 21 Dec 2018 20:54:37 +0000 (UTC)
Date:   Fri, 21 Dec 2018 15:54:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [for-next][PATCH 23/24] string.h: Add strncmp_prefix() helper
 macro
Message-ID: <20181221155435.38a9a221@gandalf.local.home>
In-Reply-To: <077eeb8b09baebe78822819b5f15d671b738a2b2.camel@perches.com>
References: <20181221175618.968519903@goodmis.org>
        <20181221175659.208858193@goodmis.org>
        <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
        <20181221144054.20bdeb33@gandalf.local.home>
        <CAHk-=wgSvRhj6KNRdn9gbK9RJVAswdtKSNjAxdf9O9vn04T5XQ@mail.gmail.com>
        <20181221153526.5e6055ca@gandalf.local.home>
        <077eeb8b09baebe78822819b5f15d671b738a2b2.camel@perches.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 12:46:47 -0800
Joe Perches <joe@perches.com> wrote:


> > @@ -14,6 +14,28 @@ extern void *memdup_user(const void __user *, size_t);
> >  extern void *vmemdup_user(const void __user *, size_t);
> >  extern void *memdup_user_nul(const void __user *, size_t);
> >  
> > +/**
> > + * have_prefix - Test if a string has a given prefix  
> 
> There is a naming mismatch of have/has here
> and has_prefix is probably too generic a name.
> 
> How about str_has_prefix?

Sure.

> 
> > + * @str: The string to test
> > + * @prefix: The string to see if @str starts with
> > + *
> > + * A common way to test a prefix of a string is to do:
> > + *  strncmp(str, prefix, sizeof(prefix) - 1)
> > + *
> > + * But this can lead to bugs due to typos, or if prefix is a pointer
> > + * and not a constant. Instead use has_prefix().
> > + *
> > + * Returns: 0 if @str does not start with @prefix
> > +         strlen(@prefix) if @str does start with @prefix
> > + */
> > +#define has_prefix(str, prefix)						\
> > +	({								\
> > +		const char *____prefix____ = (const char *)(prefix);	\
> > +		int ____len____ = strlen(____prefix____);		\
> > +		strncmp(str, ____prefix____, ____len____) == 0 ?	\
> > +			____len____ : 0;				\
> > +	})   
> 
> I think all the underscores are unnecessary and confusing.
> 

Well, perhaps I can just remove the ending ones. I get paranoid with
macro variables, and tend to over do it so that there's no question.

I don't find them confusing ;-)  But I tend to use a lot of macros.

-- Steve
