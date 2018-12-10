Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17A2C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3DD2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3DD2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeLJRNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:13:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54125 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727356AbeLJRNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:33 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A2823154848;
        Mon, 10 Dec 2018 17:13:33 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72AC9600D6;
        Mon, 10 Dec 2018 17:13:30 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 0F31A223BB9; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 03/52] fuse: rely on mutex_unlock() barrier instead of fput()
Date:   Mon, 10 Dec 2018 12:12:29 -0500
Message-Id: <20181210171318.16998-4-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 10 Dec 2018 17:13:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

fput() will be moved out of this function in a later patch, so we cannot
rely on it as the memory barrier for ensuring file->private_data = fud
is visible.

Luckily there is a mutex_unlock() right before fput() which provides the
same effect.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 0b94b23b02d4..d08cd8bf7705 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1198,12 +1198,11 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	list_add_tail(&fc->entry, &fuse_conn_list);
 	sb->s_root = root_dentry;
 	file->private_data = fud;
-	mutex_unlock(&fuse_mutex);
 	/*
-	 * atomic_dec_and_test() in fput() provides the necessary
-	 * memory barrier for file->private_data to be visible on all
-	 * CPUs after this
+	 * mutex_unlock() provides the necessary memory barrier for
+	 * file->private_data to be visible on all CPUs after this
 	 */
+	mutex_unlock(&fuse_mutex);
 	fput(file);
 
 	fuse_send_init(fc, init_req);
-- 
2.13.6

