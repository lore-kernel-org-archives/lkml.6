Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeDOMWF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 08:22:05 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:7268 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752277AbeDOMWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 08:22:04 -0400
X-IronPort-AV: E=Sophos;i="5.48,454,1517871600";
   d="scan'208";a="322925558"
Date: Sun, 15 Apr 2018 14:22:01 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Daniel Santos <daniel.santos@pobox.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: BUILD_BUG_ON_MSG
In-Reply-To: <9f2e95dc-6f8e-0adc-50d9-578f1077722d@pobox.com>
Message-ID: <alpine.DEB.2.20.1804151410480.8462@hadrien>
References: <alpine.DEB.2.20.1804150736110.2673@hadrien> <9f2e95dc-6f8e-0adc-50d9-578f1077722d@pobox.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-82193140-1523794922=:8462"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8323329-82193140-1523794922=:8462
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 15 Apr 2018, Daniel Santos wrote:

> Hello Julia,
>
> I'm CCing LKML on this so that others can be involved.
>
>
> On 04/15/2018 12:43 AM, Julia Lawall wrote:
> > Hello,
> >
> > I saw that you introduced BUILD_BUG_ON_MSG in the Linux kernel a few years
> > ago.
> >
> > BUILD_BUG_ON_MSG is not safe when used in header files.  Via
> > compiletime_assert, it makes a new function whose name is only determined
> > by a line number.  When BUILD_BUG_ON_MSG is used in header files,
> > multiple uses may end up at the same line, in different header files.  The
> > reported errors are then quite confusing; I guess the last function with
> > the given name is used.
>
> Yes, This is an unfortunate side-effect of the implementation, since
> "error" and "warning" are function attributes.  This issue was discussed
> during review and it was decided that one should simply not use more
> than one of such macro on the same line in an implementation file.  I
> had thought we added a "don't use more than once per line" in the
> documentation for these macros, but I'm not seeing it right now -- if
> it's really missing then we probably want to add it.

The problem is not multiple calls on the same line.  The problem is that
every header file has eg a line 1, line 2, etc.  __LINE__ gives the line
number in the header file, and not in the result of expanding the header
file.  This line may be the same as the line in some other header file
that also has a BUILD_BUG_ON_MSG.

>
> >
> > I tried incorporating __func__, but for some reason it didn't expand into
> > anything.  Perhaps I used it incorrectly in some way.
>
> Neither __func__ nor __FUNCTION__ are cpp macros, they are just static
> const char arrays (see
> https://gcc.gnu.org/onlinedocs/gcc/Function-Names.html).  For some
> reason I recall believing that __PRETTY_FUNCTION__ *is* a cpp macro, but
> I'm probably wrong, and even if it was it wouldn't be a valid function
> prefix.
>
> > If it is not
> > possible to get the name of the enclosing function, would it be reasonable
> > to make a new kind of BUILD_BUG_ON call that takes an extra argument that
> > can be used in the function name to make it unique?
> >
> > thanks,
> > julia
> >
> You're still going to need the function name as a cpp macro.  If you
> have that, you can just expand _compiletime_assert() directly.  Please
> post your code when sending an inquiry like this -- it makes it easier
> for others to help you and we don't have to waste as much time trying to
> figure out exactly what you might be doing and how.

Here are the adjustments I made for myself; obviously the names are not
ideal:

diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
index 43d1fd5..43d6f67 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -43,6 +43,7 @@
  * See BUILD_BUG_ON for description.
  */
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
+#define MY_BUILD_BUG_ON_MSG(cond, tok, msg) my_compiletime_assert(!(cond), tok, msg)

 /**
  * BUILD_BUG_ON - break compile if a condition is true.
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index ab4711c..bb19c7a 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -338,6 +350,9 @@ unsigned long read_word_at_a_time(const void *addr)
 #define compiletime_assert(condition, msg) \
 	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)

+#define my_compiletime_assert(condition, tok, msg) \
+	_compiletime_assert(condition, msg, tok ## __my_compiletime_assert_, __LINE__)
+
 #define compiletime_assert_atomic_type(t)				\
 	compiletime_assert(__native_word(t),				\
 		"Need native word sized stores/loads for atomicity.")

Then my uses would be eg

MY_BUILD_BUG_ON_MSG(cond1, callsite, "condition 1 holds");
MY_BUILD_BUG_ON_MSG(cond2, callsite, "condition 2 holds");
etc.

thanks,
julia


> I don't remember if
> doing this inside of an always_inline function (instead of a macro
> expansion) works or not.
>
> For a long time I've considered the merits of directly adding a gcc
> extension to perform these checks without all of these side effects and
> the lengthy macro expansion backtrace, which is also an ugly artifact of
> this mechanism.  In fact, I was really disappointed with C11's
> _Static_assert because I at first thought it was a generic solution, but
> then came to find out otherwise.
>
> IMO, the ideal mechanism would behave more like MAYBE_BUILD_BUG_ON, but
> without all of the cpp fluff currently required.  Does anybody know if
> this has been proposed or a gcc feature request filed for this yet?
>
> Daniel
>
>
>
--8323329-82193140-1523794922=:8462--
