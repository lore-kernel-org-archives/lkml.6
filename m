Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+jIRiopE00ytqCbNnCyCEInGCZXwVRMkJ9XCoGJMZF/Ztz6wLJZPUaGlwbIOti76Gnnbnz
ARC-Seal: i=1; a=rsa-sha256; t=1523022233; cv=none;
        d=google.com; s=arc-20160816;
        b=anqTB3TGMverz9QSqiU3iHzBr1Sz+8WeUjOztGCUYfjOZcSp0ZIvDOHjjjTsU0kbRB
         w5G6ff9elZTF0e9TawFHUPLIAXSaUSJ2FqQ93OO9JLqrqoCruqTv3weNArhkBd8wmek4
         eF152p9NATgsSzStyV7LXajvYSn8nir+L5AMKuSRAuFsPQnWDlE2xlrVGkSnZo/SxMv9
         /fCcRWXtVv8aIH7QgH2M4fyHkMyj4csqwfdwk7+YcSp/7NSzpWHYp1UkagyrFycxsmkX
         f4k4fT9BITeOvzjumuy46qGLE34yODiMr6+2Pw79LR10EmeOi3/Hf2KV1aRDHL5LtrGH
         PZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cmPh83y+0/oggWvh9V5lBQjj5UgF7dpZJbSYFvp66J0=;
        b=lF+ts5Qz5j7f0oyS0uZStmGD5qrMTqBIpCwGKniPbzeCDgYio2ABnugX7Xh9syWqlx
         Yb/x9NlqUvhiyT1OYLx8PpbJfiqyC5E4S1RLM1aApSqlKKzUN6Cvazdrd620yR4AfR82
         bJ6tPetpgDTHl1PAuo3gGDFucEdXrwI2vjFDUP2epOFM2rcuPpbvpgEbPnOMaqVlYlAE
         EDx259qCKINWVeZq5I7aybSoJR4MhTEqyU+yYhWqTWNRfUzxcnH35glIZVwj03SqmmoR
         Wj2JNhpiTvao3NIuLQ6nSeCqNRnx9436qSbpR0QOq+OMPwdxo+5Y1F1/c+PkjPtWzkk4
         RcyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.15 53/72] crypto: talitos - fix IPsec cipher in length
Date: Fri,  6 Apr 2018 15:24:28 +0200
Message-Id: <20180406084353.114510304@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004561260195768?=
X-GMAIL-MSGID: =?utf-8?q?1597004561260195768?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/talitos.c |   36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1128,10 +1128,10 @@ next:
 	return count;
 }
 
-static int talitos_sg_map(struct device *dev, struct scatterlist *src,
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
@@ -1140,6 +1140,7 @@ static int talitos_sg_map(struct device
 		to_talitos_ptr(ptr, 0, 0, is_sec1);
 		return 1;
 	}
+	to_talitos_ptr_ext_set(ptr, elen, is_sec1);
 	if (sg_count == 1) {
 		to_talitos_ptr(ptr, sg_dma_address(src) + offset, len, is_sec1);
 		return sg_count;
@@ -1148,7 +1149,7 @@ static int talitos_sg_map(struct device
 		to_talitos_ptr(ptr, edesc->dma_link_tbl + offset, len, is_sec1);
 		return sg_count;
 	}
-	sg_count = sg_to_link_tbl_offset(src, sg_count, offset, len,
+	sg_count = sg_to_link_tbl_offset(src, sg_count, offset, len + elen,
 					 &edesc->link_tbl[tbl_off]);
 	if (sg_count == 1) {
 		/* Only one segment now, so no link tbl needed*/
@@ -1162,6 +1163,15 @@ static int talitos_sg_map(struct device
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
@@ -1179,7 +1189,7 @@ static int ipsec_esp(struct talitos_edes
 	unsigned int ivsize = crypto_aead_ivsize(aead);
 	int tbl_off = 0;
 	int sg_count, ret;
-	int sg_link_tbl_len;
+	int elen = 0;
 	bool sync_needed = false;
 	struct talitos_private *priv = dev_get_drvdata(dev);
 	bool is_sec1 = has_ftr_sec1(priv);
@@ -1221,17 +1231,11 @@ static int ipsec_esp(struct talitos_edes
 	 * extent is bytes of HMAC postpended to ciphertext,
 	 * typically 12 for ipsec
 	 */
-	sg_link_tbl_len = cryptlen;
-
-	if (is_ipsec_esp) {
-		to_talitos_ptr_ext_set(&desc->ptr[4], authsize, is_sec1);
-
-		if (desc->hdr & DESC_HDR_MODE1_MDEU_CICV)
-			sg_link_tbl_len += authsize;
-	}
+	if (is_ipsec_esp && (desc->hdr & DESC_HDR_MODE1_MDEU_CICV))
+		elen = authsize;
 
-	ret = talitos_sg_map(dev, areq->src, sg_link_tbl_len, edesc,
-			     &desc->ptr[4], sg_count, areq->assoclen, tbl_off);
+	ret = talitos_sg_map_ext(dev, areq->src, cryptlen, edesc, &desc->ptr[4],
+				 sg_count, areq->assoclen, tbl_off, elen);
 
 	if (ret > 1) {
 		tbl_off += ret;
