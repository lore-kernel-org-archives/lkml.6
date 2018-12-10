Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD53C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6352A2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6352A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbeLJRPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:15:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728471AbeLJRNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:38 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64BE6804E3;
        Mon, 10 Dec 2018 17:13:38 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18420101962A;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A6FB7224275; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 41/52] fuse: Reschedule dax free work if too many EAGAIN attempts
Date:   Mon, 10 Dec 2018 12:13:07 -0500
Message-Id: <20181210171318.16998-42-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 10 Dec 2018 17:13:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fuse_dax_free_memory() can be very cpu intensive in corner cases. For example,
if one inode has consumed all the memory and a setupmapping request is
pending, that means inode lock is held by request and worker thread will
not get lock for a while. And given there is only one inode consuming all
the dax ranges, all the attempts to acquire lock will fail.

So if there are too many inode lock failures (-EAGAIN), reschedule the
worker with a 10ms delay.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index dbe3410a94d7..709747458335 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3909,7 +3909,7 @@ int fuse_dax_free_one_mapping(struct fuse_conn *fc, struct inode *inode,
 int fuse_dax_free_memory(struct fuse_conn *fc, unsigned long nr_to_free)
 {
 	struct fuse_dax_mapping *dmap, *pos, *temp;
-	int ret, nr_freed = 0;
+	int ret, nr_freed = 0, nr_eagain = 0;
 	u64 dmap_start = 0, window_offset = 0;
 	struct inode *inode = NULL;
 
@@ -3918,6 +3918,12 @@ int fuse_dax_free_memory(struct fuse_conn *fc, unsigned long nr_to_free)
 		if (nr_freed >= nr_to_free)
 			break;
 
+		if (nr_eagain > 20) {
+			queue_delayed_work(system_long_wq, &fc->dax_free_work,
+						msecs_to_jiffies(10));
+			return 0;
+		}
+
 		dmap = NULL;
 		spin_lock(&fc->lock);
 
@@ -3955,8 +3961,10 @@ int fuse_dax_free_memory(struct fuse_conn *fc, unsigned long nr_to_free)
 		}
 
 		/* Could not get inode lock. Try next element */
-		if (ret == -EAGAIN)
+		if (ret == -EAGAIN) {
+			nr_eagain++;
 			continue;
+		}
 		nr_freed++;
 	}
 	return 0;
-- 
2.13.6

