Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoEETSFNwnSKtzdZoKcqJRUWMsz6dCBAdzJYZfbCNxsSi36PAAHGavxlIaqpyb9TQV7CXFW
ARC-Seal: i=1; a=rsa-sha256; t=1527156185; cv=none;
        d=google.com; s=arc-20160816;
        b=d3FneJLTYh+gixqcQMMN4A4Vbsk4oqGWZXav57lLAxA3uBQDsEahoPNrY0CqHkhblW
         bKB+yi5Veu4SzB9cVX6wgT+qfGSUTUHbT1nNW0lLQj/e+ohryrRiMlUCbZ1ROH4YUAeE
         PQ7+Hybz7BdI81zna2tm1b0jNzvCgAe+zUV+RcnU2YK1vc3QMbRnGmYc4PX3EUFoeAA3
         aD8u2LRhqovls0zpn9kS2eMEjzFkXxaV+8Swcx9LN/qa2NFFtJAK6p+akVCBETOyftKY
         EfUE08DZZ5sqqkH8upP+kwGRIC8EoJX4+x+u2BZPAz8xgJSsBl9Mjiaav0g6UlR5+IVl
         U0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=XhwesVIsJ6/Br3mx1FjXhRCCSMOWtIlPlD4WLYPharE=;
        b=ENuREtn2Q2Afp0bZSeDKZCzeaMchqrnRikqTbz3iJin+kSDAv6GGc9SKSt88AjF32T
         /n8N4CPWBqjOflRe9jiMDPks/BraIgrp7teI465R9K6bESRzGIrSHIto4LEgPcnQapku
         Rhf0EZyjzuG4wJoc29N25QB9LR01kgpKo5DXqnCMgdwNtC5NVknGGcRC9sCAxW+zOviB
         1SXP3wz7dpp69Sn8mfDyrtkHxmw778RcXvcEkxNFNgpa9IwFGltVFipMW53+ffUIazol
         2Pi6HBziQbRG4Dd6pihd8AeGnBLVbZKJGxRXnvrImIIXBBlTNSegXXERD0FsG1hUkXDA
         jkRA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=nuR1wx0K;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=nuR1wx0K;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ioana Radulescu <ruxandra.radulescu@nxp.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 093/161] staging: fsl-dpaa2/eth: Fix incorrect casts
Date: Thu, 24 May 2018 11:38:38 +0200
Message-Id: <20180524093029.568570633@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338820614579952?=
X-GMAIL-MSGID: =?utf-8?q?1601339323999076765?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -324,7 +324,7 @@ static int consume_frames(struct dpaa2_e
 		}
 
 		fd = dpaa2_dq_fd(dq);
-		fq = (struct dpaa2_eth_fq *)dpaa2_dq_fqd_ctx(dq);
+		fq = (struct dpaa2_eth_fq *)(uintptr_t)dpaa2_dq_fqd_ctx(dq);
 		fq->stats.frames++;
 
 		fq->consume(priv, ch, fd, &ch->napi, fq->flowid);
@@ -1908,7 +1908,7 @@ static int setup_rx_flow(struct dpaa2_et
 	queue.destination.id = fq->channel->dpcon_id;
 	queue.destination.type = DPNI_DEST_DPCON;
 	queue.destination.priority = 1;
-	queue.user_context = (u64)fq;
+	queue.user_context = (u64)(uintptr_t)fq;
 	err = dpni_set_queue(priv->mc_io, 0, priv->mc_token,
 			     DPNI_QUEUE_RX, 0, fq->flowid,
 			     DPNI_QUEUE_OPT_USER_CTX | DPNI_QUEUE_OPT_DEST,
@@ -1960,7 +1960,7 @@ static int setup_tx_flow(struct dpaa2_et
 	queue.destination.id = fq->channel->dpcon_id;
 	queue.destination.type = DPNI_DEST_DPCON;
 	queue.destination.priority = 0;
-	queue.user_context = (u64)fq;
+	queue.user_context = (u64)(uintptr_t)fq;
 	err = dpni_set_queue(priv->mc_io, 0, priv->mc_token,
 			     DPNI_QUEUE_TX_CONFIRM, 0, fq->flowid,
 			     DPNI_QUEUE_OPT_USER_CTX | DPNI_QUEUE_OPT_DEST,
