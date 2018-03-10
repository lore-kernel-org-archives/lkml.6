Return-Path: <kernel-hardening-return-12377-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELv6YZpleUAD6/9aLsqAPj+xziTMe6rLlrFtWTDo6VgqCWvEq8Z4aSN/r1QqhF89KQ80tjpB
ARC-Seal: i=1; a=rsa-sha256; t=1520697900; cv=none;
        d=google.com; s=arc-20160816;
        b=kyq4L4p2wOZsxGF3Doi6bKNJI4oBIPGDSROWStU0surjK93kY9biPqFXVXpqovMIkw
         PPR6UkwSttOwgeRrF2jIl3dHeppHtvQDzbsgcUMucMnDQOhrtNFWws/TKGftg6KLwp2Y
         KnGYe6vAIwLLHcF2aafJX2v/mYodFI5k/5SjB7gLmFwAFKXwihtjuPPDdWHMbj0FhS1U
         pGgwngNu2/1YQZVlRtf11LFtPhVi4ECRgsPr2rFKV/LtT2ODeN4YF2XKHzgalpiMqcwt
         jPhUCAF8H62LXD/9jYhd14C6hSQluQ/ZIHJqPUyJrBE/TItmX4rLnswuGTr7aKsLZQq2
         a3pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=GnYswFN9BduIcB5OceWkeWAAgAcwMXqsiwj/sw5mncU=;
        b=T9elvz7gH5QnZSekwE/w1xSyzedw9GKBcbVYYPyICT+KpF+4CKnNVD30EiZpBbu420
         2pFPHRcgAdo48bhHtPSGzFLbWfLo1YPuf1tQYs4f6zGe2j60usBVQmsLC+MzTXu9hbhr
         r6O2d2INrLrezkIPuIqO3sDBDQsScx4e7ogy4BRmMPhJhEESdlsQ0ztIPnBbtg8u8/5G
         YFl7jxIYl3H/h5lWC9ebG3te8ZFu4NtfaXcG+IFa9oxl9U88pcPZu6a8GTyprfY3VqWe
         acrjtP/pmWhyY3cjIS9UdiovRLopWHGa4Mi+8v+XiikfCXHkVx3hlHGceb57DzJ9TtoV
         t3xg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Gw1sD4WD;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Qkjhk3fr;
       spf=pass (google.com: domain of kernel-hardening-return-12377-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12377-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Gw1sD4WD;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Qkjhk3fr;
       spf=pass (google.com: domain of kernel-hardening-return-12377-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12377-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CANiq72nmCCDa9vV-49cNaJoQQO25r2YsYDaspoKn0xMeDOH10w@mail.gmail.com>
References: <20180309200536.GA5670@beast> <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
 <e8874944-f0b7-7a1f-26f3-446d7d7fcc38@infradead.org> <CANiq72k_vsTPMXvcfTNo+sjRoVMkihvRz-fzeXdcXvNEEeY-Pw@mail.gmail.com>
 <CANiq72nmCCDa9vV-49cNaJoQQO25r2YsYDaspoKn0xMeDOH10w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 10 Mar 2018 08:04:40 -0800
X-Google-Sender-Auth: 78DNyYzTnij456GLgqWSnGn4F-k
Message-ID: <CA+55aFxtM4zq7vGsUz0DBpJ7jECrHoXwiYdAX+Z2wSNyfPKDsw@mail.gmail.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in min()/max()
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>, linux-kernel <linux-kernel@vger.kernel.org>,
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
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594567321389215251?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 11:03 PM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Just compiled 4.9.0 and it seems to work -- so that would be the
> minimum required.
>
> Sigh...
>
> Some enterprise distros are either already shipping gcc >= 5 or will
> probably be shipping it soon (e.g. RHEL 8), so how much does it hurt
> to ask for a newer gcc? Are there many users/companies out there using
> enterprise distributions' gcc to compile and run the very latest
> kernels?

I wouldn't mind upping the compiler requirements, and we have other
reasons to go to 4.6.

But _this_ particular issue doesn't seem worth it to then go even
further. Annoying.

                   Linus
