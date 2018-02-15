Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225qhakLzagD/XmmvYOXPROzzzWWQum3dAo5XjTM82ZagXmjYbiaEDvGU5X3Dm88xsodV/my
ARC-Seal: i=1; a=rsa-sha256; t=1518709413; cv=none;
        d=google.com; s=arc-20160816;
        b=sTkcFdB7Um6ZvvIDSsgipSa41w5SJf+DiAkfnUbl9iqGh9xjnJ9z0oX0T5L4AuE1CA
         niaD4xYrctNOuE6gzpvg0/76xsdZyf4mSnBTyJqpWqx7w4HFcq3BSI2brYr0KyAuH+2Y
         D2l/gEsuD7fx7JR17N50GjcURWUWKpPndbL5XnPlXziAbmBu03TRlnZ6SVxL7UCVwG62
         jf7DrrLnbndAL+ed0iZMcGE5Neqw3RpU3DOsrIw7QiWUKmlRjkkmxuXUqeyqYvB7XUrc
         F7/+kwoZYvGFbza6PXnGE9gJUByyu2tNmTCmM2LbSiDHDANnd7b+VamNQBMdqaqkzifI
         uJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2L+kV8D08mBSoCtpDsMc+hBybxhDF80vR1jj2JriSaA=;
        b=xBdqvBNbCPjwfz+5SMW7YuwOmRLn5IbF1FULrNUSSgUlSIbSQGRElkw5xtMibMmFQr
         8RB+fGy5V6Xp9AVR8CpYOoe7/rgun0LfZuBVeeaKDQh1gN2S2vNiXMffHYlsW84JQLK5
         wnfeR+8hQe9sw00G0DlStFGnKieLWirs7tevrZ1J+hJSzX7wyeW8oBivzIXC9n4ar7+H
         zUi/Um91r+doDfJl92MH9fm6rCEUpIoo4J8KCZ4BuKQAfH7x6aqQWZoPOorhChY68vee
         UcFel1saxFzyo+PLBSR2MbCalEuiERXl+9bFXBx6CbE1hpmIKBAY9NjpKqMylGspFASD
         huoQ==
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
Subject: [PATCH 4.15 108/202] crypto: hash - introduce crypto_hash_alg_has_setkey()
Date: Thu, 15 Feb 2018 16:16:48 +0100
Message-Id: <20180215151718.892416554@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480736419252893?=
X-GMAIL-MSGID: =?utf-8?q?1592482242371783769?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -649,5 +649,16 @@ struct hash_alg_common *ahash_attr_alg(s
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
@@ -90,6 +90,8 @@ static inline bool crypto_shash_alg_has_
 	return alg->setkey != shash_no_setkey;
 }
 
+bool crypto_hash_alg_has_setkey(struct hash_alg_common *halg);
+
 int crypto_init_ahash_spawn(struct crypto_ahash_spawn *spawn,
 			    struct hash_alg_common *alg,
 			    struct crypto_instance *inst);
