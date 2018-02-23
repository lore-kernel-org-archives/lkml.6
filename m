Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvYbmeBBXOTrIY6Ow8xSbcdRQDVJ69GJaX9T5KwzxEoUYdZpQDdAQyHDgMaCghow4v+jQ9V
ARC-Seal: i=1; a=rsa-sha256; t=1519411331; cv=none;
        d=google.com; s=arc-20160816;
        b=MXmJ16B5Vcd5QTcZgZOVxcipQv4NK0E/aOWPB9Z4kYxGaUce+m58aftzaru8jx3pIp
         PB2w2IkH8QQzJUyDVh7AM/OC7EDTifqc88y8JpI++Xi3Gq8/bsGKc+QcbFIh7gyD3CFF
         fGTm9WTz6m3glacivYWiU8AduQuUTaUGqwHleU3olSD6VRs5cRqGu1fX+watQ7jhpIx+
         +ghBqCENiGKOUj2yoQRaDeM9cxYfZZLXI5r5S1W8R25HgrSlyj6WrTitJ6l0tpjdi/uT
         /xWhB1BjAiRYVO8x2DIdVAeug+L7s5pLQTqOFa+WestKvoziL6tP0x3STjG7M6TGu4eQ
         fttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=l5tmCNOCL5ZPF8FZIxxcFUCMUVdA31MRxUkmbTMW7eo=;
        b=bpTzKLisreN36uiU+3/Y2nQbj/J6mh5VRht2UBwLwIuQWs5WHnCHgFNEYmw0MOfoFE
         M6dxwv3jmE7OC7vRAgyNR4/CRR+dzv05s/0Dx6X30qW3A2H2jslESZZ3oF1o7+JXXd06
         b7jpHaPFmeJurQGOv+pg9dtPt94e3ZvB4KsOp+MH7dVzACPbAhD4xBzJDufuJp80qwOd
         +maF4tO6l90ZZlSfMgATEjf7y9IxRvXVLPeMqD+vgU1jCkKbLLh2vmp4Zd4c7gYpnh/K
         srniIZyaZYurdhoW5InzDd0kL6bzQOP196brad07MRsunRQN3vsM57x+Kk5wg0qYg5jY
         PTKg==
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
Subject: [PATCH 4.4 193/193] crypto: s5p-sss - Fix kernel Oops in AES-ECB mode
Date: Fri, 23 Feb 2018 19:27:06 +0100
Message-Id: <20180223170356.654413380@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217639655479509?=
X-GMAIL-MSGID: =?utf-8?q?1593218256752603659?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/crypto/s5p-sss.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -401,16 +401,21 @@ static void s5p_aes_crypt_start(struct s
 	uint32_t                    aes_control;
 	int                         err;
 	unsigned long               flags;
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
-
+		iv = req->info;
+	} else {
+		iv = NULL; /* AES_ECB */
+	}
 	if (dev->ctx->keylen == AES_KEYSIZE_192)
 		aes_control |= SSS_AES_KEY_SIZE_192;
 	else if (dev->ctx->keylen == AES_KEYSIZE_256)
@@ -440,7 +445,7 @@ static void s5p_aes_crypt_start(struct s
 		goto outdata_error;
 
 	SSS_AES_WRITE(dev, AES_CONTROL, aes_control);
-	s5p_set_aes(dev, dev->ctx->aes_key, req->info, dev->ctx->keylen);
+	s5p_set_aes(dev, dev->ctx->aes_key, iv, dev->ctx->keylen);
 
 	s5p_set_dma_indata(dev,  req->src);
 	s5p_set_dma_outdata(dev, req->dst);
