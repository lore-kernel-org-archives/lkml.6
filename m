Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B55BC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E092A20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E092A20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeILIT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 04:19:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbeILIT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 04:19:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F1D440216F7;
        Wed, 12 Sep 2018 03:17:34 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-130.pek2.redhat.com [10.72.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 404902027EA4;
        Wed, 12 Sep 2018 03:17:30 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        mst@redhat.com, jasowang@redhat.com
Subject: [PATCH net-next V2 02/11] tuntap: switch to use XDP_PACKET_HEADROOM
Date:   Wed, 12 Sep 2018 11:17:00 +0800
Message-Id: <20180912031709.14112-3-jasowang@redhat.com>
In-Reply-To: <20180912031709.14112-1-jasowang@redhat.com>
References: <20180912031709.14112-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 12 Sep 2018 03:17:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 12 Sep 2018 03:17:34 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 2c548bd20393..d3677a544b56 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -113,7 +113,6 @@ do {								\
 } while (0)
 #endif
 
-#define TUN_HEADROOM 256
 #define TUN_RX_PAD (NET_IP_ALIGN + NET_SKB_PAD)
 
 /* TUN device flags */
@@ -1654,7 +1653,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog)
-		pad += TUN_HEADROOM;
+		pad += XDP_PACKET_HEADROOM;
 	buflen += SKB_DATA_ALIGN(len + pad);
 	rcu_read_unlock();
 
-- 
2.17.1

