Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4467BFA3749
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF02216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF02216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jtan.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeIMVw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:52:26 -0400
Received: from jim.sh ([75.150.123.25]:56021 "EHLO psychosis.jim.sh"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbeIMVw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:52:26 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Sep 2018 17:52:25 EDT
Received: from psychosis.jim.sh (localhost [127.0.0.1])
        by psychosis.jim.sh (8.14.4/8.14.4/Debian-8+deb8u2) with ESMTP id w8DGZk3X007408
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 13 Sep 2018 12:35:46 -0400
Received: (from jim@localhost)
        by psychosis.jim.sh (8.14.4/8.14.4/Submit) id w8DGZjv9007407;
        Thu, 13 Sep 2018 12:35:45 -0400
From:   Jim Paris <jim@jtan.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Jim Paris <jim@jtan.com>,
        stable@vger.kernel.org
Subject: [PATCH] gpiolib: fix freeing of descriptors on error
Date:   Thu, 13 Sep 2018 12:35:41 -0400
Message-Id: <20180913163541.7364-1-jim@jtan.com>
X-Mailer: git-send-email 2.15.1
X-Virus-Scanned: clamav-milter 0.99.2 at psychosis
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the main loop in linehandle_create() encounters an error, it
fails to free one of the previously-requested GPIO descriptors.
This renders the unfreed GPIO unusable until reboot, and leaves
its label pointing to free'd kernel memory.

Cc: stable@vger.kernel.org
Fixes: ab3dbcf78f60 ("gpioib: do not free unrequested descriptors")
Signed-off-by: Jim Paris <jim@jtan.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e8f8a1999393..a57300c1d649 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -571,7 +571,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 		if (ret)
 			goto out_free_descs;
 		lh->descs[i] = desc;
-		count = i;
+		count = i + 1;
 
 		if (lflags & GPIOHANDLE_REQUEST_ACTIVE_LOW)
 			set_bit(FLAG_ACTIVE_LOW, &desc->flags);
-- 
2.18.0

