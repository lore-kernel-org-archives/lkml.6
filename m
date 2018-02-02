Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227WJs5Sc9rFdAv6FqgTTNoUz35hH7+nkvYHLiz4TXxnXcXi8U060yAlDXO2RTtyZyUTl10s
ARC-Seal: i=1; a=rsa-sha256; t=1517591693; cv=none;
        d=google.com; s=arc-20160816;
        b=sHpR6FAp/PBMHUBAQgTpX7nBnCtpL49CVXGjyfZ6xhkfI8tTrqRumGDfcL5g/eGy6w
         pr/VfN+AnK3jfM6NZ9hXSQ5N2SMw8+mTRlbHjL5+GXGPIAEG+opmWvW4zyziCOQ+m4ia
         xxwmLUKkNALPs9am6NA6QYRLkXKan1shj/lVURPWkkAL+9QKLAfgUByvLjE8gU5kNWCB
         3p8Ctvo4JQ0kTn9k8EE8o5BcphDk54IOoW72DMkubCFobD3S4f+11uluORnKOhIk4/Gs
         1WmNXrkRhZS88s8OBj7znGVjkAFi5A/c0YKPEhZTr/VeD+P2bJC0Qb5g2d/x+eAesprq
         oISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=K/OgMpl3hkkqriqrczTvVieEaw857sCy7UcxAkMp02Q=;
        b=sdoHBo+Ilc/bRkk5aeQpaMtt7OAp2Yi5gdq1BcsDE3R5QHt7tyepE3Ibn9ohtKMqRa
         q5nlV1WvGtGjAkp5ZF9hzA8b4kcb+ntnN15wg9duaLmN4vMEBNgXz3pZAkObke9ERzp9
         jgvTMMGdthh9pPc/flx4LOkuYbIDiAM+HU2QK95JQt2dER9VYddGn9McJUPsmY8mX7lp
         qZwZCqZo040si/uIJddzTdOWcvwxXAx4/TtAq5xikD9oBGcYs28GMWT90X2RWQxkiVrm
         zEDch/7u5clAVbA0Z3qcZp0pRDXbbaGw6OrWOHZwmSBmJX/isU0ATDb+ANz3tKKKx7Rf
         YrmQ==
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
Subject: [PATCH 4.15 12/55] crypto: inside-secure - fix hash when length is a multiple of a block
Date: Fri,  2 Feb 2018 17:58:30 +0100
Message-Id: <20180202140827.168066257@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309763913025219?=
X-GMAIL-MSGID: =?utf-8?q?1591310228298668200?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <antoine.tenart@free-electrons.com>

commit 809778e02cd45d0625439fee67688f655627bb3c upstream.

This patch fixes the hash support in the SafeXcel driver when the update
size is a multiple of a block size, and when a final call is made just
after with a size of 0. In such cases the driver should cache the last
block from the update to avoid handling 0 length data on the final call
(that's a hardware limitation).

Fixes: 1b44c5a60c13 ("crypto: inside-secure - add SafeXcel EIP197 crypto engine driver")
Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/inside-secure/safexcel_hash.c |   34 +++++++++++++++++++--------
 1 file changed, 24 insertions(+), 10 deletions(-)

--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -186,17 +186,31 @@ static int safexcel_ahash_send_req(struc
 	else
 		cache_len = queued - areq->nbytes;
 
-	/*
-	 * If this is not the last request and the queued data does not fit
-	 * into full blocks, cache it for the next send() call.
-	 */
-	extra = queued & (crypto_ahash_blocksize(ahash) - 1);
-	if (!req->last_req && extra) {
-		sg_pcopy_to_buffer(areq->src, sg_nents(areq->src),
-				   req->cache_next, extra, areq->nbytes - extra);
+	if (!req->last_req) {
+		/* If this is not the last request and the queued data does not
+		 * fit into full blocks, cache it for the next send() call.
+		 */
+		extra = queued & (crypto_ahash_blocksize(ahash) - 1);
+		if (!extra)
+			/* If this is not the last request and the queued data
+			 * is a multiple of a block, cache the last one for now.
+			 */
+			extra = queued - crypto_ahash_blocksize(ahash);
 
-		queued -= extra;
-		len -= extra;
+		if (extra) {
+			sg_pcopy_to_buffer(areq->src, sg_nents(areq->src),
+					   req->cache_next, extra,
+					   areq->nbytes - extra);
+
+			queued -= extra;
+			len -= extra;
+
+			if (!queued) {
+				*commands = 0;
+				*results = 0;
+				return 0;
+			}
+		}
 	}
 
 	spin_lock_bh(&priv->ring[ring].egress_lock);
