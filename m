Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518809900; cv=none;
        d=google.com; s=arc-20160816;
        b=1E+xxAClpKGoI/UTLPs/my3AGdar4LY2UW0HrENwTCaHtrZ6pzYLKw3ywkWVrlO64O
         DHzosakMwBMuc38fYAoBgzyqp2d7/6PpwVUFpPo64yL2W3q/OjwgAFFf6HcD5fsFzgeg
         CAH6NJ9F83ZNUUKSTQdHTNk5c54GsoqTsleiQbkFpU3caXGmrl9q0l7Q6A4Gv2FSxBVT
         aFxOUPgknSImCGr/Y7/gN1S/Ys25gWuzvq9e2gvpm79u6h2G7uljna1kD6xx87ek6JdB
         oqyvxSY7RyFBK/m8PIoWSFGyv6y5EJEvmTNN31PjPRVpqYCI+unYC1OrxZU8qPbw0dGC
         vCyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=qzRyTAaKL8PIagGaiujErUrKlts5ErHnYCehjhoU2aw=;
        b=nQ4a95QRb0ttcJlvOPE8M2IfsuZg+mR83gPHeImEfP2LEMi5ooqBoEvleBFc8KQ/iu
         ypmWTcGMS5hpKliZoTdxBOOJ8ZFix6Y2hmW/kZ+DU9Uge2mT+3DsPZSYy1+XAU6q8C1c
         MzOeObxhL7wydhbZ8FWMRwYIMwwTElcZZq//O+i5JLVIFHDyDwsm0nU8SlPRK6ONS7Uq
         LVr5LnW7Xlukbu/u2yJoASAHe4KGJ/fyEzN3Txos+tVZvIjcSHbTtuQMxKZrSzeD52Gs
         guF36Vi1I/3Q0eCJc6YAVrEJO0L67oPp7q5/xdD9/7SXLhspnIRWUSiYmMWCcH4lmSyF
         jApA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=e7M7ogQR;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=e7M7ogQR;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x227wLUdeao5lOFsXQzXaNjhWdJEW6ssGf5XafbAaCFZd6N47/sHTRCT0e8R+NPQudynCnWB95sf3tkuMr0GYyYk=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180216191755.6F62DDEA@viggo.jf.intel.com>
References: <20180216191755.6F62DDEA@viggo.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Feb 2018 11:38:19 -0800
X-Google-Sender-Auth: UEoThBX8IE0NAEEM3kgt4Ej19os
Message-ID: <CA+55aFwgxWj95pUxpWL0N0uzHBmyEL7NFveC70ZtJ4ONFX45=Q@mail.gmail.com>
Subject: Re: [RFC][PATCH] x86: proposed new ARCH_CAPABILITIES MSR bit for RSB-underflow
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Rik van Riel <riel@redhat.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>, Kees Cook <keescook@google.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>, Paul Turner <pjt@google.com>,
	David Woodhouse <dwmw@amazon.co.uk>, "the arch/x86 maintainers" <x86@kernel.org>, Andi Kleen <ak@linux.intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>, Arjan van de Ven <arjan@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, "Mallick, Asit K" <asit.k.mallick@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592586608850569551?=
X-GMAIL-MSGID: =?utf-8?q?1592587610281245823?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 11:17 AM, Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
> Intel is considering adding a new bit to the IA32_ARCH_CAPABILITIES
> MSR to tell when RSB underflow might be happen.  Feedback on this
> would be greatly appreciated before the specification is finalized.

Yes, please. It would be lovely to not have any "this model" kind of checks.

Of course, your patch still doesn't allow for "we claim to be skylake
for various other independent reasons, but the RSB issue is fixed".

So it might actually be even better with _two_ bits: "explicitly needs
RSB stuffing" and "explicitly fixed and does _not_ need RSB stuffing".

And then if neither bit it set, we fall back to the implicit "we know
Skylake needs it".

If both bits are set, we just go with a "CPU is batshit schitzo"
message, and assume it needs RSB stuffing just because it's obviously
broken.

             Linus
