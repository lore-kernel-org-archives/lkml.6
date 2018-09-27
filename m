Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B396C004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A093214DC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A093214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbeI0QMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:12:41 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:34497 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbeI0QMl (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 27 Sep 2018 12:12:41 -0400
Received: from linux-dvef.suse.de (unknown.telstraglobal.net [134.159.103.118])
        by smtp.nue.novell.com with ESMTP (NOT encrypted); Thu, 27 Sep 2018 11:55:09 +0200
From:   "Cho, Yu-Chen" <acho@suse.com>
To:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, acho@suse.com,
        jlee@suse.com
Subject: [PATCH] btsdio: Do not bind to non-removable BCM43430
Date:   Thu, 27 Sep 2018 17:54:55 +0800
Message-Id: <20180927095455.32247-1-acho@suse.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM43430 devices soldered onto the PCB (non-removable)
use an UART connection for bluetooth.
But also advertise btsdio support on their 3th sdio function.

Signed-off-by: Cho, Yu-Chen <acho@suse.com>
---
 drivers/bluetooth/btsdio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 20142bc77554..84d23d786ce5 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -297,7 +297,8 @@ static int btsdio_probe(struct sdio_func *func,
 	 * uart connection for bluetooth, ignore the BT SDIO interface.
 	 */
 	if (func->vendor == SDIO_VENDOR_ID_BROADCOM &&
-	    func->device == SDIO_DEVICE_ID_BROADCOM_43341 &&
+	    (func->device == SDIO_DEVICE_ID_BROADCOM_43341 ||
+	    func->device == SDIO_DEVICE_ID_BROADCOM_43430) &&
 	    !mmc_card_is_removable(func->card->host))
 		return -ENODEV;
 
-- 
2.18.0

