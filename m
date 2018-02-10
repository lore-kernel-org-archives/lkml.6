Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518293898; cv=none;
        d=google.com; s=arc-20160816;
        b=V8f9mlGkN2Tiulp11xqSjRyB4mLJxd0Eo6oDuyS/S84k1Mi4ItIyfJWo884cZ3kAPu
         4T24MwNUjhFTSCZGJ58sG069eTZ9MUQGuUpn+e2kUhJOsCQc7k3Hhg9iW5SJb715yuS8
         iawReBEuitQ311aRhEpNj3FlCNPDfZU4hmvKcGulLac1FEJsDuru1T+OAP0EAfFjvSuy
         oeToszJOOXTstozqsqcBMgnNYIfS8RtF6Ocy5fXinNyS/wLoIS95HLtjiS/5Kr2Bkaq+
         lWTvKRc/W0tXgwvopKnGAjc7UVFRmYIZdcrqbJFW+gmiVmf4jouom4IZUb2K9O4AZTiP
         o2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=5DqJm5YGfCXe/ZoaNAp21MK1DqvzkYY0Fu93uulpIM8=;
        b=ccqls0t8yKxSB7aaU6GLcsd4BCFkg8sR1DGgGodAmJ3t+IkOLNW6VNPUlE4Ta19PWX
         oZCcUwhPERK7kpQdoaLBOsFcqA9ge7l68yA2FFybcMj0sw5pSWsJF6DYXXO9i42MoHna
         I4PFdp2Q8X4FjnVfmJQloi/9LmXJywzOfINe9D3L63H/CZRcHRTyZBGBAHLhYcM13CZE
         9vppdFB0RsAHSqJvKqcHoRNe03ByVNs+YEjmmAJoGmrQznYJpL+Gx9NJU9r9vNG7C12v
         BNfpiujQTqcoM7jBgkdEpL6YhsfEN/MpNdM+6x7lqzHVyFosCQEECuKCd7UhptZ/YweT
         rl3g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gBlIkiNq;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gBlIkiNq;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x224Vl+43TdjPMjMCtvfkzYPIcy/1T5QvLIIQBoDeur7Am0N3GzVe819xRvlJN09Lnm6GoOD2AFcdgs3xN2A3ZE8=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <50431bff2cda445490f5242c1189c8cd@AcuMS.aculab.com>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-10-git-send-email-joro@8bytes.org> <CA+55aFzB9H=RT6YB3onZCephZMs9ccz4aJ_jcPcfEkKJD_YDCQ@mail.gmail.com>
 <aa52108c-4874-9810-8ff5-e6415189cd73@redhat.com> <50431bff2cda445490f5242c1189c8cd@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 10 Feb 2018 12:18:17 -0800
X-Google-Sender-Auth: CSQIqAjjyMekQx_MqWVreHvkCSs
Message-ID: <CA+55aFwdk9pGMxHpScf9jQAL0K0OkkghCWMrgxcrdFtYPbXmUw@mail.gmail.com>
Subject: Re: [PATCH 09/31] x86/entry/32: Leave the kernel via trampoline stack
To: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Joerg Roedel <joro@8bytes.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"the arch/x86 maintainers" <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>, Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>, Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>, Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904027044040?=
X-GMAIL-MSGID: =?utf-8?q?1592046542691348553?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 10, 2018 at 7:26 AM, David Laight <David.Laight@aculab.com> wrote:
>
> The alignment doesn't matter, 'rep movsl' will still work.

.. no it won't. It might not copy the last two bytes or whatever,
because the shift of the count will have ignored the low bits.

But since an unaligned stack pointer really shouldn't be an issue,
it's fine to not care.

>> Indeed, "rep movs" has some setup overhead that makes it undesirable
>> for small sizes. In my testing, moving less than 128 bytes with "rep movs"
>> is a loss.
>
> It very much depends on the cpu.

No again.

It does NOT depend on the CPU, since the only CPU's that are relevant
to this patch are the ones that don't do 64-bit. If you run a 32-bit
Linux on a 64-bit CPU, performance simply isn't an issue. The problem
is between keyboard and chair, not in the kernel.

And absolutely *no* 32-bit-only CPU does "rep movs" really well.  Some
of them do it even worse than others (P4), but none of them do a great
job.

That said, none of them should do _such_ a shitty job that this will
be in the least noticeable compared to all the crazy %cr3 stuff.

                Linus
