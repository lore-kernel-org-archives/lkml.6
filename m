Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224cIvdhBZvxTG/ek0Nj5q5jmVcMRJhQtTtGvnVQkg4dUr6aQX43KrscqLoI4SzJopfzqcjF
ARC-Seal: i=1; a=rsa-sha256; t=1517591233; cv=none;
        d=google.com; s=arc-20160816;
        b=nY8//arp38XKnzoqr39Ih2TpV9sE5UHokJc+n5CPUJypWjq+NCbGZ9++kt8RPuARLo
         0S4aFmJRkOiuY77JLHrHvhfB94/jskMbYEEczJcr40CvS+/xVHaOYBvdj1GTDjMLhu0Z
         vPPR1H1Pj1c9U9EVDH0H7QMthx6MIkmi4YDlBYo1EgUhZUQkMvFxJ1x2XHnD/f/3k0n1
         oDhknodcKe6G2EjkOnGPDH1yD+S3b/zy1pjYdqcHKNJTwcX70kAkgomXjcyYvzALDSZl
         ijJ14cs7VBHNObQYep2PxnSjYwGK6rolO1+P53SBscuBSCXLvTVa/9NcppJT9UVZ3GT5
         aC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=v2Kco4+OAG88NZ/yXOp5ay7QLGjdP7a3xAJQ5LsPCGk=;
        b=WOvvgltAZWg6FsmCMx0y0ngKn+fGXM0saNkUGuFB2AG3i9ZzptDI84aI5SNX9FRXPg
         miOChftIsL5AymUNuKsxwNvyVbuVQAmSMnQahC84X9ByHx4IvLyDQhpyPvfNu+fa+FYJ
         dVsRZQBoJQ5G76Nl2WZXL7AYMSCg+xKmotJZ//i6vWpmsZg3HS6xPWd7l0p2n0N/3swB
         eD6Vp58kYg4qgMWraKwitTmhVmW0sCPB3+RvmOhBGgf7wkaC5DTxW6l7HamMA0aAyiLN
         OgGdfopCi1kLWw0LySPheoB3cWjLC+o3+dsD7p+g2aoTFhEjul7tm3Cr0RZsk2nvLkwS
         /Iig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stefano Brivio <sbrivio@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 010/156] crypto: aesni - fix typo in generic_gcmaes_decrypt
Date: Fri,  2 Feb 2018 17:56:31 +0100
Message-Id: <20180202140840.787171740@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309745134653616?=
X-GMAIL-MSGID: =?utf-8?q?1591309745134653616?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

commit 106840c41096a01079d3a2025225029c13713802 upstream.

generic_gcmaes_decrypt needs to use generic_gcmaes_ctx, not
aesni_rfc4106_gcm_ctx. This is actually harmless because the fields in
struct generic_gcmaes_ctx share the layout of the same fields in
aesni_rfc4106_gcm_ctx.

Fixes: cce2ea8d90fe ("crypto: aesni - add generic gcm(aes)")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/aesni-intel_glue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1115,7 +1115,7 @@ static int generic_gcmaes_decrypt(struct
 {
 	__be32 counter = cpu_to_be32(1);
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct aesni_rfc4106_gcm_ctx *ctx = aesni_rfc4106_gcm_ctx_get(tfm);
+	struct generic_gcmaes_ctx *ctx = generic_gcmaes_ctx_get(tfm);
 	void *aes_ctx = &(ctx->aes_key_expanded);
 	u8 iv[16] __attribute__ ((__aligned__(AESNI_ALIGN)));
 
