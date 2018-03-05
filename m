Return-Path: <brgerst@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520261490; cv=none;
        d=google.com; s=arc-20160816;
        b=ojytjJagZsXUncj3esvIO4z0oo8prs6TosrXNRTL+uu2607rU+yNAhYVbI7uF+KQfg
         1YtkbwZ9+IDoxFj5tn2THp8NLkdYNj8ktonK+7t95NPAFldRIzFBiaA0UgnTkfT7DpY5
         oAtVX5Yjw5cXrDKncpayI2WASpQixV5NpuXgYsN7FpCMHZtSMa6OpLhnfsbelCnM/j6k
         x90lic+DCcqp8139SesG5eUn88BNOo/mECEyQ8Z/CVZ4t9YlfEuAh1U6S/j6R+2FhxXV
         RDdByfKp9W123j8slDnZaM1VRvLIKx8pDTQjtoAUu5K1C5mc++OiIuTabu61AEpuEjqd
         O5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=wDhyNvvZP2AiwUiw4igZ2Spz8pQgeLknHc4+VcmYO48=;
        b=BFkLOYwsjCQK8oTBBGdr1IiTaLNcI5Ka4sFe4QXakGQzUop9P2vEPRAiEnzVrIcDTx
         eQHFK52FcDw/IZ7zsdvgWzQFFgQXI0A5vDVijambaEx+Jev8C1yCSUKMqcEdfUYugwm6
         oiOrssnxAZHNYVsdh4h6lb494VIJ7NmpF0hJIRQVkt6IR0Va6BquAmgxC9pRq9bYvL7A
         9YDiwaLzwGd5BqknEzDLgNOJgurCD8MlrJqTTnEb+c/gJpva9IpbuES5cKxIPdUo3HPe
         CEZoOtl+4NI3LWK6o204ET6AS7L5oKI/8gq00Gy/x0HsywxQg8JdBmsrHt7N2WuGw+WR
         wdcw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OLgEu9cR;
       spf=pass (google.com: domain of brgerst@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=brgerst@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OLgEu9cR;
       spf=pass (google.com: domain of brgerst@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=brgerst@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsi0ilqxoIU9flRzqR4EcsN0x7/ItHGnMLVNxFukdeM8P59qaOCgCjth8q9hFqge/8QQpn0OzFxwTVu/ad03+o=
MIME-Version: 1.0
In-Reply-To: <20180305131231.GR16484@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
 <1520245563-8444-8-git-send-email-joro@8bytes.org> <CA+55aFym-18UbD5K3n1Ki=mvpuLqa7E6E=qG0aE-dctzTap_WQ@mail.gmail.com>
 <20180305131231.GR16484@8bytes.org>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 5 Mar 2018 09:51:29 -0500
Message-ID: <CAMzpN2gQ0pfSZES_cnNJSzvvGxbzuHdP0iAjx5GG5kJ6FGudbw@mail.gmail.com>
Subject: Re: [PATCH 07/34] x86/entry/32: Restore segments before int registers
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Peter Anvin <hpa@zytor.com>,
	"the arch/x86 maintainers" <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, Andrew Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
	=?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
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
X-GMAIL-MSGID: =?utf-8?q?1594109712168547718?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 8:12 AM, Joerg Roedel <joro@8bytes.org> wrote:
> On Mon, Mar 05, 2018 at 04:17:45AM -0800, Linus Torvalds wrote:
>>     Restoring the segments can cause exceptions that need to be
>>     handled. With PTI enabled, we still need to be on kernel cr3
>>     when the exception happens. For the cr3-switch we need
>>     at least one integer scratch register, so we can't switch
>>     with the user integer registers already loaded.
>>
>>
>> This fundamentally seems wrong.
>
> Okay, right, with v3 it is wrong, in v2 I still thought I could get away
> without remembering the entry-cr3, but didn't think about the #DB case
> then.
>
> In v3 I added code which remembers the entry-cr3 and handles the
> entry-from-kernel-mode-with-user-cr3 case for all exceptions including
> #DB.
>
>> The things is, we *know* that we will restore two segment registers with the
>> user cr3 already loaded: CS and SS get restored with the final iret.
>
> Yeah, I know, but the iret-exception path is fine because it will
> deliver a SIGILL and doesn't return to the faulting iret.
>
> Anyway, I will remove these restore-reorderings, they are not needed
> anymore.
>
>> So has this been tested with
>>
>>  - single-stepping through sysenter
>>
>>    This takes a DB fault in the first kernel instruction. We're in kernel mode,
>> but with user cr3.
>>
>>  - ptracing and setting CS/SS to something bad
>>
>>    That should test the "exception on iret" case - again in kernel mode, but
>> with user cr3 restored for the return.
>
> The iret-exception case is tested by the ldt_gdt selftest (the
> do_multicpu_tests subtest). But I didn't actually tested single-stepping
> through sysenter yet. I just re-ran the same tests I did with v2 on this
> patch-set.
>
> Regards,
>
>         Joerg
>

For the IRET fault case you will still need to catch it in the
exception code.  See the 64-bit code (.Lerror_bad_iret) for example.
For 32-bit, you could just expand that check to cover the whole exit
prologue after the CR3 switch, including the data segment loads.

I do wonder though, how expensive is a CR3 read?  The SDM implies that
only writes are serializing.  It may be simpler to just
unconditionally check it.

--
Brian Gerst
