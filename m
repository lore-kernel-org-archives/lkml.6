Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524531834; cv=none;
        d=google.com; s=arc-20160816;
        b=HuVxCjm6RkYSmxzxlxaiML+rx8JS/6bskodR3CL8/LP3nfOKJGjPVoMSnmGGB+nDey
         4szX0R1Y83YWggJquFlq2PbBvbAnudN9lK8/Xf1xoVLT5t3/6yZPTB6XJaD8zyZtNT5l
         EIW8aKvM01M2oHkPaiLAR3TO85brnxpa0ZRjsaCtgbsn2P805bsO62MKK/axIdgBVdDa
         /pUCGCKpDPWCI8AySdCR5RzFR9XA0jzm0dXvyx4gkz4l1Q/HFbA2iSXU/GxUPNXVxJZa
         RDfRwCjMN7qQc/KUZUUONvt7qy8GWpLnKdENW/ntE0LyJM3Cidzl0qD0Dihfw5zhKCnb
         kqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=AIWx4S1+D0E92O3VI/N5o1i2947ESe/iMKURvuE2H0s=;
        b=wYHU6qHImtidiICQY/FSMcUdjpdyvE7zUUYP9EWTXhDQchae+nNb3vR4iLxI+EEZAs
         w6Dkq7+NrgpgnveXPG0DW80NNl3/jYBcK4IChIDloJAoDNEzcgKdLxnUVEJeMyyWE+YS
         4ayYQzC+NZkju6ECF/PsVPVm+Ykc4kckAxUlHNb93YHccqjSGiP3rJpgVUz3MzDjBF90
         edt9RkJLIvPEAPhwBSK2SXVNjnReGyaLyfoCY/Awi8TW3MnHerI29pW4pXMp5LxgA7mK
         zHNO96ZoGAgQkuj5RVEWNe7CT9ljzRY5mp0YkXvngqNv3p3mv4hJdu/aao6Id/iysq7F
         3muQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=EHlzkzRu;
       dkim=pass header.i=@chromium.org header.s=google header.b=STW11T49;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=EHlzkzRu;
       dkim=pass header.i=@chromium.org header.s=google header.b=STW11T49;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx481MtT20ztPcke186iwa1xb18DpUevfL0bmXdAxQp8bjvb2+7hsIbaIQ8wEZVakldIOgboPJL3Fr3rDHt6aLlo=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <c5a605b8-423f-5e92-5fbe-12cb44a70bd6@linux.intel.com>
References: <1523024546-6150-1-git-send-email-alex.popov@linux.com>
 <1523024546-6150-3-git-send-email-alex.popov@linux.com> <CAGXu5jKm218fpxyV3vOM+2SO-ERG3tWPUV0x8+-S0MJAReFz+A@mail.gmail.com>
 <c5a605b8-423f-5e92-5fbe-12cb44a70bd6@linux.intel.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 23 Apr 2018 18:03:51 -0700
X-Google-Sender-Auth: bo0qWU6L7TIsTplgr8YnmlBPDRQ
Message-ID: <CAGXu5jJT=SAe5NNKWXu6CXLhX7_C7i4qJ4Znd92jnGxb71UJdA@mail.gmail.com>
Subject: Re: [PATCH v11 2/6] x86/entry: Add STACKLEAK erasing the kernel stack
 at the end of syscalls
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Alexander Popov <alex.popov@linux.com>, Ingo Molnar <mingo@kernel.org>,
	Laura Abbott <labbott@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>, Andy Lutomirski <luto@kernel.org>,
	Tycho Andersen <tycho@tycho.ws>, Mark Rutland <mark.rutland@arm.com>,
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
	Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
	Boris Lukashev <blukashev@sempervictus.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597007022879408472?=
X-GMAIL-MSGID: =?utf-8?q?1598587492365089938?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 11:50 AM, Dave Hansen
<dave.hansen@linux.intel.com> wrote:
> On 04/16/2018 11:29 AM, Kees Cook wrote:
>> Dave, Ingo, Linus: how does this look? With the assembly rewritten
>> into C, the entry changes are very small:
>
> The assembly looks very nice to me now.  It is as minimally invasive as
> it can get.  Definitely no objections from me on that part.

Can you give an Acked-by for the x86 parts? Or Ingo?

If this is workable, I'd like to carry it in -next to see if anything
else shakes out...

-Kees

-- 
Kees Cook
Pixel Security
