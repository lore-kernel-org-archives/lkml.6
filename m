Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE661C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844BA21773
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390433AbeLUUfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:35:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732146AbeLUUfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:35:30 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8016A21773;
        Fri, 21 Dec 2018 20:35:28 +0000 (UTC)
Date:   Fri, 21 Dec 2018 15:35:26 -0500
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
Message-ID: <20181221153526.5e6055ca@gandalf.local.home>
In-Reply-To: <CAHk-=wgSvRhj6KNRdn9gbK9RJVAswdtKSNjAxdf9O9vn04T5XQ@mail.gmail.com>
References: <20181221175618.968519903@goodmis.org>
        <20181221175659.208858193@goodmis.org>
        <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
        <20181221144054.20bdeb33@gandalf.local.home>
        <CAHk-=wgSvRhj6KNRdn9gbK9RJVAswdtKSNjAxdf9O9vn04T5XQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 12:01:48 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Dec 21, 2018 at 11:40 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > OK, what about if we just use strlen() and say that this macro is not
> > safe for parameters with side effects.  
> 
> I think gcc follows simple assignments just fine, and does the
> optimized strlen() for them too.
> 
> So why not just do
> 
>    #define have_prefix(str,prefix) ({ \
>         const char *__pfx = prefix; \
>         size_t __pfxlen = strlen(__pfx); \
>         strncmp(str, __pfx, __pfxlen) ? 0 : __pfxlen); })
> 
> and be done with it safely?
> 
> The above is ENTIRELY untested.
>

At first I thought this would have issues, but with a slight change...

#define have_prefix(str, prefix) ({ \
	const char *__pfx = (const char *)prefix; \


And the rest the same, it appears to work.

Need the cast because if for some reason someone passed in something
like "const unsigned char" then it wouldn't work. But that's just a nit.

So something like this then?

-- Steve

diff --git a/include/linux/string.h b/include/linux/string.h
index 27d0482e5e05..4586fee60194 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -14,6 +14,28 @@ extern void *memdup_user(const void __user *, size_t);
 extern void *vmemdup_user(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
+/**
+ * have_prefix - Test if a string has a given prefix
+ * @str: The string to test
+ * @prefix: The string to see if @str starts with
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
+		const char *____prefix____ = (const char *)(prefix);	\
+		int ____len____ = strlen(____prefix____);		\
+		strncmp(str, ____prefix____, ____len____) == 0 ?	\
+			____len____ : 0;				\
+	})
+
 /*
  * Include machine specific inline routines
  */
