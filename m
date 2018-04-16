Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523903355; cv=none;
        d=google.com; s=arc-20160816;
        b=QmsQvk2kTHnoGtdqY/NNT7CE0ie4Kk3BeAJtukHwjU1lSH6P/Tf70TPA0/ru4H7CJh
         /73cAh04GlESpZFVbQC30r50mrzLiHtayResQXZACYfoUxijK5hAENxkF+CA2T5ZyseW
         y3Cs5CRibAKqWIvZj+QaoDTxzMGbV2OuIF+oLv6n2+evutvmQiIrLbzkDcZhqEnpErwx
         S3+PUSQGr6TztMs/KEk8GW7crZtEUqhTn5qHSz/7ZDj0198l5HJuwb/itKePaidyErem
         4dnXxa12ZJIOVZdJsmzuAHPxemDkaL+vEWriOCPvshmPyPoT74iLZWGcmDnalW8ng+ua
         FMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=1IWjPxj81AM/BeFE1BOv32XSDwKpfNZ26wsdamAnSbE=;
        b=XPggzeDQjdjbgSZfC002+xnh9XmWo57VsNNFNh0tepXjt2Hri9dvw62EbiL4nlRod5
         DM2ZaejKXtkoi/Bqdcm1rh/HG7+JaGmVieLltQjFLVJJbczVIcyOVMCm0QfqTIcEemLV
         rj72R00QChtAQjBojR/MYFvZiYNZJ0AIMcJnjtXIXUpX/DJB/YTvLGJCG5TTD5hQOqvf
         l/BP2LHr+jGjleb9nhmi9Q2sRZoiJw6yg593vQF2bKKB96nXt3Z3m3r9txm8dE0xvcgS
         Jg0YSrD41BO8KkH7C8N2YXmX1lrkyJf2DD8BDvgE1HlImjsBRxFXAUvLq3St+m000awq
         K43g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=NvAF+582;
       dkim=pass header.i=@chromium.org header.s=google header.b=HORN0uzb;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=NvAF+582;
       dkim=pass header.i=@chromium.org header.s=google header.b=HORN0uzb;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4+ihx6ST86jjng3FMlAnOKcSOwOt3gUn0M+d91Ip8T2LRj5zW1hkGDOXskPfkrJUfaglG6GkLsDoN9VxuRkq+w=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1523024546-6150-3-git-send-email-alex.popov@linux.com>
References: <1523024546-6150-1-git-send-email-alex.popov@linux.com> <1523024546-6150-3-git-send-email-alex.popov@linux.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 16 Apr 2018 11:29:13 -0700
X-Google-Sender-Auth: CUaChLBr_I122P_ywfFFQPNhXnA
Message-ID: <CAGXu5jKm218fpxyV3vOM+2SO-ERG3tWPUV0x8+-S0MJAReFz+A@mail.gmail.com>
Subject: Re: [PATCH v11 2/6] x86/entry: Add STACKLEAK erasing the kernel stack
 at the end of syscalls
To: Alexander Popov <alex.popov@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Laura Abbott <labbott@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, PaX Team <pageexec@freemail.hu>,
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
X-ccpol: medium
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597007022879408472?=
X-GMAIL-MSGID: =?utf-8?q?1597928484779950853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 6, 2018 at 7:22 AM, Alexander Popov <alex.popov@linux.com> wrote:
> This commit introduces the architecture-specific code filling the used
> part of the kernel stack with a poison value before returning to the
> userspace. Full STACKLEAK feature also contains the gcc plugin which
> comes in a separate commit.

Thanks for sending this again! And thanks for the updated reasoning
for why this remains a valuable addition:

https://lkml.kernel.org/r/1523024546-6150-1-git-send-email-alex.popov@linux.com

I, too, remain convinced this is a good protection to have, even as we
slowly remove VLAs and try to improve the compiler's initialization of
stack variables.

Dave, Ingo, Linus: how does this look? With the assembly rewritten
into C, the entry changes are very small:

>  arch/x86/entry/entry_32.S        |  7 ++++++
>  arch/x86/entry/entry_64.S        |  3 +++
>  arch/x86/entry/entry_64_compat.S |  5 ++++
>  arch/x86/entry/erase.c           | 54 ++++++++++++++++++++++++++++++++++++++++

I'd really like to get people's Ack/Review. :)

Laura, can this C version work for arm64 as well?

Thanks,

-Kees

-- 
Kees Cook
Pixel Security
