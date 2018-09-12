Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CCEC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F9220866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F9220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeILFUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:20:30 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51526 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbeILFU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:20:29 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 2D6312A7D1; Tue, 11 Sep 2018 20:18:44 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <df79f23f3ccd7261c498bdbe93404b9f2c53a88e.1536709753.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1536709753.git.fthain@telegraphics.com.au>
References: <cover.1536709753.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 3/7] macintosh/via-macii: Synchronous bus reset
Date:   Tue, 11 Sep 2018 20:18:44 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the reset operation synchronous, like the other ADB drivers.
The reset request is static data but callers may not know that.
This way the struct is not in use when the reset method returns.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-macii.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index cf6f7d52d6be..36a4f49e79b5 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -331,7 +331,8 @@ static int macii_reset_bus(void)
 		return 0;
 
 	/* Command = 0, Address = ignored */
-	adb_request(&req, NULL, 0, 1, ADB_BUSRESET);
+	adb_request(&req, NULL, ADBREQ_NOSEND, 1, ADB_BUSRESET);
+	macii_send_request(&req, 1);
 
 	/* Don't want any more requests during the Global Reset low time. */
 	udelay(3000);
-- 
2.16.4

