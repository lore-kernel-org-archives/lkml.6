Return-Path: <luto@kernel.org>
X-Google-Smtp-Source: AG47ELve9Zculqwc/DJdOf42KdmidClcs4EzfYk4YY7vRxrX2etvwPPsOAUHae2Rb/U00g1VWa2d
ARC-Seal: i=1; a=rsa-sha256; t=1520359129; cv=none;
        d=google.com; s=arc-20160816;
        b=C7mDUyCY5uFyPccwW0M2SpaNMwfWyRkVH7dyc9efSkGSPgaQ92OCvMf/ZchvzEALDB
         YIvkwC0vGII8Cxg6s/fzL+P4U2sT+0ZOFAZGMs+A/MUxLMkNv+gyLyyhtTcoMRllvmtO
         oGQGEJyBaeq2WkAzWMah7672VYW4hBJDX2kaTsfPiF59JJ4WECWkVL2FRkIB1jXEvUaa
         mkXZpLwfxYmOgQur+y2dqkh4Q4yDHolp4NlrVogcYGs+XJeFTM7MtLrxlMSvapeIXM0v
         j7Bx63k/AEyN0hZPUbf77+28mQGgJihA2KGp0q+Afj1JvQLemp6t9h76gP9NWKGRJdha
         xOpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=s53JoKN6GGW3unXeuV887LSWts+tYDZETL5vw65DvCI=;
        b=B+DHoqtK4jG+NHFN9uZRzkeGfRr5pi63dsORB0BzGABHuV989okoYpEPThtlVzx8+K
         o1gwVEL2UJN/5OfwOAwPzuf0LYD5rjwSAIPJ+n7bF1tOMI+5cmN4mmjh0P9mFNwtoiAT
         Y2r01yZxlAEbemdPHSQRrEjTKqgRadE0uGnYuHv3jG9xKjktG+HXUhe8ZfJV52d5+HDL
         KSkcKlLyvAzXevUcWVy/JTuNpuHsem7DEPoYA04jRmOZvyiFufXP4+4QjTAdM13lptnU
         pJUvWH5BoI7ul1HkMFsTSK3z/H7XWPqwdu1ppRS5oMI9iJ/qd2Nyt/463fkYixgYw8MQ
         8tmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0872217BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
MIME-Version: 1.0
In-Reply-To: <CA+55aFyknMsiT3efAeOyf32O2NJjD9vt0XxtAegFVmmn+pvxgA@mail.gmail.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-5-git-send-email-alex.popov@linux.com> <b52a2cca-cb5c-d47f-131e-7db297f78958@linux.intel.com>
 <CAGXu5jLRpJ7ktij4TpaSG-RZLOou=RWyY_=jTMNE87+E4Xp2Ag@mail.gmail.com>
 <CA+55aFxEAYyrUkApo-dtZvxcYbvWBZJpUytjbm7e2wruTvbYjQ@mail.gmail.com>
 <CAGXu5j+-AjMKxOYDOpbmJ4X357JRGWViAOmqyqd6bu_w47mffw@mail.gmail.com>
 <CA+55aFxpzgQiJg8XyQTH-hDHd7A0jRAtOJ8b6krrvNDQX96Vrw@mail.gmail.com>
 <CAGXu5jJaTR25zZp5sGqc6m3nv3AunYhEZhxtB_JuP2WFbv_pfg@mail.gmail.com> <CA+55aFyknMsiT3efAeOyf32O2NJjD9vt0XxtAegFVmmn+pvxgA@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 6 Mar 2018 17:58:26 +0000
X-Gmail-Original-Message-ID: <CALCETrWpt3ckn0jpDS_J7Da053-gi27ddbK8zEBicpeFWuhP_w@mail.gmail.com>
Message-ID: <CALCETrWpt3ckn0jpDS_J7Da053-gi27ddbK8zEBicpeFWuhP_w@mail.gmail.com>
Subject: Re: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in syscall_trace_enter()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@linux.intel.com>,
	Alexander Popov <alex.popov@linux.com>,
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
X-GMAIL-MSGID: =?utf-8?q?1594212094633524422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 4:30 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Mar 5, 2018 at 4:56 PM, Kees Cook <keescook@chromium.org> wrote:
>> On Mon, Mar 5, 2018 at 1:40 PM, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>
> I was actually hoping that the clang people would get rid of those,
> but they only seemed to care about VLA's in structures, not about them
> in general ;(
>
> I detest VLA's, we really shouldn't use them. I'm sorry we have any.

Then we need to fix our abysmal synchronous crypto API, which, AFAICT,
is the primary user of on-stack VLAs in the kernel.
