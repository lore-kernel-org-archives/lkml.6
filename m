Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96435C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142D1208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142D1208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owl.eu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754524AbeFRCYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 22:24:11 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:48695 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754440AbeFRCYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 22:24:10 -0400
Received: from localhost (modemcable008.172-80-70.mc.videotron.ca [70.80.172.8])
        (Authenticated sender: hle@owl.eu.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 354D5200004;
        Mon, 18 Jun 2018 02:24:06 +0000 (UTC)
Date:   Sun, 17 Jun 2018 22:24:00 -0400
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Marcus Wolf <linux@wolf-entwicklungen.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: fix race condition in pi433_open
Message-ID: <20180618022400.GA1893@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever pi433_open and pi433_remove execute concurrently, a race
condition potentially resulting in use-after-free might happen.

Let T1 and T2 be two kernel threads.

1. T1 executes pi433_open and stops before "device->users++".
2. The pi433 device was removed inbetween, so T2 executes pi433_remove
   and frees device because the user count has not been incremented yet.
3. T1 executes "device->users++" (use-after-free).

This race condition happens because the check of minor number and
user count increment does not happen atomically.

Fix: Extend scope of minor_lock in pi433_open().

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
 drivers/staging/pi433/pi433_if.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 94e0bfcec991..73c511249f7f 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -957,11 +957,13 @@ static int pi433_open(struct inode *inode, struct file *filp)
 
 	mutex_lock(&minor_lock);
 	device = idr_find(&pi433_idr, iminor(inode));
-	mutex_unlock(&minor_lock);
 	if (!device) {
+		mutex_unlock(&minor_lock);
 		pr_debug("device: minor %d unknown.\n", iminor(inode));
 		return -ENODEV;
 	}
+	device->users++;
+	mutex_unlock(&minor_lock);
 
 	if (!device->rx_buffer) {
 		device->rx_buffer = kmalloc(MAX_MSG_SIZE, GFP_KERNEL);
@@ -969,7 +971,6 @@ static int pi433_open(struct inode *inode, struct file *filp)
 			return -ENOMEM;
 	}
 
-	device->users++;
 	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
 	if (!instance) {
 		kfree(device->rx_buffer);
-- 
2.17.1
