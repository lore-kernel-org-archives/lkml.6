Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC45CC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0969208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hSZ/oHav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0969208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755760AbeFYXzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:55:10 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44888 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754330AbeFYXzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:55:08 -0400
Received: by mail-pf0-f196.google.com with SMTP id x23-v6so3263456pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 16:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7t5j5UuxjuFVdTcRTOTfuLSfrBlPZS2OMCHOy6tkSjA=;
        b=hSZ/oHavsD1cbhdH2/OMfQo/RO5jJWGMFzxdt9l16o1YIwmQkxP/9CfT0lwDCEyRHM
         avdxws49lKsUMgM4O8PYZmN/wfaUGQxwXd5l2wgb94dkfDNHaefY2PXijOSO4+UCuSee
         CFKKXZ7RjtFXyeGY3p4A2C4Fil/IXAJN6BNgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7t5j5UuxjuFVdTcRTOTfuLSfrBlPZS2OMCHOy6tkSjA=;
        b=gLyCaj8iOvxARC+y4OKVSY5T4IfyyR3Q9SWplr3r/1gFapbNk7k7pBOJ+27oweA1xM
         PzA3MhyU5GJjnPERqKiqy6TPIiM8X4asw+P+w+iCvZgeb1scEGNGWMkPn1v6KD4s1ubS
         Ul/R62A944+tfzg0mxGWp/TZ3XFFMclpFGodJh+hDanB+jwYCpjrFd1pKusp0WI+afxf
         HklbcjUqxIYC63lCALFg9Pa9j1IOiinxlseMebkKcYhRN0QBUDM1O89GFZzSEX0Q4A1v
         Cw+F3JTnk3kiwCqr6znheqnhdFZkdWZ8Fe+2A/WJ/R5F8+SZSbHC1oJG5pw0wLlx9v+S
         TAXQ==
X-Gm-Message-State: APt69E3IZ8M9K/2G6hQs/PU6AjAr7y/RLqxe3wND5eTQ9pXD52u0AY8p
        JtwxPsv7lTPk72Bgcujq21Xd8vPm7ls=
X-Google-Smtp-Source: ADUXVKJ/i/zuwcOr9ICgo3I2ZMwG+qGTD/nuEaOX6+UdEhjLPh6m0J51lk2nV3md5wT2GlvLVdyVjg==
X-Received: by 2002:a65:620b:: with SMTP id d11-v6mr1307618pgv.429.1529970907826;
        Mon, 25 Jun 2018 16:55:07 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id u1-v6sm180101pfn.59.2018.06.25.16.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 16:55:06 -0700 (PDT)
Date:   Mon, 25 Jun 2018 16:55:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Watson <davejwatson@fb.com>
Cc:     Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net/tls: Remove VLA usage on nonce
Message-ID: <20180625235505.GA22661@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the prior VLA removal, commit b16520f7493d ("net/tls: Remove
VLA usage"), and a new VLA addition, commit c46234ebb4d1e ("tls: RX path
for ktls"), passed in the night. This removes the newly added VLA, which
happens to have its bounds based on the same max value.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/tls/tls_sw.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index f127fac88acf..3e0b64549552 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -941,7 +941,7 @@ static int tls_read_size(struct strparser *strp, struct sk_buff *skb)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(strp->sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
-	char header[tls_ctx->rx.prepend_size];
+	char header[TLS_HEADER_SIZE + MAX_IV_SIZE];
 	struct strp_msg *rxm = strp_msg(skb);
 	size_t cipher_overhead;
 	size_t data_len = 0;
@@ -951,6 +951,12 @@ static int tls_read_size(struct strparser *strp, struct sk_buff *skb)
 	if (rxm->offset + tls_ctx->rx.prepend_size > skb->len)
 		return 0;
 
+	/* Sanity-check size of on-stack buffer. */
+	if (WARN_ON(tls_ctx->rx.prepend_size > sizeof(header))) {
+		ret = -EINVAL;
+		goto read_failure;
+	}
+
 	/* Linearize header to local buffer */
 	ret = skb_copy_bits(skb, rxm->offset, header, tls_ctx->rx.prepend_size);
 
@@ -1111,7 +1117,7 @@ int tls_set_sw_offload(struct sock *sk, struct tls_context *ctx, int tx)
 	}
 
 	/* Sanity-check the IV size for stack allocations. */
-	if (iv_size > MAX_IV_SIZE) {
+	if (iv_size > MAX_IV_SIZE || nonce_size > MAX_IV_SIZE) {
 		rc = -EINVAL;
 		goto free_priv;
 	}
-- 
2.17.1


-- 
Kees Cook
Pixel Security
