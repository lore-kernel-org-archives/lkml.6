Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226xGxxbHP5BnZgDzZ4LSDey9V+skvmXHyP5eVMSNWcglWQVnw0JLh6ByVeJzyUGIHCIwdKi
ARC-Seal: i=1; a=rsa-sha256; t=1518707977; cv=none;
        d=google.com; s=arc-20160816;
        b=a5oM5AyrC52jDU/5ZBN5SpmLXkqm6Q80b1wH6o364MdjLRZnQ83gTXHH6CqRPsSXyl
         uF8ifQ21rE4V6UJ+Uy0feu+lB/VPsJkPTT3JuCMiXvg1+rGoZ4d4wF30phW1Gxg82mhp
         Bkag+t/qgPb8CabKtnOpfPJrbqU6NEh6WokfPU0PPENjfyxyIIS4YP4Zy2FONzKaRF0V
         fVRD5H+iooDsKRzAgVsjte2LKgtYi9ZD6MhZlZXDo5g5vW7pOaKXm1iZWKHBEARTjKtK
         8FLO/M9u0wLNKiPrqLQ1oN+4lrrvog1tHVZpw491cFeSatus1qBD6iHN3JKxrvpWaqfz
         eWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+WavQRHdyMkzESrKvT0BvG3KADAdB+ti5fc8+58rYuQ=;
        b=qsjNKrQcaVkdcsZjzxNaKlGPU2vf1d0QEY7T8hGPQqqIpIEk2h191IcwPD9xLPV+L2
         aTgjpGFkxQJcyNdlmMTtzk0BWyqzVj++asBxsgvXnXzJbPQ63+pqPRqGXzZv66PDXU+6
         5IbJKEm9iU7LXJGUnBgGr7ViL/k5iDyXz3DI3hEdw67E9dp1v0Gy8EP47aGirPuCYGKn
         BtkClJo2ISz18oef3qMV6lJzHLdpAylpEpg2Pe2RkBR+thFaKWGzcgonmY3ozY0WnVAR
         O3h14uXfYuqVb9zTZTKJUYz1dz6NhcgGFTBaG5zryWpqdIcn4NMDvxsjp6BdYPtOhsF2
         zBHA==
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
Subject: [PATCH 3.18 31/45] crypto: hash - introduce crypto_hash_alg_has_setkey()
Date: Thu, 15 Feb 2018 16:17:22 +0100
Message-Id: <20180215144122.598907501@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480736419252893?=
X-GMAIL-MSGID: =?utf-8?q?1592480736419252893?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -636,5 +636,16 @@ struct hash_alg_common *ahash_attr_alg(s
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
@@ -91,6 +91,8 @@ static inline bool crypto_shash_alg_has_
 	return alg->setkey != shash_no_setkey;
 }
 
+bool crypto_hash_alg_has_setkey(struct hash_alg_common *halg);
+
 int crypto_init_ahash_spawn(struct crypto_ahash_spawn *spawn,
 			    struct hash_alg_common *alg,
 			    struct crypto_instance *inst);
