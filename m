Return-Path: <kernel-hardening-return-12383-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs5HN+vxWWX9tOa9LingTyh4TFnXttIkBwBiZ4Ezr5XVNYrCDfsunrM2K/w1b7XCZoM0jZm
ARC-Seal: i=1; a=rsa-sha256; t=1520707371; cv=none;
        d=google.com; s=arc-20160816;
        b=jQ7oUXX1FF2MSViu3HdKgDsYojfQryjO9YsDItgBIlZrc8dqPO5XJJiGlmK3ep4tMz
         kzedM/4RB40XeJ/XVShrJ/IyrwTPjh4f1Q9cfM3KjkUAUksQU68G2vKjSM2e9gjas1b2
         CRR1sh/5OWoo1OUyLfZouP4w7aA6bTy0AJTG5NvjKUMS1c03agn0HL6GQEprFfc5NEip
         p8nHR52Y3SIsWWFgTVzAx88pjLJuWXYYLVrBDGsB33yVTMyP4Prnkjx05kjSbUIaYeZ6
         1LJJ1b5FHe4OWADMlmdR7fm0qCg+5Azqs2nwRvXxfK/f5SvCgh4MwrtWPWIZ1x6MkaUN
         dxtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=qHLgObodLwvbTRUhZsh+SoQ79wFr7HYazIeAHIzZpks=;
        b=eMVxW6pMkqExDZYnYJbEOVuUK/Ft5AGg2QKOZoMHa9mZeapmW7DT6my55ovK5jS0Wc
         maMVlrDRtOMPvTTuJbWEnU2Vrbyl5QrCe0pVxZ7pQAILc+OlKAr4xGRpo4kIMxBYfmx5
         kkVjC9Ns6Q7EOcrzFe/BD59sdDBCbsiOqtzt4LurUfBluibLWPvxbN39X952yTP4wnWV
         C7uEnLzAwk4CA+38cob6oHXhXHxzNAJhTG05fJI4Q1oBOXc6Dm+77zj8wcdORGAgzDrI
         T4z9knjeilHSLX3OUwDrV5tZ8KDrMQt6bpOFgvlTY9ED3HqfrjuoAdSUaAttR7GInwEe
         dKNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SQ7gJsaP;
       spf=pass (google.com: domain of kernel-hardening-return-12383-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12383-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SQ7gJsaP;
       spf=pass (google.com: domain of kernel-hardening-return-12383-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12383-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <CA+55aFyLicYSe+R4yQ2Eu+P9m6qsRfso-HiK78Sw+-dPuZvAYg@mail.gmail.com>
References: <20180309200536.GA5670@beast> <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
 <e8874944-f0b7-7a1f-26f3-446d7d7fcc38@infradead.org> <CANiq72k_vsTPMXvcfTNo+sjRoVMkihvRz-fzeXdcXvNEEeY-Pw@mail.gmail.com>
 <CAGXu5jLtKAUsoYemHZTrJqKEH9=BqwO_QXk=x3BPfCKqZ6DRYA@mail.gmail.com> <CA+55aFyLicYSe+R4yQ2Eu+P9m6qsRfso-HiK78Sw+-dPuZvAYg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 10 Mar 2018 18:34:36 +0100
Message-ID: <CANiq72nwg3mMhWeE_bLKdQ5WP+0E+SxxvcuUF=Rn9a1MM+EapQ@mail.gmail.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in min()/max()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Tobin C. Harding" <me@tobin.cc>,
	Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, Chris Mason <clm@fb.com>,
	Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>,
	Ian Abbott <abbotti@mev.co.uk>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Petr Mladek <pmladek@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594577252941327225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 5:30 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Mar 10, 2018 at 7:33 AM, Kees Cook <keescook@chromium.org> wrote:
>>
>> Alright, I'm giving up on fixing max(). I'll go back to STACK_MAX() or
>> some other name for the simple macro. Bleh.
>
> Oh, and I'm starting to see the real problem.
>
> It's not that our current "min/max()" are broiken. It's that "-Wvla" is g=
arbage.
>
> Lookie here:
>
>         int array[(1,2)];
>
> results in gcc saying
>
>      warning: ISO C90 forbids variable length array =E2=80=98array=E2=80=
=99 [-Wvla]
>        int array[(1,2)];
>        ^~~
>
> and that error message - and the name of the flag - is obviously pure gar=
bage.
>
> What is *actually* going on is that ISO C90 requires an array size to
> be not a constant value, but a constant *expression*. Those are two
> different things.
>
> A constant expression has little to do with "compile-time constant".
> It's a more restricted form of it, and has actual syntax requirements.
> A comma expression is not a constant expression, for example, which
> was why I tested this.
>
> So "-Wvla" is garbage, with a misleading name, and a misleading
> warning string. It has nothing to do with "variable length" and
> whether the compiler can figure it out at build time, and everything
> to do with a _syntax_ rule.

The warning string is basically the same to the one used for C++, i.e.:

    int size2 =3D 2;
    constexpr int size3 =3D 2;

    int array1[(2,2)];
    int array2[(size2, size2)];
    int array3[(size3, size3)];

only warns for array2 with:

    warning: ISO C++ forbids variable length array 'array2' [-Wvla]
     int array2[(size2, size2)];

So the warning is probably implemented to just trigger whenever VLAs
are used but the given standard does not allow them, for all
languages. The problem is why the ISO C90 frontend is not giving an
error for using invalid syntax for array sizes to begin with?

Miguel
