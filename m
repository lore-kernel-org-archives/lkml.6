Return-Path: <kernel-hardening-return-12378-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtD6oNqNYby8ds2BnAwJ7MAzkf0x72LOnDDRm7w9lezVXbkmgwcLxNgG9NUNg4a2cNO0hJ7
ARC-Seal: i=1; a=rsa-sha256; t=1520698288; cv=none;
        d=google.com; s=arc-20160816;
        b=yMAYy2v9vpOVxtKdaWOJqWyFIIdTkoGZ6ir0Qk/ZdPVD29f5E5EZ2sy1SBntI+Tecy
         iE/klXqSHD6w3smYyfQUH4dpmDCJ522VDSvYzygAW5/u14OUFwOFnNfyL2pkC0oBL2qo
         Dd0ergkwnK2JJOVPKAAVRuE33DRsT4x2ePRdQSCsn5Eky8rkNuAbLy5m+mxGtW3qhLP4
         ZMBMc7ZGtQ4li1S3aNzqcvC1loEUlCduo6tfe+HvzAVnXw4zPMefafSirsyHNh9i9REN
         Kg/U33Ow8yCDzIwtICaHUoZJ1EIQSZQUxrCGmyDBkEw/xT01X3mhxoCPZ37f7R1u9ZVJ
         5X3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=jZzJUEyasqAKEwzh1feeFzcld/Vq9xfvbjawFxpUoqE=;
        b=VjDWmp+QqBY7Hv29NEMMF9liIKlntRshtusmrajBtlpTOUaZ6vnSFYQRSg3t+VnICA
         xPe8gY//+GYP9xuco6SS6RfvgJ45UW92ElF683r7DGxHNjjSxclwGZz6gpoYZnmVTR4E
         jDyu1O5QcJSro6KYUrVvslTjG1svKFV/8yHlhUbGgOwJokrrlZZ20EecE783KjB+H6J0
         sOKV+iKri6fx/aZ2e/4cshlgarULdrWU2PJ1AdwTNV+Zh/g3RJKloK2aGoyvv7OYAllA
         2ALg7lbIyZbPdM2alncWRC4u5P3RRYNEjkHh50SvcTPufW29iNvsmgycocrDfz/Wy8V5
         zIdw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bF04HXX2;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=g2iaaiYa;
       spf=pass (google.com: domain of kernel-hardening-return-12378-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12378-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bF04HXX2;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=g2iaaiYa;
       spf=pass (google.com: domain of kernel-hardening-return-12378-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12378-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5jLtKAUsoYemHZTrJqKEH9=BqwO_QXk=x3BPfCKqZ6DRYA@mail.gmail.com>
References: <20180309200536.GA5670@beast> <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
 <e8874944-f0b7-7a1f-26f3-446d7d7fcc38@infradead.org> <CANiq72k_vsTPMXvcfTNo+sjRoVMkihvRz-fzeXdcXvNEEeY-Pw@mail.gmail.com>
 <CAGXu5jLtKAUsoYemHZTrJqKEH9=BqwO_QXk=x3BPfCKqZ6DRYA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 10 Mar 2018 08:11:09 -0800
X-Google-Sender-Auth: Gj-uaecmhmiKJAHjloIpWFxfa3Q
Message-ID: <CA+55aFyt0Aua_Jzp__kTRZaiBoki6-EWmVnrFrjntpYiytqe4g@mail.gmail.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in min()/max()
To: Kees Cook <keescook@chromium.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
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
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594567728966471545?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 7:33 AM, Kees Cook <keescook@chromium.org> wrote:
>
> And sparse freaks out too:
>
>    drivers/net/ethernet/via/via-velocity.c:97:26: sparse: incorrect
> type in initializer (different address spaces) @@    expected void
> *addr @@    got struct mac_regs [noderef] <avoid *addr @@

Actually, this seems a valid warning - it's assigning a __iomem
pointer to a regular void, and dropping the iomem in the process.

Sparse does *not* like VLA's, so what may be going on is that fixing
something VLA-related in your tree just makes sparse (correctly) check
something that it had given up on before.

So don't worry about the sparse ones, if they are new. They seem correct.

                     Linus
