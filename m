Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225UJg+tR3dRqqNfta7CZu3jSRYeFZEpInCqsN52zhYDYGHPUuV3QOOLuDgBzDw7cAUYS8qJ
ARC-Seal: i=1; a=rsa-sha256; t=1518709416; cv=none;
        d=google.com; s=arc-20160816;
        b=0duyC1Rbz02+9yQOvNV4KfBqbYSqlN+rOpUttyO9teL9AbFwmZR7AhpaSupg3NeeJ6
         UuPmW+YMuCAhEMuS7A6hazh/1OLAvO9B4END1AfChSLqopbZviP070J6upcAfN4TFj8E
         J04Jq0UI1iN8rKIki7jV2H52UTW5WabnkoZ0dFoC3yyrSEyhw3GyIyuCuSU1msCKhqeC
         NjsQcges2AXOykA7VmEgcC6VzMP8AYQ6naDcVnVT69E8GXg9Lj/xzEu4WVVP2M4PwjMl
         SKSS1X3ZWnMmumhm0KxDWe3dGMdn4bVi7PTkv0Re1/QkY9irQhshGhcmAnJBBtOGbzBg
         bX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=q4U3iAVRzUWbyTlHP//YQeTznXP7HqCdRsHhuGEVlvQ=;
        b=OKWI6vvQ7LtBhUZBFUVAgSKqZbPuMREvH1S7FONZ2R5zdq64ESIorZenUma+Ra6Y5e
         Z+nUvYfU/mnVzTlNr+vZ+4PNAGcw/efN1BPK8yl2UlK6KD2XKi4YXMheNSQ92FmQTYrv
         7+kxYh1giipFTxIv2STmDRdJdbcIPETOhm9b8MhzXkZzkwADBx8tWY8ybKhKO/CD8oIT
         bdqPpVef8wwV8EZ0KR7vLeGJOQh5RN+kyUJ8h3kBio8BqV0C8Xmq1UR567nBx8BPaZS1
         MK1H6TM9Cu0T6iVC+FtyB2X8ZKYODUr4kbiOVUSbomtg68UoHMpvbu205F17x7hzwh60
         o4ow==
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
Subject: [PATCH 4.15 109/202] crypto: cryptd - pass through absence of ->setkey()
Date: Thu, 15 Feb 2018 16:16:49 +0100
Message-Id: <20180215151718.937873847@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480741570671700?=
X-GMAIL-MSGID: =?utf-8?q?1592482244888808895?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 841a3ff329713f796a63356fef6e2f72e4a3f6a3 upstream.

When the cryptd template is used to wrap an unkeyed hash algorithm,
don't install a ->setkey() method to the cryptd instance.  This change
is necessary for cryptd to keep working with unkeyed hash algorithms
once we start enforcing that ->setkey() is called when present.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/cryptd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -911,7 +911,8 @@ static int cryptd_create_hash(struct cry
 	inst->alg.finup  = cryptd_hash_finup_enqueue;
 	inst->alg.export = cryptd_hash_export;
 	inst->alg.import = cryptd_hash_import;
-	inst->alg.setkey = cryptd_hash_setkey;
+	if (crypto_shash_alg_has_setkey(salg))
+		inst->alg.setkey = cryptd_hash_setkey;
 	inst->alg.digest = cryptd_hash_digest_enqueue;
 
 	err = ahash_register_instance(tmpl, inst);
