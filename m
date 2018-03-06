Return-Path: <danielmicay@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520349386; cv=none;
        d=google.com; s=arc-20160816;
        b=SvytAFi7JlLp1SWJqKjOiaoPEw0MLL8ikN/V8YJ7DZ6qt36LoP9UB+32sP2NFqRNH3
         Ic6Gd0Q0Hx++4NcZdprZCM6azjqi/3iCqRFklhLzOtQD2gRRKm+SbimeIGizShd9nLbt
         VYI/gtnYJwYEKyO1zIWqQ+Xa21mzS/iMYjj2SVPNJmCYiCMK5FQwXbTVom/P46wBBzU0
         nVoaET/bbdL57xID42iIyf7KJF7O1hxJSJIEthFm3VUndtL+CaGNFrwpWt2me/emBhtP
         OPfYDwwsJA90VS+FNDpoDb6b6r0VA4POIWPIQvs1CDD5nkoS3bRxg1yeC6k51wYiQXS6
         TQaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=tedkacjw5Rqhoei4qa3NglIULQDRViYNWV859ewmd8I=;
        b=A298a12C9JKOsiKVIdqwmAV7MVY4KTC43KKsYk6K+907FUJwAywXvpybZiqtgXP9rU
         9ypDWEZ5sT6v5OO/pMzaUzLfezE2FH/oKqC3yyLvbL8NLPJANFoJ6sGiWr/3e3rBqV/B
         lQha8eOPRDHVoGDRut4Ilv7hrFr+4LvYVd/rgofATEUVg723qvNDw/BcaRSgLITkv+Vr
         x2+xvEgOqmijAb1aW/zANmio9ljzfR0yn1UAmC1hiarJhEItVVXWv3Avtux+9MZCiwDs
         ngy1JJyTxEqW8Syq4eGRr0oltRx6iU6YY7UnN9CkS5TMVrfwCP9EdVw4NbguNxlVSTqP
         jb/A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=T31YAOIR;
       spf=pass (google.com: domain of danielmicay@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=danielmicay@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=T31YAOIR;
       spf=pass (google.com: domain of danielmicay@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=danielmicay@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELu1HG6UWslXAAp454QApZKf1gSjuB4kdfKBrtLxIPcwO4s/84dpkX7zKylEKG0LjwWVoeJngl0se8i0wF81CAk=
MIME-Version: 1.0
In-Reply-To: <20180306080855.phtgl2bzqm5hnthu@gmail.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-5-git-send-email-alex.popov@linux.com> <b52a2cca-cb5c-d47f-131e-7db297f78958@linux.intel.com>
 <CAGXu5jLRpJ7ktij4TpaSG-RZLOou=RWyY_=jTMNE87+E4Xp2Ag@mail.gmail.com>
 <CA+55aFxEAYyrUkApo-dtZvxcYbvWBZJpUytjbm7e2wruTvbYjQ@mail.gmail.com>
 <CAGXu5j+-AjMKxOYDOpbmJ4X357JRGWViAOmqyqd6bu_w47mffw@mail.gmail.com> <20180306080855.phtgl2bzqm5hnthu@gmail.com>
From: Daniel Micay <danielmicay@gmail.com>
Date: Tue, 6 Mar 2018 10:16:24 -0500
Message-ID: <CA+DvKQ+uQD0qyMvwqaRd_sMLBHE5q9pcfOQ+VknBW2==q0NJJA@mail.gmail.com>
Subject: Re: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in syscall_trace_enter()
To: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>, Alexander Popov <alex.popov@linux.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>, Andy Lutomirski <luto@kernel.org>,
	Tycho Andersen <tycho@tycho.ws>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, Borislav Petkov <bp@alien8.de>,
	Richard Sandiford <richard.sandiford@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	"H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Dmitry V . Levin" <ldv@altlinux.org>, Emese Revfy <re.emese@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Garnier <thgarnie@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Josef Bacik <jbacik@fb.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, "David S . Miller" <davem@davemloft.net>,
	Ding Tianhong <dingtianhong@huawei.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>, Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Mathias Krause <minipli@googlemail.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947986518331727?=
X-GMAIL-MSGID: =?utf-8?q?1594201878517653479?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are cases that clearing the stack can cover but I don't think it
has high importance if all locals were being default initialized to
zero. The new stack will end up with gaps from alignment, variables
that weren't fully used, etc. where data from an old stack is present.
Unless there's something really important left over like a private
key, it shouldn't make issues like a before read overflow on the stack
much worse.

There's an important missing feature which does get covered by this
plugin: variable-length arrays can skip past the VMAP_STACK guard
pages (as could alloca / large frames if they were actually used). The
ideal would probably be both GCC and Clang providing a working, safe
implementation of stack probes to enable with VMAP_STACK but they
don't do that. I'm not sure it makes sense for the kernel to be
working around that downstream though. It's strange because Clang has
had a working implementation on Windows for ages where the ABI
requires it but for some reason they never provided the option
elsewhere.


Zeroing locals isn't very expensive because the compiler has a chance
to optimize it out when it can figure out it isn't needed and they're
almost always used. If there are cases it hurts, it might be possible
to fix that by inlining an initialization function so it can see the
initialization. From my tests doing it in the entirety of the kernel
and Android userspace via a Clang patch (which we use in production),
SSP has a much more significant cost. Filling them with a non-zero
value is also a nice way to find bugs and I think that will still be
true with KMSan available via Clang. There might be cases where
there's a large array where the compiler can't remove the zeroing and
the call is pretty hot... but we didn't run into any substantial
performance costs, although for our niche we only really care about UI
latency, battery life, etc. and losing 1-2% throughput for some things
is irrelevant.
