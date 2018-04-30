Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525132123; cv=none;
        d=google.com; s=arc-20160816;
        b=0B6nJ1EA/oRy2Wza1F65jaeweeZ3y39IvTwAyVk8Fk/iTtL2Mvg4edLurnBhmSsVFE
         IOCTaO9DjelOvSHNK2vtqkDd5czdRzi44GJjAANHcBUo5tRUVyXGqzrwwVjbC8U5A/u6
         4u3LdIyl3ZABrQ6yeOdBq6ebVOYjxreAXDR9M1LxReYkIK9+bbOM9xorDkz+gFocwhZs
         egw2yY8Lol1V1IFumHZrCFr3vad5pn3cyUN3d5vy+FOdOdoyB/A/W87y7HS0M0nrfmA9
         Lr3bbE9G+W5c+1FXlTfITajyMOj5Yx3ubOY8rCB8ITAXXBfeItO5sLGOoJBkk6Zgz7GA
         H2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=rqhm8mkzO4Djr2jlFRM4eKFqPE8FDlNkXsrHn1LeY9M=;
        b=Y/pQimRifbd2e8Hz8X6jWMQUqxETGy0BbmNFH1MmKJ+D9vIAjHdElRXvogHSmqyCa4
         ijYPb6fFi30v6gQovA066bhvzP1JKUnksQT8NDDWh7uOo86TIQGnc0bni8EaAGe0N43b
         0SIZkDfeFuV9cyiGnL4RmWWT4KTuy7j9ySOhCHM8U3UySdMdXX6ayHSaGSiBDrG6wssO
         axfOfp7+G0Hl6Df1QTWgGp2UqoJGkUQP2/J6BKqGf7dcY3E33wKFCPdMQ0pj9lVTq9+V
         H3tYwjM1Ci5eodVuOstNSt1FcaXSJBm7RiKD1GH+Cboi+c+B3oThAma/LXxPNue3Nj7+
         2l1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=cqdz6LId;
       dkim=pass header.i=@chromium.org header.s=google header.b=P5t/K4eD;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=cqdz6LId;
       dkim=pass header.i=@chromium.org header.s=google header.b=P5t/K4eD;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZruihnOaJ7syio2VNTBQ0VaEbtWEk1CUFc+ZM1OUfzZJxk5FpFwUPBpLERlOrMVAY4hJHOq430RZGsUC50dVKQ=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <4e668302-8754-3f4e-3372-d0d7ba30cfa3@linux.intel.com>
References: <1523024546-6150-1-git-send-email-alex.popov@linux.com>
 <1523024546-6150-3-git-send-email-alex.popov@linux.com> <4e668302-8754-3f4e-3372-d0d7ba30cfa3@linux.intel.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 30 Apr 2018 16:48:41 -0700
X-Google-Sender-Auth: h8qHM7aI5Zj_pV1TaX1phPF3TkI
Message-ID: <CAGXu5jJ_0e63QSv0YZsQoT_=zN8U-83nwxrQ10h=QjszbHK-aQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/6] x86/entry: Add STACKLEAK erasing the kernel stack
 at the end of syscalls
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
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
	Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
	Boris Lukashev <blukashev@sempervictus.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597007022879408472?=
X-GMAIL-MSGID: =?utf-8?q?1599216940850648612?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 9:23 PM, Dave Hansen
<dave.hansen@linux.intel.com> wrote:
> Hi Alexander,
>
> You can add:
>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
>
> for this patch if you like.  I haven't taken a super close look at the
> rest, but this is certainly minimally invasive from my point of view for
> the entry code.  Thanks, again for reworking it.

Thanks Dave!

Given this improvement and your review, I'm going to start carrying
this for linux-next. Linus, if you're still opposed to this even after
the changes here in v11, please let us know. I'd rather hash things
out now instead of during a NAK in the 4.18 merge window. :)

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
