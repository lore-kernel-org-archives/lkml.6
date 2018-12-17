Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB4BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A955214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeLQVyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:54:44 -0500
Received: from gateway34.websitewelcome.com ([192.185.149.222]:24400 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727289AbeLQVyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:54:43 -0500
X-Greylist: delayed 1206 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Dec 2018 16:54:43 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id D9D8A1F31C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 15:34:36 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Z0X6gpzZz90onZ0X6gOPeA; Mon, 17 Dec 2018 15:34:36 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=48868 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gZ0X1-004EAc-PV; Mon, 17 Dec 2018 15:34:36 -0600
Date:   Mon, 17 Dec 2018 15:34:30 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] gpiolib: Fix potential Spectre v1 vulnerabilities
Message-ID: <20181217213430.GA28450@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gZ0X1-004EAc-PV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.106.44]:48868
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

offset and lineinfo.line_offset are indirectly controlled by user-space,
hence leading to a potential exploitation of the Spectre variant 1
vulnerability.

This issue was detected with the help of Smatch:

drivers/gpio/gpiolib.c:580 linehandle_create() warn: potential spectre issue 'gdev->descs' [r] (local cap)
drivers/gpio/gpiolib.c:927 lineevent_create() warn: potential spectre issue 'gdev->descs' [r] (local cap)
drivers/gpio/gpiolib.c:1053 gpio_ioctl() warn: potential spectre issue 'gdev->descs' [r] (local cap)

Fix this by sanitizing both offset and lineinfo.line_offset before
using them to index gdev->descs.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpio/gpiolib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index fc36dc358716..73a0a550162e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -29,6 +29,8 @@
 #include <linux/timekeeping.h>
 #include <uapi/linux/gpio.h>
 
+#include <linux/nospec.h>
+
 #include "gpiolib.h"
 
 #define CREATE_TRACE_POINTS
@@ -576,6 +578,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 			ret = -EINVAL;
 			goto out_free_descs;
 		}
+		offset = array_index_nospec(offset, gdev->ngpio);
 
 		desc = &gdev->descs[offset];
 		ret = gpiod_request(desc, lh->label);
@@ -910,6 +913,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 		ret = -EINVAL;
 		goto out_free_label;
 	}
+	offset = array_index_nospec(offset, gdev->ngpio);
 
 	/* Return an error if a unknown flag is set */
 	if ((lflags & ~GPIOHANDLE_REQUEST_VALID_FLAGS) ||
@@ -1049,6 +1053,8 @@ static long gpio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			return -EFAULT;
 		if (lineinfo.line_offset >= gdev->ngpio)
 			return -EINVAL;
+		lineinfo.line_offset = array_index_nospec(lineinfo.line_offset,
+							  gdev->ngpio);
 
 		desc = &gdev->descs[lineinfo.line_offset];
 		if (desc->name) {
-- 
2.19.2

