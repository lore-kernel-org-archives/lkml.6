Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754833AbeD3QLU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:11:20 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:42915 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754809AbeD3QLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:11:19 -0400
X-Google-Smtp-Source: AB8JxZp67rEsbDfoHDF7lEajTGaNA3tXpQXf3k56RabNYAMAm+gaHz0dK7roZznDp8QFrPnTuy55NSo3v1xjvFOZgZw=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1804301741570.3243@hypnos.tec.linutronix.de>
References: <alpine.DEB.2.20.1804301741570.3243@hypnos.tec.linutronix.de>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 30 Apr 2018 09:11:17 -0700
X-Google-Sender-Auth: 5yJKua-LNYgDoqyx0qOXsrUgh54
Message-ID: <CAGXu5jL1W=AC023asgeMRUXAnhU2vd-RJRqGtOOetQ=aXwDcFQ@mail.gmail.com>
Subject: Re: Hashed pointer issues
To: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C. Harding" <me@tobin.cc>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 8:50 AM, Anna-Maria Gleixner
<anna-maria@linutronix.de> wrote:
> Hi,
>
> I stumbled over an issue with hashed pointers and tracing.
>
> I'm using trace points for examination and on error the trace buffers
> are dumped. The error occurs when entropy has not been set up, so the
> pointers are not hashed and only (ptrval) is printed instead. The
> pointers are required to distinguish the different objects in the
> trace.
>
> Beside workarounds like patching lib/vsprintf.c helpers before testing
> or dumping trace buffers later (given that kernel comes up properly
> and entropy is set up), is there a possible generic solution for this
> issue? A commandline option for disabling the pointer obfuscation
> would be a pretty handy tool.

I (or other folks?) had proposed this before, but, AIUI, Linus remains
opposed. I still think something like this would be useful:

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 30c0cb8cc9bc..22bf631395d1 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1703,12 +1703,27 @@ static int __init initialize_ptr_random(void)
 }
 early_initcall(initialize_ptr_random);

+static bool bypass_pointer_hashing __ro_after_init;
+
+static int __init early_bypass_pointer_hashing_param(char *buf)
+{
+       if (!buf)
+               return -EINVAL;
+       return strtobool(buf, &bypass_pointer_hashing);
+}
+early_param("bypass_pointer_hashing", early_bypass_pointer_hashing_param);
+
 /* Maps a pointer to a 32 bit unique identifier. */
 static char *ptr_to_id(char *buf, char *end, void *ptr, struct
printf_spec spec)
 {
        unsigned long hashval;
        const int default_width = 2 * sizeof(ptr);

+       if (unlikely(bypass_pointer_hashing)) {
+               hashval = (uintptr_t)ptr;
+               goto bypass;
+       }
+
        if (unlikely(!have_filled_random_ptr_key)) {
                spec.field_width = default_width;
                /* string length must be less than default_width */
@@ -1726,6 +1741,7 @@ static char *ptr_to_id(char *buf, char *end,
void *ptr, struct printf_spec spec)
        hashval = (unsigned long)siphash_1u32((u32)ptr, &ptr_key);
 #endif

+bypass:
        spec.flags |= SMALL;
        if (spec.field_width == -1) {
                spec.field_width = default_width;


(apologies for gmail-induced whitespace damage...)

-- 
Kees Cook
Pixel Security
