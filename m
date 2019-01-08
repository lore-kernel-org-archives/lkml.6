Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6647C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6D420651
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6djmrIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfAHMpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:45:33 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38881 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfAHMpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:45:32 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so1860545plb.5;
        Tue, 08 Jan 2019 04:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rBcF/qpb7sv+0HGh3EXqXiXdG51s3dVZfqIbkSsGFTg=;
        b=i6djmrIRt6CZtWS5bXsApCvksZ8Q3KO4GMXLD6OvZxO+W45eNa811jL8ueQnQrOmG8
         k3IAYxRLHgPQDFecENQmRL4fCVhMMnWPKa3vUzp8U2CevVdVxQYWM5pPrgK0Qr6ICgj0
         ogcH5aDDeFOXwAMb7e50ch4qamTjX/709R19zfdXWqK+AxA8Vz1Tf1krw3on1kvpu7wN
         0WeOEk3826Grbw6uqlwTIGdrOwW+/c7+OAlU6RUg6y11t5v7LpkbVFKj4n5R8f5ZKkaX
         aaRDdCr59/pi9w1X1Fyg/pw4zUgFbqIk2LvDedPMwZNmzxI7MpkT7CTNZkTuhuvLUjch
         mUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rBcF/qpb7sv+0HGh3EXqXiXdG51s3dVZfqIbkSsGFTg=;
        b=bWmpNb2PmhUx4Hfs4ugF3COm+p88i+Fidn8Ddtlm/nge0nr0WIJwOqkBAaKLdDUhDb
         D9P2u/7biZkRiZQCI1gcSkMdOdX4IPzChbneO8OilbirQyWnXD6ZHB1CNyh/moACaBiT
         6Gor0tj6s/AJHtCCHU4tBhqv7Vt3KWOuV5e8QEzi1WVmo4pLFRg74WnR+NK0I/9hWvb5
         pKAKHn2W91ZwaIkdTigQ7ovSEiljqaODw+3ZNOJZJN4DtsPen/mOfW/Tnkyif9Yzhb5X
         lxStvR+stR8WOqfk/QfwiTSlI8c/RDDS7j2LpjAYfEgJOseL3ynk9mKyR5P6II6SyoHO
         32/w==
X-Gm-Message-State: AJcUukebqNVisE3FRuiyFF6MBStgCUyB6mkMuR0GyeiCEae30v9SKfyV
        7lg8aQulcNIDKVN7DrOF2c4=
X-Google-Smtp-Source: ALg8bN4LySyBrYLlFWZJ0YbRyf+OiUUwJFT1H7sERWJLEyHo8zmhZ30gSzSHZ3nlhJ0iw63noPbViQ==
X-Received: by 2002:a17:902:70c6:: with SMTP id l6mr1708662plt.30.1546951531922;
        Tue, 08 Jan 2019 04:45:31 -0800 (PST)
Received: from localhost.localdomain ([2402:f000:1:4414:811b:a348:3027:e3a0])
        by smtp.gmail.com with ESMTPSA id d18sm105622235pfj.47.2019.01.08.04.45.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 04:45:31 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     davem@davemloft.net, yanjun.zhu@oracle.com, keescook@chromium.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: nvidia: forcedeth: Fix two possible concurrency use-after-free bugs
Date:   Tue,  8 Jan 2019 20:45:18 +0800
Message-Id: <20190108124518.21986-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/net/ethernet/nvidia/forcedeth.c, the functions
nv_start_xmit() and nv_start_xmit_optimized() can be concurrently
executed with nv_poll_controller().

nv_start_xmit
  line 2321: prev_tx_ctx->skb = skb;

nv_start_xmit_optimized
  line 2479: prev_tx_ctx->skb = skb;

nv_poll_controller
  nv_do_nic_poll
    line 4134: spin_lock(&np->lock);
    nv_drain_rxtx
      nv_drain_tx
        nv_release_txskb
          line 2004: dev_kfree_skb_any(tx_skb->skb);

Thus, two possible concurrency use-after-free bugs may occur.

To fix these possible bugs, the calls to spin_lock_irqsave() in 
nv_start_xmit() and nv_start_xmit_optimized() are moved to the 
front of "prev_tx_ctx->skb = skb;"

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/nvidia/forcedeth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index 1d9b0d44ddb6..48fa5a0bd2cb 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -2317,6 +2317,8 @@ static netdev_tx_t nv_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* set last fragment flag  */
 	prev_tx->flaglen |= cpu_to_le32(tx_flags_extra);
 
+	spin_lock_irqsave(&np->lock, flags);
+
 	/* save skb in this slot's context area */
 	prev_tx_ctx->skb = skb;
 
@@ -2326,8 +2328,6 @@ static netdev_tx_t nv_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		tx_flags_extra = skb->ip_summed == CHECKSUM_PARTIAL ?
 			 NV_TX2_CHECKSUM_L3 | NV_TX2_CHECKSUM_L4 : 0;
 
-	spin_lock_irqsave(&np->lock, flags);
-
 	/* set tx flags */
 	start_tx->flaglen |= cpu_to_le32(tx_flags | tx_flags_extra);
 
@@ -2475,6 +2475,8 @@ static netdev_tx_t nv_start_xmit_optimized(struct sk_buff *skb,
 	/* set last fragment flag  */
 	prev_tx->flaglen |= cpu_to_le32(NV_TX2_LASTPACKET);
 
+	spin_lock_irqsave(&np->lock, flags);
+
 	/* save skb in this slot's context area */
 	prev_tx_ctx->skb = skb;
 
@@ -2491,8 +2493,6 @@ static netdev_tx_t nv_start_xmit_optimized(struct sk_buff *skb,
 	else
 		start_tx->txvlan = 0;
 
-	spin_lock_irqsave(&np->lock, flags);
-
 	if (np->tx_limit) {
 		/* Limit the number of outstanding tx. Setup all fragments, but
 		 * do not set the VALID bit on the first descriptor. Save a pointer
-- 
2.17.0

