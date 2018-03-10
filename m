Return-Path: <kernel-hardening-return-12367-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu6GERFYcn5f8Go5e000tl6kng/JGcF3LLp/afVuies8AaNR+R597gmaEmB01zI4e+3HYqP
ARC-Seal: i=1; a=rsa-sha256; t=1520664149; cv=none;
        d=google.com; s=arc-20160816;
        b=GEmUJ7t43RwkX+IHEsJSQxghSC0sZvjOxUTFQScOzBnIlZg8SODlX74GHzJ4CftDcW
         P5R6ZHgg4vwKqYsXS7aV91D7Qa7RGclKw1oeivm64dcGGlyBas9RDJgwtKpHqPTolSG2
         XmmHe7faOUnOvDae7x5LDLS7UCDhTrSJC8jrfyDa/UPx7VqQjDpX7UYR7Zb5ocHj5s05
         sSV1yCN5H0P1XrtzEK8cHmdlseSNF0HFEfcSQQtO9azHfVc5zX6PqQlYM5rgr98fiUOg
         SnNsQf4QtkkJMvS++OFBf7CCaRh9mJbsjK1FyVNC1SLspwnKPUs1j6btZ4sSVag6k9XY
         PS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=EvROVMgYizoSakGh1QOJQx86XdckQZXUz72Ro/SGaqU=;
        b=CVZWmiiemYlYAlLATZgzEcyo9wD4H3g5s5Y++yIAukkglc2PB9JajZKoEmY7UWhJET
         4BBs+cA8kVR2REYPsVwQtpthtKjuUU64w6/FsafGf19K2Y2hZm13M3AEB6A9FvXZbS3S
         3PDRPMpsrs+2O49CEWkEzaanwULjmr+8MZ1ogSbjLYyhpJlGhZri3WKOt/J3+7W0F7sa
         nBlKsa4bMRl/C2vrOHk5R8eNl1+/+e0qhL93OcNqt82zCZjv6qPEBvDHjLS+X6gm/Sz3
         eBpOeERnXD3BnonmrXTPairSibyrFdzk2QeIpYBi7LvUzt1GaWnV1ty9o9Kv+MZXlZGZ
         mm4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12367-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12367-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12367-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12367-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A57F2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 9 Mar 2018 22:10:19 -0500
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
Message-ID: <20180309221019.31c896a3@vmware.local.home>
In-Reply-To: <20180310023907.798690563@goodmis.org>
References: <20180309200536.GA5670@beast>
	<20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
	<CA+55aFw9hWz1-YFVoHEiXDjqb9q7dz=rQVXr7YLkMuVLvbwaOg@mail.gmail.com>
	<20180309163241.a421e216999bd0b1f43a64c2@linux-foundation.org>
	<CA+55aFwbO2vUsjWzAwB6SZ65RM4r3P0+2JvyMHn=ry0CgWCBgA@mail.gmail.com>
	<CAGXu5j+D=zs8AMb969dhH05GmKPuBxKPcAs89KfKzVf47faL1g@mail.gmail.com>
	<CAGXu5j+4_2vZF9uPy_agcGymbHbVqohSqApKZZxwcTz4OC_Skg@mail.gmail.com>
	<20180310023907.798690563@goodmis.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594531931322322791?=
X-GMAIL-MSGID: =?utf-8?q?1594531931322322791?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 09 Mar 2018 21:34:45 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

>  2 files changed, 1050 insertions(+), 1273 deletions(-)

BTW, it's a bit bigger impact than 223 deletions. As I added a lot of
comments to explain the logic better. Removing comments and white space
from the modifications we have:

 649 insertions(+), 1035 deletions(-)

That's 386 lines of code removed.

-- Steve
