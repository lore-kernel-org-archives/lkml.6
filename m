Return-Path: <kernel-hardening-return-12920-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48fKQ43x8onr2R/i23tvYby2GKlvQXu9UIX10GCZqEm6wv0WUzk5hu9uIJQYyVACcN7E4zZ
ARC-Seal: i=1; a=rsa-sha256; t=1523282110; cv=none;
        d=google.com; s=arc-20160816;
        b=bbkoerfrx/lEgsk1Q8aRId4SmWWdLYIN+LOLkVarYLr6xT7LFoiWfO++Ynbldefsin
         aD8CU4uWCNVBN/FzH01/CiwTPagxVrLsAMUaEORjpJAIrHNwOhxCn4KZkjRgR5qbUdD6
         O/Mu5tWVQidU0Vx2wWMlgAMQssfIC1wLRmUBjyVV9mlG8roo13PfX/AUsAEJ8oCZetR7
         +seIBMGFc45qYerZtT3LooD/8WQ2Teq+RUYTJfgibX+28irN+cas5epMnqM1otBEBNko
         QHu8EIhv86fbUpL+pcyW87KXzqfqVCs2H7omw4iDHGOyN7YCunipWlsN6T/OvzbeT7kn
         0f2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=YAlTGdnPdSsRn+04SbOD45FkZFw5nVfUTH5BnaTOpDI=;
        b=eu1hvskgtGiHQ6+spNJ+PrHJYNLPCsb5kITtoVnmkNbMyuI7Zpx+cVJMR9wNNlRAKv
         02B+mMBEwR4q5dc9ddM1LLvXE9M2B4ZIDrL0vvLWK2gi3RNsa0UrNR64G+b2uWFUayyp
         NUBAeLyyHUTxoNExbaFfUDf6m9A9QvZz1oOi+fvk7pqtuKDxwMRfuKj1VPfLvAoPAWnw
         fHBLa8REqoNu8dOIcMGOIH18NgkoO11dBd+RtSybueBuo0njfpAIBonlY/lpvhEFdNXa
         KQzzyFB48HSMzTYjnO4j0T1/U4IW6yAR5VdPL9g2ShJOY7uJusBq28HRNMSyZ/0uXMyZ
         TE8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r8Z+8gzY;
       spf=pass (google.com: domain of kernel-hardening-return-12920-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12920-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r8Z+8gzY;
       spf=pass (google.com: domain of kernel-hardening-return-12920-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12920-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com,
	linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Kees Cook <keescook@chromium.org>,
	Salvatore Mesoraca <s.mesoraca16@gmail.com>,
	Eric Biggers <ebiggers3@gmail.com>,
	Laura Abbott <labbott@redhat.com>
Subject: [PATCH 3/6] crypto: api - avoid VLA use
Date: Mon,  9 Apr 2018 15:54:01 +0200
Message-Id: <1523282044-22075-4-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523282044-22075-1-git-send-email-s.mesoraca16@gmail.com>
References: <1523282044-22075-1-git-send-email-s.mesoraca16@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597113773763364977?=
X-GMAIL-MSGID: =?utf-8?q?1597277062128487333?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We avoid a VLA[1] by always allocating MAX_BLOCKSIZE +
MAX_ALIGNMASK bytes.
We also check the selected cipher at initialization time, if
it doesn't comply with these limits, the initialization will
fail.

[1] http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 crypto/cipher.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/crypto/cipher.c b/crypto/cipher.c
index 94fa355..9cedf23 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -67,7 +67,7 @@ static void cipher_crypt_unaligned(void (*fn)(struct crypto_tfm *, u8 *,
 {
 	unsigned long alignmask = crypto_tfm_alg_alignmask(tfm);
 	unsigned int size = crypto_tfm_alg_blocksize(tfm);
-	u8 buffer[size + alignmask];
+	u8 buffer[MAX_BLOCKSIZE + MAX_ALIGNMASK];
 	u8 *tmp = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
 
 	memcpy(tmp, src, size);
@@ -105,9 +105,14 @@ static void cipher_decrypt_unaligned(struct crypto_tfm *tfm,
 
 int crypto_init_cipher_ops(struct crypto_tfm *tfm)
 {
+	const unsigned long alignmask = crypto_tfm_alg_alignmask(tfm);
+	const unsigned int size = crypto_tfm_alg_blocksize(tfm);
 	struct cipher_tfm *ops = &tfm->crt_cipher;
 	struct cipher_alg *cipher = &tfm->__crt_alg->cra_cipher;
 
+	if (size > MAX_BLOCKSIZE || alignmask > MAX_ALIGNMASK)
+		return -EINVAL;
+
 	ops->cit_setkey = setkey;
 	ops->cit_encrypt_one = crypto_tfm_alg_alignmask(tfm) ?
 		cipher_encrypt_unaligned : cipher->cia_encrypt;
-- 
1.9.1
