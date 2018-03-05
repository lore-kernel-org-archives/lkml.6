Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520287113; cv=none;
        d=google.com; s=arc-20160816;
        b=RWdnvKaFmRzjIB5k5ouRoh01OKIeL/oL7qXB3H3SskiRZyxpLVgw+Dgps5Ybzz7S9+
         NKVSUA77YfPSu69wfUr1dznY7iGH43iEVFhQEM08wo6/kfefy7IEIDiSO/RxAc1VO2Us
         lyG5PfS3YFc/QwQRE2hkodxWq/8ujn+wCEFHIT8btCaWL51xCP1gresqWXyy+z63ONXr
         xYIsXpBQx4I6upaLLyNg994L/dn7nWe/7ObRuUHqIryx1ZndYtryhWIOZxdqz4IBINi4
         91z4AkdWCGSbUqIck2pPFLj775Q9+dHDpn78xit4/2f+3f2cqiZBvVM56Xzeg+r2p/55
         1x5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=D8+sDlZ04A6nU8lPrFC+GGw5cVy+BdRREk66oqQ5sYE=;
        b=1AzvJ5EF6ApuJvYT7Z2s5KjXzs0OEXRyd1xadUEhFGE6xQRiW9FI4ZfjybKLnZVnHx
         V3UaXTurjiwi51J4++fU8s9hJFc/0JyilfK5kz9p8bQLQ+7vmrt/g+t32QvwzNB8pC2Y
         d68T7hXkzoWAN22TEjmtvOTl3cLQMmdR/brjWTssxmZMc1NaPBX6ULxXgpVLxsGBHVOB
         w/uqp7Fii3GdCVOjfMKqQL2tUaLNdB7DuI+qVfil3jqP01O70qyRCpnJ/TEOLf3Xu1NR
         uYO/i0bFjk5sf8oIOH65ucga1FyrsB7zqOdbxdnsnkfezzZHPok14cyyeygESihE7KOr
         m4vQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SCzKqx0Q;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=U5O9dcgX;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SCzKqx0Q;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=U5O9dcgX;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELvqP1w8BiwLwKYwpDgTN/9Ma+54qJ2E/mWvAUbVjmjIIAsbCWmJXbctTJIcdB3EMEOj1sHR+G+mzBsllJ9iNss=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180305213550.GV16484@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
 <1520245563-8444-8-git-send-email-joro@8bytes.org> <CA+55aFym-18UbD5K3n1Ki=mvpuLqa7E6E=qG0aE-dctzTap_WQ@mail.gmail.com>
 <20180305131231.GR16484@8bytes.org> <CA+55aFwn5EkHTfrUFww54CDWovoUornv6rSrao43agbLBQD6-Q@mail.gmail.com>
 <CAMzpN2hscOXJFzm07Hk=2Ttr3wQFSisxP=EZhRMtAU6xSm8zSw@mail.gmail.com>
 <CA+55aFwxiZ9bD2Zu5xV0idz_dDctPvrrWA2r54+NL4aj9oeN8Q@mail.gmail.com> <20180305213550.GV16484@8bytes.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Mar 2018 13:58:32 -0800
X-Google-Sender-Auth: RN-OJg34hhXtaWx9CRJX-Kh71s4
Message-ID: <CA+55aFx2dxZmL487CnhV6rWRiqmJwZNAspyPqCD4Hwqxwncs6Q@mail.gmail.com>
Subject: Re: [PATCH 07/34] x86/entry/32: Restore segments before int registers
To: Joerg Roedel <joro@8bytes.org>
Cc: Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
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
X-GMAIL-MSGID: =?utf-8?q?1594136580270844712?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 1:35 PM, Joerg Roedel <joro@8bytes.org> wrote:
> On Mon, Mar 05, 2018 at 12:50:33PM -0800, Linus Torvalds wrote:
>>
>> Ahh, good. So presumably Joerg actually did check it, just didn't even notice ;)
>
> Yeah, sort of. I ran the test, but it didn't catch the failure case in
> previous versions which was return to user with kernel-cr3 :)

Ahh. Yes, that's bad. The NX protection to guarantee that you don't
return to user mode was really good on x86-64.

So some other case could slip through, because user code can happily
run with the kernel page tables.

> I could probably add some debug instrumentation to check for that in my
> future testing, as there is no NX protection in the user address-range
> for the kernel-cr3.

Does not NX work with PAE?

Oh, it looks like the NX bit is marked as "RSVD (must be 0)" in the
PDPDT. Oh well.

                  Linux
