Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48MswoanpMvnNAAgz8krcMxx7r7R1haBhHE+IQ2kF4wWWjR6gbpQGA2ObNDn8ozniHw834O
ARC-Seal: i=1; a=rsa-sha256; t=1523472127; cv=none;
        d=google.com; s=arc-20160816;
        b=ZgYpjHubrkdjDIWuHAZP9PDxI33PP36DfNPCMbcTNcbZturF6dCCJoCqlf8eDaraQ9
         zn1l/+fZDmFD767g5y06wGD61RKBz7CLPxHQ6CTc1EAfX4EuXOLDOvgAnfU0Y7nIiHak
         FiQf3txLcWfvW/EIMLuRXSBRKxNL8/DoQhn/aEx6odm5bIFWpN2O2ZHOgXzbbuNjSMJI
         Ocn6g0nQu9OAFFqKtWwMNjOI8DFFGFSvW6y+S5EImS1NYrFzAAxhjDjHBoAvtuH6nisQ
         yYLC99RNpADtSvDtGETIhmr+44Y3kiUgGmH+KKIbUX3ERO6sTInoHp4EU2HcmMHaaHKv
         5Mjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qbgp4pLzaK1f4QUL+SyEDRqU8Dp+103nDPACuVBSHFw=;
        b=NXnNsCIR0S0EQw2bE6UM6On1QKQIt8vHnQq8jXt3AX0VjkeRTT/QxHWxaM9J7+Tcl8
         BNKRmZDcwOXGhOEdz1bvRk03Vf8jorMQstqASKn1Xsf0o8HOcsIrtonerpcJkR4zEhDr
         s/T74aOhec60c2qv5S2qZzZb0yKzm/PZuMwLdKFb2hTQ0wYuQk2fBAKZoVCbqcrakPLK
         eKqJCbGBJWIYIXm/HeTgsrRQR8X6AQE1PUIYjoIVcVCgSv7kp3OqcsvQbR3jxbNwFde0
         WcrRJsq0VlvGIXEjaaV6TX5iTx0VlKe/bgwQCx003g/Jrhbq+Lw0WxnlZOfRaI2rtUQE
         3EJw==
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
Subject: [PATCH 3.18 097/121] ipsec: check return value of skb_to_sgvec always
Date: Wed, 11 Apr 2018 20:36:40 +0200
Message-Id: <20180411183502.560556607@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476309416013335?=
X-GMAIL-MSGID: =?utf-8?q?1597476309416013335?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit 3f29770723fe498a5c5f57c3a31a996ebdde03e1 upstream.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
[nc: Adjust context due to lack of 000ae7b2690e2 and fca11ebde3f0]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ah4.c  |    8 ++++++--
 net/ipv4/esp4.c |   12 ++++++++----
 net/ipv6/ah6.c  |    8 ++++++--
 net/ipv6/esp6.c |   12 ++++++++----
 4 files changed, 28 insertions(+), 12 deletions(-)

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
@@ -391,7 +393,9 @@ static int ah_input(struct xfrm_state *x
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
@@ -239,9 +239,11 @@ static int esp_output(struct xfrm_state
 	esph->seq_no = htonl(XFRM_SKB_CB(skb)->seq.output.low);
 
 	sg_init_table(sg, nfrags);
-	skb_to_sgvec(skb, sg,
-		     esph->enc_data + crypto_aead_ivsize(aead) - skb->data,
-		     clen + alen);
+	err = skb_to_sgvec(skb, sg,
+			   esph->enc_data + crypto_aead_ivsize(aead) - skb->data,
+			   clen + alen);
+	if (unlikely(err < 0))
+		goto error;
 
 	if ((x->props.flags & XFRM_STATE_ESN)) {
 		sg_init_table(asg, 3);
@@ -426,7 +428,9 @@ static int esp_input(struct xfrm_state *
 	iv = esph->enc_data;
 
 	sg_init_table(sg, nfrags);
-	skb_to_sgvec(skb, sg, sizeof(*esph) + crypto_aead_ivsize(aead), elen);
+	err = skb_to_sgvec(skb, sg, sizeof(*esph) + crypto_aead_ivsize(aead), elen);
+	if (unlikely(err < 0))
+		goto out;
 
 	if ((x->props.flags & XFRM_STATE_ESN)) {
 		sg_init_table(asg, 3);
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
@@ -601,7 +603,9 @@ static int ah6_input(struct xfrm_state *
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
@@ -231,9 +231,11 @@ static int esp6_output(struct xfrm_state
 	esph->seq_no = htonl(XFRM_SKB_CB(skb)->seq.output.low);
 
 	sg_init_table(sg, nfrags);
-	skb_to_sgvec(skb, sg,
-		     esph->enc_data + crypto_aead_ivsize(aead) - skb->data,
-		     clen + alen);
+	err = skb_to_sgvec(skb, sg,
+			   esph->enc_data + crypto_aead_ivsize(aead) - skb->data,
+			   clen + alen);
+	if (unlikely(err < 0))
+		goto error;
 
 	if ((x->props.flags & XFRM_STATE_ESN)) {
 		sg_init_table(asg, 3);
@@ -381,7 +383,9 @@ static int esp6_input(struct xfrm_state
 	iv = esph->enc_data;
 
 	sg_init_table(sg, nfrags);
-	skb_to_sgvec(skb, sg, sizeof(*esph) + crypto_aead_ivsize(aead), elen);
+	ret = skb_to_sgvec(skb, sg, sizeof(*esph) + crypto_aead_ivsize(aead), elen);
+	if (unlikely(ret < 0))
+		goto out;
 
 	if ((x->props.flags & XFRM_STATE_ESN)) {
 		sg_init_table(asg, 3);
