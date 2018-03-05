Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520283780; cv=none;
        d=google.com; s=arc-20160816;
        b=COwrIpOte7tRpjVwRE6wP5zpyUpyjRYeCLKlNWmJOSXSSxbteruzM1B30+qd7wOtqy
         h220liUp0dOV1MfMJXQ/8zVBfi3ws64CZsw7JT3Eon4BoqsaYhoOIn12zHtJ8EEANoaQ
         dyitJxcuVYRZB4a8gtDXWxqoBpv3X2mvH054Zs2KZgkqKlliHOtlGEjFWj1uw/tSkufR
         PzKtN5JxwkWUlVzdXEkaf4f3GgEj+RDYdTNJMLkYUQJU6oUPcgMvEoPg22MJFmwOPaU4
         nW3oegYfDmRaY8JVvmt0ZnukdO1vKpODyKwlheUP1+C8/H3/Hz/wIoRB3sqg+3obC8rK
         UKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=9HbzXpGlIb+lvNYrHVzrAH3M0PkNwh0+Y7+Idbx7RsU=;
        b=m7Fcg4k99Kr1MosZU9RhyPECoDR32k2CvjgJFKRFrZkUWFuMo9P18Cf4b/EbXXQRov
         swzeOka5pCulYJTJ+xlIIQ5XdSXalGB8fhtdz/J9RVF7p0Cwsi6cNOXCYig62s6qk+OO
         uztsB1eSZGeQH8sZoletU0J1wQmUiwGZjhKK7cVmXdUHK1iikQQIY2pVP+tViSia6Ona
         eZMmM6pOixKHCITNzls39CaubrP0wpVnW98fJSMBGUHi8RHfOSDITR8rzazFpgm1s1H5
         si1JkYwZjXtEHPVwfHs5MgXXeQ+muqGE5s0eTuAqJHmbmBJh13hmZD5Hy3gzcEFVXBfM
         zY+A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=gzXbz5Hv;
       dkim=pass header.i=@chromium.org header.s=google header.b=F+NtQqnh;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=gzXbz5Hv;
       dkim=pass header.i=@chromium.org header.s=google header.b=F+NtQqnh;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELtTg5sPqf9O4M7I1+72ZF4O4P+VkNIlFKsNFUDAmVarziXd/Li3gkSYuzjo+FxL2BQ1+rLYxyPWx8k0ull0dOs=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CA+55aFxEAYyrUkApo-dtZvxcYbvWBZJpUytjbm7e2wruTvbYjQ@mail.gmail.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-5-git-send-email-alex.popov@linux.com> <b52a2cca-cb5c-d47f-131e-7db297f78958@linux.intel.com>
 <CAGXu5jLRpJ7ktij4TpaSG-RZLOou=RWyY_=jTMNE87+E4Xp2Ag@mail.gmail.com> <CA+55aFxEAYyrUkApo-dtZvxcYbvWBZJpUytjbm7e2wruTvbYjQ@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 5 Mar 2018 13:02:58 -0800
X-Google-Sender-Auth: nsLyGHMWCOGuaY4YrARiYbwPjmI
Message-ID: <CAGXu5j+-AjMKxOYDOpbmJ4X357JRGWViAOmqyqd6bu_w47mffw@mail.gmail.com>
Subject: Re: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in syscall_trace_enter()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Alexander Popov <alex.popov@linux.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>, Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Laura Abbott <labbott@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Borislav Petkov <bp@alien8.de>, Richard Sandiford <richard.sandiford@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, "Dmitry V . Levin" <ldv@altlinux.org>,
	Emese Revfy <re.emese@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
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
X-GMAIL-MSGID: =?utf-8?q?1594133085041510029?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 12:15 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> This is the first I see of any of this, it was apparently not actually
> posted to lkml or anything like that.

This series was still RFC and narrowly focused (e.g. we recently had
compiler folks reviewing it). I'd say we're now to the point where
it's getting mature enough for larger review (I commented on the 0/n
patch to this end earlier today).

> It doesn't actually seem to help *find* bugs at all. As such, it's
> another "paper over and forget" thing that just adds fairly high
> overhead when it's enabled.

This specific class of flaw ("uninitialized" stack contents being used
or leaked) is already being looked for by tons of tools like KASan.
There are teams of people working on it, and they still haven't found
all the cases where these flaws appear.

Luckily we don't have to pick one or the other: we can continue to
look for bugs while defending against them ever happening in the first
place. We've already seen multiple cases of this just with the by-ref
initialization plugin, where a stack content leak goes away because we
asked the compiler to please initialize the memory for us when we
forgot to do it ourselves. Getting the compiler to help us seems like
the obviously correct thing to do, since we're using such a
memory-safety-unfriendly language. :)

> I'm NAK'ing it sight-unseen (see above) just because I'm tired of
> these kinds of pointless things that don't actually strive to improve
> on the kernel, just add more and more overhead for nebulous "things
> may happen", and that just make the code uglier.

I hope you'll reconsider. In this case, I think it does improve the
kernel, especially if we can gain more complete coverage through
native compiler options (instead of just a plugin). Right now, for
example, the kernel is littered with memset()s because the compiler
can't be trusted to correctly zero-init padding, etc. This is an
endless source of bugs, and this patch series provides a comprehensive
and fast way to keep the stack cleared. (See the benchmark I asked for
that compared this 1% "clear only what was used" against the 30% to
wipe the entire stack every time. The latter is obviously insane, and
the former is quite clever and kills an entire bug class.)

-Kees

-- 
Kees Cook
Pixel Security
