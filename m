Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs9Dw73VZ6Kh92Hr/DV8jU/WMHlHZ7ZcoGB6DvVBBx7GsFWZGXN51qizCMGduOnwFXvnhto
ARC-Seal: i=1; a=rsa-sha256; t=1521214536; cv=none;
        d=google.com; s=arc-20160816;
        b=sXMfDa6GF/C7CPh2WNGfcjodaAEWKqWIHho+K/p2cWTq2ty9b9fFPY79mL7oPUr9U/
         +Tg3orbuHn42umDth/XopxInmaM4OHcIwBQhWtH86eL7iwiPcR7pTIZ9wfz3Fx2Zf6eQ
         +OBB+1VpsDFNBnDtV+y76XytDkiR7N3dq9NVOq9MzdR2F8z5GdQ+fNMopoNGltDnXC9p
         Dd+UyA/1kYPUy8XNeN9zQ4ygvTdEQGIrxnIAoGaUvUJ6R1wDdqJlSuBZ+yPuTEqbgDFw
         lL6JFa9GZJkXuPHIlJ0zBzubk+pfmypj0LOa2JA+6DvmJ74ZAnCk2w6wZ1tPo6fdc+86
         +zng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HQv/LtyifTYPNNaAUeh5X0ghgGSEkBLfiQJk07UIKyA=;
        b=y+hHbW5+wGCLIj6sCOhiMQGbR8tH/RZW8mOe3A8NwHH6EoEbiYfkXrzVfBDy5es2eR
         ZYgjiQLwZBoQZ0UlILbTPYjyAYbwCNr9Az9cAeyyW65evvpeNEuisJr1pGHqUHRAwTNE
         vFo737FLSSZF3rubCWyNrZidvi4HFlbTsQxvLYYrkLGFPyFL9pHDhtKK/MjeMLi1feC6
         xASNNygBeuZCOh+IZYgmoG7V/Ou+YVJWrhhk3pDxBVoOdHK8qYtlRnwEBTGSIA8xHfcl
         5f4zD/JwjsfhAvFvsGtqWNAqXY4yPwDC5fNjbgCR547frQDCLZcw59Y6nVwT+Z+eHwgJ
         +Gsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pierre Ducroquet <pinaraf@pinaraf.info>,
	PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 042/109] crypto: ecc - Fix NULL pointer deref. on no default_rng
Date: Fri, 16 Mar 2018 16:23:11 +0100
Message-Id: <20180316152332.238232657@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109054048113937?=
X-GMAIL-MSGID: =?utf-8?q?1595109054048113937?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre <pinaraf@pinaraf.info>


[ Upstream commit 4c0e22c90510308433272d7ba281b1eb4eda8209 ]

If crypto_get_default_rng returns an error, the
function ecc_gen_privkey should return an error.
Instead, it currently tries to use the default_rng
nevertheless, thus creating a kernel panic with a
NULL pointer dereference.
Returning the error directly, as was supposedly
intended when looking at the code, fixes this.

Signed-off-by: Pierre Ducroquet <pinaraf@pinaraf.info>
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/ecc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -964,7 +964,7 @@ int ecc_gen_privkey(unsigned int curve_i
 	 * DRBG with a security strength of 256.
 	 */
 	if (crypto_get_default_rng())
-		err = -EFAULT;
+		return -EFAULT;
 
 	err = crypto_rng_get_bytes(crypto_default_rng, (u8 *)priv, nbytes);
 	crypto_put_default_rng();
