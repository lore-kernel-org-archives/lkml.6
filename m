Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227MUbE7WfiN34YQgsHsGSOtSSzF+Vvdvt4ijHYxU94X2/gNbkiXP9FXDJkmapV/syWXUJ5H
ARC-Seal: i=1; a=rsa-sha256; t=1518708889; cv=none;
        d=google.com; s=arc-20160816;
        b=IghPuDYYVI2I0t+G9ghu0IHJTOlNxUNsvU7ZS7csKqHcg0Rx/26AKnFDBHvmcl9iJO
         ocXOkkVt/5kaDFX+OfGlBC03M3MMTfgh5JAs62wZw9ibx41tSozArnSnITxTvPIuUx3q
         J/JOG4zYId7jW39M+zDBBmxiIaKKOANzsDD1qh//EMXQ6IIWGs2UGQcJIM6UPvAIf5Lz
         8Lkv7BqyI2lB0H8HYrTmZFi+I5QoKxUmppoi/GB0CB2mBF9R4Iir7wChzcxcQQAddnV/
         Qob+mCERfMaq0iP9PNhg+9MvAsydrv069/RF/suwNdHGCELle4CzIdckd9j+qZKPWwoz
         1lWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=r6Zgo+qnpqdhYkolyi/WSL1JZuKku/Fmx5Dwa2sRPLo=;
        b=dSF9kSoI+tKsiAVlCFBE30F+pXhD9a/6LZnDXuX0D7XwV36aNK/R3nF3cbRmKj6yBo
         tETavHh69VxWF0JJ1lWMfAGFouYxU2QyiVSCjsXvi2AoxtJ2vS6hMGe+f8IiAH5GyDan
         01uCto/jaUsCYiI434hbWIMLizy25uREM1GlB2WZCI+oBiH11MMw97W8gnObPqQdT8H/
         n1zebWQVbphiy/K9zjELWtr3vfBQhKF9fGpzNSAWWG3KTGByr+I0tapT6d3OV8VGQB1l
         g3RLqp0I/4kP7TNCE3uEOv6MpY9Rx6ieIFZQe1GBTvC4k5H3lEMgNSR1A7MZTxN++JWM
         x5cA==
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
Subject: [PATCH 4.14 116/195] crypto: mcryptd - pass through absence of ->setkey()
Date: Thu, 15 Feb 2018 16:16:47 +0100
Message-Id: <20180215151711.492621983@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481189631310311?=
X-GMAIL-MSGID: =?utf-8?q?1592481692840448204?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -535,7 +535,8 @@ static int mcryptd_create_hash(struct cr
 	inst->alg.finup  = mcryptd_hash_finup_enqueue;
 	inst->alg.export = mcryptd_hash_export;
 	inst->alg.import = mcryptd_hash_import;
-	inst->alg.setkey = mcryptd_hash_setkey;
+	if (crypto_hash_alg_has_setkey(halg))
+		inst->alg.setkey = mcryptd_hash_setkey;
 	inst->alg.digest = mcryptd_hash_digest_enqueue;
 
 	err = ahash_register_instance(tmpl, inst);
