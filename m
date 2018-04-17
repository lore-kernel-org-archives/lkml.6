Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48lYWh6LCzrc68MrZbqM9EFYzM/nJNmuMDVTsT73pS/oIOjnIpRmdrn5BaKBePxkjU9c+zV
ARC-Seal: i=1; a=rsa-sha256; t=1523980869; cv=none;
        d=google.com; s=arc-20160816;
        b=YxDF9PP6a0xUe1PkElznLIKgsEi0w635Wws/JoB3asJTwl1sAkh6O2XvUKlahF59xn
         me/4RoAQuhwiRnBWH2Me9b6lCB5GHJ9JlXKUBCQPOmp6XlUmH+2+vOCqVRQh+iJfnKoP
         eflz8DN7lcJ85D5ru0dc2kcoyHMIBqSADHyuD4JDDpjTmhGxB6xq4uBGOOeeE/tgpw4I
         5UOxRkx0qvupzvQ4NKWoEbySaz6SJXLE3QB4wo8G3W01ohdTjJIVnyWBBn29904ZpRzW
         xe4IRyPr9gUGZBA0Eh/EPqlPAwTBis/Oftumyopx55Jep320fWtaDCUG/Bpzq9yQ5sY/
         IUqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tDYRlRVyL99pY5nSW832DQeJI+/b+d40grPiajlqt78=;
        b=P2og2jniAu/nHMDEXJYjI2G/xmWFH12rKqOC5i8OLHRvOqNvAFYRPnrycAPd038jVI
         qDEPXNP5Saw81oTL916oXR9TDJ+hpDeLof/SekqdIPbAhknB4eT/6FIj0NprWT7byhCh
         lzvEQpv8TRO8rk9E22wHxsjL74ZZJuWa+aNMUmkbD6llocjT41iOTt7h6W37qHqS9VGw
         EDHUaBUh59g9S/1LScQI9V9i9UqKKKhULmplWsXWzlsbnyxVfgdGYXWG21EmCwjNcsQN
         npWxx/WNzUhRitrCpVz9smUzKE3M6gScpYmQ0hsYZofOKBXvFlM+d5ZA5MagKrgIqti2
         /xbw==
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
Subject: [PATCH 4.16 34/68] sunrpc: remove incorrect HMAC request initialization
Date: Tue, 17 Apr 2018 17:57:47 +0200
Message-Id: <20180417155750.730189624@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009764077402720?=
X-GMAIL-MSGID: =?utf-8?q?1598009764077402720?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
