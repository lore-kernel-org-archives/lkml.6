Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2ADC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 14:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DC72087F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 14:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uV1wioqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeLZOWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 09:22:35 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43102 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeLZOWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 09:22:35 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so7620256pgk.10;
        Wed, 26 Dec 2018 06:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6TntGLTr54y8dewlGK4UCkfUJs2JacuKR9U0JDuJQpM=;
        b=uV1wioqfD+sI3fPPeEcXzif+hGRAh0HnE3TQBHKSlOu/+/H/M72D53+2N/BCMRpQ/+
         4fwobXzY93elB7x2XD8UDZsCRsb+Ocgj7QUdHvfjriBqlaPConuoUiWQbEQnKOhEJbsg
         F4wZKRRppZizHyn6xILwlb10rnbnd8TQNWI1CeLUYIxA7gLSPIJOet0Rsuf3J5yyZrVT
         wu6MKmqLN1Ta2C/bbpCM8FnRFvTncwJBlkNUfN8NgptjS5ZqyN9JJbCXRNk/fdn7DXYg
         3xFnzB1HurP5JPinJuHnPCrrJ0f0iS0z24DW1wT3ozUpGcMnz+fkmKtsGyaRzHtjE1Px
         CiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6TntGLTr54y8dewlGK4UCkfUJs2JacuKR9U0JDuJQpM=;
        b=VffqGph7LNs3NeIerQy01067a3JXKg24tM7ClYuiR/OBHpTcLtbehpNDBlKEjKG74S
         wckRgALxgYFu5mKW2c5d/l5ZRYBE2iSVaiZQb811CAiRfIh4V3oIxOT+CTUxcyissVgI
         0JsBpa7OUFhDAKGTNuDnoqTl3XWZwK4Iz0yFIHHQKcOo0poaKxmsm2O9XP8bxGYGCwpm
         /mEP9Rp0wq91gRXf7skcNTbYzM3eQMUopTas008Tz3jNwrw6x3/+Vc8aKlig26w+poqf
         +FLrnSfpC0ARYUik/AhpwpjCYpxurxMfeR2IzGqac2BOjfkptgZyq+cORS7bn9IXbzOo
         TKfA==
X-Gm-Message-State: AA+aEWYOzUQxpFZYPcnz5PCaQAtntaWjplgUZym5FqrtSl5RmBJZ28/M
        VpDpo9YQ6jski/eAkM3rclv93FBt
X-Google-Smtp-Source: AFSGD/VSOgjpf8VKuTnshKY5khUrCtR7tomJJykNgo+N0UgEcBwY9fajEaZj6fVd2oN0gfqvBz2rJQ==
X-Received: by 2002:aa7:8286:: with SMTP id s6mr19997794pfm.63.1545834154560;
        Wed, 26 Dec 2018 06:22:34 -0800 (PST)
Received: from localhost.localdomain ([2402:f000:1:4414:a8df:74f3:1213:8d3d])
        by smtp.gmail.com with ESMTPSA id e65sm66348298pfc.74.2018.12.26.06.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 06:22:33 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     m.grzeschik@pengutronix.de, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: arcnet: Fix a possible concurrency use-after-free bug in arcnet_reply_tasklet()
Date:   Wed, 26 Dec 2018 22:22:26 +0800
Message-Id: <20181226142226.13039-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/net/arcnet/arcnet.c, the functions arcnet_reply_tasklet() and
arcnet_send_packet() may be concurrently executed.

arcnet_reply_tasklet()
  line 430: dev_kfree_skb(lp->outgoing.skb);

arcnet_send_packet()
  line 682: spin_lock_irqsave();
  line 690: lp->outgoing.skb = skb;
  line 691: proto->prepare_tx(..., skb->len, ...)

Thus, a possible concurrency use-after-free bugs may occur.

To fix this bug, the calls to spin_lock_irqsave() and
spin_unlock_irqrestore() are added in arcnet_reply_tasklet() to protect
dev_kfree_skb(lp->outgoing.skb).

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/arcnet/arcnet.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/arcnet/arcnet.c b/drivers/net/arcnet/arcnet.c
index 8459115d9d4e..c5e943d01d66 100644
--- a/drivers/net/arcnet/arcnet.c
+++ b/drivers/net/arcnet/arcnet.c
@@ -426,10 +426,14 @@ static void arcnet_reply_tasklet(unsigned long data)
 	serr->ee.ee_data = skb_shinfo(skb)->tskey;
 	serr->ee.ee_info = lp->reply_status;
 
+	spin_lock_irqsave(&lp->lock, flags);
+
 	/* finally erasing outgoing skb */
 	dev_kfree_skb(lp->outgoing.skb);
 	lp->outgoing.skb = NULL;
 
+	spin_unlock_irqrestore(&lp->lock, flags);
+
 	ackskb->dev = lp->dev;
 
 	ret = sock_queue_err_skb(sk, ackskb);
-- 
2.17.0

