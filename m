Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520274240; cv=none;
        d=google.com; s=arc-20160816;
        b=P3+YLSI+l3rBexmsvvuu6RSOdpKdRD8VoZN+Hme9X8bZsqX2HehMA5VUvQxlbY32Y7
         Yi3d7Xi1VbDTGpvmC8y17ZZa8wViA6RIMg3oKlL7d8txDc4znlAPzsgqp/asEtC4GchG
         uIityVSxKlK6ik8Ri8ZBZHzqlX1OzhiBOSBKVOBBQ93mC31js85rV5rKpuuaV5cnHNWU
         l12FTYdlDpuCz3bDDRguXAURuRUV+b1ChrFMvSnbPFMEkQADJplagQjHXWAoOl+X4Js9
         Eyu3uddXhP+HVAubZa5Ttd7V/yFLs2x7YiTyGLWzj7r/ysIFiZPb3HeXRvYE36jsZSyC
         fhfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=1QA5HB/Ws/FGBbTznxvPXKMN1Jkg/65sWe+aV0LJlT0=;
        b=vGuJAZmqxXCMOth3S3OtcUG+BbmmOuiPWJOa7Bxn1SYHyHmweANt3Pb3VQmNLoT1Uc
         5rACg20uLO8ryc0Bei4LHIz02RYQPQC14xTTnrjG62r0DGriVORRRbSIh4EJmPqpkA8x
         Xw05G/ryj/h9vA6ZxjgZ6aceQt/4ih9kQSzNig16qcjUPep7C/y2tv6QiTa3nij7MPqe
         G9e6/e5Vf3j1A2u52jJHpxTHfGk0KZuIzHvpj/ZCGHwVoEC5CZkg3sVUgjFO3G6x0oeg
         W5cjvdQ58GzISzkVQIc3wjg7i/C19fPOLkEaX15u/UhZ5Gvcp1UjTxWZzoennqFBt8XP
         q0bA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O2nhZ4t4;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=LuvWwWsD;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O2nhZ4t4;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=LuvWwWsD;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELvDqPN0E3l0Mx58Oyqd/dK7eRUjEcPHfN0RSazV3/0AO28W58scy9hoSRVrvuwJrXwzHAyEIEMDhPZ1/2xLISA=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180305131231.GR16484@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
 <1520245563-8444-8-git-send-email-joro@8bytes.org> <CA+55aFym-18UbD5K3n1Ki=mvpuLqa7E6E=qG0aE-dctzTap_WQ@mail.gmail.com>
 <20180305131231.GR16484@8bytes.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Mar 2018 10:23:59 -0800
X-Google-Sender-Auth: c8dcRYPvap0uRrBrOYcGIc1ZUB4
Message-ID: <CA+55aFwn5EkHTfrUFww54CDWovoUornv6rSrao43agbLBQD6-Q@mail.gmail.com>
Subject: Re: [PATCH 07/34] x86/entry/32: Restore segments before int registers
To: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Anvin <hpa@zytor.com>,
	"the arch/x86 maintainers" <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, Andrew Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
	=?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
	Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093021030252223?=
X-GMAIL-MSGID: =?utf-8?q?1594123081917115936?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 5:12 AM, Joerg Roedel <joro@8bytes.org> wrote:
>
>> The things is, we *know* that we will restore two segment registers with the
>> user cr3 already loaded: CS and SS get restored with the final iret.
>
> Yeah, I know, but the iret-exception path is fine because it will
> deliver a SIGILL and doesn't return to the faulting iret.

That's not so much my worry, as just getting %cr3 wrong. The fact is,
we still take the exception, and we still have to handle it, and that
still needs to get the user<->kernel cr3 right.

So then the whole "restore segments early" must be wrong, because
*that* path must get it all right too, no?

And it appears that the code *does* get it right, and you can just
avoid this patch entirely?

> The iret-exception case is tested by the ldt_gdt selftest (the
> do_multicpu_tests subtest). But I didn't actually tested single-stepping
> through sysenter yet. I just re-ran the same tests I did with v2 on this
> patch-set.

Ok. Maybe we should have a test for the "take DB on first instruction
of sysenter".

           Linus
