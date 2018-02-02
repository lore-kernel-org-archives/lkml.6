Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2243Lm9bV+U5cofD1/6QRVEDzVOEGtrvS8t1LftluJCmxIHuVCTGV0GFHKrhyX/Met/DgnO3
ARC-Seal: i=1; a=rsa-sha256; t=1517591251; cv=none;
        d=google.com; s=arc-20160816;
        b=WP4RYFx1fhQSgQrJCWieo+gxj4YtLJPQjg7TjuVzAK90Y8mQ5+MTzV69lPNLGIB1fv
         uYB/6o7PqhhjgtNILxIXpRiP4pl6oOCQ3QUBMj0y9l7/3FhwZYpvxspWj8znMibP3alX
         YczWLhYh305f1u+LbHSf19W5JX7uVLGpGWon9VwUDTdPDj+2P/oHYdIhMnC8SFqj4bXF
         /QK6BCSE7LmgjVk9MPtvYTKID9nwbdn26KPHIm98AlN/UsdeolT8GzPHPmJrIyQItoko
         YN6SHM+LsCt4bW0TglmDmHI5kSQEvYUXi+9zxoThp2AS6vBAge9gwCkOrr623jBqD/Wg
         Q10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=59BO1eBgvf6ErkGAG3tT1gipt5haK8F/OkqIMyLLVfc=;
        b=vxlSpeet8mkxnI0LxeH+jek6H3o+9ftSzq+bcQ0y7jW/WXMRLo7gDfnhqgS6PTd3ZW
         D2aZW5aS2JHO1nWH/M7XYgjwJt/98yTXM+AUvynRtHO3rPh/zzsRIXwA7Mtj1dguVrwI
         YGggV5mIg75pMYXXvSmeWNHqs4d2lFtlgrF7HMx0bwx4DPHJVlMYuXIjm5g14momEJ5h
         odNuu6e24YuV1frFho9+qEq2JI8DwwtZe8vF+gDU/yPX8dr/QhPzR8paNnhQLThv7DSA
         BD7ii2cQSnL6jPcMDpO9WrHSxHmkPBhAihiRvxkz/P82Dp+MyGCeSfjrohTCfWIdZckg
         588A==
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
Subject: [PATCH 4.14 016/156] crypto: inside-secure - fix hash when length is a multiple of a block
Date: Fri,  2 Feb 2018 17:56:37 +0100
Message-Id: <20180202140841.044638657@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309763913025219?=
X-GMAIL-MSGID: =?utf-8?q?1591309763913025219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -185,17 +185,31 @@ static int safexcel_ahash_send(struct cr
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
