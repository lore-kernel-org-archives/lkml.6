Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520285763; cv=none;
        d=google.com; s=arc-20160816;
        b=jz31ktGOrXVvkqnCthzBK7nim3gpiIt7atkywpoXvUYYMjgRiRgYmvO1nzGQuI1C2b
         Mxll8R6NEdXFZZqFMgqgP9WbLOjttvhPuRDINfvQL5GvHz3w79MBijvI+GZOaRuyPgvl
         bpNyx7MThbm3KkNSrUsizmfI4D1+CqViNsrdJ4sHTAlShaMWM0zYewjh+Y68/optgy4Z
         XJyIZyT2D24NXbgmUypg04kFxd1Nq4eGM2O5g2y1Eoa6aQuhqyYpec2yjT0Xrfnsk33S
         ytY8oyIXmRgVhETiXRbYkwGEf7zsbr3l3wMVFymmece124Kltjd5T/PdEquZeyd91mzT
         ikFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=nH4/+MrbblmnhL8cmzeJEbuWBaMg3iFgKfv1tcT2WRA=;
        b=0X15E3XeSy+07NW7NwzmaG0PEazDBF+OXXHIenS3JEwhyjstLNQcXXmnCMrRCicBhr
         fMQhzeULg/wNLvcrkqr0ZiLHcD5OcADcu4EL7AdW79Ro7fsUfqyRiJzu9dGUJ7Y1jazM
         aOlld1J5Lsk4b1H6zLEgtolRiIi69CmoWOBTF0JmuBwGnuxzppLWm/xGQTxDsANjnfHk
         k+bUat9doUHl0NSL4iZ9c1n0k34eb+VZfDpkYxas//PY5xvzxIQbv/Fz1X2FhVpyM1lS
         gJI32hXpQSGqplMWdJFOqGUgdJEJ9+IlLgVid/0LdGwY9yqC7RJQIJuucNdGG3jPPwqQ
         ebIg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SOZ333G2;
       dkim=pass header.i=@chromium.org header.s=google header.b=BWj1atfs;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SOZ333G2;
       dkim=pass header.i=@chromium.org header.s=google header.b=BWj1atfs;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELunU/BsNq7jx7hyWhffvMPfqEU7HlmeTG14FfYjm/Bvm4noiMl2G8kKnI6ziQHTBYRxfVkNn9s8t+IJIYLBNV0=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <b6abd009-8f64-c5a2-6496-6affb31ad75e@linux.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-3-git-send-email-alex.popov@linux.com> <d968e58a-3abd-8e3c-cee3-00c19c1b6430@linux.intel.com>
 <94f268b2-31a4-620a-86ed-325d5bb33c57@redhat.com> <20180305202535.GX25201@hirez.programming.kicks-ass.net>
 <b6abd009-8f64-c5a2-6496-6affb31ad75e@linux.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 5 Mar 2018 13:36:01 -0800
X-Google-Sender-Auth: rxKex_gJDMBdlGpTVnz5yxDeI8U
Message-ID: <CAGXu5jKNsp4WKUJQZ81NWciOGYBGAdVhiSQy9Qa-JAY84LiwmQ@mail.gmail.com>
Subject: Re: [PATCH RFC v9 2/7] x86/entry: Add STACKLEAK erasing the kernel
 stack at the end of syscalls
To: Alexander Popov <alex.popov@linux.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Laura Abbott <labbott@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>, Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, Borislav Petkov <bp@alien8.de>,
	Richard Sandiford <richard.sandiford@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	"H . Peter Anvin" <hpa@zytor.com>, "Dmitry V . Levin" <ldv@altlinux.org>, Emese Revfy <re.emese@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
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
X-GMAIL-THRID: =?utf-8?q?1593947982901315923?=
X-GMAIL-MSGID: =?utf-8?q?1594135164017141339?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 1:21 PM, Alexander Popov <alex.popov@linux.com> wrote:
> On 05.03.2018 23:25, Peter Zijlstra wrote:
>> On Mon, Mar 05, 2018 at 11:43:19AM -0800, Laura Abbott wrote:
>>> On 03/05/2018 08:41 AM, Dave Hansen wrote:
>>>> On 03/03/2018 12:00 PM, Alexander Popov wrote:
>>>>>   Documentation/x86/x86_64/mm.txt  |   2 +
>>>>>   arch/Kconfig                     |  27 ++++++++++
>>>>>   arch/x86/Kconfig                 |   1 +
>>>>>   arch/x86/entry/entry_32.S        |  88 +++++++++++++++++++++++++++++++
>>>>>   arch/x86/entry/entry_64.S        | 108 +++++++++++++++++++++++++++++++++++++++
>>>>>   arch/x86/entry/entry_64_compat.S |  11 ++++
>>>>
>>>> This is a *lot* of assembly.  I wonder if you tried at all to get more
>>>> of this into C or whether you just inherited the assembly from the
>>>> original code?
>>>>
>>>
>>> This came up previously http://www.openwall.com/lists/kernel-hardening/2017/10/23/5
>>> there were concerns about trusting C to do the right thing as well as
>>> speed.
>>
>> And therefore the answer to this obvious question should've been part of
>> the Changelog :-)
>>
>> Dave is last in a long line of people asking this same question.
>
> Yes, actually the changelog in the cover letter contains that:
>
>   After some experiments, kept the asm implementation of erase_kstack(),
>   because it gives a full control over the stack for clearing it neatly
>   and doesn't offend KASAN.
>
> Moreover, later erase_kstack() on x86_64 became different from one on x86_32.

Maybe explicitly mention the C experiments in future change log?

-Kees

-- 
Kees Cook
Pixel Security
