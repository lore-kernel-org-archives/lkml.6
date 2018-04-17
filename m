Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/DFFOF4UC+qeQfXoxFvpRNxoAcOfKasVGuWyqzlc9iLvXbB29uUpS5U4FuyKNI0/ttjjdH
ARC-Seal: i=1; a=rsa-sha256; t=1523981407; cv=none;
        d=google.com; s=arc-20160816;
        b=hasDGJpUlA7D2IFx+3nX4ajN46rmaleRaNf7NF7rnr6orJHUUHsoRXifAKLg4KQU3J
         bNL5VHCH0FuIJ2Du3VorGVTii7fSPxwEminP7uZfvpuvLLJijw5prY9682gl3BElwaK9
         7lG6dT1GkxGiScQdszjCvxgh8ra7bC+UafYuJRv3Yc2LvimFzajPBhiXlWV13AO9cREF
         bPBwh0p4xBZPsc/CGRPzEpn6AKW/U/V+snAZv53IjHGRQtFYFo84Bd50TA59v77FiCiO
         Eypc0pDy/xeIkW6kA8LwIgLg2VtXq4Em7VxQU/d4YsA9ryeUjDVfjJhePF8jXG/LO/2y
         BvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RO8yvfhi37G7YUnn+t+VHHoEWqtzPOqE5mGdpzpRYMQ=;
        b=dP1200Ztlrs2UbY/gG5q5OWcvl1atjcpzCEHFMLzG27oVZ1j6/FjocXIBqrru0V3op
         umUNIKCqM1zDTxLnWiT2Gmqr6h8hYkjTeW9/Lzjy9+s6zHPX/JlGJSDDBQPHhnQJ81MI
         4EnFlw8RZZQvyIPMHQiCxJsc291Z0/EmBaZJ8AUEtPMAdmOwIZ7QOBIE4K6cGGPLGqna
         SWZnC0Ig21W9Q3wjxx/b6gMZ70b5XKY/hHCtlFWsqymfxFrfal+aadzwFRb7qA13QyXp
         BW9IQXfB+FMkNiCvCKRCcAQsXkbTryXk4Jtr/HAf35AOBR71RG9iaD8jG5kEYcSTUBnH
         nS6g==
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
Subject: [PATCH 4.9 51/66] sunrpc: remove incorrect HMAC request initialization
Date: Tue, 17 Apr 2018 17:59:24 +0200
Message-Id: <20180417155648.106865963@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009764077402720?=
X-GMAIL-MSGID: =?utf-8?q?1598010328669385783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
