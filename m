Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x22775RXkwwMeonvj0+DiiE7kHNP7NPuGIycEe/wY1hi3VpBnMy0blwzFEihaWVdavg9PXVHS
ARC-Seal: i=1; a=rsa-sha256; t=1518707982; cv=none;
        d=google.com; s=arc-20160816;
        b=nBWn5stE7ylCmFeWL5o0OSzeSzM4FbDLoXpDjO8DN0K7w0hdRSdiwucY6ue90bMPMM
         jXSVrKjqL5oWVNVMA3XsgD5UuLVZO8HNeuu3XgPS/J9hljkZuP5dfim2yLb6klYAmaKL
         3JIwgrH2wA8j/4I6OYZtzWVJTgbukqmYZzUhZ3FXfowiDlEIETXUwOiZ4gVbLorZ5ZiU
         8j32NdSKL3iZFjfUU4SDRoMJutYNhsQ3ORYL0jnd9tLey2U32n+j49OiwjXwt8s6ws26
         6V4fC6eP+/B3AycRa1pQ5IP4Gt/k2XVjiUcPKL4Vzw6F7tw3kWHCCe0s7KGOiw19TBFk
         glgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=B4AIblebKZcPO4CVECv6UyfxEeTDra1sjuRxVA7NiJI=;
        b=tTCnCdBqV2uo7UHLCYtMivKAmwskBvB/FQImXU+zQYDVpshr6UDcVvp3aogi1EVthq
         pYBM0JVGxk8WpCgQMawpBLqM5xAo/X/my1BfMuVe37VXBVILCAExvKdyUNiI+4lS2Drh
         xwQ1OGWWLcHhmii3iS+MeNbg6rCG1U1JvtMK7ouVAaHul97Brm2GlksbkntOMJv7nfYW
         wqKFQgvm1+0xlnKkgLqcB2COu8Tp/HaM4hTmluFLpN4emjZr2sVQcMyWyfTx8Pp6nLMM
         6Bxy8AxG3BfnDPaM2kLcv0xaJ08TB47s0WxlIgLJ74UbvveeIy5btwcYqSwxUPqM2bHG
         WFdQ==
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
Subject: [PATCH 3.18 32/45] crypto: cryptd - pass through absence of ->setkey()
Date: Thu, 15 Feb 2018 16:17:23 +0100
Message-Id: <20180215144122.792567406@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480741570671700?=
X-GMAIL-MSGID: =?utf-8?q?1592480741570671700?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -618,7 +618,8 @@ static int cryptd_create_hash(struct cry
 	inst->alg.finup  = cryptd_hash_finup_enqueue;
 	inst->alg.export = cryptd_hash_export;
 	inst->alg.import = cryptd_hash_import;
-	inst->alg.setkey = cryptd_hash_setkey;
+	if (crypto_shash_alg_has_setkey(salg))
+		inst->alg.setkey = cryptd_hash_setkey;
 	inst->alg.digest = cryptd_hash_digest_enqueue;
 
 	err = ahash_register_instance(tmpl, inst);
