Return-Path: <kernel-hardening-return-12370-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtICw6aN8mDxYn17od2zBOlHeqNqVZNfL14Ne11/HhxSlO8oR2710rcUGYM3iquPRdh/OaH
ARC-Seal: i=1; a=rsa-sha256; t=1520664309; cv=none;
        d=google.com; s=arc-20160816;
        b=YxXtGPX+cAwBlibEQ99E2fV0b487DQMBiF05s3YcQAEA2t8yshgXz0Q5rKzGrMBOkM
         9TbG1gET43kHtxLFGbSLAPvkACHCpgRbQDeIgJNaUGstQjkZMar45OpsMgOaqiDQU8Q1
         i8MtNf7OzJOJU9mdnx9GPeslcfqnpJ/R7aYJ6aalUm+oGavoqFlGlr3lTkk1kba8aall
         FW5Rk4DPcKIjwY9gHo8OnDDrwB5BZ98BUcj9XuC9e8tJ8F9AluJDbTi1JE+e+syaiRWU
         aVWWCMtSaglzW8iVOGBAC5S3EIJC97UqMaGO6zsVMbgPlqqj4/xATTqPjNpCQPBo4fM8
         B7fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=ZL5Tdmd0gn5WKxA3oM7l4xofwMBARzgxZK3xsCvq1Ec=;
        b=AJm73hBzYAoc7YswpNa+Eoc1J8niF4tM6IRaWPmfrerp41hx3PV4LDVdrBS6txPByO
         7Gj1mOK72YCGWcCCOWcs3Nx2E+9Lsz6iP+M0Sds9msAAibGSvZmINuc8FF9Y74RLfBrx
         9w2PsnW2zPTGXsZ/ViZjpbUySQb+BoHCM94XWz1UpBVTiBhWgJYFFNQ7j0LaTNtyIqvK
         gbOa2/NpTH4UYDMrij2pMsK+vBD58db6v1SAS4YeBuNHgRVyehR8dvYwxebtYn7noWim
         AGsSFo46D8euY3zyUIoTTnaGKjQQ3kQeXsyAeE2/WID0UatJTgW1LFFbw2ACmOHrTOXm
         JmmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QffxHkXh;
       spf=pass (google.com: domain of kernel-hardening-return-12370-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12370-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QffxHkXh;
       spf=pass (google.com: domain of kernel-hardening-return-12370-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12370-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <e8874944-f0b7-7a1f-26f3-446d7d7fcc38@infradead.org>
References: <20180309200536.GA5670@beast> <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
 <e8874944-f0b7-7a1f-26f3-446d7d7fcc38@infradead.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 10 Mar 2018 07:10:47 +0100
Message-ID: <CANiq72k_vsTPMXvcfTNo+sjRoVMkihvRz-fzeXdcXvNEEeY-Pw@mail.gmail.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in min()/max()
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Tobin C. Harding" <me@tobin.cc>, Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
	Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>,
	Ian Abbott <abbotti@mev.co.uk>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Petr Mladek <pmladek@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594532098512193513?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 4:11 AM, Randy Dunlap <rdunlap@infradead.org> wrote=
:
> On 03/09/2018 04:07 PM, Andrew Morton wrote:
>> On Fri, 9 Mar 2018 12:05:36 -0800 Kees Cook <keescook@chromium.org> wrot=
e:
>>
>>> When max() is used in stack array size calculations from literal values
>>> (e.g. "char foo[max(sizeof(struct1), sizeof(struct2))]", the compiler
>>> thinks this is a dynamic calculation due to the single-eval logic, whic=
h
>>> is not needed in the literal case. This change removes several accident=
al
>>> stack VLAs from an x86 allmodconfig build:
>>>
>>> $ diff -u before.txt after.txt | grep ^-
>>> -drivers/input/touchscreen/cyttsp4_core.c:871:2: warning: ISO C90 forbi=
ds variable length array =E2=80=98ids=E2=80=99 [-Wvla]
>>> -fs/btrfs/tree-checker.c:344:4: warning: ISO C90 forbids variable lengt=
h array =E2=80=98namebuf=E2=80=99 [-Wvla]
>>> -lib/vsprintf.c:747:2: warning: ISO C90 forbids variable length array =
=E2=80=98sym=E2=80=99 [-Wvla]
>>> -net/ipv4/proc.c:403:2: warning: ISO C90 forbids variable length array =
=E2=80=98buff=E2=80=99 [-Wvla]
>>> -net/ipv6/proc.c:198:2: warning: ISO C90 forbids variable length array =
=E2=80=98buff=E2=80=99 [-Wvla]
>>> -net/ipv6/proc.c:218:2: warning: ISO C90 forbids variable length array =
=E2=80=98buff64=E2=80=99 [-Wvla]
>>>
>>> Based on an earlier patch from Josh Poimboeuf.
>>
>> v1, v2 and v3 of this patch all fail with gcc-4.4.4:
>>
>> ./include/linux/jiffies.h: In function 'jiffies_delta_to_clock_t':
>> ./include/linux/jiffies.h:444: error: first argument to '__builtin_choos=
e_expr' not a constant
>
>
> I'm seeing that problem with
>> gcc --version
> gcc (SUSE Linux) 4.8.5

Same here, 4.8.5 fails. gcc 5.4.1 seems to work. I compiled a minimal
5.1.0 and it seems to work as well.

Cheers,
Miguel
