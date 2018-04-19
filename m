Return-Path: <luto@kernel.org>
X-Google-Smtp-Source: AIpwx4+MYP0hDxyWKL5Z/5k6NXYyJnb9Y/vSNP2xPw7EwBxH1wITH+nzYSywhLKUTadDH9XszNVB
ARC-Seal: i=1; a=rsa-sha256; t=1524098720; cv=none;
        d=google.com; s=arc-20160816;
        b=N0zlLicU1eFudfPz5pjUWekzi3jWFgfaIwGLp+dsyM0M3jz9qI8V873SZzfY9TIzrK
         u81DtrBGWfThnPKM/tnlyGqAceRxmVkY2KC5L05XXVpqFuC4xLAa0jKNB0JjJMAaKY/G
         cy/TqWGsT55jW56hGipI6OogoNW6c979UJ441EQFUYEc2egKPFwj8vj47EhIheMX6sDF
         2LGristL8phkRyj3HT4TKtxdBt1XhjStqbvd8Asf2PFzLSFTEJ54k2Zknnfe1xm22NL5
         hrXMFZ2B8yZhnUf7TwU3wdOpMETgf7ZJEVEl7m8VOLDC6F1lM+fXCU2pE/nTZGqv0xVI
         B5sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dmarc-filter
         :arc-authentication-results;
        bh=T3xIo4ODe7f8JJz6pwimCqyJVFsthsJf9mIL2gWr3B4=;
        b=RT/G7tvPXnBX7hUmxHoRakjwMvUkrhD787te9UluUroQEovt419QVQI/V9nFz1+fq+
         x3eIT68rXA8hilq6jjFPEhT8ymNwgA8ew0wp9fJiapQhrmFNqQ5aTZvSNrZ4bVwJ8JLL
         DCAlYiLZs8wM73f01D2piXF42FQHIHMmbrxwStN1OEl/A1AYxoJu9bQ3KlpetnYlJj9G
         CAA8WIQDOXE90MQn9vd7jE1+K01NfvLibWk/PWGejS840gvNh3uSJ22UyYQaWTYIdrsm
         LSs7M47ES5F0WdDep1+A05QB/ZbxPOE7Pmjl7TEiUehYJyIUuKgdAY4Yyvrp4M9J3DOa
         q8Hg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB47217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180419003833.GO6694@tassilo.jf.intel.com>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
 <1523892323-14741-4-git-send-email-joro@8bytes.org> <87k1t4t7tw.fsf@linux.intel.com>
 <CA+55aFxKzsPQW4S4esvJY=wb7D3LKBdDDcXoMKJSqcOgnD3FuA@mail.gmail.com> <20180419003833.GO6694@tassilo.jf.intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 18 Apr 2018 17:44:56 -0700
X-Gmail-Original-Message-ID: <CALCETrWYdug6cY_ZjGPV19baFWb_VZxMHGmfxnoJfnXP7z=1Sg@mail.gmail.com>
Message-ID: <CALCETrWYdug6cY_ZjGPV19baFWb_VZxMHGmfxnoJfnXP7z=1Sg@mail.gmail.com>
Subject: Re: [PATCH 03/35] x86/entry/32: Load task stack from x86_tss.sp1 in
 SYSENTER handler
To: Andi Kleen <ak@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Joerg Roedel <joro@8bytes.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"the arch/x86 maintainers" <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>, David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>, Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>, Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>, Waim@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916934570630846?=
X-GMAIL-MSGID: =?utf-8?q?1598133340349187788?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 5:38 PM, Andi Kleen <ak@linux.intel.com> wrote:
> On Wed, Apr 18, 2018 at 05:02:02PM -0700, Linus Torvalds wrote:
>> On Wed, Apr 18, 2018 at 4:26 PM, Andi Kleen <ak@linux.intel.com> wrote:
>> >
>> > Seems like a hack. Why can't that be stored in a per cpu variable?
>>
>> It *is* a percpu variable - the whole x86_tss structure is percpu.
>>
>> I guess it could be a different (separate) percpu variable, but might
>> as well use the space we already have allocated.
>
> Would be better/cleaner to use a separate variable instead of reusing
> x86 structures like this. Who knows what subtle side effects that
> may have eventually.


This variable is extremely hot, and it=E2=80=99s used under the same
circumstances as sp0, so sharing a cache line makes sense. And x86_64
works this way.

>
> It will be also easier to understand in the code.

I suppose it could go right before the TSS, but then we have potential
alignment issues.  We could also muck with unions to give the field an
alternative, clearer name, I suppose.  But this patch should go in
regardless and any cleanups should be done on x86_32 and x86_64
simultaneously, I think.
