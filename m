Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id L4HVB0krHlsfLgAAmS7hNA
	; Mon, 11 Jun 2018 07:57:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F3A01607A4; Mon, 11 Jun 2018 07:57:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 77A2F605A5;
	Mon, 11 Jun 2018 07:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77A2F605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754135AbeFKH5r (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 03:57:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:41290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754006AbeFKH5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:57:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D4A7FAC06;
        Mon, 11 Jun 2018 07:57:44 +0000 (UTC)
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        netdev@vger.kernel.org
Cc: boris.ostrovsky@oracle.com, davem@davemloft.net,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH] xen/netfront: raise max number of slots in xennet_get_responses()
Date: Mon, 11 Jun 2018 09:57:42 +0200
Message-Id: <20180611075742.1691-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max number of slots used in xennet_get_responses() is set to
MAX_SKB_FRAGS + (rx->status <= RX_COPY_THRESHOLD).

In old kernel-xen MAX_SKB_FRAGS was 18, while nowadays it is 17. This
difference is resulting in frequent messages "too many slots" and a
reduced network throughput for some workloads (factor 10 below that of
a kernel-xen based guest).

Replacing MAX_SKB_FRAGS by XEN_NETIF_NR_SLOTS_MIN for calculation of
the max number of slots to use solves that problem (tests showed no
more messages "too many slots" and throughput was as high as with the
kernel-xen based guest system).

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/net/xen-netfront.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 679da1abd73c..ba411005d829 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -790,7 +790,7 @@ static int xennet_get_responses(struct netfront_queue *queue,
 	RING_IDX cons = queue->rx.rsp_cons;
 	struct sk_buff *skb = xennet_get_rx_skb(queue, cons);
 	grant_ref_t ref = xennet_get_rx_ref(queue, cons);
-	int max = MAX_SKB_FRAGS + (rx->status <= RX_COPY_THRESHOLD);
+	int max = XEN_NETIF_NR_SLOTS_MIN + (rx->status <= RX_COPY_THRESHOLD);
 	int slots = 1;
 	int err = 0;
 	unsigned long ret;
-- 
2.13.7
