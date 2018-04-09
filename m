Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeDIRc4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 13:32:56 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:40394 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbeDIRcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 13:32:55 -0400
X-Google-Smtp-Source: AIpwx49J3b4LvONiCVw3O9T2ykimi0gz9wQGee3E9JHrHHRo7utgotpQ6QfUC634CsJ0/KwUA2FJ+39SJ4s+RC1uXdg=
MIME-Version: 1.0
In-Reply-To: <CA+55aFy1jJPX2fu7ce2Z7hxn49RaSghtnziwsyUU1Em5WEH2yw@mail.gmail.com>
References: <alpine.LFD.2.21.1804061125390.1819@schleppi> <CAGXu5jKTtU3fvqP-ygV51WcOAmTkm=y5fysKNv+k0crhJACtVg@mail.gmail.com>
 <alpine.LFD.2.21.1804091809310.1698@schleppi> <CA+55aFw1MoQ=7=U6QCGXAAiCniMKy8_igxgc8sMLykSRcDk-0g@mail.gmail.com>
 <CA+55aFy1jJPX2fu7ce2Z7hxn49RaSghtnziwsyUU1Em5WEH2yw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Apr 2018 10:32:53 -0700
X-Google-Sender-Auth: _kN8-mqOcDMVD2dHhIzSFlnqusI
Message-ID: <CA+55aFwnEAb8MBfSQBkuygpW8tDLmdS1-uLd-6GmnspviSEVRg@mail.gmail.com>
Subject: Re: [bisected] 3c8ba0d61d04ced9f8d9ff93977995a9e4e96e91 oopses on s390
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: Kees Cook <keescook@chromium.org>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 9, 2018 at 10:14 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ugh, I find that really nasty to read, but it was obviously done
> because we hit this before.

Side note, we have a *lof* of those "__x" and "__y" names in the helper macros.

Clearly min/max was the only one we really had ever hit (because it
used to have that UNIQUE_ID thing), and the patch I sent hopefully
fixes the only real problem, but it would be good to perhaps look at
this in general.

And no, -Wshadow still isn't the right answer, because while it warns
about this, it also warns about a lot of perfectly normal cases where
we have shadowing of names but it doesn't really matter.

Maybe "make __UNIQUE_ID easier to use and encourage that model" is the
right answer.

Right now "__UNIQUE_ID" is actually really nasty in several ways:

 (1) the already mentioned "the fallback is broken for same-line use"

   This doesn't really matter because both gcc and clang have _true_
unique macros, but we should probably remove the fallback as "know
broken and not really guaranteed to give a unique ID"

 (2) The argument you give to __UNIQUE_ID() is pointless. The only
reason it exists is because the broken fallback case is so broken and
by definition __LINE__ will be the same not only if two different
macros are used on the same line, but for trivial and common case of
*one* macro using it.

That second problem is a problem only because it encourages crazy
naming. For example, in the patch I sent I used "__UNIQUE_ID(__x)". If
we actually just wanted a prefix, it would be more logical to just use
"__UNIQUE_ID(x)" instead, but then macro arghument expansion means
that you don't really get "x" as the prefix, but whatever the
_arghument_ x was.

So then I have to use "__x" or something just to avoid argument
expansion. Maybe I should just have used a plain number (which cannot
have the argument expansion issue), but that doesn't work because the
prefix is directly attached to the unique number, so using
__UNIQUE_ID(1) and __UNIQUE_ID(2) is actually unsafe _too_, because
the numbers can end up not being unique at all.

I really do dislike __UNIQUE_ID() for all these reasons. It has
various really subtle problems that make it unnecessarily hard to use
and/or have odd nasty issues.

I think there's a reason why __UNIQUE_ID() really isn't used much.

               Linus
