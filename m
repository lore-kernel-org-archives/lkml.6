Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7179FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 00:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41813218A3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 00:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbeLXAFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 19:05:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbeLXAFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 19:05:48 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 806A5218A1;
        Mon, 24 Dec 2018 00:05:46 +0000 (UTC)
Date:   Sun, 23 Dec 2018 19:05:44 -0500
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
Message-ID: <20181223190544.6112f598@gandalf.local.home>
In-Reply-To: <4daf3688-ea36-627a-cd8a-8f9bc6cabc56@rasmusvillemoes.dk>
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
        <20181223175621.4e4d958c@vmware.local.home>
        <4daf3688-ea36-627a-cd8a-8f9bc6cabc56@rasmusvillemoes.dk>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Dec 2018 00:52:13 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> On 23/12/2018 23.56, Steven Rostedt wrote:
> > On Sun, 23 Dec 2018 23:01:52 +0100
> > Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> >   
> >> On 21/12/2018 23.20, Joe Perches wrote:  
> >>>
> >>> Using
> >>>
> >>> static inline bool str_has_prefix(const char *str, const char prefix[])
> >>> {
> >>> 	return !strncmp(str, prefix, strlen(prefix));
> >>> }
> >>>     
> >>
> >> We already have exactly that function, it's called strstarts().  
> > 
> > It's not exact.  
> 
> Huh? The str_has_prefix() I quoted is exactly strstarts().

The the implemented str_has_prefix() that you replied to is:

+/*
+ * A common way to test a prefix of a string is to do:
+ *  strncmp(str, prefix, sizeof(prefix) - 1)
+ *
+ * But this can lead to bugs due to typos, or if prefix is a pointer
+ * and not a constant. Instead use strncmp_prefix().
+ */
+#define strncmp_prefix(str, prefix)					\
+	({								\
+		int ____strcmp_prefix_ret____;				\
+		if (__builtin_constant_p(&prefix)) {			\
+			____strcmp_prefix_ret____ =			\
+				strncmp(str, prefix, sizeof(prefix) - 1); \
+		} else {						\
+			typeof(prefix) ____strcmp_prefix____ = prefix;	\
+			____strcmp_prefix_ret____ =			\
+				strncmp(str, ____strcmp_prefix____,	\
+					strlen(____strcmp_prefix____));	\
+		}							\
+		____strcmp_prefix_ret____;				\
+	})
+

Note, this has turned into a nice function:

 http://lkml.kernel.org/r/20181222162856.518489380@goodmis.org

+/**
+ * str_has_prefix - Test if a string has a given prefix
+ * @str: The string to test
+ * @prefix: The string to see if @str starts with
+ *
+ * A common way to test a prefix of a string is to do:
+ *  strncmp(str, prefix, sizeof(prefix) - 1)
+ *
+ * But this can lead to bugs due to typos, or if prefix is a pointer
+ * and not a constant. Instead use str_has_prefix().
+ *
+ * Returns: 0 if @str does not start with @prefix
+         strlen(@prefix) if @str does start with @prefix
+ */
+static __always_inline size_t str_has_prefix(const char *str, const char *prefix)
+{
+	size_t len = strlen(prefix);
+	return strncmp(str, prefix, len) == 0 ? len : 0;
+}
+


> 
> > 
> > Well, one thing that str_has_prefix() does that strstarts() does not,
> > is to return the prefix length which gets rid of the duplication.  
> 
> I hadn't seen the patches containing that version of str_has_prefix().
> Anyway, I just wanted to point out that strstarts() exists, so that we
> at least do not add a copy of that.

That's because you didn't read the patch that you quoted, just the
change log.

> 
> > Would it be OK to convert strstarts() to return the length of prefix?  
> 
> Dunno. By far, most users of the strncmp() idiom only seem to be
> interested in the boolean result. It's true that there are some that
> then want to skip the prefix and do further parsing, and I can see how
> avoiding duplicating the prefix length is useful. But the mathematician
> in me can't help consider the corner case of 'the empty string is always
> a prefix of any other string', and having str_has_prefix(str, "") be
> false seems wrong - obviously, nobody would ever use a literal "" there,
> but nothing in str_has_prefix() _requires_ the prefix to be a constant.

Which would be a useless use case. And if you define that it returns
the length of prefix on return, then it both matches and doesn't
match ;-)

> 
> Maybe 'bool str_skip_prefix(const char *s, const char *p, const char
> **out)' where *out is set to s+len on success, and set to s on failure
> (just to allow passing &s and continue parsing in elseifs)? That would
> make your 4/5 "tracing: Have the historgram use the result of
> str_has_prefix() for len of prefix" do
> 
>   if (str_skip_prefix(str, "onmatch(", &action_str)) {
> 
> hoisting the action_str declaration to the top, replacing the len variable?
> 

The use cases I've used in the final patch series uses the len for
indexing and other cases.

I think I'm keeping the str_has_prefix() and change the other users to
use it in the kernel. Most of the git grep strstarts() is tools
and scripts anyway.

-- Steve
