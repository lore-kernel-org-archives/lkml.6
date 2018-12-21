Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F56C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6033D218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403891AbeLUXDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 18:03:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:53010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387417AbeLUXDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 18:03:51 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CE71218D9;
        Fri, 21 Dec 2018 23:03:50 +0000 (UTC)
Date:   Fri, 21 Dec 2018 18:03:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [for-next][PATCH 23/24] string.h: Add strncmp_prefix() helper
 macro
Message-ID: <20181221180348.766f7712@gandalf.local.home>
In-Reply-To: <CAHk-=wgSovEz3gy56q0bhOMVt9Rx5ooq97KmY=XX37_JdE+4pQ@mail.gmail.com>
References: <20181221175618.968519903@goodmis.org>
        <20181221175659.208858193@goodmis.org>
        <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
        <20181221144054.20bdeb33@gandalf.local.home>
        <CAHk-=wgSvRhj6KNRdn9gbK9RJVAswdtKSNjAxdf9O9vn04T5XQ@mail.gmail.com>
        <20181221153526.5e6055ca@gandalf.local.home>
        <CAHk-=wjtkvFUuRNZU67KccuUKYHw=pYoDMQJ_9OVDFxOwmK9zQ@mail.gmail.com>
        <20181221155513.11450ca6@gandalf.local.home>
        <CAHk-=wjaNWzXSW9XT-Z=9OF=5+2ft6UqjoUgaWeEWx8PUmS9xg@mail.gmail.com>
        <20181221174816.0ed7af47@gandalf.local.home>
        <CAHk-=wgSovEz3gy56q0bhOMVt9Rx5ooq97KmY=XX37_JdE+4pQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 14:57:13 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Dec 21, 2018 at 2:48 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >  
> > > Your patch actually had them, but in the body of your email you did
> > >  
> > > > #define have_prefix(str, prefix) ({ \
> > > >       const char *__pfx = (const char *)prefix; \  
> > >
> > > which is just completely wrong.
> > >
> > > Considering your _old_ patch had the exact same bug, I really think
> > > you need to start internalizing the whole "macro arguments *have* to
> > > be properly protected" thing.  
> >
> > Well, there's less with assignments that can go wrong than with other
> > code. That is, there's little that can happen with "int x = arg;" where
> > arg is the macro paramater to cause something really nasty.  
> 
> What's wrong, Steven?

We are miscommunicating here...

I was talking about the missing parenthesis on the original patch,
which you stated was missing as well. And the original patch didn't
have the typecast.

> 
> The assignment is entirely irrelevant.
> 
> The problem is the cast.
> 
> A type cast has a very high priority, and so if you do
> 
>     (const char *)prefix
> 
> it breaks completely if you might have something like"a+6" as the argument.
> 
> Think about what if "a" is of type "unsigned long", for example?

Yes, when writing the real code, I noticed that the typecast could
cause issues without the parenthesis, and added them.

The email you are replying to was saying there's not much that can go
wrong with:

#define MACRO(x) { \
	int __p = x; \


I definitely can see something wrong with:

#define MACRO(x) { \
	int __p = (int)x; \

because exactly what you stated.

There's nothing wrong with adding (x) for the first one, but it's
unlikely anything will cause it harm. The second one the (x) *is* most
definitely required.

This is a long winded "I agree with you" ;-)

-- Steve
