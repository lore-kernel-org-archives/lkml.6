Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvG4/w2gpLw68C+WEtiF7Zf91MDYGta7ybhGrO8xkAkcH/in6SRP1L7Pp6pr9DnY9y4SrKY
ARC-Seal: i=1; a=rsa-sha256; t=1519412219; cv=none;
        d=google.com; s=arc-20160816;
        b=SX8/HFA1Bc1NZrBxkYSLdWchTXQsPFj8YVAzmD3nWCHjCmRvG+GeKjcwQCqsuXItpV
         PQzWK8OB/0LK3f9GyWbgNyIy5FKaakzbDx6taitzktMNvguaW0KJd/7x5aQlAv6/ig8z
         u7a8uvc6mQ3l90plqsm9Vh2AJiEazXhkuH/D0rOXHN0LBGUmXBa1zPTM8SKRkBA8vpzU
         8xv6n1J+IetfOkwPykLA0b5rL9zqU8KsrsMu2bY9jAflnzXa0K0ZNAU/pvifsrSpB9fc
         avJGNNjv1sWY+6yO3mAynNkUeyVmWHfJp9qIkcrCaAojUYGgS4MXI+UTbJuGZHR7gfeq
         LE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dbkAoTmHRzNS6k0vGfUU+R+KdnKcwEiQU3xZ29b7O8k=;
        b=nazy/Hb1Gtk10xYG3ZyAe5FudTs2zYucvaRka5afwO4IsOGDbp3myWkMw38szWjSCo
         k1EtuTfgWzRNjT4FquVPaRxywxtW54Pn149aflUeIeEx7EDLXMYHqN62R4/zZq/WEUhL
         aFnU2X70aao8GTp5lZRkYQv4czf4iuzzsJEwX3VZpKvdD6hbGR9mpc44az+BeBxyEdv+
         NHdOzRvFCOcWuuCOP/cS1EcuNZXj7b1Y+EdgfDWzuUuF07r2tx05bR3M8vOpgVr65Fae
         5vp3RFtTk3AWSHA8DlmxvEpxv+G0DCrIHvYyf+eajoiKZ2OX2paMbD0fz8+vS7YNob3+
         DwEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kamil Konieczny <k.konieczny@partner.samsung.com>,
	Anand Moon <linux.amoon@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 156/159] crypto: s5p-sss - Fix kernel Oops in AES-ECB mode
Date: Fri, 23 Feb 2018 19:27:44 +0100
Message-Id: <20180223170801.818855262@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217639655479509?=
X-GMAIL-MSGID: =?utf-8?q?1593219187657957650?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamil Konieczny <k.konieczny@partner.samsung.com>

commit c927b080c67e3e97193c81fc1d27f4251bf4e036 upstream.

In AES-ECB mode crypt is done with key only, so any use of IV
can cause kernel Oops. Use IV only in AES-CBC and AES-CTR.

Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
Reported-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Cc: stable@vger.kernel.org # can be applied after commit 8f9702aad138
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/s5p-sss.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -601,15 +601,21 @@ static void s5p_aes_crypt_start(struct s
 	uint32_t aes_control;
 	unsigned long flags;
 	int err;
+	u8 *iv;
 
 	aes_control = SSS_AES_KEY_CHANGE_MODE;
 	if (mode & FLAGS_AES_DECRYPT)
 		aes_control |= SSS_AES_MODE_DECRYPT;
 
-	if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CBC)
+	if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CBC) {
 		aes_control |= SSS_AES_CHAIN_MODE_CBC;
-	else if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CTR)
+		iv = req->info;
+	} else if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CTR) {
 		aes_control |= SSS_AES_CHAIN_MODE_CTR;
+		iv = req->info;
+	} else {
+		iv = NULL; /* AES_ECB */
+	}
 
 	if (dev->ctx->keylen == AES_KEYSIZE_192)
 		aes_control |= SSS_AES_KEY_SIZE_192;
@@ -640,7 +646,7 @@ static void s5p_aes_crypt_start(struct s
 		goto outdata_error;
 
 	SSS_AES_WRITE(dev, AES_CONTROL, aes_control);
-	s5p_set_aes(dev, dev->ctx->aes_key, req->info, dev->ctx->keylen);
+	s5p_set_aes(dev, dev->ctx->aes_key, iv, dev->ctx->keylen);
 
 	s5p_set_dma_indata(dev,  dev->sg_src);
 	s5p_set_dma_outdata(dev, dev->sg_dst);
