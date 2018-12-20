Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2558CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E49218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cB6yWGl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389149AbeLTS33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:29:29 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37299 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389111AbeLTS3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:29:25 -0500
Received: by mail-lf1-f68.google.com with SMTP id y11so2105644lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 10:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A5oSEUX5NghaDjuKlQPFL03PIZwpGHlDsIssOQKwoKw=;
        b=cB6yWGl+9A2svMSCpy6fDEoVmhR557ria7RvDQLuskrCWzSTDUtzdhRNkzPb/gkHZy
         zUMhy12TCmTQTNT73Zc1wypZH31T0FVgR3CNjI6nOZgRb2E4M1b2IHY7DKSgceMWcB4p
         ouqGmSmbpHM+HEN6FkGYZgX/P5T1rXzN6LqFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A5oSEUX5NghaDjuKlQPFL03PIZwpGHlDsIssOQKwoKw=;
        b=swLnlLPt7qSR1ErleYLWfL6ICcEl+cMn9/LnSo4I/OFWzl0Uo0gfxh94nxSxQ94oyF
         LetoBKEXrUNTYFfklKQDB+akmP4PkjKZJwSbGmyZsPG1JthjXHla+qOzUAlT9j8rMu5z
         XZAAwIUCJSNlVXEOoOKBftEmgWppA3XUrLdA5ZHC1LGZaKzlRO6MtsblwNXuWYcgqduA
         VrzZFU5B+2CBzahRIpxTrh3h7DU/fc8W2i5wv5RlUfEY9YLvchcky/bNjLJozWeVG10h
         Db7snL9GXXHJcMoaxCzxDxJfe7bCJYTUZ6R5FBzauuKxi5ztqY0PZNymXhES3uND36BE
         H+Tw==
X-Gm-Message-State: AA+aEWblbVcrCD1F7uYWWcd5CY9+x3tYqkCUkpMhGv97k61HY6OhDzDk
        1e/87/pF9JA/UzKso5UMHVhzirA++1Lc3w==
X-Google-Smtp-Source: AFSGD/WW2BN5PJDOsGHW8e/LAO5/TOnO1px1VhCKTIRpnD/MN3aZFvRx6wofoczHqVxaYgSnxkd+hQ==
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr15134088lfa.106.1545330561983;
        Thu, 20 Dec 2018 10:29:21 -0800 (PST)
Received: from localhost ([195.238.92.132])
        by smtp.gmail.com with ESMTPSA id y1-v6sm4179166ljh.39.2018.12.20.10.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 10:29:21 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guillaume Nault <g.nault@alphalink.fr>
