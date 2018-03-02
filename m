Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvfabro/h6bAyXaBxYcsmWEx6LuUJKuAAxtp9ZsWEK7Z3BeiCFe1aShwkbN1xUT8p4prsHh
ARC-Seal: i=1; a=rsa-sha256; t=1519981313; cv=none;
        d=google.com; s=arc-20160816;
        b=T5jVVDPMWhccBvHu1/+mfYh/qE3E/SHFp5qS0xHmS8X3kVB7pYUVX/YBt8sLJMR9Pz
         4lUTeE5ZacDA/WHIVQxZjszHXldp8Xs3tweCivj9UTBI3y8qNU46LW/+m9JRqBcgMEK9
         hweXmQbCPB1B57c3ZO13wx/77CWX9AoHqekPJJM1x2x19jDzx6hHw1wvujBS+cWaDCfv
         vNIlHMbT4d7tVyaSd1Ud73mi8uG6NL/L9xSxqsii2nW0x6NDcvwo9TzQtJoId2M3PfRU
         DNH1P3eO4+p5yx8F21qBFd8L7DlvUeNskrMupdt/ObUiIN7l4bt9a9eLMOewHQozYs/b
         NgPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+ccQbjlkto00GHaaJFFpX/13npSev51MmgXYFwfaR34=;
        b=Y8/j3QlHYRYZRDO+fSnlK2iyUbc1LIPZ/pgHXVSp732uTZZlvtstKr7aJ7fcemE21M
         ZoxHIoWYhQj3KOD5sElhXMDSpQpKNMfDxAMR1QvsW5u7KfcteKNfEh6EDeiIq9d7cpBc
         fqP3eYUpZj8lEGZFIlnouAUWpXG1jUfS5kjLhU1wFDphlkH2yH7Fp880G7t5AgPC4p5y
         OIMkabEx8VYaA8v9csJangzuO2Sj7nuYNLssW0atzRZAi9qJTitRQMwzEtXBCveheIw9
         FT+x8Hue2SeFmB+w6KqKIlMlYTWsO7ZtPzyr2WDHDjg9O3dOnmzR86PdnNh/nGnaQDdD
         q+/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ofer Heifetz <oferh@marvell.com>,
	Antoine Tenart <antoine.tenart@free-electrons.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 054/115] crypto: inside-secure - fix request allocations in invalidation path
Date: Fri,  2 Mar 2018 09:50:57 +0100
Message-Id: <20180302084506.062619778@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815925668667596?=
X-GMAIL-MSGID: =?utf-8?q?1593815925668667596?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Antoine Ténart" <antoine.tenart@free-electrons.com>


[ Upstream commit 7cad2fabd5691dbb17762877d4e7f236fe4bc181 ]

This patch makes use of the SKCIPHER_REQUEST_ON_STACK and
AHASH_REQUEST_ON_STACK helpers to allocate enough memory to contain both
the crypto request structures and their embedded context (__ctx).

Fixes: 1b44c5a60c13 ("crypto: inside-secure - add SafeXcel EIP197 crypto engine driver")
Suggested-by: Ofer Heifetz <oferh@marvell.com>
Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/inside-secure/safexcel_cipher.c |   16 ++++++++--------
 drivers/crypto/inside-secure/safexcel_hash.c   |   14 +++++++-------
 2 files changed, 15 insertions(+), 15 deletions(-)

--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -422,25 +422,25 @@ static int safexcel_cipher_exit_inv(stru
 {
 	struct safexcel_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct safexcel_crypto_priv *priv = ctx->priv;
-	struct skcipher_request req;
-	struct safexcel_cipher_req *sreq = skcipher_request_ctx(&req);
+	SKCIPHER_REQUEST_ON_STACK(req, __crypto_skcipher_cast(tfm));
+	struct safexcel_cipher_req *sreq = skcipher_request_ctx(req);
 	struct safexcel_inv_result result = {};
 	int ring = ctx->base.ring;
 
-	memset(&req, 0, sizeof(struct skcipher_request));
+	memset(req, 0, sizeof(struct skcipher_request));
 
 	/* create invalidation request */
 	init_completion(&result.completion);
-	skcipher_request_set_callback(&req, CRYPTO_TFM_REQ_MAY_BACKLOG,
-					safexcel_inv_complete, &result);
+	skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				      safexcel_inv_complete, &result);
 
-	skcipher_request_set_tfm(&req, __crypto_skcipher_cast(tfm));
-	ctx = crypto_tfm_ctx(req.base.tfm);
+	skcipher_request_set_tfm(req, __crypto_skcipher_cast(tfm));
+	ctx = crypto_tfm_ctx(req->base.tfm);
 	ctx->base.exit_inv = true;
 	sreq->needs_inv = true;
 
 	spin_lock_bh(&priv->ring[ring].queue_lock);
-	crypto_enqueue_request(&priv->ring[ring].queue, &req.base);
+	crypto_enqueue_request(&priv->ring[ring].queue, &req->base);
 	spin_unlock_bh(&priv->ring[ring].queue_lock);
 
 	if (!priv->ring[ring].need_dequeue)
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -470,25 +470,25 @@ static int safexcel_ahash_exit_inv(struc
 {
 	struct safexcel_ahash_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct safexcel_crypto_priv *priv = ctx->priv;
-	struct ahash_request req;
-	struct safexcel_ahash_req *rctx = ahash_request_ctx(&req);
+	AHASH_REQUEST_ON_STACK(req, __crypto_ahash_cast(tfm));
+	struct safexcel_ahash_req *rctx = ahash_request_ctx(req);
 	struct safexcel_inv_result result = {};
 	int ring = ctx->base.ring;
 
-	memset(&req, 0, sizeof(struct ahash_request));
+	memset(req, 0, sizeof(struct ahash_request));
 
 	/* create invalidation request */
 	init_completion(&result.completion);
-	ahash_request_set_callback(&req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
 				   safexcel_inv_complete, &result);
 
-	ahash_request_set_tfm(&req, __crypto_ahash_cast(tfm));
-	ctx = crypto_tfm_ctx(req.base.tfm);
+	ahash_request_set_tfm(req, __crypto_ahash_cast(tfm));
+	ctx = crypto_tfm_ctx(req->base.tfm);
 	ctx->base.exit_inv = true;
 	rctx->needs_inv = true;
 
 	spin_lock_bh(&priv->ring[ring].queue_lock);
-	crypto_enqueue_request(&priv->ring[ring].queue, &req.base);
+	crypto_enqueue_request(&priv->ring[ring].queue, &req->base);
 	spin_unlock_bh(&priv->ring[ring].queue_lock);
 
 	if (!priv->ring[ring].need_dequeue)
