Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517851146; cv=none;
        d=google.com; s=arc-20160816;
        b=WblRyjtP09UQLdfHIgAF1fCBd822N346BqBhWwLDblKM/pt1mrkNaTYNnFs6ggxNt1
         jYl6wRBP3ZRvaFFLOvHWLtULgaZYkzluK3N+UygvRyDKr8wzJJYqpmWhhVgF66FPRxbc
         eW6HGk4hxdUNMN9mIOXc3HUOlWXfR1Z8Ma2X5jfGeHJ9Fx6IDXEindWIYsXf6wah2c8T
         iUeVdAqOB8AQd8HBle2fIjkXFDMTJdKG/tI7GQ9bJEyyqYnIJBmVPxWYpVCQ+bPgX3uQ
         udY0acaPcgH2BFFyc0mTbITs8Nrj3nfOvpIcNZnXCpsJWVdLczSDgjyH44CYpMu0BJtP
         AtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Kp3qVlsKP8Kn5323iGqbpyDeOxXjYBeNGV5CHZx2Wq0=;
        b=VzkU3U7BBky6duJJMlGJjVd/sBjSG8IPEd1YGmvjysDsgLHKir0vSkkRmBn8vaRNiL
         wYrpcmfb8WgckQ/jB/FSMvRT1s7mUkmuWZXDJtsBfLVfmP9dxKwEy3tdiYY25824r8T2
         Aw58XrRG0JqyvMyO/Ff3DMrHZapTvnwup3Cdn27AlA3sPvl0pPf+BChhzYBE49mLUE8O
         5QIj3nWWSLnriQxGuuiT3vaD1WtcZ3IilEyNicLfV6r1iYiMFHld/oX0KS53oOQE8WfI
         d58htLOdQ6EViPBFhzXiR0/PWTCSyNfFoJvJaAfNV0DN/EiAbKwOx5CWzpmYHv2e2eC1
         rRMg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=N0RFv6Yh;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=N0RFv6Yh;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x225QISzBHGC+HD++ywzpERH/RWEkevDzqg6bFH3tVau5/dFHnLEUEX6Zcp/Zrwi0NS+Nh3Ngljfp/dCkNGtOM44=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFxdK3CJiAN_yytM7nYubYOeShvCNFGpEU9SR1HC0b8WiQ@mail.gmail.com>
References: <CACRpkdaTv4NBrRXeJE6dVi4W88+LZdsTCSzTHi0vdcKMW3Qfmw@mail.gmail.com>
 <CA+55aFzMBptQt-QHMR0MM9MA3=1rxcf8ca5qHxrf4Mm0ZobE_A@mail.gmail.com>
 <b82adbc32e4444debb947582d3a8291c@AcuMS.aculab.com> <CA+55aFxdK3CJiAN_yytM7nYubYOeShvCNFGpEU9SR1HC0b8WiQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Feb 2018 09:19:05 -0800
X-Google-Sender-Auth: ti42vsERqlf_0svpnyoAxYRZvpA
Message-ID: <CA+55aFxhUDTW_Pa9-+jmXhNDDTy5nrkiSaswxRTHh7u+j8gnOA@mail.gmail.com>
Subject: Re: [GIT PULL] pin control bulk changes for v4.16
To: David Laight <David.Laight@aculab.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591331743286572652?=
X-GMAIL-MSGID: =?utf-8?q?1591582283399057635?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 5, 2018 at 8:55 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> End result: opening a file - whether it exists or not - doesn't
> actually go down to the filesystem at all when things are cached. My
> kernel profiles also show that very clearly, there's absolutely no
> filesystem component to the build at all (but there is a noticeable
> VFS component to it, and __d_lookup_rcu is generally one of the
> hottest kernel functions along with the system call entry/exit code).

Note that when I do kernel profiles of kernel builds, I do it mostly
for the "everything is already built" case, so the real footprint for
much of my profiles is actually mostly "make" doing millions of
open/stat calls.

Because once you actually build things, the kernel is almost not
noticeable any more. It's all gcc. And people always say that it's
optimizations that are expensive, but from the profiling I've done of
user space, a _lot_ of time is spent in just parsing and reading the
data.

In fact, having just re-done this, the top function in profiling is
"_cpp_lex_token()" at 3.4% of overall time for my test kernel build.

That matches my experience from sparse: the real overhead in a
compiler is just the stupid lexing/parsing. Cache misses galore, and
there's nothing really smart you can do about it.

Once you get to optimization, you can do smart things like hash the
SSA representation to do CSE cheaply etc clever data structures. But
lexing and parsing the tree is reading text and allocating and
generating the internal representation, and it's just "work". Lots of
it.

And that is why trying to avoid unnecessary header includes matters so
much. Because the front-end really does matter for compiler
performance.

(And it's at least partly why C++ is such a pain to compile, and why
C++ people want pre-compiled headers etc. You can't just do a forward
declaration of a struct type, and you get header inclusion from hell
when you have "clever" classes and inheritance etc. C++ build times
tend to be really nasty as a result).

                  Linus
