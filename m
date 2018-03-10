Return-Path: <kernel-hardening-return-12356-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELv2T5fJMKXODIDAlAmLiBuwT0NEilIS7lNIcGxYWLpvLg8pso1Kr/OwOfIIDJ4vKw76+Gj+
ARC-Seal: i=1; a=rsa-sha256; t=1520641981; cv=none;
        d=google.com; s=arc-20160816;
        b=icullCuG+yG67LlDHIuBTlFntXyGOlRvnXbosWaAbyaTzKavP4jvRQEIZFqFeZnP1/
         smEZTu8ZrqtHY24T48xzVKDyzhbzy9JCgZGB/UbBqO2i67QwZlIBW8otYXrbbF9x2wp2
         7k8KdtICng7DAz5cnn66xC346DhzkeHaskP5/lLt1tT3Mzuu8EZLkMtGaASmWYMnmIeX
         G9CiyytB+2x7/X/TkipB6uUpbbt5hP+9mR49nFZG6euvSUwbSEEuMr9jZtRDCRcwEVyA
         kDL7/DPreBMEeBkUnH0k1MnxGZRsZN95jm1KdDgG0qfvKuIoarcdaRol07b5dqj0ogzg
         6UnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=+iEr6H+G4PXy50RbEGpLgRG4cWwP5kE5BHbZyFD0FOM=;
        b=NVsBixg8ExZJm7xYe8qscmut2VF8v5TZUUeHIKhVnmn5gGlkLTuQyLDcgP8hYXEaLw
         5IxhEMm9Q1kGTfRti1p4H41mfQy/YCSUKyRdAECwRnh75zhhUjYDnir0zLb9ky5k2MDG
         0oi5EXD6Cx+JJXUwUX5EtwE+VzP3NfROMIluD12Oww0xLabxptut+Xode0Z0y/46P5UK
         6b+uwsg7i2XXz9lwHZ/Pkfcjari/ae/rbCIlIUdKJvO880IVaV19L6Alo6E1sxUxNZ3n
         sdF9L0ndxmzOpOG7J7PMjw91j5EFCtdyk9j6KwlZjgeVZavdIY09+f6nJn11sqdhvswk
         /hog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12356-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12356-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12356-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12356-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 9 Mar 2018 16:32:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Gustavo A. R. Silva"
 <gustavo@embeddedor.com>, "Tobin C. Harding" <me@tobin.cc>, Steven Rostedt
 <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, Chris Mason
 <clm@fb.com>, Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
 "David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov
 <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo
 Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Masahiro Yamada
 <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>, Randy Dunlap
 <rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>, Sergey Senozhatsky
 <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Pantelis Antoniou
 <pantelis.antoniou@konsulko.com>, Linux Btrfs
 <linux-btrfs@vger.kernel.org>, Network Development
 <netdev@vger.kernel.org>, Kernel Hardening
 <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in
 min()/max()
Message-Id: <20180309163241.a421e216999bd0b1f43a64c2@linux-foundation.org>
In-Reply-To: <CA+55aFw9hWz1-YFVoHEiXDjqb9q7dz=rQVXr7YLkMuVLvbwaOg@mail.gmail.com>
References: <20180309200536.GA5670@beast>
	<20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
	<CA+55aFw9hWz1-YFVoHEiXDjqb9q7dz=rQVXr7YLkMuVLvbwaOg@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594508686652152615?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 9 Mar 2018 16:28:51 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Mar 9, 2018 at 4:07 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > A brief poke failed to reveal a workaround - gcc-4.4.4 doesn't appear
> > to know that __builtin_constant_p(x) is a constant.  Or something.
> 
> LOL.
> 
> I suspect it might be that it wants to evaluate
> __builtin_choose_expr() at an earlier stage than it evaluates
> __builtin_constant_p(), so it's not that it doesn't know that
> __builtin_constant_p() is a constant, it just might not know it *yet*.
> 
> Maybe.
> 
> Side note, if it's not that, but just the "complex" expression that
> has the logical 'and' etc, maybe the code could just use
> 
>   __builtin_constant_p((x)+(y))
> 
> or something.

I'll do a bit more poking at it.

> But yeah:
> 
> > Sigh.  Wasn't there some talk about modernizing our toolchain
> > requirements?
> 
> Maybe it's just time to give up on 4.4.  We wanted 4.5 for "asm goto",
> and once we upgrade to 4.5 I think Arnd said that no distro actually
> ships it, so we might as well go to 4.6.
> 
> So maybe this is just the excuse to finally make that official, if
> there is no clever workaround any more.

I wonder which gcc versions actually accept Kees's addition.
