Return-Path: <luto@kernel.org>
X-Google-Smtp-Source: AH8x227t/AlQbjAKVwVzzNRWHExyzzPQDZgcncLNDGHcEVljnyZICkD1aiHGuz3tBIlSK0YQEmXS
ARC-Seal: i=1; a=rsa-sha256; t=1518198257; cv=none;
        d=google.com; s=arc-20160816;
        b=VbaxmYTbcpMLZPeuY6unxUJPIAO354yIjUl0ZbC0NURpGnA9FOLD50KQ9+nfwArhVK
         z/KXZS/GYlR3zy8WMFduZzObrOZ44qJ5MCbvOOqVKAG4peeGF1g/7tps2D+Ih3QpAQs6
         bEI8WUrCirWeLE6aWxCZmCdB1US4r6UGWdTmrZTVF5tZeqbCgXSuWNcnOJlgoi/6mKq5
         Xk0VWQbrAWha0FhHQnsb6pwHKbOjZJ9j+ZqEdHhUFRVF4Vi6ZAzUVqrukl3mezy5sQHa
         V6vgeLmo+3IOyQwNW8U7TjTrAtt7CGIK0/0wKwVYJFk+70fC7RtqFJ1PTroiwGq3zjS0
         ZvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=P8KTBg3iLuVyL9jSaX8eR7aypHZCGYIPCvaNHp4ulkM=;
        b=rI606RgmNJWzUqErzZXT7FrDr18ycc1Q+JxG9dBnVQXsJMHsM9AWgOHvVEpN0H72z/
         ltdLm0Z4GAx4e4fEe0agiu03VI/rge2PJWg5LT8fQmU/PgzOMKDVOp5Ng7cf2lUL7xq2
         7wjkClolK71aEdlAlYL7lAbEC6tToRg5qliiUaWlOgY4G2TOP1kDZHs1A2329isaVvsB
         NjxxkmIN+IHboNxrtZDfq9Xwioxnr6RdrVBOvmyaEI47wm8SU5jzw41sOkuZ31c0nJMg
         QGpGF1j1Ixz184HXx11XSa2aCqG0MOVI4/P71yjfw+CDxno7erOdn3ynfpKGV0SAsz1Z
         vtVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5582217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
MIME-Version: 1.0
In-Reply-To: <CA+55aFzB9H=RT6YB3onZCephZMs9ccz4aJ_jcPcfEkKJD_YDCQ@mail.gmail.com>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-10-git-send-email-joro@8bytes.org> <CA+55aFzB9H=RT6YB3onZCephZMs9ccz4aJ_jcPcfEkKJD_YDCQ@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 9 Feb 2018 17:43:55 +0000
X-Gmail-Original-Message-ID: <CALCETrUfMk67QeubuujbzKXeJFT4hBcq6kuAX3r1bOOeU1bNSQ@mail.gmail.com>
Message-ID: <CALCETrUfMk67QeubuujbzKXeJFT4hBcq6kuAX3r1bOOeU1bNSQ@mail.gmail.com>
Subject: Re: [PATCH 09/31] x86/entry/32: Leave the kernel via trampoline stack
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, "the arch/x86 maintainers" <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
	Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904027044040?=
X-GMAIL-MSGID: =?utf-8?q?1591946255558524898?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 9, 2018 at 5:05 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Feb 9, 2018 at 1:25 AM, Joerg Roedel <joro@8bytes.org> wrote:
>> +
>> +       /* Copy over the stack-frame */
>> +       cld
>> +       rep movsb
>
> Ugh. This is going to be horrendous. Maybe not noticeable on modern
> CPU's, but the whole 32-bit code is kind of pointless on a modern CPU.
>
> At least use "rep movsl". If the kernel stack isn't 4-byte aligned,
> you have issues.
>

The 64-bit code mostly uses a bunch of push instructions for this.
