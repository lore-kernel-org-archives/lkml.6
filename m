Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74643C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1542B2080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dafpww5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeLSAIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 19:08:13 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39335 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeLSAIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 19:08:13 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so13651673lfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 16:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U6wuPDLanBwdg8xKHlWrvMBE4Wc9wk99yWHT28tnYjQ=;
        b=dafpww5CcFRjb80mQI3zw68kp5fn3DblCrO7dqyV+s5BjScEE4WUP086GJe6skAFPQ
         vuHzhLSXAe9Ee3ZFuriU27kZZGiTnxPM5F/l+RTOXbT8k3Wpm2SlcaKvjO0u2XD6JaLh
         gkkBQcvrw49YxXuolCCFutJ2bFZiDfn2tEnog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U6wuPDLanBwdg8xKHlWrvMBE4Wc9wk99yWHT28tnYjQ=;
        b=BxEhDEpO8iNtdILrQpW5UXJNpyS+yB0/4Lu7w3afCP9KFYRIPyDfWQtc+0D9HsnbJj
         JtAazEnu2hHO+qC9fmwr7kyvfikNfb4nWSsrlLV7VPWAlR7wpYSyX7NkvVHLnpzW4Tc7
         Z4Ni+BUp6496nT7mbFXivmX2ZRAOEWhDpB3YHAaluhT0Px4QoO1cO/zbATkH+iUT6XKC
         k1ny7yA3+UkM+RtYgokJ81TLCO0dnDDWF7FYZHnlRVEgpIix8Qa+t49Kn04GYNKQvmw/
         orTXCqESka7bD90QvRfMPDojtRIvMI/2QGwB8vr8BFhFmUUkCDiLH9qbrw/MULt6wpJ6
         rvWw==
X-Gm-Message-State: AA+aEWZRXZFWod7O2YsVBM2jTtg5WwpvoW+llgX9n99Z2I2jBoHGcsdz
        +bI6d4yz0vkAJjI+biG8izAjXXt1WsFakQ==
X-Google-Smtp-Source: AFSGD/XNMx57Je5CdddL/zwfFb1xzScW4FVZ06dQTE46aRVmNcnHJH0hwUQDejo7d+rKm2k+0tO3Ug==
X-Received: by 2002:a19:5059:: with SMTP id z25mr10915511lfj.120.1545178090158;
        Tue, 18 Dec 2018 16:08:10 -0800 (PST)
Received: from localhost ([195.238.92.132])
        by smtp.gmail.com with ESMTPSA id z6sm3433127lfa.87.2018.12.18.16.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 16:08:09 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guillaume Nault <g.nault@alphalink.fr>
Subject: [PATCH] ppp: Move PFC decompression to PPP generic layer
Date:   Wed, 19 Dec 2018 02:08:08 +0200
Message-Id: <20181219000808.28382-1-semen.protsenko@linaro.org>
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
 drivers/net/ppp/ppp_async.c   | 14 +++++++-------
 drivers/net/ppp/ppp_generic.c | 21 +++++++++++++++++++--
 drivers/net/ppp/ppp_synctty.c |  9 ++++-----
 drivers/net/ppp/pptp.c        |  5 -----
 net/l2tp/l2tp_ppp.c           |  4 ----
 5 files changed, 30 insertions(+), 23 deletions(-)

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
index 500bc0027c1b..10c4c8eec995 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1965,6 +1965,14 @@ ppp_do_recv(struct ppp *ppp, struct sk_buff *skb, struct channel *pch)
 	ppp_recv_unlock(ppp);
 }
 
+/* Decompress protocol field in PPP header if it's compressed */
+static inline void
+ppp_decompress_proto(struct sk_buff *skb)
+{
+	if (skb->data[0] & 0x01)
+		*(u8 *)skb_push(skb, 1) = 0x00;
+}
+
 void
 ppp_input(struct ppp_channel *chan, struct sk_buff *skb)
 {
@@ -1986,6 +1994,7 @@ ppp_input(struct ppp_channel *chan, struct sk_buff *skb)
 		goto done;
 	}
 
+	ppp_decompress_proto(skb);
 	proto = PPP_PROTO(skb);
 	if (!pch->ppp || proto >= 0xc000 || proto == PPP_CCPFRAG) {
 		/* put it on the channel queue */
@@ -2074,6 +2083,9 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 	if (ppp->flags & SC_MUST_COMP && ppp->rstate & SC_DC_FERROR)
 		goto err;
 
+	/* At this point the "Protocol" field MUST be decompressed, either in
+	 * ppp_decompress_frame() or in ppp_receive_mp_frame().
+	 */
 	proto = PPP_PROTO(skb);
 	switch (proto) {
 	case PPP_VJC_COMP:
@@ -2245,6 +2257,9 @@ ppp_decompress_frame(struct ppp *ppp, struct sk_buff *skb)
 		skb_put(skb, len);
 		skb_pull(skb, 2);	/* pull off the A/C bytes */
 
+		/* Don't call ppp_decompress_proto() here, but rather rely on
+		 * corresponding algo (mppe/bsd/deflate) to decompress it.
+		 */
 	} else {
 		/* Uncompressed frame - pass to decompressor so it
 		   can update its dictionary if necessary. */
@@ -2290,9 +2305,11 @@ ppp_receive_mp_frame(struct ppp *ppp, struct sk_buff *skb, struct channel *pch)
 
 	/*
 	 * Do protocol ID decompression on the first fragment of each packet.
+	 * We can't wait for this to happen in ppp_input(), because
+	 * ppp_receive_nonmp_frame() expects decompressed protocol field.
 	 */
-	if ((PPP_MP_CB(skb)->BEbits & B) && (skb->data[0] & 1))
-		*(u8 *)skb_push(skb, 1) = 0;
+	if (PPP_MP_CB(skb)->BEbits & B)
+		ppp_decompress_proto(skb);
 
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

