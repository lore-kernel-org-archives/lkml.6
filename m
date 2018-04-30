Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754752AbeD3TQs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 15:16:48 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:43377 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753522AbeD3TQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 15:16:46 -0400
X-Google-Smtp-Source: AB8JxZqXlYf5dwgL78PYRo2N0SGH1f+CoFR1epVMwjv7Kkga8YfRQOiIX+0YGR5IdEyDr/sXEC0Fjpbmah1kk+g06B0=
MIME-Version: 1.0
In-Reply-To: <CA+55aFyreOY8uzOkkDkU=WttNfbH2_6nStfsm9j2T6F5ZyntHg@mail.gmail.com>
References: <alpine.DEB.2.20.1804301741570.3243@hypnos.tec.linutronix.de>
 <CAGXu5jL1W=AC023asgeMRUXAnhU2vd-RJRqGtOOetQ=aXwDcFQ@mail.gmail.com>
 <CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com>
 <20180430124135.0cce92e3@gandalf.local.home> <CA+55aFzpJC4+tuSopeze72D2sv1urGdap8+Bj2Y9hEYitAkE4Q@mail.gmail.com>
 <CA+55aFyNqnrM=_5pMgEeL20jVKN7MgWKG52pbaR0FayO=5VuXw@mail.gmail.com>
 <CAGXu5jLVJxDJcbhrQU5-wduaP+OvePXP8VvCFMrJ47pYD-zaXg@mail.gmail.com> <CA+55aFyreOY8uzOkkDkU=WttNfbH2_6nStfsm9j2T6F5ZyntHg@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 30 Apr 2018 12:16:45 -0700
X-Google-Sender-Auth: lZasT2WGEPl5k-ywLeLuVWu37A8
Message-ID: <CAGXu5jKbagUs7cS5y6zRQkgiA0tnD7K0FajwA1Gt+ZCPrc2jfQ@mail.gmail.com>
Subject: Re: Hashed pointer issues
To: Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C. Harding" <me@tobin.cc>, "Ted Ts'o" <tytso@mit.edu>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 12:00 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Apr 30, 2018 at 11:38 AM Kees Cook <keescook@chromium.org> wrote:
>
>> Something like this? (Untested.)
>
> Looks workable.
>
>> +       /* If we have hw RNG, start hashing immediately. */
>> +       if (arch_has_random()) {
>> +               get_random_bytes_arch(&ptr_key, sizeof(ptr_key));
>> +               ptr_key_ready();
>> +               return 0;
>> +       }
>
> Small tweak: you should check the return value of get_random_bytes_arch(),
> because in theory it can fail.
>
> Sadly, that's not actually how get_random_bytes_arch() really works - it
> falls back on "get_random_bytes()" on failure instead, which is explicitly
> against the whole point here.

I just noticed: there are _no_ users of get_random_bytes_arch() ...
didn't we once use it to feed entropy to the CRNG?

> So I think it would need some tweaking, with a new function entirely
> (get_random_bytes_arch() with a failure return for "cannot fill buffer").
>
> But that would be just a few more lines, because we could make the existing
> get_random_bytes_arch() just use the failure-case thing.
>
> So add a "get_hw_random_bytes()" that does that same loop in
> get_random_bytes_arch(), but returns the number of bytes it filled in.
>
> Then get_random_bytes_arch() turns into
>
>      got = get_hw_random_bytes(p, nbytes);
>      if (got < nbytes)
>          get_random_bytes(p+got, nbytes-got);
>
> and the initialize_ptr_random() use would be something like
>
>      if (get_hw_random_bytes(&ptr_key, sizeof(ptr_key)) == sizeof(ptr_key)) {
>          ptr_key_ready();
>          return 0;
>     }
>
> Hmm?
>
> Maybe we could call the "get_hw_random_bytes()" something like
> "get_early_random_bytes()" and the "use HW for it" is purely an
> implementation detail?

Yeah, and if we add __must_check, I think this should be fine. Ted,
any thoughts on this?

Tobin, is this something you've got time to implement and test?

-Kees

-- 
Kees Cook
Pixel Security
