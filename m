Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FC6C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0DC206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0DC206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbeJBUNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:13:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33316 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbeJBUNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:18 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0EACEC11;
        Tue,  2 Oct 2018 13:29:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugo Lefeuvre <hle@owl.eu.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 120/228] staging: pi433: fix race condition in pi433_ioctl
Date:   Tue,  2 Oct 2018 06:23:37 -0700
Message-Id: <20181002132507.547176454@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hugo Lefeuvre <hle@owl.eu.com>

[ Upstream commit 6de4ef65a8c6f53ce7eef06666410bc3b6e4b624 ]

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
of copied data and simpler code.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/pi433/pi433_if.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -880,6 +880,7 @@ pi433_ioctl(struct file *filp, unsigned
 	int			retval = 0;
 	struct pi433_instance	*instance;
 	struct pi433_device	*device;
+	struct pi433_tx_cfg	tx_cfg;
 	void __user *argp = (void __user *)arg;
 
 	/* Check type and command number */
@@ -902,9 +903,11 @@ pi433_ioctl(struct file *filp, unsigned
 			return -EFAULT;
 		break;
 	case PI433_IOC_WR_TX_CFG:
-		if (copy_from_user(&instance->tx_cfg, argp,
-				   sizeof(struct pi433_tx_cfg)))
+		if (copy_from_user(&tx_cfg, argp, sizeof(struct pi433_tx_cfg)))
 			return -EFAULT;
+		mutex_lock(&device->tx_fifo_lock);
+		memcpy(&instance->tx_cfg, &tx_cfg, sizeof(struct pi433_tx_cfg));
+		mutex_unlock(&device->tx_fifo_lock);
 		break;
 	case PI433_IOC_RD_RX_CFG:
 		if (copy_to_user(argp, &device->rx_cfg,


