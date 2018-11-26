Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384CEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F294220873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F294220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbeKZU4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:56:37 -0500
Received: from relay.sw.ru ([185.231.240.75]:50490 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbeKZU4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:56:36 -0500
Received: from [10.94.4.83] (helo=finist-ce7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <khorenko@virtuozzo.com>)
        id 1gRDjC-0007LI-F2; Mon, 26 Nov 2018 13:02:54 +0300
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] fbcon: use kvmalloc() for scrollback buffer
Date:   Mon, 26 Nov 2018 13:02:53 +0300
Message-Id: <20181126100253.3299-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scrollback frame buffer is rather big - 32K,
so it requires 3rd order page, so let's use kvmalloc() instead of
ordinary kmalloc() for it.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 drivers/video/fbdev/core/fbcon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 8958ccc8b1ac..2b1a34d3f5e2 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -992,7 +992,7 @@ static const char *fbcon_startup(void)
 			if (!softback_buf) {
 				softback_buf =
 				    (unsigned long)
-				    kmalloc(fbcon_softback_size,
+				    kvmalloc(fbcon_softback_size,
 					    GFP_KERNEL);
 				if (!softback_buf) {
 					fbcon_softback_size = 0;
@@ -1001,7 +1001,7 @@ static const char *fbcon_startup(void)
 			}
 		} else {
 			if (softback_buf) {
-				kfree((void *) softback_buf);
+				kvfree((void *) softback_buf);
 				softback_buf = 0;
 				softback_top = 0;
 			}
@@ -3665,7 +3665,7 @@ static void fbcon_exit(void)
 	}
 #endif
 
-	kfree((void *)softback_buf);
+	kvfree((void *)softback_buf);
 	softback_buf = 0UL;
 
 	for_each_registered_fb(i) {
-- 
2.15.1

