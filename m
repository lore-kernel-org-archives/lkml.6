Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226adEsQQyJS9H4SWqgV0NSdUnbBnSl7bN5guJ+ZWHIGItejYqkJol2BPzEc+A6mN8pxmMYw
ARC-Seal: i=1; a=rsa-sha256; t=1518708410; cv=none;
        d=google.com; s=arc-20160816;
        b=vMwiR1uikK9Q+93QwJcO2Y1HQHCN3sOtALwUwpOjeKobgITxtHCMh/d92rTgyVFr02
         lcK+aPauykNQFHw96ypv0iqnbN42Fn1pgyC3xOaELvvGID2Q+mwyV9KigHmksRPONtx1
         cHkOdKy3O6ClphZ5hc7vqWBEAmhUoCAzAEmph1g4jKF/HgofMyzIxayjIgryPShMITFg
         cnPetbfbrUtOiFpV8ySZUd3KAYzqV1bllONboan1yDEmU1lUzlCkw2nbFpJqxh56l2zI
         kVS5p2syNVdtTkRdzaDTVXR5s5piZpvwa6DQhkYA04D0hU/x/3Tt1PoHrRjWpEvBttP5
         Ergw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gIv2DkhHG/sSP75RA1rJPCJsq4Y80YeBagkbHE0+e84=;
        b=N9Dh3060nrM+onCkl7mVv7K7dhvLZFEADoFB8u1Psti6Y/tdYFUusfQy5MBgQfNdyn
         3c34Y6+KOvxTfRVTm7fADX3Sfe7+QA9aSoC92whLBzUYAbtnoX7sO+je30ZMUWkWQPV8
         orxJk2hT5yZDIc6+4UH8oHE3k412fSnscjzWv120ZHDxeZCo/fkKihaP2BwGtUsO5UN6
         aLnNL6nLHzjWam8vEXTi9ax0DydCC+BCObdRHHbvQe8CMg/j7GjRKC6RZVwMpzLGB7YL
         PHik6qdOtcI/JiJWq6GSdndkdhPKDjijKb2JRPAa+r1PhtaLWS4EYmHW78dQRTkpP0Zs
         S4GA==
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
Subject: [PATCH 4.9 33/88] crypto: mcryptd - pass through absence of ->setkey()
Date: Thu, 15 Feb 2018 16:17:00 +0100
Message-Id: <20180215151227.257655460@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481189631310311?=
X-GMAIL-MSGID: =?utf-8?q?1592481189631310311?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit fa59b92d299f2787e6bae1ff078ee0982e80211f upstream.

When the mcryptd template is used to wrap an unkeyed hash algorithm,
don't install a ->setkey() method to the mcryptd instance.  This change
is necessary for mcryptd to keep working with unkeyed hash algorithms
once we start enforcing that ->setkey() is called when present.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/mcryptd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/crypto/mcryptd.c
+++ b/crypto/mcryptd.c
@@ -534,7 +534,8 @@ static int mcryptd_create_hash(struct cr
 	inst->alg.finup  = mcryptd_hash_finup_enqueue;
 	inst->alg.export = mcryptd_hash_export;
 	inst->alg.import = mcryptd_hash_import;
-	inst->alg.setkey = mcryptd_hash_setkey;
+	if (crypto_hash_alg_has_setkey(halg))
+		inst->alg.setkey = mcryptd_hash_setkey;
 	inst->alg.digest = mcryptd_hash_digest_enqueue;
 
 	err = ahash_register_instance(tmpl, inst);
