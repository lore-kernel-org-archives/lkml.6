Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtjcJRdpm8wHg6Anr86xHxDiPv0xZBDgNwsfuKHjq73O1eyBXTC1BGo5Qr5cVOsSUp0vnNY
ARC-Seal: i=1; a=rsa-sha256; t=1519412328; cv=none;
        d=google.com; s=arc-20160816;
        b=ORZOaN7gaWSWHO5fZ2A/bWbkQVWrQqSbmGPcbKWvqad3GLDxHVqN1ePEFTyf7TEEhg
         aqDf3drh9wbq0/izMaRAEmrGfd210YzO6Rk4hRLvRbsYZ5YuffBJ3P84CPRyNgTk59R5
         6+YFICp/C3PwdYolotVWMyb+RWlu3UYrcirtcrE78Ya0xJ1Iru6TSOfufFEadZkmttwq
         bHbiIg3in4DGN/zd9oF808y+5RATOfqvQcsk2043QNbGNOSTYrMASmJ3fwMaXzBIw78f
         8lhwqPp85cXzn5v3GLsiOyGW+JkEY5ZApsXqTODBgWkkG9ZiANgNhYu9mbJbrge5VntC
         DjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=m1lEcFy0EDSFQNF2Jy5DTnw8/DXP8g+c7gFvCakgqUM=;
        b=JQUNknHP7RZbJMi2wqsdmdcsTocSmR/YCNU90S7Qd5VwrlSDGmPbOAaDvLUaPC0cDW
         XpDe48egy6K+GTFV0JSHm+EcQJyJhOGZNJv4hclpYYBu6xFmI2D5ZCaSTXdwRtH555y6
         m2y2VJhCyBwgSeOGPVYG3/ucGA1lKul6kVKD177DaFtdfDkuhxSAFH8AMkZpFpCD9oSM
         0j+HSE6HGt/U0xIyhdfg3rJ/OE0KhXLABToGfgcoCskvDIB948LZv+LtEJtGMF/PRto8
         rcaMoRKfF86qLJTifbiHAWelaF3usN4TO8DmqMzgVAixUI6uAjBGg/K+YepwbPqJlSs5
         DaDg==
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
Subject: [PATCH 4.15 42/45] crypto: s5p-sss - Fix kernel Oops in AES-ECB mode
Date: Fri, 23 Feb 2018 19:29:21 +0100
Message-Id: <20180223170722.083625911@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217639655479509?=
X-GMAIL-MSGID: =?utf-8?q?1593219301862359560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1926,15 +1926,21 @@ static void s5p_aes_crypt_start(struct s
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
@@ -1965,7 +1971,7 @@ static void s5p_aes_crypt_start(struct s
 		goto outdata_error;
 
 	SSS_AES_WRITE(dev, AES_CONTROL, aes_control);
-	s5p_set_aes(dev, dev->ctx->aes_key, req->info, dev->ctx->keylen);
+	s5p_set_aes(dev, dev->ctx->aes_key, iv, dev->ctx->keylen);
 
 	s5p_set_dma_indata(dev,  dev->sg_src);
 	s5p_set_dma_outdata(dev, dev->sg_dst);
