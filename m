Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq766HzLSZbQCcDVkpg3DHpwKd2Hj3ECOdPbe2NANA34wz8i72qywMUFk8WFIwPmg0C4IMc
ARC-Seal: i=1; a=rsa-sha256; t=1527156305; cv=none;
        d=google.com; s=arc-20160816;
        b=v4k26X6DZ+l68jC1zAxifUsoW0B2UJlfsIu7T2QBkRbf/sJ3/FJbcwsgxEbqYXxT4Q
         1/ojHLr1F1bo4/fVMuseitrr+TjVggFt3HnJ+dWe23H8mj5Olh1eplAgiHidsZW9qvUf
         6lChsz/yek6ByeoJVAdrX8n8JhhgFXoqw9Us409QwGSYfW9jhyBVIjz8RUDZxPrcodKH
         SlpA+FoVrY99r8x/3ZkJQYz4ElyUKr+h7kx1+F599xiQdNYkiS/rTB55TsH1TY9CWpcD
         CpsR6N/yRWvQTQJRuQtuDoDiS1uyHOXhw0/NfepC2LgJQGf2TBzX+S7AeiI1YEri6xRd
         j+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=3wCOoH004G5NyScQ0gl5zL2AxEganViJbjK6e4avCmc=;
        b=zSXpF7zdngmFh9HI4+ay4qwA5yBSnZzhKwNx6tlgo8dPphnLeMYS0C0xUocVmZCk5H
         OkspwCXAW6AOYOUuJhP55lv/zqmGczo1OA+TzMfYAGLUK0i/gR2KajQ8a0czDxc7CreR
         3juW3WiOq4pFKPlOVlgkf8bDwUPYmCtgBznSUQxtZbyFUAYt0RO/FifwUVhxfDynCkXR
         n0knoJHFaxgOrv5iExBdUyocW5qg+QnumF4GcIMKSwVP14LToYTTzsuestVyWj2x9+Ad
         oyCY/1Cn420nnPDAyUm7TMvjA/GtTRCyZwvXE/5bBNkAgpgCZIRIeMEe8r0QMSmZRK0b
         tCAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=e/03UVrI;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=e/03UVrI;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Antoine Tenart <antoine.tenart@bootlin.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 103/161] crypto: inside-secure - fix the extra cache computation
Date: Thu, 24 May 2018 11:38:48 +0200
Message-Id: <20180524093030.746688522@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338846366854167?=
X-GMAIL-MSGID: =?utf-8?q?1601339450353293419?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit c1a8fa6e240ed4b99778d48ab790743565cb61c8 ]

This patch fixes the extra cache computation when the queued data is a
multiple of a block size. This fixes the hash support in some cases.

Fixes: 809778e02cd4 ("crypto: inside-secure - fix hash when length is a multiple of a block")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/inside-secure/safexcel_hash.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -201,7 +201,7 @@ static int safexcel_ahash_send_req(struc
 			/* If this is not the last request and the queued data
 			 * is a multiple of a block, cache the last one for now.
 			 */
-			extra = queued - crypto_ahash_blocksize(ahash);
+			extra = crypto_ahash_blocksize(ahash);
 
 		if (extra) {
 			sg_pcopy_to_buffer(areq->src, sg_nents(areq->src),
