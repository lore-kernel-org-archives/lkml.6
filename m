Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226DznUo8AYOOguIMaKHlE20p1WNZg23FtS7AdgdKsaPqO6gpHtYpK3MyEx//Yfod+0zAD4C
ARC-Seal: i=1; a=rsa-sha256; t=1517591696; cv=none;
        d=google.com; s=arc-20160816;
        b=Wxw382o83GQqQowCCsJPFSarmBrglhHwQONPS0oPMalK9XJKedbAVKMg0E/HrS5QWJ
         kJxfrjjHJeQ4mPUyiReuiwpM+kb6aX4hXfIy3f3+OZlv4x+VIERBfyrtuB2Xi1XuGWwE
         vNz2/ZtqHiUG8kadkScMQn7XINXTRejJ+O1R+BnGwoZvTK2N/jlkPZr0F4dMJt/vdLqw
         zjnC9cwqyBkthekBsJKE7/nHUtVDhUruq4l3wn0sbcXkZGQHSluLrysPcs3BDRzE1XsO
         qyoaKFKZo+Pg9bOfTeD6cf7sNlj7DSx+62ocxI4ARqmO7JHA59hzJQ1nrJYf7GpHSNwe
         maMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rhSd/rRTkbT8hqKhh5VrFKrCT9Ph3nYQbXKL9V2xyyQ=;
        b=ELldb9aazZmgTHqtFqcuWvouV3nXa8xcy63rFT+VZ/nHgG0rvgedb/Bvta51b8YdUv
         1UIsSG5WiYtGJabSGe/UEPO99fzn6QCt6sC150AZdaW9qdzM/kxhBWPtBLtU5t9N/b0i
         QAyTFbsEdQendK9Uug0pvadI67s04Lx53wwjWEFmjIaVqGjC6aDPreviH5DaEmgoKWHE
         30qQ5LKxNUAgdfCSv4D4Kf7Fih6gq/6Wl4E2ktGxbyaEafkdZhsAuVb/oqr3ojYtpAbf
         DxzTZvKTePBWtvvW/p1jSKB7bDlKjKFHYZoGArSjIw/pl0yPaHiCNItkuAFeyx5WxLIc
         AVEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Antoine Tenart <antoine.tenart@free-electrons.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.15 13/55] crypto: inside-secure - avoid unmapping DMA memory that was not mapped
Date: Fri,  2 Feb 2018 17:58:31 +0100
Message-Id: <20180202140827.337756380@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309766611043261?=
X-GMAIL-MSGID: =?utf-8?q?1591310230818724375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -34,6 +34,8 @@ struct safexcel_ahash_req {
 	bool hmac;
 	bool needs_inv;
 
+	int nents;
+
 	u8 state_sz;    /* expected sate size, only set once */
 	u32 state[SHA256_DIGEST_SIZE / sizeof(u32)] __aligned(sizeof(u32));
 
@@ -152,8 +154,10 @@ static int safexcel_handle_req_result(st
 		memcpy(areq->result, sreq->state,
 		       crypto_ahash_digestsize(ahash));
 
-	dma_unmap_sg(priv->dev, areq->src,
-		     sg_nents_for_len(areq->src, areq->nbytes), DMA_TO_DEVICE);
+	if (sreq->nents) {
+		dma_unmap_sg(priv->dev, areq->src, sreq->nents, DMA_TO_DEVICE);
+		sreq->nents = 0;
+	}
 
 	safexcel_free_context(priv, async, sreq->state_sz);
 
@@ -178,7 +182,7 @@ static int safexcel_ahash_send_req(struc
 	struct safexcel_command_desc *cdesc, *first_cdesc = NULL;
 	struct safexcel_result_desc *rdesc;
 	struct scatterlist *sg;
-	int i, nents, queued, len, cache_len, extra, n_cdesc = 0, ret = 0;
+	int i, queued, len, cache_len, extra, n_cdesc = 0, ret = 0;
 
 	queued = len = req->len - req->processed;
 	if (queued < crypto_ahash_blocksize(ahash))
@@ -248,15 +252,15 @@ static int safexcel_ahash_send_req(struc
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
