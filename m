Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BB8C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B30E2506A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B30E2506A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753159AbeGAQOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:14:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60366 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932811AbeGAQOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:14:33 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 666C94A3;
        Sun,  1 Jul 2018 16:14:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dr Silvio Cesare of InfoSect <silvio.cesare@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 3.18 81/85] video: uvesafb: Fix integer overflow in allocation
Date:   Sun,  1 Jul 2018 18:02:39 +0200
Message-Id: <20180701153125.591292918@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153122.365061142@linuxfoundation.org>
References: <20180701153122.365061142@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 9f645bcc566a1e9f921bdae7528a01ced5bc3713 upstream.

cmap->len can get close to INT_MAX/2, allowing for an integer overflow in
allocation. This uses kmalloc_array() instead to catch the condition.

Reported-by: Dr Silvio Cesare of InfoSect <silvio.cesare@gmail.com>
Fixes: 8bdb3a2d7df48 ("uvesafb: the driver core")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/uvesafb.c |    3 ++-
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
 


