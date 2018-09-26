Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2853AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF2E21530
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF2E21530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeIZWsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:48:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbeIZWsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:48:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44BB7308214B;
        Wed, 26 Sep 2018 16:34:37 +0000 (UTC)
Received: from mmorsy.remote.csb (unknown [10.36.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E40410694C6;
        Wed, 26 Sep 2018 16:34:27 +0000 (UTC)
From:   Mohammed Gamal <mgamal@redhat.com>
To:     sthemmin@microsoft.com, netdev@vger.kernel.org
Cc:     kys@microsoft.com, haiyangz@microsoft.com, vkuznets@redhat.com,
        otubo@redhat.com, cavery@redhat.com, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, Mohammed Gamal <mgamal@redhat.com>
Subject: [PATCH] hv_netvsc: Make sure out channel is fully opened on send
Date:   Wed, 26 Sep 2018 18:34:19 +0200
Message-Id: <1537979659-26979-1-git-send-email-mgamal@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 26 Sep 2018 16:34:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dring high network traffic changes to network interface parameters
such as number of channels or MTU can cause a kernel panic with a NULL
pointer dereference. This is due to netvsc_device_remove() being
called and deallocating the channel ring buffers, which can then be
accessed by netvsc_send_pkt() before they're allocated on calling
netvsc_device_add()

The patch fixes this problem by checking the channel state and returning
ENODEV if not yet opened. We also move the call to hv_ringbuf_avail_percent()
which may access the uninitialized ring buffer.

Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
 drivers/net/hyperv/netvsc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index fe01e14..75f1b31 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -825,7 +825,12 @@ static inline int netvsc_send_pkt(
 	struct netdev_queue *txq = netdev_get_tx_queue(ndev, packet->q_idx);
 	u64 req_id;
 	int ret;
-	u32 ring_avail = hv_get_avail_to_write_percent(&out_channel->outbound);
+	u32 ring_avail;
+
+	if (out_channel->state != CHANNEL_OPENED_STATE)
+		return -ENODEV;
+
+	ring_avail = hv_get_avail_to_write_percent(&out_channel->outbound);
 
 	nvmsg.hdr.msg_type = NVSP_MSG1_TYPE_SEND_RNDIS_PKT;
 	if (skb)
-- 
1.8.3.1

