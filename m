Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523859047; cv=none;
        d=google.com; s=arc-20160816;
        b=LgbRtZaOONgYxl6bHiWAr3VHzlUIXGSIUsdfdi+VlrU8P8NFrSmfK9ePJL5B+7rfCy
         werHa4stttt13bLzO5rIGfG+ITQCkPa2uoUUsLY4YApTFEmXDPXosv+jVmjFb3BXc3aZ
         PwuUBoWOeoSPn5RU8Cq/L69MS6q/jxYhuOrY3ZBSQjV0QOGv2gCisuf25OnyEe7m8Pth
         vxEpnaq+dJilqb6Rh0Sx9BJPwK9OPadXriMfM1MSEF0zr+yr4mlFxt9TWW7AHgCaXSER
         zkv5bYNK5YxUWkAJKPkNs2vVZAbYGzMcwmlLU5MALq0hnuechBS2lFTLbpwmyGaXIoqH
         jo2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=yvdMQCQPJYF87AmScV/IOXkvbIMXPVRmRfS2er34QmM=;
        b=Hx9KS/fcYNG3nCnVjd7Sk3FlBJ9gyajoeyV9/1+QRY8EzQXCI1Jat+9oefhiPRM6oK
         yURHk9A1yCWgrJD/Wvkr8T2loP1UKDaXAo53Bv+JtnGQmrkUdjmBmHtow8Jgs2aE+kQc
         rw0aPRwlh2Y9L3FlgVKlHUn1MbThWIn2BL3xorSH3SBtaUkBpWfBwovIWSQWQMUuT3nu
         sKrVuQOxW7hbQbUYMwkWDDOviGSUzb66y0zX8CVLWioxxUXDYCAVRM0zamxPbgpYePHk
         vV6aeOQvP1/NavXRJiecooXdxZpzXJuxvtjTprgcwFLklqiBxlcV8G8x/cCufv7BuDlq
         OpYw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=C6KsDYur;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=C6KsDYur;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AIpwx4+sfAjBAJnvoF/vZtfLPoru7qxhHG8fuMVjDCPOBbJOoPGFqwbkB6Y4HFUjEkDMZY1aGTnt7A==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 16 Apr 2018 08:10:44 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Joao Moreira <jmoreira@suse.de>
Cc: kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
	x86@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
	tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
	gregkh@linuxfoundation.org, keescook@chromium.org
Subject: Re: [PATCH 1/4] x86/crypto: camellia: Fix function prototypes
Message-ID: <20180416061044.z6eb4psw2sbszemb@gmail.com>
References: <20180415041542.5364-1-jmoreira@suse.de>
 <20180415041542.5364-2-jmoreira@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180415041542.5364-2-jmoreira@suse.de>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597784202629370804?=
X-GMAIL-MSGID: =?utf-8?q?1597882025005407875?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Joao Moreira <jmoreira@suse.de> wrote:

> Convert the use of 'struct camellia_ctx *' to 'void *' in prototypes of
> functions which are referenced through 'struct common_glue_func_entry',
> making their prototypes match those of this struct and, consequently,
> turning them compatible with CFI requirements.
> 
> Whenever needed, cast 'void *' to 'struct camellia_ctx *'.

> +static inline void camellia_enc_blk(void *ctx, u8 *dst, const u8 *src)
>  {
> -	__camellia_enc_blk(ctx, dst, src, false);
> +	__camellia_enc_blk((struct camellia_ctx *) ctx, dst, src, false);
>  }

I don't see how this is an improvement: instead of having a proper type there's 
now an opaque type and an ugly (and dangerous) type cast.

What does "compatible with CFI requirements" mean?

Thanks,

	Ingo
