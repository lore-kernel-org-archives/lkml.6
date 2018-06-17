Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8819AC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 21:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33889208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 21:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="lXsw54U8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33889208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752941AbeFQVli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 17:41:38 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:50832 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbeFQVle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 17:41:34 -0400
Received: from trochilidae.lan (unknown [37.17.239.3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 517085C0E8F;
        Sun, 17 Jun 2018 23:41:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529271693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=60VWSnAPTQIyeth83WbShYS3nl5CpAltgDX1ZvbxCxY=;
        b=lXsw54U8q0I070PQB2tUzxGqHa0PFD0c2OnIwzyyjh4wBxDF6p/7btpq5s1vLrot9vRJH2
        uatI+RcG8j/smteT+XtePt4sDQQseDwItjy0PpNwDMh/uaurbRiCmf7bro2l0/pUsNmzHf
        mU6Bkarg+VZouYe3sJdEkiih1XLwahk=
From:   Stefan Agner <stefan@agner.ch>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Stefan Agner <stefan@agner.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: hamradio: use eth_broadcast_addr
Date:   Sun, 17 Jun 2018 23:40:53 +0200
Message-Id: <20180617214058.6926-1-stefan@agner.ch>
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
address, whereas the bcast_addr is used to set the broadcast
address. This leads to a warning when using clang:
drivers/net/hamradio/bpqether.c:94:13: warning: variable 'bpq_eth_addr' is not
      needed and will not be emitted [-Wunneeded-internal-declaration]
static char bpq_eth_addr[6];
            ^

Remove both variables and use the common eth_broadcast_addr
to set the broadcast address.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/net/hamradio/bpqether.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/hamradio/bpqether.c b/drivers/net/hamradio/bpqether.c
index f347fd9c5b28..777fa59f5e0c 100644
--- a/drivers/net/hamradio/bpqether.c
+++ b/drivers/net/hamradio/bpqether.c
@@ -89,10 +89,6 @@
 static const char banner[] __initconst = KERN_INFO \
 	"AX.25: bpqether driver version 004\n";
 
-static char bcast_addr[6]={0xFF,0xFF,0xFF,0xFF,0xFF,0xFF};
-
-static char bpq_eth_addr[6];
-
 static int bpq_rcv(struct sk_buff *, struct net_device *, struct packet_type *, struct net_device *);
 static int bpq_device_event(struct notifier_block *, unsigned long, void *);
 
@@ -501,8 +497,8 @@ static int bpq_new_device(struct net_device *edev)
 	bpq->ethdev = edev;
 	bpq->axdev = ndev;
 
-	memcpy(bpq->dest_addr, bcast_addr, sizeof(bpq_eth_addr));
-	memcpy(bpq->acpt_addr, bcast_addr, sizeof(bpq_eth_addr));
+	eth_broadcast_addr(bpq->dest_addr);
+	eth_broadcast_addr(bpq->acpt_addr);
 
 	err = register_netdevice(ndev);
 	if (err)
-- 
2.17.1

