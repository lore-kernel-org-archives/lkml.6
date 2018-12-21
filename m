Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048ACC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C851221927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391741AbeLUTk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:40:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:33108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389698AbeLUTk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:40:57 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD11E21927;
        Fri, 21 Dec 2018 19:40:55 +0000 (UTC)
Date:   Fri, 21 Dec 2018 14:40:54 -0500
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
Message-ID: <20181221144054.20bdeb33@gandalf.local.home>
In-Reply-To: <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
References: <20181221175618.968519903@goodmis.org>
 <20181221175659.208858193@goodmis.org>
 <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 10:51:29 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Dec 21, 2018 at 9:57 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I figured the best thing to do is to create a helper macro and place it
> > into include/linux/string.h. And go around and fix all the open coded
> > versions of it later.
> >
> > I plan on only applying this patch and updating the tracing hooks for
> > this merge window. And perhaps use it to fix some of the bugs that were
> > found.  
> 
> I like the helper function concept, but as they say about CS: "There
> is only one hard problem in computer science: naming and off-by-one
> errors".
> 
> And this one has that problem. The name makes absolutely no sense.

Good thing I rebased and put these patches at the end before running
my tests :-) (Specifically because I was expecting to have feedback like
this).

> 
> Calling it "strncmp_prefix()" when there is no "n" there makes no sense.
> 
> So drop the "n" from the name.

I originally did that, but then I thought strcmp() is a full compare,
and 'n' denotes it is partial. But thinking about it more, yeah one
would think it would need a parameter to represent 'n'.

> 
> And honestly, maybe it would be better to use a different naming
> pattern entirely, and avoid the crazy non-boolean "str*cmp()" model.
> That thing is useful for search comparisons (where "before/after"
> matters), but it's horrible for the actual "is this true or not",
> where the code ends up being
> 
>         if (!strcmp_prefix(a, "prefix")) {
>                 // This is the "Yes, prefix matched" case, despite the
> "if !" syntax
> 
> which is just confusing.
> 
> So I'd really prefer more of a
> 
>         #define has_prefix(str, prefix) ...

I like changing the name.

> 
> model that actually returns a boolean (true if it has a prefix, false
> if it doesn't), rather than use the "str*cmp" naming and return
> values.

Actually, instead of returning a bool, it can return the length if it
matches.

Reason being, there's several locations that does something like:

	while (...) {
		len = strlen("const");
		if (strncmp(str, "const", len) == 0) {
			str += len;
			break;
		}
	}

And I was having trouble thinking about how to deal with these. But if
we have a has_prefix() that returns the length on match then we can do:

	if ((len = has_prefix(str, "const")) {
		str += len;



> 
> (But I agree that *if* you use the "strcmp" naming, then you do need
> to hold to the traditional strcmp return value semantics).
> 
> Hmm?
> 
> Finally, I also suspect that your helper might be slightly fragile.
> Doing sizeof() seems broken. I could see somebody using some prefix
> define for arrays with constant sizes, and doing
> 
>    #define PFX1 "cpp\0"
>    #define PFX2 "c\0\0\0"
>    #define PFX3 "h\0\0\0"
> 
> or similar. Also, is there a reason you use "&prefix" for the constant

That was left over in my original tests in userspace. When I first
tried it with __builtin_constant_p() I got an error, and added the '&',
but then fixed something else. The something else was what actually
caused the error, but since it didn't complain (and past all my tests),
I left in the '&'.

> test? I don't see that pattern anywhere else. Plus it looks entirely
> wrong without the parenthesis (ie "&(prefix)" to make sure we group
> things right).
> 
> So a lot of small problems, but the naming one is big.

OK, what about if we just use strlen() and say that this macro is not
safe for parameters with side effects.

-- Steve

diff --git a/include/linux/string.h b/include/linux/string.h
index 27d0482e5e05..f9d274a81276 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -14,6 +14,29 @@ extern void *memdup_user(const void __user *, size_t);
 extern void *vmemdup_user(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
+/**
+ * have_prefix - Test if a string has a given prefix
+ * @str: The string to test
+ * @prefix: The string to see if @str starts with
+ *
+ * IMPORTANT; @prefix must not have side effects (used more than once here)
+ *
+ * A common way to test a prefix of a string is to do:
+ *  strncmp(str, prefix, sizeof(prefix) - 1)
+ *
+ * But this can lead to bugs due to typos, or if prefix is a pointer
+ * and not a constant. Instead use has_prefix().
+ *
+ * Returns: 0 if @str does not start with @prefix
+         strlen(@prefix) if @str does start with @prefix
+ */
+#define has_prefix(str, prefix)						\
+	({								\
+		int ____strcmp_prefix_len____ = strlen(prefix);		\
+		strncmp(str, prefix, ____strcmp_prefix_len____) == 0 ?	\
+			____strcmp_prefix_len____ : 0;			\
+	})
+
 /*
  * Include machine specific inline routines
  */
