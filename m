Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx4/kVsDyrVw1SKwkoX8TRtc+Wo7/qkNfxd9epxdaJ7mL1ehItQ+VB/qD7RMOqSN6dBBuIww6
ARC-Seal: i=1; a=rsa-sha256; t=1524134157; cv=none;
        d=google.com; s=arc-20160816;
        b=EADl9mcS8U30FuOh50noD6Q5iiTzrf29jE6eRufQhWSM4KIp5VHdwAapefnxOVmucH
         h0tEyEsJle2wluihfLWiL76YJga2KIvutDnpdlomQAKlUT1AW+CyykPJ1cXzK6gwgZAM
         wM8TpWcLGEqdR9e5r2JM6pyBhEN8UhM4Lkrf3bOzRVTFtwi5XVTigL8ypFTu9Hl6FytX
         ggdQWWMGbC0Zq5S3U/WZpfby2Gk8XOyojIWKAiKn49CJ4cxRuvCuc+jbzBaAD35e1R/E
         BOP7iXvbxSkiZeN0wJqdW+F8INAX+G6GHxwr5l6sp0prTgKbrZyStiXh5z4UZLrBWZYI
         ZOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=rMBI2IO9vqOANipbYntQNPI8IEtN3MVA0AI1Z5I3/7k=;
        b=nXCbmxU2quwyRNvImKC+Ht5bwtKcFR/dm2ppv0Max7ZQHWo7OOcw39xXIEpQFQHzw4
         i9wW1xXjgp1mfZAUx+EzwCgbjSNATscMtgwcPZeB26dceZylJHn/rUk3sYgcE3w1Vc8f
         qsv8Ymye2eIsvvWQwk6zSLaBrq2s5eNGgF2Vp7TXuyH0I4LmW4l9DHpU70eIQI47Wr5L
         wPUrtyxHNozmtNovPLakN/2HsT1KepUGJFcRVjxmL10Eia6JH0ZLiT1k1Xxk4ICs4cp8
         3+fq+MvVAfhUCGemu8zLQYWsn6J8r9IRIM41kDP1mNTPxlMAET2bjr1QQzGSHMXcwbD6
         uxCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Thu, 19 Apr 2018 12:35:29 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Kees Cook <keescook@chromium.org>
cc: Ingo Molnar <mingo@kernel.org>, Joao Moreira <jmoreira@suse.de>,
    Kernel Hardening <kernel-hardening@lists.openwall.com>,
    LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>,
    "H. Peter Anvin" <hpa@zytor.com>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/4] x86/crypto: camellia: Fix function prototypes
In-Reply-To: <CAGXu5jLerFuW=-uxpegBinAjJN0shPJkYAVaz9K7VWzVRmnOEQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1804191233500.1563@nanos.tec.linutronix.de>
References: <20180415041542.5364-1-jmoreira@suse.de> <20180415041542.5364-2-jmoreira@suse.de> <20180416061044.z6eb4psw2sbszemb@gmail.com> <CAGXu5jLerFuW=-uxpegBinAjJN0shPJkYAVaz9K7VWzVRmnOEQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597784202629370804?=
X-GMAIL-MSGID: =?utf-8?q?1598170498635337030?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 18 Apr 2018, Kees Cook wrote:
> So, instead of the original series, how about something like this:
> 
> Switch function pointers to not use the function cast, and define a
> new GLUE_FUNC macro that kinda looks like the tricks used for
> syscalls:
> 
> static const struct common_glue_ctx camellia_enc = {
> ...
>         .funcs = { {
> ...
>                 .num_blocks = 1,
>                 .fn_u = { .ecb = camellia_enc_blk }
>         } }
> };
> 
> #define GLUE_FUNC(func, context) \
> static inline void func(void *ctx, u8 *dst, const u8 *src) \
> { __##func((context)ctx, dst, src); } \
> __##func(context ctx, u8 *dst, const u8 *src)
> 
> GLUE_FUNC(camellia_enc_blk, struct camellia_ctx *)
> {
> ...original function...
> }

I was about to suggest this before I read to the end of the mail. Yes, that
is much more palatable.

Thanks,

	tglx
