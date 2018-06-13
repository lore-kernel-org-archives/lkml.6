Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7B3AAC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3921020660
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3921020660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owl.eu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934364AbeFMBrv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:47:51 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53973 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932985AbeFMBrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:47:51 -0400
X-Originating-IP: 70.80.172.8
Received: from localhost (modemcable008.172-80-70.mc.videotron.ca [70.80.172.8])
        (Authenticated sender: hle@owl.eu.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id BDDB460014;
        Wed, 13 Jun 2018 01:47:45 +0000 (UTC)
Date:   Tue, 12 Jun 2018 21:47:41 -0400
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Marcus Wolf <linux@wolf-entwicklungen.de>
Subject: [PATCH v2] staging: pi433: fix race condition in pi433_ioctl
Message-ID: <20180613014741.GC2265@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the PI433_IOC_WR_TX_CFG case in pi433_ioctl, instance->tx_cfg is
modified via

copy_from_user(&instance->tx_cfg, argp, sizeof(struct pi433_tx_cfg)))

without any kind of synchronization. In the case where two threads
would execute this same command concurrently the tx_cfg field might
enter in an inconsistent state.

Additionally: if ioctl(PI433_IOC_WR_TX_CFG) and write() execute
concurrently the tx config might be modified while it is being
copied to the fifo, resulting in potential data corruption.

Fix: Get instance->tx_cfg_lock before modifying tx config in the
PI433_IOC_WR_TX_CFG case in pi433_ioctl.

Also, do not copy data directly from user space to instance->tx_cfg.
Instead use a temporary buffer allowing future checks for correctness
of copied data.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
Changes in v2:
    - Use device->tx_fifo_lock instead of introducing a new lock in
      instance.
    - Do not copy data directly from user space to instance->tx_cfg,
      instead use a temporary buffer allowing future checks for
      correctness of copied data.
---
 drivers/staging/pi433/pi433_if.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index b061f77dda41..3ec1ed01d04b 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -880,6 +880,7 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	int			retval = 0;
 	struct pi433_instance	*instance;
 	struct pi433_device	*device;
+	struct pi433_tx_cfg	tx_cfg_buffer;
 	void __user *argp = (void __user *)arg;
 
 	/* Check type and command number */
@@ -902,9 +903,15 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			return -EFAULT;
 		break;
 	case PI433_IOC_WR_TX_CFG:
-		if (copy_from_user(&instance->tx_cfg, argp,
-				   sizeof(struct pi433_tx_cfg)))
+		/* do not modify tx config while it is being copied to fifo */
+		mutex_lock(&device->tx_fifo_lock);
+		if (copy_from_user(&tx_cfg_buffer, argp,
+				   sizeof(struct pi433_tx_cfg))) {
+			mutex_unlock(&device->tx_fifo_lock);
 			return -EFAULT;
+		}
+		memcpy(&instance->tx_cfg, &tx_cfg_buffer, sizeof(struct pi433_tx_cfg));
+		mutex_unlock(&device->tx_fifo_lock);
 		break;
 	case PI433_IOC_RD_RX_CFG:
 		if (copy_to_user(argp, &device->rx_cfg,
-- 
2.17.1
