Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B008AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7513320864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7513320864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968293AbeFRIlv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:41:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:60364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968197AbeFRIiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:38:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B962EAE5D;
        Mon, 18 Jun 2018 08:38:13 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shankarapailoor@gmail.com, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] jfs: Fix buffer overrun in ea_get
Date:   Mon, 18 Jun 2018 11:38:11 +0300
Message-Id: <1529311091-8307-1-git-send-email-nborisov@suse.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ea_buf->xattr buffer is allocated with min(min_size, ea_size).
This is wrong since after the xattr buffer is allocated the ->max_size
variable is actually rounded up to th next ->s_blocksize size. Fix this
by using the rounded up max_size as input to the malloc.

Suggested-by: Shankara Pailoor <shankarapailoor@gmail.com>
Reported-by: Shankara Pailoor <shankarapailoor@gmail.com>
CC: shankarapailoor@gmail.com
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
Hello David, 

I'm sending you the patch for the issue which was originally reported and 
suggested by Shankar.  I won't usually got and override the original 
author of a patch but given the clear lack of experience with upstream (missing 
SOB line, no changelog explaining the change etc) and the 
fact there is already a CVE for this issue (using syzkaller for quick CVE 
generation seems to be all the rage these days, go figure...) I'd rather have 
an upstream, backportable version sooner rather than later. 

 fs/jfs/xattr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index c60f3d32ee91..96b9355ff69a 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -493,14 +493,14 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
 		 * To keep the rest of the code simple.  Allocate a
 		 * contiguous buffer to work with
 		 */
-		ea_buf->xattr = kmalloc(size, GFP_KERNEL);
-		if (ea_buf->xattr == NULL)
-			return -ENOMEM;
-
 		ea_buf->flag = EA_MALLOC;
 		ea_buf->max_size = (size + sb->s_blocksize - 1) &
 		    ~(sb->s_blocksize - 1);
 
+		ea_buf->xattr = kmalloc(ea_buf->max_size, GFP_KERNEL);
+		if (ea_buf->xattr == NULL)
+			return -ENOMEM;
+
 		if (ea_size == 0)
 			return 0;
 
-- 
2.7.4

