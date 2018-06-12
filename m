Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 596AAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9440208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9440208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owl.eu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934921AbeFLBMJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 21:12:09 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36049 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933569AbeFLBMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 21:12:08 -0400
X-Originating-IP: 70.80.172.8
Received: from localhost (modemcable008.172-80-70.mc.videotron.ca [70.80.172.8])
        (Authenticated sender: hle@owl.eu.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 1F24EE0006;
        Tue, 12 Jun 2018 01:12:02 +0000 (UTC)
Date:   Mon, 11 Jun 2018 21:12:00 -0400
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Subject: [PATCH] staging: pi433: add mutex fixing race condition when
 accessing tx_cfg
Message-ID: <20180612011200.GB1794@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the PI433_IOC_WR_TX_CFG case in pi433_ioctl, instance->tx_cfg is
modified using

copy_from_user(&instance->tx_cfg, argp, sizeof(struct pi433_tx_cfg)))

without any kind of synchronization. In the case where two threads
would execute this same command concurrently the tx_cfg field might
enter in an inconsistent state.

Add a mutex making sure that the PI433_IOC_WR_TX_CFG case will never
be run by several threads concurrently.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
 drivers/staging/pi433/pi433_if.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index d1e0ddbc79ce..94c9d5482f44 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -115,6 +115,7 @@ struct pi433_device {
 
 struct pi433_instance {
 	struct pi433_device	*device;
+	struct mutex		tx_cfg_lock; /* guards race conditions when updating tx config */
 	struct pi433_tx_cfg	tx_cfg;
 };
 
@@ -889,9 +890,13 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			return -EFAULT;
 		break;
 	case PI433_IOC_WR_TX_CFG:
+		mutex_lock(&instance->tx_cfg_lock);
 		if (copy_from_user(&instance->tx_cfg, argp,
-				   sizeof(struct pi433_tx_cfg)))
+				   sizeof(struct pi433_tx_cfg))) {
+			mutex_unlock(&instance->tx_cfg_lock);
 			return -EFAULT;
+		}
+		mutex_unlock(&instance->tx_cfg_lock);
 		break;
 	case PI433_IOC_RD_RX_CFG:
 		if (copy_to_user(argp, &device->rx_cfg,
@@ -966,6 +971,8 @@ static int pi433_open(struct inode *inode, struct file *filp)
 	instance->tx_cfg.bit_rate = 4711;
 	// TODO: fill instance->tx_cfg;
 
+	mutex_init(&instance->tx_cfg_lock);
+
 	/* instance data as context */
 	filp->private_data = instance;
 	nonseekable_open(inode, filp);
-- 
2.17.1
