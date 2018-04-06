Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+0VjNEDCEkSHVgKq0kTEy73A/Ryg+GOVSga+mmNBH/2Vp4V8psG/oDaQ3i+iQ5NwU/fu3E
ARC-Seal: i=1; a=rsa-sha256; t=1523022271; cv=none;
        d=google.com; s=arc-20160816;
        b=Hxb0uosAX4okFRcMLpL7hR/RYx4jEiHXKqGU/NrFi03fqLx+SVf/5vBaXU6Iqsisid
         5mDKTMTRgfc2+lhmfAywBZiN7zpMyeSta7talpUG8Lj9Ro0UF2hY5Cvyq87FGqXvM03e
         hCmt8jzmsvx+iSCg0u0xsPlm5xiy7B8Lw4oK/xEHcVgSBPCPKwaIG4KumYmEVGewclp1
         efwgBUVuhIVl/R1UDsYK2iqOkatz7LQgHMgPLB2FZp+uMLLAmN9ip7zVjXHe+9AkLFDG
         ZkZ9IKpPX3ZNqwEzT/Smv013c5Fv5D1ssZGNjaRrWrfoYO/NLOr7wcBgk+2ZIT8DLKto
         M1Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2GoaFmn7OqzB4vtBf1qu5B7sFm+KVIKeOlU0You7I04=;
        b=RZ/EeF2rSpva99HrSmdEKIrwqoWiRVkYfuDXRgxooOSCeP5MGtlm5OzAEabxoQnveE
         01GNAxXLef6WszC0KG5v+tw7cjXFLO1LHPYffso0iM4ySKKQ+UHhkVmtFTaVt1UwAuOA
         Qy1KaRJ+vk1Udokinyjj32+QEOnctk8iwLYNXMvGTK8QZxur7ZqBOYFBwTAfogmyyfKj
         qPeaVCw4ihIRrYK6vFWjG8d6au3MaLb/hqVqUqkIpEph+yVr1cSZ/B5VgRgKy2AgZlPE
         ta7wS1GIVr8TJeJF49hfEVIf2rzrpS8VgZLqL1wEfMaHvcojzkGOyoNWsO0B2A7czdr/
         UZvA==
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
Subject: [PATCH 4.16 15/31] crypto: talitos - fix IPsec cipher in length
Date: Fri,  6 Apr 2018 15:24:40 +0200
Message-Id: <20180406084343.084818814@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004561260195768?=
X-GMAIL-MSGID: =?utf-8?q?1597004600859759174?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
