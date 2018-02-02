Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226++FHeElLIRMBWul7t9+OiMfeiUmvlHd+hehfve4kcqEty6GUntjiFAY7an4avdi0kfUXz
ARC-Seal: i=1; a=rsa-sha256; t=1517591699; cv=none;
        d=google.com; s=arc-20160816;
        b=vcY/la1UZTJz99Kgp+QRaaIEXvzCoDqbsuvPqjFyA7FK9Y8yMn9+ZUkB/syCmI61au
         mmBBomB3MM9UuPJXnFG0B6Y3gO5rB/UAKY2rYp1pHeNTekI5QPf4UAKnIdZK4mCH/QHL
         NFC/KI3hqcT98qogpdJ86AD2RXl12Rr2pvPCu6AOggIcg2AzmG4zLiPMMeKBBaIZ0Tlg
         lPcJTjQ3AaI3bKhg6wrOpgoFo7IFvyCicefbfnDR2JjL71R4fXUYW3SfiLBmdHXGO1/8
         11fR49AmRhgY10jQgpcAzbthMyK6TgQgcQ3z4nPGvsevoyIk0yWIAE445sRH2UH8yld7
         bA8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=60Gl1wpjZBVzvL8DV1XYMrp9GLWn0ORpD9toGSfpu1E=;
        b=bqyAkQG7QNnK9zXaB8CwV3OFy5YXtIamRzE1PucW60Sk0MqftP18njTN0r6uxa+dVk
         TSkqze5YQ3Yw11ZNWwXvt/IlX/ySebHG8/xfgXWXoYsunG6lgRhtvWyIfAksVwWxcjnW
         bfNghIZjz/7w4lidpmWN7mnyFvJoerCK2KAWXh8Oe8X42BjJPEDFCZyABLs8WECd5k/v
         SzXS+9AREXbMvYdUt+NxiJiA8ivEnOIoURfyDuuFkOWVzXJ8eW9vfpcZ3xGE/hqYIAt1
         hTcDUJvc4Gw8UyXTlf0P5EmNesfT3Ia+zPypTz0DXoXDRPoo16RhytcZgjQzLTGSrG77
         stsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.15 14/55] crypto: sha3-generic - fixes for alignment and big endian operation
Date: Fri,  2 Feb 2018 17:58:32 +0100
Message-Id: <20180202140827.482272510@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309502067401156?=
X-GMAIL-MSGID: =?utf-8?q?1591310233734572366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit c013cee99d5a18aec8c71fee8f5f41369cd12595 upstream.

Ensure that the input is byte swabbed before injecting it into the
SHA3 transform. Use the get_unaligned() accessor for this so that
we don't perform unaligned access inadvertently on architectures
that do not support that.

Fixes: 53964b9ee63b7075 ("crypto: sha3 - Add SHA-3 hash algorithm")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/sha3_generic.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/crypto/sha3_generic.c
+++ b/crypto/sha3_generic.c
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <crypto/sha3.h>
 #include <asm/byteorder.h>
+#include <asm/unaligned.h>
 
 #define KECCAK_ROUNDS 24
 
@@ -149,7 +150,7 @@ static int sha3_update(struct shash_desc
 			unsigned int i;
 
 			for (i = 0; i < sctx->rsizw; i++)
-				sctx->st[i] ^= ((u64 *) src)[i];
+				sctx->st[i] ^= get_unaligned_le64(src + 8 * i);
 			keccakf(sctx->st);
 
 			done += sctx->rsiz;
@@ -174,7 +175,7 @@ static int sha3_final(struct shash_desc
 	sctx->buf[sctx->rsiz - 1] |= 0x80;
 
 	for (i = 0; i < sctx->rsizw; i++)
-		sctx->st[i] ^= ((u64 *) sctx->buf)[i];
+		sctx->st[i] ^= get_unaligned_le64(sctx->buf + 8 * i);
 
 	keccakf(sctx->st);
 
