Return-Path: <kernel-hardening-return-12355-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELukB74d+B34lhQ13GQRAw2eZ8lUMWqCd8eUbgM/3VZq89aycVL0e3LeQc7TkFGhe74RaOPF
ARC-Seal: i=1; a=rsa-sha256; t=1520641751; cv=none;
        d=google.com; s=arc-20160816;
        b=CfFBem0of/GQOJAJmu4g0/pgVG497HgF0xOK6KmEiUKzVCzSrStqzeha8MRmwm58HV
         VpSXuS7XYsqPeOvfgSoniFmOmQt28Mmlt5GwPbtfz3XYH2z8KygOlPWifJMjzpHnpYnO
         5u4tkKzYcwJO/SHC3BoxaMV9P0CyPqkjrAriWWsaB1UfkW+B1WqdAiPobwvPkX892WPX
         T0S2nAxhASF8iFTRITVegf60cx0exBv73n/rnRyvhasBx8CtRDSEeR5cAH7iVZYhVUF/
         NbXMEz5OS4soeyBIkRBvOd09GZ41bujNKYutSdonuJ+RE93yaddSI8Z6Zrr0yjVFGqHP
         eoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=Wnt5gniLHBT4dA8facbSYoNSdJLWbIjFeRtq9pczDrE=;
        b=eAelhfDv6LET+jmY+4YLgJr8xV0KMkxImqb+4Ku3sDoi64qdkmQ91YOHW+PxVKRM4z
         GFHjfviW3JXHpKolakp+w1aLdwI3HuPFchxNRqPmpGglVhuzn7wpmxvWe/AB2MA6aMFg
         zxbusGA3RD8SIHpPq9Gf6Ab4iraaE9LZAuNQuTQVTP3H8L/OkpgGLtKHkNdmHypO6aJx
         tBVnBf7uBE+hzUpDjyBLpPPgTOcC+wcdornwrvdKdjrJezXth+9KuYVuiNwDSSKYLhYv
         /7iN1d1AhVMWGru7TA81aD2bOqQpUZDbAJHsdPDw/rHAsynygQCdRJyB6uK4sLLB42Qe
         kN6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Y54BC2y7;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=R4PLUwjR;
       spf=pass (google.com: domain of kernel-hardening-return-12355-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12355-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Y54BC2y7;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=R4PLUwjR;
       spf=pass (google.com: domain of kernel-hardening-return-12355-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12355-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
References: <20180309200536.GA5670@beast> <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Mar 2018 16:28:51 -0800
X-Google-Sender-Auth: ELqLyvexIu5FJlGFzQUMXFSorWw
Message-ID: <CA+55aFw9hWz1-YFVoHEiXDjqb9q7dz=rQVXr7YLkMuVLvbwaOg@mail.gmail.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in min()/max()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Tobin C. Harding" <me@tobin.cc>, Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
	Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>,
	Randy Dunlap <rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594508445239723923?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 4:07 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> A brief poke failed to reveal a workaround - gcc-4.4.4 doesn't appear
> to know that __builtin_constant_p(x) is a constant.  Or something.

LOL.

I suspect it might be that it wants to evaluate
__builtin_choose_expr() at an earlier stage than it evaluates
__builtin_constant_p(), so it's not that it doesn't know that
__builtin_constant_p() is a constant, it just might not know it *yet*.

Maybe.

Side note, if it's not that, but just the "complex" expression that
has the logical 'and' etc, maybe the code could just use

  __builtin_constant_p((x)+(y))

or something.

But yeah:

> Sigh.  Wasn't there some talk about modernizing our toolchain
> requirements?

Maybe it's just time to give up on 4.4.  We wanted 4.5 for "asm goto",
and once we upgrade to 4.5 I think Arnd said that no distro actually
ships it, so we might as well go to 4.6.

So maybe this is just the excuse to finally make that official, if
there is no clever workaround any more.

                    Linus
