Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F32DC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68B0208B3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68B0208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388798AbeG0RNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:13:31 -0400
Received: from bran.ispras.ru ([83.149.199.196]:16116 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388568AbeG0RNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:13:31 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id 5166D203B2;
        Fri, 27 Jul 2018 18:50:57 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Wolfgang Grandegger <wg@grandegger.com>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Martin Kelly <mkelly@xevo.com>,
        Martin Lederhilger <m.lederhilger@ds-automotion.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] can: ems_usb: Fix memory leak on ems_usb_disconnect
Date:   Fri, 27 Jul 2018 18:50:42 +0300
Message-Id: <20180727155042.24582-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ems_usb_probe() allocates memory for dev->tx_msg_buffer, but there
is no its deallocation in ems_usb_disconnect.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/net/can/usb/ems_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 12ff0020ecd6..b7dfd4109d24 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -1072,6 +1072,7 @@ static void ems_usb_disconnect(struct usb_interface *intf)
 		usb_free_urb(dev->intr_urb);
 
 		kfree(dev->intr_in_buffer);
+		kfree(dev->tx_msg_buffer);
 	}
 }
 
-- 
2.18.0

