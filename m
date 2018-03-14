Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521045488; cv=none;
        d=google.com; s=arc-20160816;
        b=JnPWHFW9/aZv7XFVH9xfTtfeFAWjFEbJLxj6xRINpsI0A5l/MsCyTt8xAEitJsC0SR
         yG2ibmXmKK1unr6j1CknYi8AN35MrG6RnJUauijFVWsWyXMPX4Os8gWP0NysE4t3i5qP
         aN078DlpIC1WLyOS8anTQgPjkovjjnquoIWlC50YRUwXDBoHhUcvpJzFz7Ea9YvtjzQT
         sg2YBro319nu45M2FSHGauPgLelx8ZaglsZ736WHrTS6jDeqVhLmIuZOt71ZaN9o5dYQ
         1SX+mEUixfyCelVuLNtPRIdoWAplO595NFqiShk5eGXkA7qEV8yKeBHGHhond9d6HwSm
         +bng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=lD5rk/2l6f1jE0ztNDcIJvT1cD9ksdl4F8TP57ISXvk=;
        b=qo4jFx1di8coT22MOQhVvJUQqRk00Havdbp8/7p4/CK3FB5qGmyeTyUESjc+I3u9f1
         fMY2NgsOTy0woz/UzEchdwQML6Ry7TEWt//QOqg2IKoS+IdguzcLfN1BhqtNbL+xBDYd
         k3xd8bnvvIeLDydypgKbcdp+NrXm3c9O6DW1pabS+uoDNE62y3NOlhxowUad4SSKyIL0
         meQOvPK+aMbiFToo2q54EGN0foprAlYgJhRZSjYE8NmBM4NKcIMInqUN9OgOsgeLs46Z
         bY2wK/vzzOwVYs/X1lTsQwyYNVgdDlM8kyno9DC8AkBXuvpAeyAQduHNYI8YBr7vITCH
         Hf7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FO0SHR5x;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=MLmojVad;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FO0SHR5x;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=MLmojVad;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELuVqc2LRTg7GVbjS0+Mu+IucK1d5Y1rsKOrOc0F/8Tja0rxJFH/ejJrYzAhgYflltju65vz+6wsAMW0mcCPygg=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFx45SM4VxD-V4qLo8=hxqYtGH+qBeB74KekwCkJK7D=xA@mail.gmail.com>
References: <CAGXu5j+4mEyhE6shkxWqY4AVQGcq2U7nzf4j_n2+CdW2t6CzqQ@mail.gmail.com>
 <CA+55aFykZL+cSBJjBBts7ebEFfyGPdMzTmLSxKnT_29=j942dA@mail.gmail.com>
 <CAGXu5jJVSG7ZuftTRGZjgKqetpmxNpeqwxAzhY8BJ4_H-oUw5w@mail.gmail.com>
 <CA+55aFyfW901QRpdmgEsaY8b4+AOPf2SKKVo7mNs2iRUTHND3w@mail.gmail.com>
 <fe00723e-bdd0-3558-a137-da5f4f3d6127@redhat.com> <CA+55aFx45SM4VxD-V4qLo8=hxqYtGH+qBeB74KekwCkJK7D=xA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Mar 2018 09:38:07 -0700
X-Google-Sender-Auth: nvexWU_YGIdchVRIYYyAHbkWu28
Message-ID: <CA+55aFx+Sue=MLs34j=8-3gf-UB8LmvBhWNFXNA1aUYbUier5A@mail.gmail.com>
Subject: Re: Fully initialized stack usage (was Re: [PATCH RFC v9 4/7]
 x86/entry: Erase kernel stack in syscall_trace_enter())
To: Florian Weimer <fweimer@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
	P J P <pjp@fedoraproject.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
	Daniel Micay <danielmicay@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Alexander Popov <alex.popov@linux.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>, Andy Lutomirski <luto@kernel.org>,
	Tycho Andersen <tycho@tycho.ws>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Borislav Petkov <bp@alien8.de>, Richard Sandiford <richard.sandiford@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, "Dmitry V . Levin" <ldv@altlinux.org>,
	Emese Revfy <re.emese@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Garnier <thgarnie@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Josef Bacik <jbacik@fb.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, "David S . Miller" <davem@davemloft.net>,
	Ding Tianhong <dingtianhong@huawei.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Dominik Brodowski <linux@dominikbrodowski.net>,
	Juergen Gross <jgross@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Mathias Krause <minipli@googlemail.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kyle Huey <me@kylehuey.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>, Will Deacon <will.deacon@arm.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594750868471232540?=
X-GMAIL-MSGID: =?utf-8?q?1594931793766613101?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 9:29 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The second one results in good code:
>
>         movl    $0, 16(%rsp)
>         movl    $123, 20(%rsp)
>
> which is good and doesn't leave the padding uninitialized

Side note: this obviously implies that your patch already fixes
things, but funnily, it only if the structure didn't have an
initializer.

IOW, with your patch,

        struct a a;

        a = (struct a) ( 1, 2 };

would do the right thing for us because of an odd internal gcc
implementation detail, because that initial definition of 'a' doesn't
have an initializer, so your patch adds an empty one, and gcc seems to
always treat that as "clear the whole stricture". After that, the
structure assignment works fine and leaves the padding zero.

But a plain

        struct a a = { 1, 2 };

doesn't DTRT, and leaves uninitialized bytes to be passed around.

Of course, there might be other special cases that I simply didn't
happen to trigger with my overly stupid example and testing. Maybe
sometimes gcc does structure copies or clearing using the
member-by-member model?

My quick testing seems to indicate that it's _only_ initializers that
cause this, whether they are part of the variable declaration or
afterwards.

              Linus
