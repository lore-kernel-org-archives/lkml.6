Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/3Qenu60qwiHEP2nHf/mc5U2HGhkegrmE1CeTqtKi75X5BdfdnTXhAyx3Deoh+iZwmLE5t
ARC-Seal: i=1; a=rsa-sha256; t=1523473499; cv=none;
        d=google.com; s=arc-20160816;
        b=kpEuB0eKy3Ti5hJl/WFQ5NfpFosudGlDPSKOyNXgUHqtKyVe04ybdStTBvF5EpbotV
         U2wpf9nm/WkAvOAazzxRxZlC151aMmxgTG+kC/JNPSaldLyI3ssB45weQ6gyTt1BJ2ae
         dLhunuhyWyf9v1xiMsuXTU7OugGdFNu6cExjUJcDYSepOuSOmSEO9xB86DTGyTVTuZ9i
         iv6z7PUb6q8R10AtFbIRmny1cBdI3ZvajJeRZvcuerLYMpSFzDEmKdXLSogv3yuLkGjy
         xNCpsrhfpYJRqwr3WmPh9FjCo/3h3s5xQCdVVrlVBe0gwIs9ZtN2hacb6xNEZ3GPS7J6
         RYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9uftiEnVvlsFDNyink1SPerCJywOoNo10r8qVo+xHwE=;
        b=YoSNtlv+gzFBi/FxqgL1hRCkbARIWbWYDT1hU1dhOb5YaGGoRKehVKbyDWm5phX5z5
         64lBm8+QQ1tjtAu4BpWcRDNvjm604H/6gFBq2Cm8ExEQGhvefkcjhN2WRW8MSsLQLp3N
         YV/vtQz5+ws/it/HkTch6fcujJn7VwTcH9xFZPfKi8DKNkS6X3cckOzgSimaQb1OSFGP
         6DTVzES1giYUEpmA8Z/x88Nv0XRnBGinywK2F6Sy4dWoc2qhMeEWfsfrDAoB770cDwfb
         R5AQAWLdud0wj+M6PStTK3ihr/qVm1WiAHd2FaSRiR6pjjrVKZwqJddKR/R/C+s0bJWA
         +Gjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 270/310] ipsec: check return value of skb_to_sgvec always
Date: Wed, 11 Apr 2018 20:36:49 +0200
Message-Id: <20180411183634.254806700@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476309416013335?=
X-GMAIL-MSGID: =?utf-8?q?1597477747957599025?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit 3f29770723fe498a5c5f57c3a31a996ebdde03e1 upstream.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
[natechancellor: Adjusted context due to lack of fca11ebde3f0]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/ah4.c  |    8 ++++++--
 net/ipv4/esp4.c |   13 ++++++++-----
 net/ipv6/ah6.c  |    8 ++++++--
 net/ipv6/esp6.c |   12 ++++++++----
 4 files changed, 28 insertions(+), 13 deletions(-)

--- a/net/ipv4/ah4.c
+++ b/net/ipv4/ah4.c
@@ -220,7 +220,9 @@ static int ah_output(struct xfrm_state *
 	ah->seq_no = htonl(XFRM_SKB_CB(skb)->seq.output.low);
 
 	sg_init_table(sg, nfrags + sglists);
-	skb_to_sgvec_nomark(skb, sg, 0, skb->len);
+	err = skb_to_sgvec_nomark(skb, sg, 0, skb->len);
+	if (unlikely(err < 0))
+		goto out_free;
 
 	if (x->props.flags & XFRM_STATE_ESN) {
 		/* Attach seqhi sg right after packet payload */
@@ -393,7 +395,9 @@ static int ah_input(struct xfrm_state *x
 	skb_push(skb, ihl);
 
 	sg_init_table(sg, nfrags + sglists);
-	skb_to_sgvec_nomark(skb, sg, 0, skb->len);
+	err = skb_to_sgvec_nomark(skb, sg, 0, skb->len);
+	if (unlikely(err < 0))
+		goto out_free;
 
 	if (x->props.flags & XFRM_STATE_ESN) {
 		/* Attach seqhi sg right after packet payload */
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -268,10 +268,11 @@ static int esp_output(struct xfrm_state
 	esph->spi = x->id.spi;
 
 	sg_init_table(sg, nfrags);
-	skb_to_sgvec(skb, sg,
-		     (unsigned char *)esph - skb->data,
-		     assoclen + ivlen + clen + alen);
-
+	err = skb_to_sgvec(skb, sg,
+		           (unsigned char *)esph - skb->data,
+		           assoclen + ivlen + clen + alen);
+	if (unlikely(err < 0))
+		goto error;
 	aead_request_set_crypt(req, sg, sg, ivlen + clen, iv);
 	aead_request_set_ad(req, assoclen);
 
@@ -481,7 +482,9 @@ static int esp_input(struct xfrm_state *
 	}
 
 	sg_init_table(sg, nfrags);
-	skb_to_sgvec(skb, sg, 0, skb->len);
+	err = skb_to_sgvec(skb, sg, 0, skb->len);
+	if (unlikely(err < 0))
+		goto out;
 
 	aead_request_set_crypt(req, sg, sg, elen + ivlen, iv);
 	aead_request_set_ad(req, assoclen);
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -423,7 +423,9 @@ static int ah6_output(struct xfrm_state
 	ah->seq_no = htonl(XFRM_SKB_CB(skb)->seq.output.low);
 
 	sg_init_table(sg, nfrags + sglists);
-	skb_to_sgvec_nomark(skb, sg, 0, skb->len);
+	err = skb_to_sgvec_nomark(skb, sg, 0, skb->len);
+	if (unlikely(err < 0))
+		goto out_free;
 
 	if (x->props.flags & XFRM_STATE_ESN) {
 		/* Attach seqhi sg right after packet payload */
@@ -603,7 +605,9 @@ static int ah6_input(struct xfrm_state *
 	ip6h->hop_limit   = 0;
 
 	sg_init_table(sg, nfrags + sglists);
-	skb_to_sgvec_nomark(skb, sg, 0, skb->len);
+	err = skb_to_sgvec_nomark(skb, sg, 0, skb->len);
+	if (unlikely(err < 0))
+		goto out_free;
 
 	if (x->props.flags & XFRM_STATE_ESN) {
 		/* Attach seqhi sg right after packet payload */
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -248,9 +248,11 @@ static int esp6_output(struct xfrm_state
 	esph->spi = x->id.spi;
 
 	sg_init_table(sg, nfrags);
-	skb_to_sgvec(skb, sg,
-		     (unsigned char *)esph - skb->data,
-		     assoclen + ivlen + clen + alen);
+	err = skb_to_sgvec(skb, sg,
+		           (unsigned char *)esph - skb->data,
+		           assoclen + ivlen + clen + alen);
+	if (unlikely(err < 0))
+		goto error;
 
 	aead_request_set_crypt(req, sg, sg, ivlen + clen, iv);
 	aead_request_set_ad(req, assoclen);
@@ -423,7 +425,9 @@ static int esp6_input(struct xfrm_state
 	}
 
 	sg_init_table(sg, nfrags);
-	skb_to_sgvec(skb, sg, 0, skb->len);
+	ret = skb_to_sgvec(skb, sg, 0, skb->len);
+	if (unlikely(ret < 0))
+		goto out;
 
 	aead_request_set_crypt(req, sg, sg, elen + ivlen, iv);
 	aead_request_set_ad(req, assoclen);
