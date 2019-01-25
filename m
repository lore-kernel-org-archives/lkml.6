Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5667EC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228E3218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6fRiCEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfAYKqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:46:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42154 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAYKqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:46:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so9746985wrx.9;
        Fri, 25 Jan 2019 02:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mQI/+sNPW3cWviJBz4RvXI4WSmKJyJbGpq6y4etWi2Y=;
        b=R6fRiCEuCyQwDdzgt9pkpz7iWPI1TjhhMLsrRoPbonYIHYVWgR6uCRYlvhoM+rbbRT
         M3q/elgkTOO/0brKEt3inLz4VoRCNWhZoErk1fa3VGwAoe+2DkAFFRfl3c1E3MjK/yEC
         LDo7U4brlqh5tErhSwJfU4AYq9Dh3379H5ZKNyoGL/j8WdfV7MCZzfU9iMK+TqymtLJQ
         z4CXIF8OC0absicNccaQdDDbMqM+kwcD5AMIwIi+LBODu1UbppGOpvZZkTm3H+37P39X
         mFKmAoaEnDPiK2zqxzAoaESS8e0F73AuZZ/yeBH/Sh4F+YX0MFDFHQAJ9HUpdu39972q
         nlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mQI/+sNPW3cWviJBz4RvXI4WSmKJyJbGpq6y4etWi2Y=;
        b=rBpV/v51yXr9SYf/xdYgnsb8QD6DO+ym/enfDpeUoaumaBrqzjpDwB9fB8eqwhMSAr
         zO8NqI7AQBruEXFTyfyyRPz4g3NydYqfM05VhqkB9kVD+K+fzPVW/xncin4LMkwZJ33b
         6A6cItpw9G0gSWcRFduzCcYy/j4608UWUKuQzEhcApIhycof5pkbZR8RRKl2sGPCGGor
         fkQOLOYjOpmfBbM3Vk8GaIichdIXmk2+uA7k4SpOzDFqaJ1CrCktr+r7xad91vCvDF4X
         fjYlQP8bRuZU9TfedfOtn2o6CtrCoyFmYkfiVE+TAf8smWciwn3hotgbZ1bRZkoOOy4m
         Wbsw==
X-Gm-Message-State: AJcUukeYKzyI0UHVOga2/aDrImUJRryxGGXpLmt6eLTB7hOuKbgltZnB
        7lp04RWFCAFD3ovLh5/0Jbw=
X-Google-Smtp-Source: ALg8bN6LMdzwpe4WRzfoFT6cXa7L1JSSqHHjR0OtlNBhKSvY8PVLjps72JiBCwMBu+wMT9NR5PLaqA==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr10629625wrv.116.1548413203577;
        Fri, 25 Jan 2019 02:46:43 -0800 (PST)
Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:15:13:4c1a:d2d1:436c:979b])
        by smtp.gmail.com with ESMTPSA id 143sm135792993wml.14.2019.01.25.02.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 02:46:42 -0800 (PST)
From:   Dmitry Vyukov <dvyukov@gmail.com>
To:     f6bvp@free.fr, davem@davemloft.net, linux-hams@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot+1a2c456a1ea08fa5b5f7@syzkaller.appspotmail.com,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net/rose: fix NULL ax25_cb kernel panic
Date:   Fri, 25 Jan 2019 11:46:40 +0100
Message-Id: <20190125104640.253862-1-dvyukov@gmail.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bernard Pidoux <f6bvp@free.fr>

When an internally generated frame is handled by rose_xmit(),
rose_route_frame() is called:

        if (!rose_route_frame(skb, NULL)) {
                dev_kfree_skb(skb);
                stats->tx_errors++;
                return NETDEV_TX_OK;
        }

We have the same code sequence in Net/Rom where an internally generated
frame is handled by nr_xmit() calling nr_route_frame(skb, NULL).
However, in this function NULL argument is tested while it is not in
rose_route_frame().
Then kernel panic occurs later on when calling ax25cmp() with a NULL
ax25_cb argument as reported many times and recently with syzbot.

We need to test if ax25 is NULL before using it.

Testing:
Built kernel with CONFIG_ROSE=y.

Signed-off-by: Bernard Pidoux <f6bvp@free.fr>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: syzbot+1a2c456a1ea08fa5b5f7@syzkaller.appspotmail.com
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Bernard Pidoux <f6bvp@free.fr>
Cc: linux-hams@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 net/rose/rose_route.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/rose/rose_route.c b/net/rose/rose_route.c
index 77e9f85a2c92..f2ff21d7df08 100644
--- a/net/rose/rose_route.c
+++ b/net/rose/rose_route.c
@@ -850,6 +850,7 @@ void rose_link_device_down(struct net_device *dev)
 
 /*
  *	Route a frame to an appropriate AX.25 connection.
+ *	A NULL ax25_cb indicates an internally generated frame.
  */
 int rose_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 {
@@ -867,6 +868,10 @@ int rose_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 
 	if (skb->len < ROSE_MIN_LEN)
 		return res;
+
+	if (!ax25)
+		return rose_loopback_queue(skb, NULL);
+
 	frametype = skb->data[2];
 	lci = ((skb->data[0] << 8) & 0xF00) + ((skb->data[1] << 0) & 0x0FF);
 	if (frametype == ROSE_CALL_REQUEST &&
-- 
2.20.1.495.gaa96b0ce6b-goog

