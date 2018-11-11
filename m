Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C43EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E36B20817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnS4Ipof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E36B20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390013AbeKLJE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:04:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389881AbeKLIVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:45 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CA17208A3;
        Sun, 11 Nov 2018 22:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975508;
        bh=SNPbVXnoz0liD53V6QWZSv32elts4kdqtMZVrI6l/ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lnS4IpofSnO/TFYWq6nw03DQRlJTW8d33KBCUw2zZ3HBC0NzTj4fJlOKs5JsuoPnX
         WlhyXw5a8iq6TQw2VDBko6Y8n2IWYgk8HxfiVBLAVRm8/4ngq8/h893Bovod8Y86Nb
         AcCiGymiiPTV3Ayi0elSYl0xAAdHZYW0VlwkWUyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.18 330/350] btrfs: protect space cache inode alloc with GFP_NOFS
Date:   Sun, 11 Nov 2018 14:23:14 -0800
Message-Id: <20181111221721.893563493@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

commit 84de76a2fb217dc1b6bc2965cc397d1648aa1404 upstream.

If we're allocating a new space cache inode it's likely going to be
under a transaction handle, so we need to use memalloc_nofs_save() in
order to avoid deadlocks, and more importantly lockdep messages that
make xfstests fail.

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/free-space-cache.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -10,6 +10,7 @@
 #include <linux/math64.h>
 #include <linux/ratelimit.h>
 #include <linux/error-injection.h>
+#include <linux/sched/mm.h>
 #include "ctree.h"
 #include "free-space-cache.h"
 #include "transaction.h"
@@ -47,6 +48,7 @@ static struct inode *__lookup_free_space
 	struct btrfs_free_space_header *header;
 	struct extent_buffer *leaf;
 	struct inode *inode = NULL;
+	unsigned nofs_flag;
 	int ret;
 
 	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
@@ -68,7 +70,13 @@ static struct inode *__lookup_free_space
 	btrfs_disk_key_to_cpu(&location, &disk_key);
 	btrfs_release_path(path);
 
+	/*
+	 * We are often under a trans handle at this point, so we need to make
+	 * sure NOFS is set to keep us from deadlocking.
+	 */
+	nofs_flag = memalloc_nofs_save();
 	inode = btrfs_iget(fs_info->sb, &location, root, NULL);
+	memalloc_nofs_restore(nofs_flag);
 	if (IS_ERR(inode))
 		return inode;
 	if (is_bad_inode(inode)) {


