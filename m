Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518810204; cv=none;
        d=google.com; s=arc-20160816;
        b=ngd9SYRr+w/nnPCnIOUNmcdKIdODEnaciC9Lzz/22gCyPHiCB3j1kuVu3xENCHCT/N
         zFUOszpIfmshInqGrXwBtpsk0mi6JcsWhZzOhT/STVq31g2Zz2NeekeBs1QeWEsoI+6Y
         AaJ8fAN2AyuTMeZL8lST53uzu1SIgKQvg6Gs6uqi7nB+um/JrBCLsYiOhSfVhofrlWCZ
         ATmjQMLagi+eVH/R2A/IN4h5yizUINZSgepCHYNq4n95ohB0ODIJzczSiCGqb9fIf5TG
         +4gy5h9TT/zY1shJ8uB+XX6212QlBPjUGBJjF0sIE6AQaVZkM6LZOt6JBrd/9EY94gJu
         J6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Z8C0aEgJfB3c8SAuRVgSGQBe5AuF2/vKQgq0mutLCvw=;
        b=oYcuTEDmCwHQVFbf4WlsEAIu9gOvuTP/mcdO4n8j6xYpyzEgOJwvYGfcZna69GB6B0
         aA4XUFDo3/JKgoIZSQddDHwIBfzoGDlyhhdt+tSP9QIcVP9tMxSIj5J00jhAGldNNGzW
         b/S57qi8lixB9zmk0k8I4g58joxWkvyNeClZO9dsXbvxz6UfshtzBDpe1ZLCpgwQ/5QW
         Nwc6UReia42xecQPc0TwXtDupcxgtYHIUZmjZJW7/qvuV9peBoF6SsaSQKrRByYTi4ol
         U29dheFBEkNDAxfDb9dVYZNWMAYcp+zBoB/0jjdiZMX1YI4of934RzlLdQrSzfd2OsuO
         EBeg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Gr3VcU/f;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Gr3VcU/f;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x225LjBKhuf03Fgbw38M17sPzgRkGrduNIx5Sb63dztVhtc1Tq8Wu/m8Ro1hg1iZD2KLQPhTbgM0gXQpxV9I4h7g=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFwgxWj95pUxpWL0N0uzHBmyEL7NFveC70ZtJ4ONFX45=Q@mail.gmail.com>
References: <20180216191755.6F62DDEA@viggo.jf.intel.com> <CA+55aFwgxWj95pUxpWL0N0uzHBmyEL7NFveC70ZtJ4ONFX45=Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Feb 2018 11:43:23 -0800
X-Google-Sender-Auth: hRCw-7if9WtQbNd9CINsxCeT_tE
Message-ID: <CA+55aFyg-uS_hE6f2t5gOrwaCMXErPvGA7tjfhmXZmZOPzi8Ww@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1592587928996613011?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 11:38 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Of course, your patch still doesn't allow for "we claim to be skylake
> for various other independent reasons, but the RSB issue is fixed".

.. maybe nobody ever has a reason to do that, though?

Who knows, virtualization people may simply want the user to specify
the model, but then make the Spectre decisions be based on actual
hardware capabilities (whether those are "current" or "some minimum
base").

Two bits allow that. One bit means "if you claim you're running
skylake, we'll always have to stuff, whether you _really_ are or not".

                   Linus
