Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520283034; cv=none;
        d=google.com; s=arc-20160816;
        b=TUWTv9BXaon8Zud3Cx+ovXd7jZVAtEEgeMtARdkqYgXQyi6Nutouw9vdNC+x20+7JD
         F+kqh/qIx40277IfOd+aBDu7rXrwqS/e8AkwkIjYh34LoFS760MF6p/ppHBvNkRvRlJS
         vX+WghLi2dIoKIj2eVc941RrU9OlhBnSQRmExpGZrUDCoOhvFl9Jd1Awz3PdkRirRvfy
         4RcTqg4NSx241M+avwqiPenrDpAeCkNjk6UNZcNK8qzhW6KBpvWyNgb6IN4xBAjHZ5un
         WVbAJm2PQWfyDWrj0DY8WQmqivgoGOgwZfPQCgWbjaRI4UGHdrUi53lsQ6fGv3pYVfLR
         BFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=tPMNLL6jSGgK5hC7/WN4eXz8+6UQUsCToXPTI/kzYNI=;
        b=pvp9/YO7lIXAGnFX006sEt/SCmGK2Xn5BsrQMoGODT6dXgJxJAHuCSyEanU6N3AVkc
         fFW5u2vukxENwX23trqSmK5PnIsgDgd/5RMXLSSMFAinVmSr/OR6cUP9UvbmOFZT3Bwa
         M+bPE4IlIVpK31+zkYNk2bAnL4056VI8v8wleiaOmbSh7nTfU6Q1hxkWJRk+RP4Sfxsl
         xV+uoRZp5hIr2y2h6tV58VDSe9+S7tQF03UJaeNgWDhLwDOqg4dSLVCxIfdVyZHO7QTa
         Bar7g5UrFEyybw4gmMW6TWARgWr1cjfvXHkCd4AwO1X0t+TL17jbpeIYYcz2p1dVu6yh
         eWdg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=H726PbS4;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=MqCKO7pp;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=H726PbS4;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=MqCKO7pp;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELuBLu/GEkeYjSCS2Okrar7GH0+qmUjaSRveCOpJyPq6nAWDzfpth9jCZyZFN3fNKaR/nyPFz3/07LjRrKT1Em8=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAMzpN2hscOXJFzm07Hk=2Ttr3wQFSisxP=EZhRMtAU6xSm8zSw@mail.gmail.com>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
 <1520245563-8444-8-git-send-email-joro@8bytes.org> <CA+55aFym-18UbD5K3n1Ki=mvpuLqa7E6E=qG0aE-dctzTap_WQ@mail.gmail.com>
 <20180305131231.GR16484@8bytes.org> <CA+55aFwn5EkHTfrUFww54CDWovoUornv6rSrao43agbLBQD6-Q@mail.gmail.com>
 <CAMzpN2hscOXJFzm07Hk=2Ttr3wQFSisxP=EZhRMtAU6xSm8zSw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Mar 2018 12:50:33 -0800
X-Google-Sender-Auth: C9yrtpcJvghz2SoSVgGDr0sZt88
Message-ID: <CA+55aFwxiZ9bD2Zu5xV0idz_dDctPvrrWA2r54+NL4aj9oeN8Q@mail.gmail.com>
Subject: Re: [PATCH 07/34] x86/entry/32: Restore segments before int registers
To: Brian Gerst <brgerst@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Peter Anvin <hpa@zytor.com>, "the arch/x86 maintainers" <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	Andrew Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>, Eduardo Valentin <eduval@amazon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>, Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>, Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093021030252223?=
X-GMAIL-MSGID: =?utf-8?q?1594132303119783253?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 12:38 PM, Brian Gerst <brgerst@gmail.com> wrote:
>
> There already is a test: single_step_syscall.c

Ahh, good. So presumably Joerg actually did check it, just didn't even notice ;)

            Linus
