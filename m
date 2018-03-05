Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520280379; cv=none;
        d=google.com; s=arc-20160816;
        b=V7d5rLuT3GfXtl5WB8EolH4YNJkygAhyaPi2Zn++75h3GNk1kG+bk8eGEqZntCHqhq
         RapwkX6osH7AZ+/ebkqhgjAKxLM+uzz5eoLJ4pxwSD8KOWHkzMjLZXVTyu+H4KNIpoU+
         hFu8b5cOQFQ384vktseFLqELWvvYZGYGCiZltKhC38DdUdaqt4M3x8tImkPtZ5qhfo6l
         yRf5fhX0n2BalR6zVUpJ8D+fI0L5GuxpL2gtNN2+3jrOWDOk9OusSeuKaT0TMXq0qwW7
         7ewEGXCT2jSgTGl9FFwVxa1WRY/gtLW3Oa7KxV2OGCcFrO0rfXh64tl+0c2U6OX32jCJ
         YwAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=IfC5RmKdfnRCmEj6ZH2tME5LHqbLLun0wK7ADeaXpEA=;
        b=WPiYk6eYlT0xdJFQBJnTk8m75Z/kzMZgoEf5DdptKxmGyMYtoF7DGgJ1WSB5bgkTLy
         X4nHeO+gMm/xD+aZUPhtcHk+DT7HjtrOJg97Iga/7aaeNou5/O4zJvysQSaeGEWfpUiU
         c2dR+k96MeRHJxF4uRoafrDKRtyAMjiqv+b2vafCJJP6aTSkIr1BvnenoBotZtkkDX7u
         pCft5Ue8DtwLhlg7joL6OWxFXC9YqVb7mmsCLLi3ZOHaGQAKLfJF5a331/U7/qR9kXwb
         BoAcekM2fD5ezXA3p3GFaQC+a3TFJ7yVtP1UIldDwHULBvLG7RatOblQvxw/vJFSa1kH
         nuOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=NaTQqDBq;
       dkim=pass header.i=@chromium.org header.s=google header.b=YHef/kLo;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=NaTQqDBq;
       dkim=pass header.i=@chromium.org header.s=google header.b=YHef/kLo;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELsEvcv6+Wz2397V1iRYoEWZqD3AT7nWLEtQoNdkvjG84jfj7XA+3fXt/zipCTiOhotensPNQQHAgSg63HRvHAQ=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <b52a2cca-cb5c-d47f-131e-7db297f78958@linux.intel.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-5-git-send-email-alex.popov@linux.com> <b52a2cca-cb5c-d47f-131e-7db297f78958@linux.intel.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 5 Mar 2018 12:06:18 -0800
X-Google-Sender-Auth: soj2jBWLrcIHiCdmkAh7ce7afps
Message-ID: <CAGXu5jLRpJ7ktij4TpaSG-RZLOou=RWyY_=jTMNE87+E4Xp2Ag@mail.gmail.com>
Subject: Re: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in syscall_trace_enter()
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Alexander Popov <alex.popov@linux.com>,
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
X-GMAIL-MSGID: =?utf-8?q?1594129519241977143?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 11:40 AM, Dave Hansen
<dave.hansen@linux.intel.com> wrote:
> On 03/03/2018 12:00 PM, Alexander Popov wrote:
>> @@ -128,6 +134,7 @@ static long syscall_trace_enter(struct pt_regs *regs)
>>
>>       do_audit_syscall_entry(regs, arch);
>>
>> +     erase_kstack();
>>       return ret ?: regs->orig_ax;
>>  }
>
> This seems like an odd place to be clearing the stack.  Why was it done her?

Perhaps the commit log could be improved, but the idea is that the
audit work (ptrace, seccomp, etc), is happening before the syscall
code starts running, and it has therefore written to the stack (that
used to be cleared on last exit). This retains the clear stack state
even in the face of ptrace-ish work happening before the syscall
proper starts.

-Kees

-- 
Kees Cook
Pixel Security
