Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D854C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38461218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358024;
	bh=kCVIncFlZ5IpvsY0PR9TEQ+x0u0dPrOizGlIg4v8FEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tKTjmmAg/b8DKZVMDYCwGS/WmdBluLsqru7TtrcuAaCZXWxjzaonIHMs2Wpr99HuP
	 IAu0sg/JqGLtY8mweEshPwh9mMg0/cGeU1n0s11bRRtxRJL++Es1OxBDlpZxAoRUwd
	 Bc6y9m+VsKN6kyQJ2jIQ5nE4LgG9mbgoMfE+bfs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbfAXT1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:27:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:53146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729218AbfAXT1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:27:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C7C2218FC;
        Thu, 24 Jan 2019 19:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358019;
        bh=kCVIncFlZ5IpvsY0PR9TEQ+x0u0dPrOizGlIg4v8FEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FmZcs3sFwIP+SwLO/XIC85a34ipcEKVcoWIBfM2Vm281RKxH49WXGU/aH0HgroAG8
         gjqqlKnso2aRnCvqpz1iZ7VkSLAqSoQ2thmxgNlSeC6DDCEjD99f15NYuLC2Y9+bH1
         QycC8Tkd6Ubk/qzqRm/rft9sTFO7qBX6muhTinHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.4 068/104] loop: Fold __loop_release into loop_release
Date:   Thu, 24 Jan 2019 20:19:57 +0100
Message-Id: <20190124190203.062416837@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 967d1dc144b50ad005e5eecdfadfbcfb399ffff6 upstream.

__loop_release() has a single call site. Fold it there. This is
currently not a huge win but it will make following replacement of
loop_index_mutex more obvious.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1586,12 +1586,15 @@ out:
 	return err;
 }
 
-static void __lo_release(struct loop_device *lo)
+static void lo_release(struct gendisk *disk, fmode_t mode)
 {
+	struct loop_device *lo;
 	int err;
 
+	mutex_lock(&loop_index_mutex);
+	lo = disk->private_data;
 	if (atomic_dec_return(&lo->lo_refcnt))
-		return;
+		goto unlock_index;
 
 	mutex_lock(&loop_ctl_mutex);
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
@@ -1601,7 +1604,7 @@ static void __lo_release(struct loop_dev
 		 */
 		err = loop_clr_fd(lo);
 		if (!err)
-			return;
+			goto unlock_index;
 	} else {
 		/*
 		 * Otherwise keep thread (if running) and config,
@@ -1611,12 +1614,7 @@ static void __lo_release(struct loop_dev
 	}
 
 	mutex_unlock(&loop_ctl_mutex);
-}
-
-static void lo_release(struct gendisk *disk, fmode_t mode)
-{
-	mutex_lock(&loop_index_mutex);
-	__lo_release(disk->private_data);
+unlock_index:
 	mutex_unlock(&loop_index_mutex);
 }
 


