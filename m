Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4860C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557C5257FF
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557C5257FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753721AbeGAR7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:59:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34786 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030395AbeGAQaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:30:30 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6C370ACD;
        Sun,  1 Jul 2018 16:30:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chad Austin <chadaustin@fb.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.14 031/157] fuse: atomic_o_trunc should truncate pagecache
Date:   Sun,  1 Jul 2018 18:21:43 +0200
Message-Id: <20180701160853.898767358@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit df0e91d488276086bc07da2e389986cae0048c37 upstream.

Fuse has an "atomic_o_trunc" mode, where userspace filesystem uses the
O_TRUNC flag in the OPEN request to truncate the file atomically with the
open.

In this mode there's no need to send a SETATTR request to userspace after
the open, so fuse_do_setattr() checks this mode and returns.  But this
misses the important step of truncating the pagecache.

Add the missing parts of truncation to the ATTR_OPEN branch.

Reported-by: Chad Austin <chadaustin@fb.com>
Fixes: 6ff958edbf39 ("fuse: add atomic open+truncate support")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/dir.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1629,8 +1629,19 @@ int fuse_do_setattr(struct dentry *dentr
 		return err;
 
 	if (attr->ia_valid & ATTR_OPEN) {
-		if (fc->atomic_o_trunc)
+		/* This is coming from open(..., ... | O_TRUNC); */
+		WARN_ON(!(attr->ia_valid & ATTR_SIZE));
+		WARN_ON(attr->ia_size != 0);
+		if (fc->atomic_o_trunc) {
+			/*
+			 * No need to send request to userspace, since actual
+			 * truncation has already been done by OPEN.  But still
+			 * need to truncate page cache.
+			 */
+			i_size_write(inode, 0);
+			truncate_pagecache(inode, 0);
 			return 0;
+		}
 		file = NULL;
 	}
 


