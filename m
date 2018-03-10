Return-Path: <kernel-hardening-return-12369-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuznblmTd/wUHk4P5KVpX3jK4PIS4DK2MM93UfNFenwC5xDOft18SOINfiyo6B3j0rQpfSi
ARC-Seal: i=1; a=rsa-sha256; t=1520664223; cv=none;
        d=google.com; s=arc-20160816;
        b=fLH+4POlE96kFDiPqv0ofVZexBSUuFkRj6jOSUt/y8AYWjDf36Nq7Y4dtIE2sYcUUh
         wL1MibgWmdFQ0jOTyfLivBwQ3jg/cARaGW4wkHnL1J9wU0cyJfr5paY3ZWojuarh+01i
         cuaWrqNkiqC1P5CcVrw2US3uX48Q3InwAjqRV9sKHwAb61s9Cvq2jR+7tJ5bk763J7Fv
         TdjZGuvUbIluT8NKPQ6LdsE0TRxs+6w3KQdE4KY4lhhRWXk24Ey4yH7gAfN2gatCj72Y
         mStH4H3Klo0IO9TWxfOHBk+o4oaCEhcVK1Mqh+T9VpKYd+jb3JXza2iHnFsxnq0yITd4
         wcnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=VzkT7uuVmxBuCYLHz10MmqyHFwQTFdTDX1jTvFMW0P8=;
        b=OsXqd9qEcjBJUAx0E9L0GQeXUEX44ZCcdWhLFTWpSvyll2chp2PYZmSfdhdiCwX1Tt
         jCMAakfxmwAujncZHbg6y0o9FdX6YKZQ5zxJmngbtfuf8CLYDG+Q9vBEP9QKUNImXtQl
         DIot19Jzz09zglN830dkd3dPiiVylWuRey3imb8nbZp5yU6/7qmsRGESGrkUvYVVXPS8
         1/TYH26jXpRkq9Gqg+6eYQspxaAjunMR9DDRSOTGbF/Qwtrb0BOApRiQlJWSQ7KCkuHI
         1xODwegg5u++5wRUXAgKaiWVQrcUPSlvEOAVzaV3sRx0o1Lb3zoGWhBTkUihDWOcqzA+
         280Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12369-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12369-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12369-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12369-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC3B21771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 9 Mar 2018 22:22:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf
 <jpoimboe@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Tobin C. Harding"
 <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>, Chris Mason <clm@fb.com>,
 Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>, "David S.
 Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar
 <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Borislav Petkov <bp@suse.de>, Randy Dunlap <rdunlap@infradead.org>, Ian
 Abbott <abbotti@mev.co.uk>, Sergey Senozhatsky
 <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Pantelis Antoniou
 <pantelis.antoniou@konsulko.com>, Linux Btrfs
 <linux-btrfs@vger.kernel.org>, Network Development
 <netdev@vger.kernel.org>, Kernel Hardening
 <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH 3/3] tracing: Rewrite filter logic to be simpler and
 faster
Message-ID: <20180309222238.6761728e@vmware.local.home>
In-Reply-To: <20180309221523.1fce7118@vmware.local.home>
References: <20180309200536.GA5670@beast>
	<20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
	<CA+55aFw9hWz1-YFVoHEiXDjqb9q7dz=rQVXr7YLkMuVLvbwaOg@mail.gmail.com>
	<20180309163241.a421e216999bd0b1f43a64c2@linux-foundation.org>
	<CA+55aFwbO2vUsjWzAwB6SZ65RM4r3P0+2JvyMHn=ry0CgWCBgA@mail.gmail.com>
	<CAGXu5j+D=zs8AMb969dhH05GmKPuBxKPcAs89KfKzVf47faL1g@mail.gmail.com>
	<CAGXu5j+4_2vZF9uPy_agcGymbHbVqohSqApKZZxwcTz4OC_Skg@mail.gmail.com>
	<20180310023907.798690563@goodmis.org>
	<20180309221019.31c896a3@vmware.local.home>
	<20180309221523.1fce7118@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594531931322322791?=
X-GMAIL-MSGID: =?utf-8?q?1594532008827068735?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 9 Mar 2018 22:15:23 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Sorry for the spam.

A little more spam ;-)

I know what happened, as I'm able to recreate it. For those that use
claws-mail, be careful.

I clicked on the email I wanted to reply to. Then I must have hit the
down arrow key, as it moved the selected email to the next email. I hit
"Reply All", and it showed the email I clicked on (as well as the
subject), but the Cc list belonged to the email that was selected by the
down arrow key.

That's a nasty subtle bug. I think I'll go report this to the claws
folks.

-- Steve
