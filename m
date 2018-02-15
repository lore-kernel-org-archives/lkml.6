Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224nYWh0LfXGMiTXPQNGWJ5FL8CqAhXo00aJkgy4zW1etlkPAip8YcHG6WFBJn+3p9uPehK+
ARC-Seal: i=1; a=rsa-sha256; t=1518708407; cv=none;
        d=google.com; s=arc-20160816;
        b=xJN9xjJOPh9ewA3mCW2YTkv8SAaoakQSXmUTilyloBUXkoK9El2F31+dkbXDmqKXQI
         MI1vSEGVcxTwYyZ9tZKk0JMf+BRNnJTiJwfBu0emRF+1JyOXouojilB3eHaSlOtZ1UlA
         3JHepFEuB/Nr5H+ajYSIYXNVTOtrCwTh71DFG2pR948l06MZYJD6To0bCKS5YlBpulf5
         sm9MZb8wgrBW6HbgcbNFOpOZ4eGAQ91gOHnHS+iwxVaqmANxM4t3iJ0LRxZcCIXRGNkW
         z+0SkGN0qrmlIt9OuZMJ+MmDZ0ppX4A1KO6erhNuozeqVM10OjYgrUotH8sCgH8Xv5VO
         iXsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7ld2aq6huFShKI8OSu7gniGiV/rVprczhs4cdLgGIj4=;
        b=cRYr9Kgsqhvf3QNxAE3/+EnbHrM/ahryiFiS8Whhzdw6Wgqs2i41F5cDncjFn3YDtk
         ZnezjoDkme41FnfiUVlun2V5zlZHGJkMh3pOCqKqcHI0koB6mba63cT0aXSK6Un+KkWe
         O+yQ/inAvyDa22MdrfEQ0S/ELK6bwaPAwVq4LWngT8nAbzbLFwk5g9hdLnFEfwxx27Jn
         bKKBlh1TRaoHJo1p746k/5P/tUIVjXxMcEs+VU65tA0xVSmySukMmJVIBvocLYDdB88D
         33kfn1FfNaUg8YeRN9Ra6cx5fykh7IRRNTE8FiW7qGo0oHOKMsdzrC0ZeSKxqBenta/J
         XeEw==
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
Subject: [PATCH 4.9 32/88] crypto: cryptd - pass through absence of ->setkey()
Date: Thu, 15 Feb 2018 16:16:59 +0100
Message-Id: <20180215151227.116313542@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480741570671700?=
X-GMAIL-MSGID: =?utf-8?q?1592481186524365726?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -691,7 +691,8 @@ static int cryptd_create_hash(struct cry
 	inst->alg.finup  = cryptd_hash_finup_enqueue;
 	inst->alg.export = cryptd_hash_export;
 	inst->alg.import = cryptd_hash_import;
-	inst->alg.setkey = cryptd_hash_setkey;
+	if (crypto_shash_alg_has_setkey(salg))
+		inst->alg.setkey = cryptd_hash_setkey;
 	inst->alg.digest = cryptd_hash_digest_enqueue;
 
 	err = ahash_register_instance(tmpl, inst);