Subject: [PATCH v2] ppp: Move PFC decompression to PPP generic layer
Date:   Thu, 20 Dec 2018 20:29:20 +0200
Message-Id: <20181220182920.4208-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract "Protocol" field decompression code from transport protocols to
PPP generic layer, where it actually belongs. As a consequence, this
patch fixes incorrect place of PFC decompression in L2TP driver (when
it's not PPPOX_BOUND) and also enables this decompression for other
protocols, like PPPoE.

Protocol field decompression also happens in PPP Multilink Protocol
code and in PPP compression protocols implementations (bsd, deflate,
mppe). It looks like there is no easy way to get rid of that, so it was
decided to leave it as is, but provide those cases with appropriate
comments instead.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Fix the order of checking skb data room and proto decompression
  - Remove "inline" keyword from ppp_decompress_proto()
  - Don't split line before function name
  - Prefix ppp_decompress_proto() function with "__"
  - Add ppp_decompress_proto() function with skb data room checks
  - Add description for introduced functions
  - Fix comments (as per review on mailing list)

 drivers/net/ppp/ppp_async.c   | 14 ++++-----
 drivers/net/ppp/ppp_generic.c | 54 +++++++++++++++++++++++++++++++++--
 drivers/net/ppp/ppp_synctty.c |  9 +++---
 drivers/net/ppp/pptp.c        |  5 ----
 net/l2tp/l2tp_ppp.c           |  4 ---
 5 files changed, 62 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index 288cf099876b..b287bb811875 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -770,7 +770,7 @@ process_input_packet(struct asyncppp *ap)
 {
 	struct sk_buff *skb;
 	unsigned char *p;
-	unsigned int len, fcs, proto;
+	unsigned int len, fcs;
 
 	skb = ap->rpkt;
 	if (ap->state & (SC_TOSS | SC_ESCAPE))
@@ -799,14 +799,14 @@ process_input_packet(struct asyncppp *ap)
 			goto err;
 		p = skb_pull(skb, 2);
 	}
-	proto = p[0];
-	if (proto & 1) {
-		/* protocol is compressed */
-		*(u8 *)skb_push(skb, 1) = 0;
-	} else {
+
+	/* If protocol field is not compressed, it can be LCP packet */
+	if (!(p[0] & 0x01)) {
+		unsigned int proto;
+
 		if (skb->len < 2)
 			goto err;
-		proto = (proto << 8) + p[1];
+		proto = (p[0] << 8) + p[1];
 		if (proto == PPP_LCP)
 			async_lcp_peek(ap, p, skb->len, 1);
 	}
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 500bc0027c1b..c708400fff4a 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1965,6 +1965,46 @@ ppp_do_recv(struct ppp *ppp, struct sk_buff *skb, struct channel *pch)
 	ppp_recv_unlock(ppp);
 }
 
+/**
+ * __ppp_decompress_proto - Decompress protocol field, slim version.
+ * @skb: Socket buffer where protocol field should be decompressed. It must have
+ *	 at least 1 byte of head room and 1 byte of linear data. First byte of
+ *	 data must be a protocol field byte.
+ *
+ * Decompress protocol field in PPP header if it's compressed, e.g. when
+ * Protocol-Field-Compression (PFC) was negotiated. No checks w.r.t. skb data
+ * length are done in this function.
+ */
+static void __ppp_decompress_proto(struct sk_buff *skb)
+{
+	if (skb->data[0] & 0x01)
+		*(u8 *)skb_push(skb, 1) = 0x00;
+}
+
+/**
+ * ppp_decompress_proto - Check skb data room and decompress protocol field.
+ * @skb: Socket buffer where protocol field should be decompressed. First byte
+ *	 of data must be a protocol field byte.
+ *
+ * Decompress protocol field in PPP header if it's compressed, e.g. when
+ * Protocol-Field-Compression (PFC) was negotiated. This function also makes
+ * sure that skb data room is sufficient for Protocol field, before and after
+ * decompression.
+ *
+ * Return: true - decompressed successfully, false - not enough room in skb.
+ */
+static bool ppp_decompress_proto(struct sk_buff *skb)
+{
+	/* At least one byte should be present (if protocol is compressed) */
+	if (!pskb_may_pull(skb, 1))
+		return false;
+
+	__ppp_decompress_proto(skb);
+
+	/* Protocol field should occupy 2 bytes when not compressed */
+	return pskb_may_pull(skb, 2);
+}
+
 void
 ppp_input(struct ppp_channel *chan, struct sk_buff *skb)
 {
@@ -1977,7 +2017,7 @@ ppp_input(struct ppp_channel *chan, struct sk_buff *skb)
 	}
 
 	read_lock_bh(&pch->upl);
-	if (!pskb_may_pull(skb, 2)) {
+	if (!ppp_decompress_proto(skb)) {
 		kfree_skb(skb);
 		if (pch->ppp) {
 			++pch->ppp->dev->stats.rx_length_errors;
@@ -2074,6 +2114,9 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 	if (ppp->flags & SC_MUST_COMP && ppp->rstate & SC_DC_FERROR)
 		goto err;
 
+	/* At this point the "Protocol" field MUST be decompressed, either in
+	 * ppp_input(), ppp_decompress_frame() or in ppp_receive_mp_frame().
+	 */
 	proto = PPP_PROTO(skb);
 	switch (proto) {
 	case PPP_VJC_COMP:
@@ -2245,6 +2288,9 @@ ppp_decompress_frame(struct ppp *ppp, struct sk_buff *skb)
 		skb_put(skb, len);
 		skb_pull(skb, 2);	/* pull off the A/C bytes */
 
+		/* Don't call __ppp_decompress_proto() here, but instead rely on
+		 * corresponding algo (mppe/bsd/deflate) to decompress it.
+		 */
 	} else {
 		/* Uncompressed frame - pass to decompressor so it
 		   can update its dictionary if necessary. */
@@ -2290,9 +2336,11 @@ ppp_receive_mp_frame(struct ppp *ppp, struct sk_buff *skb, struct channel *pch)
 
 	/*
 	 * Do protocol ID decompression on the first fragment of each packet.
+	 * We have to do that here, because ppp_receive_nonmp_frame() expects
+	 * decompressed protocol field.
 	 */
-	if ((PPP_MP_CB(skb)->BEbits & B) && (skb->data[0] & 1))
-		*(u8 *)skb_push(skb, 1) = 0;
+	if (PPP_MP_CB(skb)->BEbits & B)
+		__ppp_decompress_proto(skb);
 
 	/*
 	 * Expand sequence number to 32 bits, making it as close
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 047f6c68a441..d02ba2494d93 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -709,11 +709,10 @@ ppp_sync_input(struct syncppp *ap, const unsigned char *buf,
 		p = skb_pull(skb, 2);
 	}
 
-	/* decompress protocol field if compressed */
-	if (p[0] & 1) {
-		/* protocol is compressed */
-		*(u8 *)skb_push(skb, 1) = 0;
-	} else if (skb->len < 2)
+	/* PPP packet length should be >= 2 bytes when protocol field is not
+	 * compressed.
+	 */
+	if (!(p[0] & 0x01) && skb->len < 2)
 		goto err;
 
 	/* queue the frame to be processed */
diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 67ffe74747a1..8f09edd811e9 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -325,11 +325,6 @@ static int pptp_rcv_core(struct sock *sk, struct sk_buff *skb)
 			skb_pull(skb, 2);
 		}
 
-		if ((*skb->data) & 1) {
-			/* protocol is compressed */
-			*(u8 *)skb_push(skb, 1) = 0;
-		}
-
 		skb->ip_summed = CHECKSUM_NONE;
 		skb_set_network_header(skb, skb->head-skb->data);
 		ppp_input(&po->chan, skb);
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index c03c6461f236..04d9946dcdba 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -236,10 +236,6 @@ static void pppol2tp_recv(struct l2tp_session *session, struct sk_buff *skb, int
 	    skb->data[1] == PPP_UI)
 		skb_pull(skb, 2);
 
-	/* Decompress protocol field if PFC is enabled */
-	if ((*skb->data) & 0x1)
-		*(u8 *)skb_push(skb, 1) = 0;
-
 	if (sk->sk_state & PPPOX_BOUND) {
 		struct pppox_sock *po;
 
-- 
2.19.2

