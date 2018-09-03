Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCA8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60C420868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60C420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeICVND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:13:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36450 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbeICVNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:13:02 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5CD6CCF3;
        Mon,  3 Sep 2018 16:52:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH 3.18 45/56] udl-kms: change down_interruptible to down
Date:   Mon,  3 Sep 2018 18:49:35 +0200
Message-Id: <20180903164926.303543364@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
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

From: Mikulas Patocka <mpatocka@redhat.com>

commit 8456b99c16d193c4c3b7df305cf431e027f0189c upstream.

If we leave urbs around, it causes not only leak, but also memory
corruption. This patch fixes the function udl_free_urb_list, so that it
always waits for all urbs that are in progress.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/udl/udl_main.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -141,18 +141,13 @@ static void udl_free_urb_list(struct drm
 	struct list_head *node;
 	struct urb_node *unode;
 	struct urb *urb;
-	int ret;
 	unsigned long flags;
 
 	DRM_DEBUG("Waiting for completes and freeing all render urbs\n");
 
 	/* keep waiting and freeing, until we've got 'em all */
 	while (count--) {
-
-		/* Getting interrupted means a leak, but ok at shutdown*/
-		ret = down_interruptible(&udl->urbs.limit_sem);
-		if (ret)
-			break;
+		down(&udl->urbs.limit_sem);
 
 		spin_lock_irqsave(&udl->urbs.lock, flags);
 


