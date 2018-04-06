Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48nld67a+knbzOEoXwIsxLIhH2YplZdPVvZXbGxeBG+H7hherYQjdXKMhKnaqU4KRJJUZfB
ARC-Seal: i=1; a=rsa-sha256; t=1523022241; cv=none;
        d=google.com; s=arc-20160816;
        b=K83EPTb51mv+JnytHpOourxLybs/2+qTnOFoYUkZMKFXNHZaIXZI31dZy87LAQnjm9
         g5iDu0CY9PpGvSZ5xj3pbdKSP+K1dlPfcA0AS5xEl36PhYKH8KYXalRGCGhiGIBGPp/D
         4Tz4Oe753OE6mmKj/1fb8MhwS2LED7Gctn+fQJnsTfR9EHpoCMkNI+3ys0dvxW8ZoTp5
         AIbb5tz56eYnZKTi1S5sf4I92rhiAUE04ix3j/0t0/L5hWaf2REPZ330dRUVhdeISwcJ
         IsQy+q+EN+9EmrLEdU3/mSu7zIIJKynBndqu2n4ist4oX8+mD8wmZgp6HAo/Zubp99Yw
         kidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=H26ZFI7/ZqoZBtWZ7mvV0gvxONhBRteOW90j5NE5w+U=;
        b=VjirOatmRa474OCA9yo1p4pq36MR7AA5Vmmlz+1MSNPnK0zuxzCs85S7PwvHesvl2c
         rkl4mEg8Un3bEn/0Kp5a6JLokA4Jcmn5zSGKOvsWyt+UI772yCrw2aettrg6XUPEhLhZ
         HGaTBWg13OwAJQwZPQWjB2jW1HhCHaw1x1bYf+5QVJX1rZcheYLr8W7u/cTCv+ax6xZK
         2vy/OKPqstiMsq1a4bQIEW63p23Q6tXjp3lqU5hfLEJW0ve5gPb+f3masftNotOplnbl
         cjoapf3q4l5zH8If30yvdA5lmMiiYhkEYuM86BXk/GbWTUDIxUZLovT8a0zKq6oPPnTN
         9TMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
	Gary R Hook <gary.hook@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.15 56/72] crypto: ccp - return an actual key size from RSA max_size callback
Date: Fri,  6 Apr 2018 15:24:31 +0200
Message-Id: <20180406084353.247534053@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004281875020882?=
X-GMAIL-MSGID: =?utf-8?q?1597004570628242792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

commit 0a9eb80e643064266868bd2fb2cd608e669309b0 upstream.

rsa-pkcs1pad uses a value returned from a RSA implementation max_size
callback as a size of an input buffer passed to the RSA implementation for
encrypt and sign operations.

CCP RSA implementation uses a hardware input buffer which size depends only
on the current RSA key length, so it should return this key length in
the max_size callback, too.
This also matches what the kernel software RSA implementation does.

Previously, the value returned from this callback was always the maximum
RSA key size the CCP hardware supports.
This resulted in this huge buffer being passed by rsa-pkcs1pad to CCP even
for smaller key sizes and then in a buffer overflow when ccp_run_rsa_cmd()
tried to copy this large input buffer into a RSA key length-sized hardware
input buffer.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Fixes: ceeec0afd684 ("crypto: ccp - Add support for RSA on the CCP")
Cc: stable@vger.kernel.org
Acked-by: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccp/ccp-crypto-rsa.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/crypto/ccp/ccp-crypto-rsa.c
+++ b/drivers/crypto/ccp/ccp-crypto-rsa.c
@@ -60,10 +60,9 @@ static int ccp_rsa_complete(struct crypt
 
 static unsigned int ccp_rsa_maxsize(struct crypto_akcipher *tfm)
 {
-	if (ccp_version() > CCP_VERSION(3, 0))
-		return CCP5_RSA_MAXMOD;
-	else
-		return CCP_RSA_MAXMOD;
+	struct ccp_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	return ctx->u.rsa.n_len;
 }
 
 static int ccp_rsa_crypt(struct akcipher_request *req, bool encrypt)
