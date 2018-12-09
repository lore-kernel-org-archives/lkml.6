Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC91C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAF120661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAF120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeLIWB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:01:28 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35956 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726678AbeLIVze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:34 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72w-0002ij-VT; Sun, 09 Dec 2018 21:55:31 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72j-0003bm-Bq; Sun, 09 Dec 2018 21:55:17 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Michael Lyle" <mlyle@lyle.org>,
        "Eric Wheeler" <bcache@linux.ewheeler.net>,
        "Jens Axboe" <axboe@kernel.dk>, "Coly Li" <colyli@suse.de>,
        "Liang Chen" <liangchen.linux@gmail.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.974780505@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 267/328] bcache: explicitly destroy mutex while exiting
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Liang Chen <liangchen.linux@gmail.com>

commit 330a4db89d39a6b43f36da16824eaa7a7509d34d upstream.

mutex_destroy does nothing most of time, but it's better to call
it to make the code future proof and it also has some meaning
for like mutex debug.

As Coly pointed out in a previous review, bcache_exit() may not be
able to handle all the references properly if userspace registers
cache and backing devices right before bch_debug_init runs and
bch_debug_init failes later. So not exposing userspace interface
until everything is ready to avoid that issue.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Reviewed-by: Coly Li <colyli@suse.de>
Reviewed-by: Eric Wheeler <bcache@linux.ewheeler.net>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/bcache/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2115,6 +2115,7 @@ static void bcache_exit(void)
 	if (bcache_major)
 		unregister_blkdev(bcache_major, "bcache");
 	unregister_reboot_notifier(&reboot);
+	mutex_destroy(&bch_register_lock);
 }
 
 static int __init bcache_init(void)
@@ -2133,14 +2134,15 @@ static int __init bcache_init(void)
 	bcache_major = register_blkdev(0, "bcache");
 	if (bcache_major < 0) {
 		unregister_reboot_notifier(&reboot);
+		mutex_destroy(&bch_register_lock);
 		return bcache_major;
 	}
 
 	if (!(bcache_wq = alloc_workqueue("bcache", WQ_MEM_RECLAIM, 0)) ||
 	    !(bcache_kobj = kobject_create_and_add("bcache", fs_kobj)) ||
-	    sysfs_create_files(bcache_kobj, files) ||
 	    bch_request_init() ||
-	    bch_debug_init(bcache_kobj))
+	    bch_debug_init(bcache_kobj) ||
+	    sysfs_create_files(bcache_kobj, files))
 		goto err;
 
 	return 0;

