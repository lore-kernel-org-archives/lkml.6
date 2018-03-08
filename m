Return-Path: <kernel-hardening-return-12270-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuAyogpSWTla3ssHcZ8cJJaPxh8aR5B0wXkcTDlPOOi5TyRnnXyHzILeFc+QuIuwKC9Rd99
ARC-Seal: i=1; a=rsa-sha256; t=1520546435; cv=none;
        d=google.com; s=arc-20160816;
        b=zYY45SbyGQyP9vin3iPE3qazhdeyUtzm15LzdS4JHDuBBQ8ShVilAI4g+21Al10fFF
         rz9WLGHErGpL5Dx6vABD4NlkP2FgNhjfcozuzymRyaqaeh9zTCw3JOMAzTQYS9ik9NXv
         zTmT3UAYYHd2ew0VqrO+z6FXOQfa3LRfVk6vWWZSiPUxohWmKLxHgl7pP1fcZnC/b04e
         8YqqLuPFqO5IxlwEvvG3qEMxAAlOGIqd5pD+4gcPytyDogGbNay8VClCqxN7WXeLJQbY
         DM/QRp2y2RlXQ9TzO8JC2mb91DevvCYjcwjZeTY/hWHfYjASWOk5dpT5ODS2dWRPVj0V
         PUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=zukZ1LIY9Ls8uVk3iY7ZhpLiFnv7N3HbWo3YJ12MA60=;
        b=Kn6bhl2TKNbJN0xWNdE1vEvo+SaMyN7pTAtHJjjzwB8xd5D/P/JuoWKUHTnm7Ux1xy
         W5ttaig/v6apspd9zQNZDixJIn8f/ORHiSt8fi9bSTCZoGCOnOkwxMi4XZ4hPHudQgMe
         t50m2yaFa1cD9R/nNOfONT4WrxmXJ4/RfcVPCU5G/P9ceAqkhCfKbmccnmUGtBbbAxJz
         giv9cg1bUtDACignkFlBglilVFlkSsNS0dRcWkA7W8J6wnGb9J5TX/dgqwIMC4WU5fHy
         B82J7qfqPZI5t+rNbZjC+E/zEIOxSwQk1HsL27ioEDFvSntjBZw8jNjEMX/axbS1cant
         CiVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12270-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12270-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12270-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12270-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Message-ID: <1520546351.23648.32.camel@hellion.org.uk>
Subject: Re: [PATCH] kernel.h: Skip single-eval logic on literals in
 min()/max()
From: Ian Campbell <ijc@hellion.org.uk>
To: Kees Cook <keescook@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
  "Tobin C. Harding" <me@tobin.cc>, rostedt@goodmis.org, corbet@lwn.net,
 Chris Mason <clm@fb.com>,  Josef Bacik <jbacik@fb.com>, David Sterba
 <dsterba@suse.com>, "David S. Miller" <davem@davemloft.net>,  Alexey
 Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI
 <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>,  Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Masahiro
 Yamada <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>, Randy
 Dunlap <rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>, Sergey
 Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek
 <pmladek@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-btrfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Date: Thu, 08 Mar 2018 21:59:11 +0000
In-Reply-To: <20180308214045.GA6787@beast>
References: <20180308214045.GA6787@beast>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594407273404510633?=
X-GMAIL-MSGID: =?utf-8?q?1594408498249015204?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-08 at 13:40 -0800, Kees Cook wrote:
> 
> +#define __min(t1, t2, x, y)						\
> +	__builtin_choose_expr(__builtin_constant_p(x) &&		\
> +			      __builtin_constant_p(y) &&		\
> +			      __builtin_types_compatible_p(t1, t2),	\
> +			      (t1)(x) < (t2)(y) ? (t1)(x) : (t2)(y),	\
> +			      __single_eval_min(t1, t2,			\
> +						__UNIQUE_ID(max1_),	\
> +						__UNIQUE_ID(max2_),	\

min1_ etc?

Ian.
