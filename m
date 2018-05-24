Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoBQU8tPxt6dq3MVMN9+o374KilyjmEV/4zRy7mxnRpEBgqac7mH9fqiQ/UDMZyiipzhoIY
ARC-Seal: i=1; a=rsa-sha256; t=1527156273; cv=none;
        d=google.com; s=arc-20160816;
        b=cvWy5rT2+3fW3IGcl0T7NI7yEOMan5okvZ3BI5NLNHouNPhYqt7apBdlxjN/GCqyk4
         V3xMfIXr4yBmfmvGeOU29qFNuF7mtb7bmIfxLm+ud6Ki5xZcZvPkSpeQByCG7sYX+H4M
         q8NKWVYV70QE8M6oG6JFHQYfliscoeGyjlmePWMK/x3pTYTb5B5GuHGK/bxrflUE/Tqm
         F7DUegMqWACNhCyNAeWI1MKQhn0czRpwymrqmYsK/vYFy5FPV3qnBLQ+4xn/y+1R0+WP
         QKz4L++LBZELjqhhYrx0pUFQ6BozJQcbxteT+0LcoKLwGng8P6fvMmbwJ71syrsBMo72
         AffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=YIsrHeVesD4IiVB3eN3qdcy0prlpWuv7m0u3lEIwdIg=;
        b=BTPHtdoAzM/RqWXH9REmqXs/jgH8KDSjPMdC66d0hctDbmvlwv+Xmdeffg0BBKqae0
         uDQm4LEh1kRKX91ba4VZOlCBTTMBJ+sCMqeZgW/3kciF/SgfEcHC6QSNbk8SFFHJcBcc
         7GBlclLOVWn3RYHPEdT3LQ7NEz+B1cl6g8jn/I7p/tvJY4460cHECcpt9Hc4TbBYiHNg
         WNhlpF7mI0E6xI98MJ0jyNrEI6RGgL3xHPJ7CpbZieikeJsyEjuxbzXKHlETE8KuImGk
         AibtjaKAXTti2FzFKyt9vhkCLjyEc+S+g/I6sj1E5XBuNu40aHla1gmMzpnytIUu7JYo
         cfQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=uRnIBlnQ;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=uRnIBlnQ;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Antoine Tenart <antoine.tenart@bootlin.com>,
	Tudor Ambarus <tudor.ambarus@microchip.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 099/161] crypto: atmel-aes - fix the keys zeroing on errors
Date: Thu, 24 May 2018 11:38:44 +0200
Message-Id: <20180524093030.271884133@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338835304621094?=
X-GMAIL-MSGID: =?utf-8?q?1601339415959310788?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 5d804a5157dbaa64872a675923ae87161165c66b ]

The Atmel AES driver uses memzero_explicit on the keys on error, but the
variable zeroed isn't the right one because of a typo. Fix this by using
the right variable.

Fixes: 89a82ef87e01 ("crypto: atmel-authenc - add support to authenc(hmac(shaX), Y(aes)) modes")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/atmel-aes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -2155,7 +2155,7 @@ static int atmel_aes_authenc_setkey(stru
 
 badkey:
 	crypto_aead_set_flags(tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
-	memzero_explicit(&key, sizeof(keys));
+	memzero_explicit(&keys, sizeof(keys));
 	return -EINVAL;
 }
 
