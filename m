Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2A6C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 13:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A2620863
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 13:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="B9VldBEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A2620863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933662AbeFQNDo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 09:03:44 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:45232 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933241AbeFQNDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 09:03:42 -0400
Received: from trochilidae.lan (unknown [37.17.239.3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id E593A5C002A;
        Sun, 17 Jun 2018 15:03:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529240620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=KSDO7pvIMo2QkcUx+p1tvfNslYfN4zzKMRszNYUzGkM=;
        b=B9VldBEb5rtnZLl4gfLQVV1VKutQiVMzUi4uR3N9rsglBJ181ni3QLN16/KbVSKFyjz3wz
        b0JMwc12s0X3kssNNiqFtYeimPMt/hb/9tov/Rqn8PPw5bm+Hd0rb5i0CxixWciepIBTEm
        wgAkJ8zBw+414pYYysVvCkhfemXTU74=
From:   Stefan Agner <stefan@agner.ch>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Stefan Agner <stefan@agner.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: hamradio: remove unused variable
Date:   Sun, 17 Jun 2018 15:03:30 +0200
Message-Id: <20180617130335.3947-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.1
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:13030, ipnet:37.17.238.0/23, country:CH];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The array bpq_eth_addr is only used to get the size of an
address. Remove the array and use the size of the array
bcast_addr which is actually copied.

Also constify and tidy up the bcast_addr declaration.

This fixes a warning seen with clang:
drivers/net/hamradio/bpqether.c:94:13: warning: variable 'bpq_eth_addr' is not
      needed and will not be emitted [-Wunneeded-internal-declaration]
static char bpq_eth_addr[6];
            ^
1 warning generated.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/net/hamradio/bpqether.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/hamradio/bpqether.c b/drivers/net/hamradio/bpqether.c
index f347fd9c5b28..8c9c9977241e 100644
--- a/drivers/net/hamradio/bpqether.c
+++ b/drivers/net/hamradio/bpqether.c
@@ -89,9 +89,7 @@
 static const char banner[] __initconst = KERN_INFO \
 	"AX.25: bpqether driver version 004\n";
 
-static char bcast_addr[6]={0xFF,0xFF,0xFF,0xFF,0xFF,0xFF};
-
-static char bpq_eth_addr[6];
+static const char bcast_addr[6] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
 
 static int bpq_rcv(struct sk_buff *, struct net_device *, struct packet_type *, struct net_device *);
 static int bpq_device_event(struct notifier_block *, unsigned long, void *);
@@ -501,8 +499,8 @@ static int bpq_new_device(struct net_device *edev)
 	bpq->ethdev = edev;
 	bpq->axdev = ndev;
 
-	memcpy(bpq->dest_addr, bcast_addr, sizeof(bpq_eth_addr));
-	memcpy(bpq->acpt_addr, bcast_addr, sizeof(bpq_eth_addr));
+	memcpy(bpq->dest_addr, bcast_addr, sizeof(bcast_addr));
+	memcpy(bpq->acpt_addr, bcast_addr, sizeof(bcast_addr));
 
 	err = register_netdevice(ndev);
 	if (err)
-- 
2.17.1

