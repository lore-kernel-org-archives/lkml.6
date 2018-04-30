Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755068AbeD3Q5t (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:57:49 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:33288 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754772AbeD3Q5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:57:48 -0400
X-Google-Smtp-Source: AB8JxZobd51smjkakACvExm/VXSVStQ0Pq7rcDwPGJDvyjcLu5Iy7A8e3WxOdUgDBFj9urVlfLwROW0KPHAFQMeJHwQ=
MIME-Version: 1.0
References: <alpine.DEB.2.20.1804301741570.3243@hypnos.tec.linutronix.de>
 <CAGXu5jL1W=AC023asgeMRUXAnhU2vd-RJRqGtOOetQ=aXwDcFQ@mail.gmail.com>
 <CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com> <20180430124135.0cce92e3@gandalf.local.home>
In-Reply-To: <20180430124135.0cce92e3@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Apr 2018 16:57:36 +0000
Message-ID: <CA+55aFzpJC4+tuSopeze72D2sv1urGdap8+Bj2Y9hEYitAkE4Q@mail.gmail.com>
Subject: Re: Hashed pointer issues
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tcharding <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 9:41 AM Steven Rostedt <rostedt@goodmis.org> wrote:

> >
> > And if we really want a command line option, can we make that still hash
> > the pointer, just force the entropy early. That way kernel developers
that
> > test that command line option are still testing the *hashing*, they just
> > are missing the good entropy.

> That may work too. Even with bad entropy, pointers at start up are hard
> to come by, and I can't see a hacker being able to use them as it only
> happens once during boot.

No, if people use the command line option, *all* pointers - not just the
boot-time ones - would get cryptographically bad hashes, since you don't
want to change the hash once it's picked (because then you couldn't use the
hashing to identify objects).

So the boot command line wouldn't affect just the bootup hashing, it would
be bad at runtime too.

But at least a person booting with that option would get the same
*behavior* as everybody else, and they wouldn't be testing something
fundamnetally different (it's still hashing, just not cryptographically
strong).

Although in *practice* we'd have tons of entropy on any modern development
CPU too, since any new hardware will have the hardware random number
generation. Some overly cautious person might not trust it, of course.

                Linus
