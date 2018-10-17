Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A13FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A462152C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A462152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeJQOXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:23:20 -0400
Received: from out04.smtpout.orange.fr ([193.252.22.213]:23783 "EHLO
        out.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbeJQOXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:23:20 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Oct 2018 10:23:19 EDT
Received: from localhost.localdomain ([77.136.80.135])
        by mwinf5d67 with ME
        id oWMe1y00V2vABet03WMetB; Wed, 17 Oct 2018 08:21:39 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 17 Oct 2018 08:21:39 +0200
X-ME-IP: 77.136.80.135
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] xfs: Fix error code in 'xfs_ioc_getbmap()'
Date:   Wed, 17 Oct 2018 08:21:38 +0200
Message-Id: <20181017062138.1721-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this function, once 'buf' has been allocated, we unconditionally
return 0.
However, 'error' is set to some error codes in several error handling
paths.
Before commit 232b51948b99 ("xfs: simplify the xfs_getbmap interface")
this was not an issue because all error paths were returning directly,
but now that some cleanup at the end may be needed, we must propagate the
error code.

Fixes: 232b51948b99 ("xfs: simplify the xfs_getbmap interface")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/xfs/xfs_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 0ef5ece5634c..bad90479ade2 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1616,7 +1616,7 @@ xfs_ioc_getbmap(
 	error = 0;
 out_free_buf:
 	kmem_free(buf);
-	return 0;
+	return error;
 }
 
 struct getfsmap_info {
-- 
2.17.1

