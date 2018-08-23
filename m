Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDC9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A692077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A692077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbeHWMRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:17:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50818 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbeHWMRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:17:02 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BD759941;
        Thu, 23 Aug 2018 08:48:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 069/324] net: hamradio: use eth_broadcast_addr
Date:   Thu, 23 Aug 2018 09:52:15 +0200
Message-Id: <20180823074959.374495388@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>

[ Upstream commit 4e8439aa34802deab11cee68b0ecb18f887fb153 ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hamradio/bpqether.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

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
 
@@ -515,8 +511,8 @@ static int bpq_new_device(struct net_dev
 	bpq->ethdev = edev;
 	bpq->axdev = ndev;
 
-	memcpy(bpq->dest_addr, bcast_addr, sizeof(bpq_eth_addr));
-	memcpy(bpq->acpt_addr, bcast_addr, sizeof(bpq_eth_addr));
+	eth_broadcast_addr(bpq->dest_addr);
+	eth_broadcast_addr(bpq->acpt_addr);
 
 	err = register_netdevice(ndev);
 	if (err)


