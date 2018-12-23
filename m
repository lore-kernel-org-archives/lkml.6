Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C35C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 22:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26F3218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 22:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbeLWW4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 17:56:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:35864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeLWW4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 17:56:24 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62C65217D7;
        Sun, 23 Dec 2018 22:56:23 +0000 (UTC)
Date:   Sun, 23 Dec 2018 17:56:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Joe Perches <joe@perches.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [for-next][PATCH 23/24] string.h: Add strncmp_prefix() helper
 macro
Message-ID: <20181223175621.4e4d958c@vmware.local.home>
In-Reply-To: <098d7abf-5b62-6a01-a370-97d96bece299@rasmusvillemoes.dk>
References: <20181221175618.968519903@goodmis.org>
        <20181221175659.208858193@goodmis.org>
        <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
        <20181221144054.20bdeb33@gandalf.local.home>
        <CAHk-=wgSvRhj6KNRdn9gbK9RJVAswdtKSNjAxdf9O9vn04T5XQ@mail.gmail.com>
        <20181221153526.5e6055ca@gandalf.local.home>
        <077eeb8b09baebe78822819b5f15d671b738a2b2.camel@perches.com>
        <20181221155435.38a9a221@gandalf.local.home>
        <871s6ad2br.fsf@igel.home>
        <20181221160826.34c544e6@gandalf.local.home>
        <84199633fd49db573c9ba71f1992936422e907d4.camel@perches.com>
        <098d7abf-5b62-6a01-a370-97d96bece299@rasmusvillemoes.dk>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2018 23:01:52 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> On 21/12/2018 23.20, Joe Perches wrote:
> > On Fri, 2018-12-21 at 16:08 -0500, Steven Rostedt wrote:  
> >> On Fri, 21 Dec 2018 21:58:32 +0100
> >> Andreas Schwab <schwab@linux-m68k.org> wrote:
> >>
> >>  
> >>>> Well, perhaps I can just remove the ending ones. I get paranoid with
> >>>> macro variables, and tend to over do it so that there's no question.    
> >>>
> >>> Why not make it an inline function?  
> >>
> >> Matters if that removes the strlen(const) optimization. I could try it
> >> and see what happens.  
> > 
> > Using
> > 
> > static inline bool str_has_prefix(const char *str, const char prefix[])
> > {
> > 	return !strncmp(str, prefix, strlen(prefix));
> > }
> >   
> 
> We already have exactly that function, it's called strstarts().

It's not exact.

> 
> commit 66f92cf9d415e96a5bdd6c64de8dd8418595d2fc
> Author: Rusty Russell <rusty@rustcorp.com.au>
> Date:   Tue Mar 31 13:05:36 2009 -0600
> 
>     strstarts: helper function for !strncmp(str, prefix, strlen(prefix))
> 
> Please don't add a copy under another name.
> 
> As for converting existing users, go for it. FWIW, I ran a cocci script
> a few years ago to find suspicious strncmp() cases, and there were some
> (e87c3f, ca957b6), but fewer than I expected. There are some
> confused/confusing ones that apparently deliberately do strncmp(a, b,
> sizeof(b)) instead of the equivalent to strcmp(a, b) (e.g. 'strncmp(str,
> "hwc", 4) == 0')

Well, one thing that str_has_prefix() does that strstarts() does not,
is to return the prefix length which gets rid of the duplication.

Would it be OK to convert strstarts() to return the length of prefix?

-- Steve
