Return-Path: <kernel-hardening-return-12381-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu41ZZBTOdSR49yXYWmphYe39WiXHqhllZqk5mRX8Lzwos3uI3TkEULVSTjpgWQqE4mPIBc
ARC-Seal: i=1; a=rsa-sha256; t=1520704302; cv=none;
        d=google.com; s=arc-20160816;
        b=eMbphqzKHKxElG9BD0bhZN+OAcNUnuC8w1wJkDyzDx/2I+mzqF69cyD+GQkOTLQ8xA
         eTJliUbFQuoXkLiU6rDREgj73hsoUEAa/s6/5oHtZiBO06LEUnvy36Z0YEb1phgsyNnV
         lj3eJfxmJlna6ZRIUjdQNhjgRZK3oHZ+JNNJdUQ+rmQYiWjmpMgSo+H3UcHYCC/uvAqk
         7XniizXPlpQCbBGwJY6okfVWFblmCvBziOif1iPjbtTv8qdaFnA+tW456RLch61Ol21X
         t0niiVcrbWN4pXDA7ye4u1jycnMmpijGWHqueCCqn8mYHsTXBztQ2JSLI7MV98EmOhiR
         sFfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=v+QHZyRoFT0rxnXXsBMEsaWYOqZH823+8B0THjDnRP4=;
        b=kEKvCENCTAIr7vSUs03TY7KxQLMY9ff2mWYC8/G4KTHvZhsk3a2KBwqg8O1JMrotX2
         0ojFnwFIeLvJgBzd59iVm2Xg/1TD1ad7+M1NLrr6sVf/gjFIv98k86X6hh3qQsiHxRDh
         O7EzmfKaOO54YiqHWoe1jxROF17rNjMGFUNEB020QB/dQaCB5wezjMtSuY3DwOS+CDLP
         ynQHHsqYYSdpRPvjFztgMP2M64x5GqdF/K3ZEsIbVzES4KjhjVno0HQ9H+MjSJo2WCDG
         bAINaQELn12dr/1wxcdCjqnv7j5ZQIDMhStk3+DYEGv8ggyZvP3c4IoT7hhCZYnnpDkx
         Pb6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RPFa9/pQ;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=gYRlIdxq;
       spf=pass (google.com: domain of kernel-hardening-return-12381-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12381-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RPFa9/pQ;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=gYRlIdxq;
       spf=pass (google.com: domain of kernel-hardening-return-12381-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12381-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CANiq72nwg3mMhWeE_bLKdQ5WP+0E+SxxvcuUF=Rn9a1MM+EapQ@mail.gmail.com>
References: <20180309200536.GA5670@beast> <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
 <e8874944-f0b7-7a1f-26f3-446d7d7fcc38@infradead.org> <CANiq72k_vsTPMXvcfTNo+sjRoVMkihvRz-fzeXdcXvNEEeY-Pw@mail.gmail.com>
 <CAGXu5jLtKAUsoYemHZTrJqKEH9=BqwO_QXk=x3BPfCKqZ6DRYA@mail.gmail.com>
 <CA+55aFyLicYSe+R4yQ2Eu+P9m6qsRfso-HiK78Sw+-dPuZvAYg@mail.gmail.com> <CANiq72nwg3mMhWeE_bLKdQ5WP+0E+SxxvcuUF=Rn9a1MM+EapQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 10 Mar 2018 09:51:19 -0800
X-Google-Sender-Auth: wLijqCMYqIcDg9EMNYFSHTXFQsY
Message-ID: <CA+55aFw+guiiJ3OavrP-RpFV9NRAF4t=oj3-GDfSyuZ9zBRfdg@mail.gmail.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in min()/max()
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Tobin C. Harding" <me@tobin.cc>,
	Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, Chris Mason <clm@fb.com>,
	Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>,
	Ian Abbott <abbotti@mev.co.uk>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Petr Mladek <pmladek@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594574034438080665?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 9:34 AM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> So the warning is probably implemented to just trigger whenever VLAs
> are used but the given standard does not allow them, for all
> languages. The problem is why the ISO C90 frontend is not giving an
> error for using invalid syntax for array sizes to begin with?

So in *historical* context - when a compiler didn't do variable length
arrays at all - the original semantics of C "constant expressions"
actually make a ton of sense.

You can basically think of a constant expression as something that can
be (historically) handled by the front-end without any real
complexity, and no optimization phases - just evaluating a simple
parse tree with purely compile-time constants.

So there's a good and perfectly valid reason for why C limits certain
expressions to just a very particular subset. It's not just array
sizes, it's  case statements etc too. And those are very much part of
the C standard.

So an error message like

   warning: ISO C90 requires array sizes to be constant-expressions

would be technically correct and useful from a portability angle. It
tells you when you're doing something non-portable, and should be
automatically enabled with "-ansi -pedantic", for example.

So what's misleading is actually the name of the warning and the
message, not that it happens. The warning isn't about "variable
length", it's literally about the rules for what a
"constant-expression" is.

And in C, the expression (2,3) has a constant _value_ (namely 3), but
it isn't a constant-expression as specified by the language.

Now, the thing is that once you actually do variable length arrays,
those old front-end rules make no sense any more (outside of the "give
portability warnings" thing).

Because once you do variable length arrays, you obviously _parse_
everything just fine, and you're doing to evaluate much more complex
expressions than some limited constant-expression rule.

And at that point it would make a whole lot more sense to add a *new*
warning that basically says "I have to generate code for a
variable-sized array", if you actually talk about VLA's.

But that's clearly not what gcc actually did.

So the problem really is that -Wvla doesn't actually warn about VLA's,
but about something technically completely different.

And that's why those stupid syntactic issues with min/max matter. It's
not whether the end result is a compile-time constant or not, it's
about completely different issues, like whether there is a
comma-expression in it.

              Linus
