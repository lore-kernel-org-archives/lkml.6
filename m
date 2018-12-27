Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13472C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D102221741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJsMPaNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbeL0CBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 21:01:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44648 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeL0CBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 21:01:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so8477388pfh.11;
        Wed, 26 Dec 2018 18:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2hLP0bIbGgAKMIlM16dWI6+N/9EXK5WvBD9KloAL1A4=;
        b=VJsMPaNAyNFTKSwDKBIFcb3bfQIWJHT7mCTQ+xeBdhSzFrfE821NO9M4Rt8TjcJILZ
         YWlhNruTjIo04Lbpz0vUmOiHWVPfwnrTXwBco4jn0uUW7fzm9e2/qwALyI5zwiThb01c
         pHSDr3XptWS/kgEn4mKp11Ztn5Uf9IysNbRLqbWbLSFcsAAL1SnDD59Bb+hhhWxTEk2S
         vjL2nIU7d6jDiCK4HKlLEQoTxUfxZ6OOw5wcTDdCbRmo3YHau5DAzQWOOS2/ZKtG8mHs
         5stcrwptkJ8sCDvqeFZi2wWelv0lBvPOmr5gpbK9dipJYCAxY/PX/MqgsVewUHr7oiez
         Dr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2hLP0bIbGgAKMIlM16dWI6+N/9EXK5WvBD9KloAL1A4=;
        b=LPGeIW4YRP6eaZjzCyV4v7XGwHrPVqEin7tkDCNw9J8a4LdWvjQts9VNzCVjBysf09
         3onKI+aOVf1OBPFkWuxEBQ2IziwtGwWtNWAl06Nv932JfebsIAs6yRSUCEsBrXJc9Ii7
         u/H7Li/lpaJLcdncxgGp/ARDdJ4iBOFq3IEZcnfTamHYwydjzLO1SB8+tn7U+q7vu81x
         1KiyiXCB+/7XIC9JP5AMINzunVbNFX5xXBHXLjhhBRrwrVDaNABTVzIWEofZKqww24lV
         lL1nHgIy6i5EEsDLy8ets4Zol0VaBS2Vx1bqI9/vZFL8cZdTBCGvEF+Y0BcAo9DbCC1M
         twVg==
X-Gm-Message-State: AA+aEWbhq1S9j5KMICnRwQq+V9PvUqirU4Lx/Ji9VCrVkdgILb3Tvw/w
        zeqCZeixTu8crMKs3gkMoy0=
X-Google-Smtp-Source: AFSGD/X2rgkbhWk1MXIWow15lhHoJzr+X6jIc52BA3iM0/T1lYrjiq+cMT+cvJDSigdcNwh/HVfUJw==
X-Received: by 2002:a62:9fd9:: with SMTP id v86mr22176469pfk.191.1545876109309;
        Wed, 26 Dec 2018 18:01:49 -0800 (PST)
Received: from localhost.localdomain ([2402:f000:1:4414:dd5d:2433:dd9b:37a2])
        by smtp.gmail.com with ESMTPSA id u8sm53957792pfl.16.2018.12.26.18.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 18:01:48 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     m.grzeschik@pengutronix.de, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] net: arcnet: Fix a possible concurrency use-after-free bug in arcnet_reply_tasklet()
Date:   Thu, 27 Dec 2018 10:01:42 +0800
Message-Id: <20181227020142.18190-1-baijiaju1990@gmail.com>
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
v2:
* Add the definition of flags to fix the compilation error.
---
 drivers/net/arcnet/arcnet.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/arcnet/arcnet.c b/drivers/net/arcnet/arcnet.c
index 8459115d9d4e..1e1b12650964 100644
--- a/drivers/net/arcnet/arcnet.c
+++ b/drivers/net/arcnet/arcnet.c
@@ -401,6 +401,7 @@ static void arcnet_reply_tasklet(unsigned long data)
 	struct sock_exterr_skb *serr;
 	struct sock *sk;
 	int ret;
+	unsigned long flags;
 
 	local_irq_disable();
 	skb = lp->outgoing.skb;
@@ -426,10 +427,14 @@ static void arcnet_reply_tasklet(unsigned long data)
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

