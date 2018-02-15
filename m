Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2265/Hby85hKvsTiQygzapW7w0C4iDHAFXn2zDN4FWleAJdTLvUxjgFoskHYlbJGxIKH9Zl6
ARC-Seal: i=1; a=rsa-sha256; t=1518708404; cv=none;
        d=google.com; s=arc-20160816;
        b=yef57W4XJFMgdOz7zvdULi9Ij691O8656+ofbXL3/noRsffMsPmkeIUqk8tWaOJPGl
         v+6MymDCYdvtgzqtmnMoCDHzOqbSSTqerVx4E5aFwri0eUMizv9cOkvfRiaGb0+ijO3C
         6jfleC4c1JGHxaf5K5qDybJCpTaURHaczdjkTdihQVLO76XlBOx9m38cdhIRYj1idYFA
         0Kc2h+dskFACCuBDyfZYbRVqxg+ClYQiFRCITpnWXyGYD0BLGq1L/1Ec5lnIbWo704qj
         ndey/5G7mhGYFaqAkzuIRT6HC2CaGcTpvs/ctfos1a+GFtSc5Tl1B+CHQuILfg26R91j
         fEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iTVu6HASsics833liQDuzl9UsMy2hFlsRKS0SRucBdM=;
        b=KVAZBpjnF2z0z/jFyzTUKHklqdxnYj8nz0C2rrOoFq9Ytb1xuYFGTXnh3MkyXLMfDa
         DtguWG4JWRInin+2Za+9+gsrj3oP9U+sv13RGcZzIRdxaNwCulvGSfgJsAFDmKzKeL1f
         oUU1It/6I9h3dnih3TTH6mtDCY+6nY4HlKSw0H/AdIXYP69LUuFmLuvwjKu2ZWOXmF6L
         gnM+//kvko0TMc9/mV0rP0/YGTCOFDtd+1C5pNt7OQ6tQTfbmzDlJEWLFqHe+tJWUXAE
         xsgPZrF/6yIURxH15iNUFoFK39ZncJHo3j9qv1BbHO1OhZr8pS0+NJgzmJ7UmnnKdN/F
         gekA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 31/88] crypto: hash - introduce crypto_hash_alg_has_setkey()
Date: Thu, 15 Feb 2018 16:16:58 +0100
Message-Id: <20180215151226.975885365@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480736419252893?=
X-GMAIL-MSGID: =?utf-8?q?1592481183487640534?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit cd6ed77ad5d223dc6299fb58f62e0f5267f7e2ba upstream.

Templates that use an shash spawn can use crypto_shash_alg_has_setkey()
to determine whether the underlying algorithm requires a key or not.
But there was no corresponding function for ahash spawns.  Add it.

Note that the new function actually has to support both shash and ahash
algorithms, since the ahash API can be used with either.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/ahash.c                 |   11 +++++++++++
 include/crypto/internal/hash.h |    2 ++
 2 files changed, 13 insertions(+)

--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -625,5 +625,16 @@ struct hash_alg_common *ahash_attr_alg(s
 }
 EXPORT_SYMBOL_GPL(ahash_attr_alg);
 
+bool crypto_hash_alg_has_setkey(struct hash_alg_common *halg)
+{
+	struct crypto_alg *alg = &halg->base;
+
+	if (alg->cra_type != &crypto_ahash_type)
+		return crypto_shash_alg_has_setkey(__crypto_shash_alg(alg));
+
+	return __crypto_ahash_alg(alg)->setkey != NULL;
+}
+EXPORT_SYMBOL_GPL(crypto_hash_alg_has_setkey);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Asynchronous cryptographic hash type");
--- a/include/crypto/internal/hash.h
+++ b/include/crypto/internal/hash.h
@@ -88,6 +88,8 @@ static inline bool crypto_shash_alg_has_
 	return alg->setkey != shash_no_setkey;
 }
 
+bool crypto_hash_alg_has_setkey(struct hash_alg_common *halg);
+
 int crypto_init_ahash_spawn(struct crypto_ahash_spawn *spawn,
 			    struct hash_alg_common *alg,
 			    struct crypto_instance *inst);
