Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC8BECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D97208D9
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D97208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392383AbeIVGQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:16:07 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44138 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391926AbeIVGKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:45 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdv-0008Bc-Bo; Sat, 22 Sep 2018 01:19:27 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdo-0000tY-Pr; Sat, 22 Sep 2018 01:19:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Kees Cook" <keescook@chromium.org>,
        "Dr Silvio Cesare of InfoSect" <silvio.cesare@gmail.com>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.239067717@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 48/63] video: uvesafb: Fix integer overflow in allocation
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 9f645bcc566a1e9f921bdae7528a01ced5bc3713 upstream.

cmap->len can get close to INT_MAX/2, allowing for an integer overflow in
allocation. This uses kmalloc_array() instead to catch the condition.

Reported-by: Dr Silvio Cesare of InfoSect <silvio.cesare@gmail.com>
Fixes: 8bdb3a2d7df48 ("uvesafb: the driver core")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/fbdev/uvesafb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1059,7 +1059,8 @@ static int uvesafb_setcmap(struct fb_cma
 		    info->cmap.len || cmap->start < info->cmap.start)
 			return -EINVAL;
 
-		entries = kmalloc(sizeof(*entries) * cmap->len, GFP_KERNEL);
+		entries = kmalloc_array(cmap->len, sizeof(*entries),
+					GFP_KERNEL);
 		if (!entries)
 			return -ENOMEM;
 

