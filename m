Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 42093C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55FC20020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="RLkj8dx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55FC20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935859AbeFMOiT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:38:19 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:33598 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935691AbeFMOiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:38:15 -0400
Received: from fe0vm1650.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0187.rbdmz01.com (Postfix) with ESMTPS id 415TrP52QXz1XLFZG;
        Wed, 13 Jun 2018 16:38:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1528900693;
        bh=xKWvSJAExCFYwQPkF9cpeARYs1KgGM4+MQ0/Lt2hetU=; l=10;
        h=From:From:Reply-To:Sender;
        b=RLkj8dx+dOJ3KDBVIWL0VNQNBYwISv4mQy9d4KwGc8ynMzpKRjtlABy+y4ATL9iWM
         xbLameKnDxnNoSicsHy+5SMefQ3MyrHUkJFfJ/+eeF6eUCaLhE4EIg3NXlRcdjoSAL
         olsBIml6L02CqNXNhk/VX+nMGhiFeGjqsKPGSTAI=
Received: from fe0vm7918.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 415TrP4cx2z1Cb;
        Wed, 13 Jun 2018 16:38:13 +0200 (CEST)
X-AuditID: 0a3aad10-40fff70000000ee7-f3-5b212c637049
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm7918.rbesz01.com (SMG Outbound) with SMTP id C4.7E.03815.36C212B5; Wed, 13 Jun 2018 16:38:27 +0200 (CEST)
Received: from SI-HUB1000.de.bosch.com (si-hub1000.de.bosch.com [10.4.103.106])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 415TrP32Z6zBpBg;
        Wed, 13 Jun 2018 16:38:13 +0200 (CEST)
Received: from luchador.grb-fir.grb.de.bosch.com (10.19.187.97) by
 SI-HUB1000.de.bosch.com (10.4.103.106) with Microsoft SMTP Server id
 14.3.319.2; Wed, 13 Jun 2018 16:38:13 +0200
From:   Mark Jonas <mark.jonas@de.bosch.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hs@denx.de>,
        <yi.zhu5@cn.bosch.com>, <petar.petrovic2@de.bosch.com>,
        <stephan.baetge@de.bosch.com>, <andy.shevchenko@gmail.com>,
        <socketcan@hartkopp.net>, <o.rempel@pengutronix.de>,
        Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH v2 1/5] can: enable multi-queue for SocketCAN devices
Date:   Wed, 13 Jun 2018 16:37:17 +0200
Message-ID: <1528900641-18677-2-git-send-email-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528900641-18677-1-git-send-email-mark.jonas@de.bosch.com>
References: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
 <1528900641-18677-1-git-send-email-mark.jonas@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA22SfUwbdRzG+fWu7bVwelwp+9JZYKfLBugEFXcimpnMrP7DdIvGjRi9rkfb
        jALplWYQX+rmxsacgrDEdQ0jW8gmshkrho6ISHkJxbjsBRSGQ4kVy1tABrbb4vBKYe0f/vf8
        vs/3c8/9njsCo3+UawhziY23lnDFjEyJK/Muap/Y9/iGwuym4Xh2sqYbsZ5ff8PY5uBJjL3R
        7pKxX52tx9m+xmTWP4bY4an7crZp7LJ0m0LX4OzHdZedt+S6v6+PIt2h5R657tN/s3W33amv
        yvYq8w18sdnOW5988R2lqfvipKTMnXKg44ePMAc6rq5GCgKoZ2D5ahuqRkqCpj6XQF9DtSxy
        6EAQOlEnjRzaEJxbWEBhREZlwki/BwvrJOp1OP3nETy8hFHfS2C04/jKkop6GWaDi/KwxqmN
        MOfuWdEktQNu1ZzHItmpMHLl2IpWUDr4tr1hhaWpwwiGet+I7CeC75QfD2uMAugKBLAa9LAz
        xnLGWI1I0ozURXy23bL1uRx2i1XPC5XZOVv2lVrcKNI05UFOn96LKAIxCeSptA2FtJSzCxUW
        L8olJIyaLKhJL6Qf0pcaKkycYHrbWl7MC4yGRHFxcbTqwVgo11vMgmAuLfEiIDAmiSwIiBxp
        4CoqeWtpBPOi9QTOrCM/Nry7l6aMnI3fz/NlvHXNfZ4gGCCFLPEdEq28kT9QZC62rdmMNpKZ
        HOvExkoIhRc9TSSI2YrwI0ihjLMIZuMqnhLB6bVpFB1AWzXryL5MkaHCrqm85EGq5hGysFW8
        iDrGiJJTaASJvanI98OBCeJPHM0D0qNy7aETV4dR6KkmkaFa4qHBs4Sg31OFQ8hRh8OlwBAO
        d2oncOgPtklhcfaeFK63O+VwbOaIAq4dnVPAknM5Huq+6yQhdNJFweC1X1QQcs8kQe1VRzLM
        fNmugcV7fVoY/CmghZ9bB1LB/6EjDfydwTRY+n0pHVzjoXTwdx1k4GzzJ5vANz22GboW5jeD
        b7IxAwKO1gzw1d/NgNtHz2VNiWVKxDJ7e8MfUrBxtv8pc3UavZ3GgSq/rt+5I2kga9C4/eb+
        XP3hK0VV63dNu57FPqsNvmS4dP5G/u6M+Re2ffNa8ojlxNx8oJXuatl4xiS5MP/XH5qhvNnh
        cpnrNDedp51ombDfPbTb+EXK/fELj9m6O28WvKLYPvXBqP3RHsOePON7/7y5qecttDBeNba4
        Kzct/w5tGFcfdDK4YOJyMjGrwP0H4pO/+14EAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhu Yi <yi.zhu5@cn.bosch.com>

