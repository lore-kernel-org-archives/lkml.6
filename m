Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227gmfFCQEFlKymv/TreIpGgDcfZeqJ5rP8XrdnSIBQdpfR8WvGvjHk1hAaxvrdcyQ+3GlnQ
ARC-Seal: i=1; a=rsa-sha256; t=1518708881; cv=none;
        d=google.com; s=arc-20160816;
        b=ulruPmFsWLZqngqFtgouhHt/mbNNmJYNsrdVlD7tIjHJH9Ypr3Iosrx0l7ciGxBOa6
         RgXaou0yOc6e3g2SxVNlr1yIV6RLsD3iFVOzlNk4gA83CM5PotLx8A1Nxs6I2LfAuo3S
         iC2Ns6WIkcVN39jNIbJrfU2bJ2qGSzKlenhmOp3RTlmdeFRMPKZpP9u6N5jS94abMMs1
         zU88WjN8dkvLI1OcDOEhUS6LL+Fida0OrO6Jrco3kpK5zMzyUpI1KBy3B/j4bOPbTpsq
         8ORaSi6il+9QWKYhuVNq9L93v/s+TZteS1LCU3Iawifsy5lcbNexm50Uo70vi3IZVX3F
         vnkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OD3yHYxbbYvfac4O8aYU84SgoSh+hdeLVi5biWJF6L0=;
        b=Wng54nx8168zz1SkTO3Spg03X/XqL+nkaCiWGjvFq55LDF5qhVR9tWmNBiq9hxaloD
         1iu126GN0pRv8VnEz+TqK0wHWFWYZ2dr2f9M6dZYTQyJApAafhOh+Macxze1/q7kH0gu
         dyEN5skiBc+AOiUpg9mAio6CQUVimGWwbePhO71zRIbYrelphAAd6ceaHXGDJy73U+hk
         HrAiotIhCghEgdywjpIXBJtjGy438OF6/hLfVHSxycL3w1ei68PaC3AM95V5GAUKa34A
         6fMclLgRRCQeNPxeWs5jK2xkUDuWY/Kv89wP9NYVr08h+wsJP2frUTLf4hnit9HI+6vD
         /DdQ==
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
Subject: [PATCH 4.14 114/195] crypto: hash - introduce crypto_hash_alg_has_setkey()
Date: Thu, 15 Feb 2018 16:16:45 +0100
Message-Id: <20180215151711.389219837@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480736419252893?=
X-GMAIL-MSGID: =?utf-8?q?1592481684825087885?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -655,5 +655,16 @@ struct hash_alg_common *ahash_attr_alg(s
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
