Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754234AbeD3TBC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 15:01:02 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:33219 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752534AbeD3TBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 15:01:00 -0400
X-Google-Smtp-Source: AB8JxZqQmEkSQuqiD5nfYXs2W2W0afwpfwO4jzPjK5y0odVKeke0GvnMvLvAd6nBzbviWhiTVQG2gzraruhihuKzWk0=
MIME-Version: 1.0
References: <alpine.DEB.2.20.1804301741570.3243@hypnos.tec.linutronix.de>
 <CAGXu5jL1W=AC023asgeMRUXAnhU2vd-RJRqGtOOetQ=aXwDcFQ@mail.gmail.com>
 <CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com>
 <20180430124135.0cce92e3@gandalf.local.home> <CA+55aFzpJC4+tuSopeze72D2sv1urGdap8+Bj2Y9hEYitAkE4Q@mail.gmail.com>
 <CA+55aFyNqnrM=_5pMgEeL20jVKN7MgWKG52pbaR0FayO=5VuXw@mail.gmail.com> <CAGXu5jLVJxDJcbhrQU5-wduaP+OvePXP8VvCFMrJ47pYD-zaXg@mail.gmail.com>
In-Reply-To: <CAGXu5jLVJxDJcbhrQU5-wduaP+OvePXP8VvCFMrJ47pYD-zaXg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Apr 2018 19:00:49 +0000
Message-ID: <CA+55aFyreOY8uzOkkDkU=WttNfbH2_6nStfsm9j2T6F5ZyntHg@mail.gmail.com>
Subject: Re: Hashed pointer issues
To: Kees Cook <keescook@chromium.org>
Cc: tcharding <me@tobin.cc>, Steven Rostedt <rostedt@goodmis.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 11:38 AM Kees Cook <keescook@chromium.org> wrote:

> Something like this? (Untested.)

Looks workable.

> +       /* If we have hw RNG, start hashing immediately. */
> +       if (arch_has_random()) {
> +               get_random_bytes_arch(&ptr_key, sizeof(ptr_key));
> +               ptr_key_ready();
> +               return 0;
> +       }

Small tweak: you should check the return value of get_random_bytes_arch(),
because in theory it can fail.

Sadly, that's not actually how get_random_bytes_arch() really works - it
falls back on "get_random_bytes()" on failure instead, which is explicitly
against the whole point here.

So I think it would need some tweaking, with a new function entirely
(get_random_bytes_arch() with a failure return for "cannot fill buffer").

But that would be just a few more lines, because we could make the existing
get_random_bytes_arch() just use the failure-case thing.

So add a "get_hw_random_bytes()" that does that same loop in
get_random_bytes_arch(), but returns the number of bytes it filled in.

Then get_random_bytes_arch() turns into

     got = get_hw_random_bytes(p, nbytes);
     if (got < nbytes)
         get_random_bytes(p+got, nbytes-got);

and the initialize_ptr_random() use would be something like

     if (get_hw_random_bytes(&ptr_key, sizeof(ptr_key)) == sizeof(ptr_key)) {
         ptr_key_ready();
         return 0;
    }

Hmm?

Maybe we could call the "get_hw_random_bytes()" something like
"get_early_random_bytes()" and the "use HW for it" is purely an
implementation detail?

                Linus
