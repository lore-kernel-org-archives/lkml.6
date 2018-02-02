Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517591258-2-2671088727296965026
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591258; b=gfnWvGxnSXHjB4tsVuYPCm/tB95DftOakvhcVPx/OLAcNIn
    SXhUFTvBdO7QYtvRZOTxNI4/7nrqH5BhJ6/V7BvzF5dzjGQV5ELnHoaaCNPRb+mr
    szRryHLwOzB1rA4E/RWA0tMC9uJ0sdtsAHt9OfQH+VOeMGkJc8Z4J2oyrL9yEOqi
    rg/g+nf7Fg+fYkSojesZQRZQ+g6dooZZUP+FuP9wiPhuq52nFq0FIhA7JLeSiEFC
    ovHy+bvPhsUKUK4P1ID0RV90v/he0ieNWkh+oYr6VRCIQ+QQ76mXjfhddpCfohW2
    n4lwPU3g7+MjsAf+JgldoJnwXwO7C6jNPfot9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591258; bh=EQqOjFUFjHzFWmuM16Vwqze0/P
    E8plPVJS37RUORFGw=; b=E3RwDYNnKt6d9kwwXvL9lR6ghnyUZBplDMxFGwmevB
    gL43hrFJbBLhDLkc0z6GNQQVT0zfF2I3UvWo7dI7SkCmHJEIQpcAGEzRHC9iw9sf
    z+5g6wENpnyV+0JpD7rQKb47akxg9BCxlOcWHTZxLNmlbJbGaUBSRNSWmeuB9E78
    r7A96WdEaHwhu4ibi3tSkKtfs79vnkZxYR/Gb8e7lJ1uigBFFpPQ+J/2rsXPPic+
    7+IL3Td9Zsojb8qEz37KqQNh8Sd75CaF16inn3tSfxXz4m/DxpLYfnYVslBMyTji
    NHzV3sq2JNgd8nlJIs670Xi4u7KD+EUwNL+likniAPTw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbeBBRHf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:07:35 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37050 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752742AbeBBRHd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:07:33 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 017/156] crypto: inside-secure - avoid unmapping DMA memory that was not mapped
Date: Fri,  2 Feb 2018 17:56:38 +0100
Message-Id: <20180202140841.092331685@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <antoine.tenart@free-electrons.com>

commit c957f8b3e2e54b29f53ef69decc87bbc858c9b58 upstream.

This patch adds a parameter in the SafeXcel ahash request structure to
keep track of the number of SG entries mapped. This allows not to call
dma_unmap_sg() when dma_map_sg() wasn't called in the first place. This
also removes a warning when the debugging of the DMA-API is enabled in
the kernel configuration: "DMA-API: device driver tries to free DMA
memory it has not allocated".

Fixes: 1b44c5a60c13 ("crypto: inside-secure - add SafeXcel EIP197 crypto engine driver")
Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/inside-secure/safexcel_hash.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -33,6 +33,8 @@ struct safexcel_ahash_req {
 	bool finish;
 	bool hmac;
 
+	int nents;
+
 	u8 state_sz;    /* expected sate size, only set once */
 	u32 state[SHA256_DIGEST_SIZE / sizeof(u32)];
 
@@ -151,8 +153,10 @@ static int safexcel_handle_result(struct
 		result_sz = crypto_ahash_digestsize(ahash);
 	memcpy(sreq->state, areq->result, result_sz);
 
-	dma_unmap_sg(priv->dev, areq->src,
-		     sg_nents_for_len(areq->src, areq->nbytes), DMA_TO_DEVICE);
+	if (sreq->nents) {
+		dma_unmap_sg(priv->dev, areq->src, sreq->nents, DMA_TO_DEVICE);
+		sreq->nents = 0;
+	}
 
 	safexcel_free_context(priv, async, sreq->state_sz);
 
@@ -177,7 +181,7 @@ static int safexcel_ahash_send(struct cr
 	struct safexcel_command_desc *cdesc, *first_cdesc = NULL;
 	struct safexcel_result_desc *rdesc;
 	struct scatterlist *sg;
-	int i, nents, queued, len, cache_len, extra, n_cdesc = 0, ret = 0;
+	int i, queued, len, cache_len, extra, n_cdesc = 0, ret = 0;
 
 	queued = len = req->len - req->processed;
 	if (queued < crypto_ahash_blocksize(ahash))
@@ -247,15 +251,15 @@ static int safexcel_ahash_send(struct cr
 	}
 
 	/* Now handle the current ahash request buffer(s) */
-	nents = dma_map_sg(priv->dev, areq->src,
-		       sg_nents_for_len(areq->src, areq->nbytes),
-		       DMA_TO_DEVICE);
-	if (!nents) {
+	req->nents = dma_map_sg(priv->dev, areq->src,
+				sg_nents_for_len(areq->src, areq->nbytes),
+				DMA_TO_DEVICE);
+	if (!req->nents) {
 		ret = -ENOMEM;
 		goto cdesc_rollback;
 	}
 
-	for_each_sg(areq->src, sg, nents, i) {
+	for_each_sg(areq->src, sg, req->nents, i) {
 		int sglen = sg_dma_len(sg);
 
 		/* Do not overflow the request */
