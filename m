Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756018AbeD3UIF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 16:08:05 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:37267 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754652AbeD3UID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 16:08:03 -0400
X-Google-Smtp-Source: AB8JxZqNdDyChj0xP/u0knCNyB6jRWmtDuoJ75K7kV/xvf925SyNy+yuj5yi1JUR4Ay7EBeatdtq6BS9c70Scfqylr0=
MIME-Version: 1.0
References: <alpine.DEB.2.20.1804301741570.3243@hypnos.tec.linutronix.de>
 <CAGXu5jL1W=AC023asgeMRUXAnhU2vd-RJRqGtOOetQ=aXwDcFQ@mail.gmail.com>
 <CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com>
 <20180430124135.0cce92e3@gandalf.local.home> <CA+55aFzpJC4+tuSopeze72D2sv1urGdap8+Bj2Y9hEYitAkE4Q@mail.gmail.com>
 <CA+55aFyNqnrM=_5pMgEeL20jVKN7MgWKG52pbaR0FayO=5VuXw@mail.gmail.com>
 <CAGXu5jLVJxDJcbhrQU5-wduaP+OvePXP8VvCFMrJ47pYD-zaXg@mail.gmail.com>
 <CA+55aFyreOY8uzOkkDkU=WttNfbH2_6nStfsm9j2T6F5ZyntHg@mail.gmail.com>
 <CAGXu5jKbagUs7cS5y6zRQkgiA0tnD7K0FajwA1Gt+ZCPrc2jfQ@mail.gmail.com> <CA+55aFxfc8C9Hx+eQZrnyYuwoOitFvMpmWkWMTeA4mNCgLaSiQ@mail.gmail.com>
In-Reply-To: <CA+55aFxfc8C9Hx+eQZrnyYuwoOitFvMpmWkWMTeA4mNCgLaSiQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Apr 2018 20:07:52 +0000
Message-ID: <CA+55aFwNayMhrA-A42M-fA05eHTjtKyO6gjttTEOQFsAqmt9Kw@mail.gmail.com>
Subject: Re: Hashed pointer issues
To: Kees Cook <keescook@chromium.org>
Cc: tcharding <me@tobin.cc>, "Theodore Ts'o" <tytso@mit.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 1:01 PM Linus Torvalds <
torvalds@linux-foundation.org> wrote:

> But if there are no actual users of get_random_bytes_arch(), maybe we can
> just remove the fallback to the non-arch code, and add that return value
> (and the __must_check()).

Hmm. It is exported, so maybe there is some crazy module out there.

Also, I have to admit that I hate the idea of people using that function
for a "fast random number generator". I think it's fine for this kind of
"initialize hashing state" thing, but I would hate for somebody to actually
use "get_random_bytes_arch()" as an actual source of random bytes.

Even when the "real" random number generator uses it, at least it washes
the result through chacha20 and has other sources or entropy mixed in too.

So let's rename it regardless. Both to see if any external module actually
uses that get_random_bytes_arch() function, and to discourage people to use
it as direct random data.

Maybe call it something like "get_seed_bytes_arch()" or something.

And maybe I'm just being silly.

                  Linus
