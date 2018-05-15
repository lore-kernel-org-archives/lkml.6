Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbeEOWlV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:41:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751634AbeEOWlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:41:20 -0400
Date: Tue, 15 May 2018 18:41:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, tcharding <me@tobin.cc>
Subject: Re: [PATCH] vsprintf: Fix memory barriers of ptr_key to
 have_filed_random_ptr_key
Message-ID: <20180515184117.5fb0b7fa@gandalf.local.home>
In-Reply-To: <CA+55aFztxY-w=0tPZ8KAenENA7NCYSWUcCPV4Nzs0ffwrh3G4Q@mail.gmail.com>
References: <20180515100558.21df515e@gandalf.local.home>
        <CA+55aFyBHRmXLo07f_7qt7szaDvppMStfX5Sq9Df6mZSy+qYvA@mail.gmail.com>
        <20180515145744.3bdcbbe9@gandalf.local.home>
        <CA+55aFwOoMHJaK5LmgmKKPvPUpTUBKSXS67cwaXwm2p-eG6ycQ@mail.gmail.com>
        <20180515161027.468e8975@gandalf.local.home>
        <CA+55aFztxY-w=0tPZ8KAenENA7NCYSWUcCPV4Nzs0ffwrh3G4Q@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2018 15:31:37 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > we could always do this:  
> 
> Ugh. I think I prefer the barriers.

But the ugliness is only at boot up, where the early printing is
important. The benefit of this is here:

@@ -1709,7 +1717,7 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
        unsigned long hashval;
        const int default_width = 2 * sizeof(ptr);
 
-       if (unlikely(!have_filled_random_ptr_key)) {
+       if (static_branch_unlikely(&not_filled_random_ptr_key)) {
                spec.field_width = default_width;
                /* string length must be less than default_width */
                return string(buf, end, "(ptrval)", spec);

Because not only do we not add any barriers, this code basically
becomes a nop once the ptr_key is filled, and this should have a small
speed up in execution (although I have not done any benchmarks).

-- Steve