The existing SocketCAN implementation provides alloc_candev() to
allocate a CAN device using a single Tx and Rx queue. This can lead to
priority inversion in case the single Tx queue is already full with low
priority messages and a high priority message needs to be sent while the
bus is fully loaded with medium priority messages.

This problem can be solved by using the existing multi-queue support of
the network subsytem. The commit makes it possible to use multi-queue in
the CAN subsystem in the same way it is used in the Ethernet subsystem
by adding an alloc_candev_mqs() call and accompanying macros. With this
support a CAN device can use multi-queue qdisc (e.g. mqprio) to avoid
the aforementioned priority inversion.

The exisiting functionality of alloc_candev() is the same as before.

CAN devices need to have prioritized multiple hardware queues or are
able to abort waiting for arbitration to make sensible use of
multi-queues.

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
Reviewed-by: Heiko Schocher <hs@denx.de>
---
 drivers/net/can/dev.c   | 8 +++++---
 include/linux/can/dev.h | 7 ++++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 365a8cc..ac8270c 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -702,7 +702,8 @@ EXPORT_SYMBOL_GPL(alloc_can_err_skb);
 /*
  * Allocate and setup space for the CAN network device
  */
-struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
+struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
+				    unsigned int txqs, unsigned int rxqs)
 {
 	struct net_device *dev;
 	struct can_priv *priv;
@@ -714,7 +715,8 @@ struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
 	else
 		size = sizeof_priv;
 
-	dev = alloc_netdev(size, "can%d", NET_NAME_UNKNOWN, can_setup);
+	dev = alloc_netdev_mqs(size, "can%d", NET_NAME_UNKNOWN, can_setup,
+			       txqs, rxqs);
 	if (!dev)
 		return NULL;
 
@@ -733,7 +735,7 @@ struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
 
 	return dev;
 }
-EXPORT_SYMBOL_GPL(alloc_candev);
+EXPORT_SYMBOL_GPL(alloc_candev_mqs);
 
 /*
  * Free space of the CAN network device
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 61f1cf2..07b73d2 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -142,7 +142,12 @@ u8 can_dlc2len(u8 can_dlc);
 /* map the sanitized data length to an appropriate data length code */
 u8 can_len2dlc(u8 len);
 
-struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max);
+struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
+				    unsigned int txqs, unsigned int rxqs);
+#define alloc_candev(sizeof_priv, echo_skb_max) \
+	alloc_candev_mqs(sizeof_priv, echo_skb_max, 1, 1)
+#define alloc_candev_mq(sizeof_priv, echo_skb_max, count) \
+	alloc_candev_mqs(sizeof_priv, echo_skb_max, count, count)
 void free_candev(struct net_device *dev);
 
 /* a candev safe wrapper around netdev_priv */
-- 
2.7.4

