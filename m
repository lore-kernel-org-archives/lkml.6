Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/B6UEaGj2c2fqxLoNkc8VImdnyLWsefYm84kZxadjo2vkvGj3KhNBzac7mEXAQ9mU9q7du
ARC-Seal: i=1; a=rsa-sha256; t=1523981041; cv=none;
        d=google.com; s=arc-20160816;
        b=XtGKOSQqbu+OsAi+0bbhrXE5stFfHnnrNg8YXlfHszDLdCv+pmztaglcBBCRuwhYGH
         TE5+Lb6VA7pMPGkSFTYrJ0hu7UeWiH0Lrzoj0jmbCSxM9WFmoQDKmtWZmJX0qZRujfcx
         h8hmdVELwzSrZvwResVlAqBwTPmFtOy6EdvjbWfF2jG/HOHuSKmcFVlAsMefq8YIJytL
         Tff9R2A6MqEkVdK+cszdrOI9Y1k6m4vkVB0i1XdG7aZ4ZP7JyvniLfncPmDvY4mO5gnD
         t21veVp7gxOgChznvoDbYtbTvSMgx6HhGtQIWV2ovOh9Zmzkd049C307bwr0qt9AHwTu
         M1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=adKGoFck9Z+keFp9sQRu2udg7nzo0SPR69P5SRINkP0=;
        b=rjXwDDi1m7RkrAc81sS9nba0f+wxDc36F02n4wFq8NFCLC1QQ2zkgIgMSbKEpJ0RTk
         K0G/z8Uu+Gs8LfXpxR6LCXWNjpGbHkAncCpLfXowp6bo/hfRVCnk42jLT2r1aLYYR1iY
         4QZnxauFW0LRgpANsIOQhn1lSae6eURPq+jZ583XP8omgtLUCXl/Ss9eiw8IhcCnpGT/
         qE0xnx83/8oi2xL3dHRxiPk6LotH4j5ZmT24mfQzCd0yxQN4scx07XlnEZNOMogT5pT6
         paX8FhtwwCsFcYfW3fKHvHVCu7EdQIHLP8cbFteLf2VAKuwG9oYEN4woXyAn8KxanWkA
         rg4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Young <m.a.young@durham.ac.uk>,
	Eric Biggers <ebiggers@google.com>,
	"J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.15 26/53] sunrpc: remove incorrect HMAC request initialization
Date: Tue, 17 Apr 2018 17:58:51 +0200
Message-Id: <20180417155724.416498922@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009764077402720?=
X-GMAIL-MSGID: =?utf-8?q?1598009944686014987?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit f3aefb6a7066e24bfea7fcf1b07907576de69d63 upstream.

make_checksum_hmac_md5() is allocating an HMAC transform and doing
crypto API calls in the following order:

    crypto_ahash_init()
    crypto_ahash_setkey()
    crypto_ahash_digest()

This is wrong because it makes no sense to init() the request before a
key has been set, given that the initial state depends on the key.  And
digest() is short for init() + update() + final(), so in this case
there's no need to explicitly call init() at all.

Before commit 9fa68f620041 ("crypto: hash - prevent using keyed hashes
without setting key") the extra init() had no real effect, at least for
the software HMAC implementation.  (There are also hardware drivers that
implement HMAC-MD5, and it's not immediately obvious how gracefully they
handle init() before setkey().)  But now the crypto API detects this
incorrect initialization and returns -ENOKEY.  This is breaking NFS
mounts in some cases.

Fix it by removing the incorrect call to crypto_ahash_init().

Reported-by: Michael Young <m.a.young@durham.ac.uk>
Fixes: 9fa68f620041 ("crypto: hash - prevent using keyed hashes without setting key")
Fixes: fffdaef2eb4a ("gss_krb5: Add support for rc4-hmac encryption")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/auth_gss/gss_krb5_crypto.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -237,9 +237,6 @@ make_checksum_hmac_md5(struct krb5_ctx *
 
 	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
 
-	err = crypto_ahash_init(req);
-	if (err)
-		goto out;
 	err = crypto_ahash_setkey(hmac_md5, cksumkey, kctx->gk5e->keylength);
 	if (err)
 		goto out;
