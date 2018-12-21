Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FD5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAA121928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392195AbeLUWsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:48:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:41794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbeLUWsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:48:20 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AE3621928;
        Fri, 21 Dec 2018 22:48:18 +0000 (UTC)
Date:   Fri, 21 Dec 2018 17:48:16 -0500
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
Message-ID: <20181221174816.0ed7af47@gandalf.local.home>
In-Reply-To: <CAHk-=wjaNWzXSW9XT-Z=9OF=5+2ft6UqjoUgaWeEWx8PUmS9xg@mail.gmail.com>
References: <20181221175618.968519903@goodmis.org>
        <20181221175659.208858193@goodmis.org>
        <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
        <20181221144054.20bdeb33@gandalf.local.home>
        <CAHk-=wgSvRhj6KNRdn9gbK9RJVAswdtKSNjAxdf9O9vn04T5XQ@mail.gmail.com>
        <20181221153526.5e6055ca@gandalf.local.home>
        <CAHk-=wjtkvFUuRNZU67KccuUKYHw=pYoDMQJ_9OVDFxOwmK9zQ@mail.gmail.com>
        <20181221155513.11450ca6@gandalf.local.home>
        <CAHk-=wjaNWzXSW9XT-Z=9OF=5+2ft6UqjoUgaWeEWx8PUmS9xg@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 14:08:11 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Dec 21, 2018 at 12:55 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Fri, 21 Dec 2018 12:41:17 -0800
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >  
> > > Parentheses....  
> >
> > ?  
> 
> Your patch actually had them, but in the body of your email you did
> 
> > #define have_prefix(str, prefix) ({ \
> >       const char *__pfx = (const char *)prefix; \  
> 
> which is just completely wrong.
> 
> Considering your _old_ patch had the exact same bug, I really think
> you need to start internalizing the whole "macro arguments *have* to
> be properly protected" thing.

Well, there's less with assignments that can go wrong than with other
code. That is, there's little that can happen with "int x = arg;" where
arg is the macro paramater to cause something really nasty. The chances
of that happening is up there with using only two underscores causing an
issue.

But they don't hurt to add.

> 
> And I agree with Joe that using a million underscores just makes code
> less legible. Two underscores at the beginning is the standard
> namespace protection. Underscores at the end do nothing. And using
> *more* than two is just crazy.

The two are standard for static variables in C code, but that makes me
worry about macros. I usually do at least three for macros. The
underscores at the end, to me, make it more balanced and easier to read:

	strncmp(str, ___prefix___, ___len___);

To me looks better than:

	strncmp(str, ___prefix, ___len);

But again, no reason to fight this bikeshed.

> 
> Finally, I think the cast is actually bogus and wrong. Why would the
> prefix ever be anything but "const char *"? Adding the cast only makes
> it more possible that somebody uses a truly wrong type ("unsigned long
> *" ?), and then the cast just silently hides it.

Actually after I sent the email, I was thinking the same thing, that
the original strncmp() would probably complain about that too, and we
should keep it the same. Not sure why I even suggested that. Perhaps, I
tested too many use cases :-/

> 
> If somebody uses "unsigned char *" for this, they'd get the exact same
> warning if they were using strncmp and do this by hand.
> 
> So why would that helper function act any differently? Particularly
> when it then has the huge downside that it will also accept absolute
> garbage?
> 
> Anyway, that was a long and winding NAK for your patch.


But after all that and said. I tested it as a static __always_inline,
and guess what. It also optimizes out the strlen() for constants!!!

Suggested-by: Andreas Schwab <schwab@linux-m68k.org>

-- Steve

diff --git a/include/linux/string.h b/include/linux/string.h
index 27d0482e5e05..538469dfb458 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -456,4 +456,25 @@ static inline void memcpy_and_pad(void *dest, size_t dest_len,
 		memcpy(dest, src, dest_len);
 }
 
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
+static __always_inline int str_has_prefix(const char *str, const char *prefix)
+{
+	int len = strlen(prefix);
+
+	return strncmp(str, prefix, len) == 0 ? len : 0;
+}
+
 #endif /* _LINUX_STRING_H_ */
