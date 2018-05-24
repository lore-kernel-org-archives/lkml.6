Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo+WoutVhAUnvYWRY/gu86ypE5wPKUyCepMKwohZAuI9X0zs66wOLIAS42rZC1LjJYcePeu
ARC-Seal: i=1; a=rsa-sha256; t=1527155705; cv=none;
        d=google.com; s=arc-20160816;
        b=UBvz0AT1eBFOxpLL7LNbko9pveEnLRPJz8w7iOos2lh/jlctf4pqQnb+rKPOll5oF9
         UHM4wSwfODnw39aTh+sAOg/G7y5NnoBjnqDwJa2cddIVZFMcRXlRPALUZ6UfnjaJbtSC
         uGGu/uv7vteGI8LfswcwVBGnwHZ001jH9LpB6Hc4E6aq12cbKkso/D3bqkP+jn3pHf6c
         4LzD9nsJbCZgoRSPD/AdkJZzkkFgJWYrLghLMe8qcynRbXIYqIGgp2xziCiIrWwo6mZJ
         WbKIFuAszoK3EsEgZ4QrBGT1Q8ASB39FQo+2D2FdnOb19TkZTO4lDZIguUHupJeRjgnH
         LOrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=mn94+L5rvm8iZxVHVjm2yAKTGI2DrehWW5WsTaqOdm8=;
        b=aH5aU+KZXmWHQ+AIys0nKKgh1ozqLZk88aCVhmtV9Rjn35DGrS0G/u841D8/x36yWS
         N6VfRjXtDeJkU2ahvwguU9vn9pa8HiiLA7cWxsILiN9OnA8kDzjhKIgx97/PYsz3+8a9
         /zPpRV91HqRMe0ZpOEoHOtC18gP7jgLyo9/B0NSBVaEh5foxY+ZEXWicreBpgASRPSx1
         wtgV/6AZAEGYQ1pYS0LdAwLy6R/CqZzAOZYMmxLXAHyhtI9uXhv89tD6isI7OfGM6X6V
         GOGwMT6+WanM2moEVjTH9AnGW9GCy1MaO3g+AkEz+BfQYJUKNI276phqOTuJuMZ4eO2V
         lt7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rv89jNjC;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rv89jNjC;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ioana Radulescu <ruxandra.radulescu@nxp.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 087/165] staging: fsl-dpaa2/eth: Fix incorrect casts
Date: Thu, 24 May 2018 11:38:13 +0200
Message-Id: <20180524093625.550700720@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338820614579952?=
X-GMAIL-MSGID: =?utf-8?q?1601338820614579952?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ioana Radulescu <ruxandra.radulescu@nxp.com>

[ Upstream commit 75c583ab9709692a60871d4719006391cde8dc1d ]

The DPAA2 Ethernet driver incorrectly assumes virtual addresses
are always 64b long, which causes compiler errors when building
for a 32b platform.

Fix this by using explicit casts to uintptr_t where necessary.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -315,7 +315,7 @@ static int consume_frames(struct dpaa2_e
 		}
 
 		fd = dpaa2_dq_fd(dq);
-		fq = (struct dpaa2_eth_fq *)dpaa2_dq_fqd_ctx(dq);
+		fq = (struct dpaa2_eth_fq *)(uintptr_t)dpaa2_dq_fqd_ctx(dq);
 		fq->stats.frames++;
 
 		fq->consume(priv, ch, fd, &ch->napi);
@@ -1888,7 +1888,7 @@ static int setup_rx_flow(struct dpaa2_et
 	queue.destination.id = fq->channel->dpcon_id;
 	queue.destination.type = DPNI_DEST_DPCON;
 	queue.destination.priority = 1;
-	queue.user_context = (u64)fq;
+	queue.user_context = (u64)(uintptr_t)fq;
 	err = dpni_set_queue(priv->mc_io, 0, priv->mc_token,
 			     DPNI_QUEUE_RX, 0, fq->flowid,
 			     DPNI_QUEUE_OPT_USER_CTX | DPNI_QUEUE_OPT_DEST,
@@ -1940,7 +1940,7 @@ static int setup_tx_flow(struct dpaa2_et
 	queue.destination.id = fq->channel->dpcon_id;
 	queue.destination.type = DPNI_DEST_DPCON;
 	queue.destination.priority = 0;
-	queue.user_context = (u64)fq;
+	queue.user_context = (u64)(uintptr_t)fq;
 	err = dpni_set_queue(priv->mc_io, 0, priv->mc_token,
 			     DPNI_QUEUE_TX_CONFIRM, 0, fq->flowid,
 			     DPNI_QUEUE_OPT_USER_CTX | DPNI_QUEUE_OPT_DEST,
