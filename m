Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoL/i6gGs2Z1r/tWE0CzltVraA4jnMchhm8f8qEE+DegEcquyxAD2+PoFPUTVlZO/EV4n1/
ARC-Seal: i=1; a=rsa-sha256; t=1525767458; cv=none;
        d=google.com; s=arc-20160816;
        b=tPlUHdMeqXkclsu4SnFaa5g378vB6125HHI57MwEyQ2dOZB6DuxWA2IkbpqrRg5VAU
         0uAXoejUKy09Ca0y45aoqVaoMfKlbjph466XEHqvVRN2jvUirGRuLJcHUYyzl+xNBr2X
         vPdX8MQlAFreqOKoi98WSRohqMU9fRPM9ofpMM75M1a1kw8J0d4eG/ZiqJ5Zn6JEUhjv
         htROviFPQCjdOpxf2h5dQ5RJJI4vyF6IwEycg/utNFa/LgnpchWpI5131L2gQQQAWa28
         tugcnSeGNFZaf9yDHnMo4MTvXW2nhPeYsMM6SXftqeCwQZIB4oCQfZgG+Nk6Wwo+iYuX
         W4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=HBCTcENquX9FsWU6UsaS1xpdgzh4tqgnUYTZ2CVqPj4=;
        b=Yia56la+SF60ysf1GXU7t7noMvqT/cZezLImY1eD+jWP+krbIM6I0M9qhcYmdEIsk8
         Jlh9vLgXosgynV9jvvp8v7D1tt528nskqtpppY8ESqh7jz+HuxBZ/blj4Gtu0Dh64uHg
         /nQ1DeqYBEKNjZ2O1yjKTyOyE+xC0tqyz2DBpqi88uR6pmIw58Wto7B7/JNx1YGCviAi
         T8gLTFPTZjymOPrmdCXVdWRNpPem3mlCPEWEvkyAKLMCIgPuAcVuhgURj6nXOsUmf1EY
         AcJUo8RjhRHmfnkElq6RdC4AACCs8oxTwAt+NOrFNaWng8gY2cYGZg6EtQppXQSB9vEz
         VE6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xeeO8HQT;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xeeO8HQT;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 05/32] crypto: talitos - fix IPsec cipher in length
Date: Tue,  8 May 2018 10:10:45 +0200
Message-Id: <20180508074009.623023630@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882936743616773?=
X-GMAIL-MSGID: =?utf-8?q?1599883138873185583?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: LEROY Christophe <christophe.leroy@c-s.fr>

commit 2b1227301a8e4729409694e323b72c064c47cb6b upstream.

For SEC 2.x+, cipher in length must contain only the ciphertext length.
In case of using hardware ICV checking, the ICV length is provided via
the "extent" field of the descriptor pointer.

Cc: <stable@vger.kernel.org> # 4.8+
Fixes: 549bd8bc5987 ("crypto: talitos - Implement AEAD for SEC1 using HMAC_SNOOP_NO_AFEU")
Reported-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Tested-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[backported to 4.9.y, 4.14.y]
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/talitos.c |   41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1116,10 +1116,10 @@ next:
 	return count;
 }
 
-int talitos_sg_map(struct device *dev, struct scatterlist *src,
-		   unsigned int len, struct talitos_edesc *edesc,
-		   struct talitos_ptr *ptr,
-		   int sg_count, unsigned int offset, int tbl_off)
+static int talitos_sg_map_ext(struct device *dev, struct scatterlist *src,
+			      unsigned int len, struct talitos_edesc *edesc,
+			      struct talitos_ptr *ptr, int sg_count,
+			      unsigned int offset, int tbl_off, int elen)
 {
 	struct talitos_private *priv = dev_get_drvdata(dev);
 	bool is_sec1 = has_ftr_sec1(priv);
@@ -1130,7 +1130,7 @@ int talitos_sg_map(struct device *dev, s
 	}
 
 	to_talitos_ptr_len(ptr, len, is_sec1);
-	to_talitos_ptr_ext_set(ptr, 0, is_sec1);
+	to_talitos_ptr_ext_set(ptr, elen, is_sec1);
 
 	if (sg_count == 1) {
 		to_talitos_ptr(ptr, sg_dma_address(src) + offset, is_sec1);
@@ -1140,7 +1140,7 @@ int talitos_sg_map(struct device *dev, s
 		to_talitos_ptr(ptr, edesc->dma_link_tbl + offset, is_sec1);
 		return sg_count;
 	}
-	sg_count = sg_to_link_tbl_offset(src, sg_count, offset, len,
+	sg_count = sg_to_link_tbl_offset(src, sg_count, offset, len + elen,
 					 &edesc->link_tbl[tbl_off]);
 	if (sg_count == 1) {
 		/* Only one segment now, so no link tbl needed*/
@@ -1154,6 +1154,15 @@ int talitos_sg_map(struct device *dev, s
 	return sg_count;
 }
 
+static int talitos_sg_map(struct device *dev, struct scatterlist *src,
+			  unsigned int len, struct talitos_edesc *edesc,
+			  struct talitos_ptr *ptr, int sg_count,
+			  unsigned int offset, int tbl_off)
+{
+	return talitos_sg_map_ext(dev, src, len, edesc, ptr, sg_count, offset,
+				  tbl_off, 0);
+}
+
 /*
  * fill in and submit ipsec_esp descriptor
  */
@@ -1171,7 +1180,7 @@ static int ipsec_esp(struct talitos_edes
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	int tbl_off = 0;
 	int sg_count, ret;
-	int sg_link_tbl_len;
+	int elen = 0;
 	bool sync_needed = false;
 	struct talitos_private *priv = dev_get_drvdata(dev);
 	bool is_sec1 = has_ftr_sec1(priv);
@@ -1225,20 +1234,12 @@ static int ipsec_esp(struct talitos_edes
 	 * extent is bytes of HMAC postpended to ciphertext,
 	 * typically 12 for ipsec
 	 */
-	to_talitos_ptr_len(&desc->ptr[4], cryptlen, is_sec1);
-	to_talitos_ptr_ext_set(&desc->ptr[4], 0, is_sec1);
-
-	sg_link_tbl_len = cryptlen;
-
-	if (desc->hdr & DESC_HDR_TYPE_IPSEC_ESP) {
-		to_talitos_ptr_ext_set(&desc->ptr[4], authsize, is_sec1);
-
-		if (edesc->desc.hdr & DESC_HDR_MODE1_MDEU_CICV)
-			sg_link_tbl_len += authsize;
-	}
+	if ((desc->hdr & DESC_HDR_TYPE_IPSEC_ESP) &&
+	    (desc->hdr & DESC_HDR_MODE1_MDEU_CICV))
+		elen = authsize;
 
-	ret = talitos_sg_map(dev, areq->src, sg_link_tbl_len, edesc,
-			     &desc->ptr[4], sg_count, areq->assoclen, tbl_off);
+	ret = talitos_sg_map_ext(dev, areq->src, cryptlen, edesc, &desc->ptr[4],
+				 sg_count, areq->assoclen, tbl_off, elen);
 
 	if (ret > 1) {
 		tbl_off += ret;
