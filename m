Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbeBVB6t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 20:58:49 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:35390 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752375AbeBVB6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 20:58:38 -0500
X-Google-Smtp-Source: AG47ELuwuZ7nJg28JjG0JhpZa0LL1iBJIu0Z0ogySXs70NYLyvuQeQqlc6nQOPyUoQU/iUxVltNVwuEE4pEXKImgEb8=
MIME-Version: 1.0
In-Reply-To: <20180222014505.2l76ccrrs36y3b26@agluck-desk>
References: <CA+55aFy8JMLjpDk+sU6pirSZdVqqHtw5oocDAEC7wcHuo5Vssw@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37DE1B@ORSMSX110.amr.corp.intel.com>
 <CA+55aFwKsa6bq5SUD6wKv8znGcxqjLCPh33a3DkbnUkSfd68Yw@mail.gmail.com>
 <CAKv+Gu--iHii9SxE7RMZKdVdLvQPPGo0wdCzG30xW0+7dakbmw@mail.gmail.com>
 <CA+55aFx4Q7AzCM5mDwga6_LteNUBWQsT6nKJMjn8JcriS3ExuQ@mail.gmail.com>
 <20180221182104.GI3231@tassilo.jf.intel.com> <20180221194731.t7jowrmicvaggu3x@agluck-desk>
 <CA+55aFzy89V13rSxGQy77Bb08qpUpH+J=trcjooKQhsAFbgrVw@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37F130@ORSMSX110.amr.corp.intel.com>
 <CA+55aFx3WKAL7e3TAs-2okggW6Z+DHANdmcsr+WTDh3N-Mx+Xw@mail.gmail.com> <20180222014505.2l76ccrrs36y3b26@agluck-desk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Feb 2018 17:58:37 -0800
X-Google-Sender-Auth: EODwPEEKcLlyYEJcSB_hRuKPmh4
Message-ID: <CA+55aFzJXsPcsJ5MtsxTp2n+43xC0yGzANLNcDm1mFbZKR75FQ@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: Limit the rate for non-root to read files
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joe Konno <joe.konno@linux.intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 5:45 PM, Luck, Tony <tony.luck@intel.com> wrote:
>
> Linus suggested per-user rate limit to solve this.

Note that you also need to serialize per user, because otherwise..

> +       if (!__ratelimit(&file->f_cred->user->ratelimit))
> +               usleep_range(10000, 10000);

..this doesn't really ratelimit anything, because you can just start a
thousand threads, and they all end up being rate-limited, but they all
just sleep for 10ms each, so you can get a hundred thousand accesses
per second anyway.

To fix that, you can either:

 - just make it return -EAGAIN instead of sleeping (which probably
just works fine and doesn't break anything and is simple)

 - add a per-user mutex, and do the usleep inside of it, so that
anybody who tries to do a thousand threads will just be serialized by
the mutex.

Note that the mutex needs to be per-user, because otherwise it will be
a DoS for the other users.

Of course, to avoid *another* DoS, the mutex should probably be
interruptible, and return -EAGAIN, so that you don't have a thousand
thread waiting for the mutex and have something that is effectively
unkillable for ten seconds.

Can it be hard and annoying to avoid DoS by rate limiting? Why, yes.
Yes it can.

                Linus
