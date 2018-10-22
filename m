Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50236C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CED2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CED2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysgo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeJVWHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 18:07:31 -0400
Received: from mail.sysgo.com ([176.9.12.79]:56058 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbeJVWHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 18:07:30 -0400
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Oct 2018 18:07:30 EDT
From:   David Engraf <david.engraf@sysgo.com>
To:     linux@dominikbrodowski.net, akpm@linux-foundation.org,
        pombredanne@nexb.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        luc.vanoostenryck@gmail.com
Cc:     linux-kernel@vger.kernel.org, David Engraf <david.engraf@sysgo.com>
Subject: [PATCH] initramfs: cleanup incomplete rootfs
Date:   Mon, 22 Oct 2018 15:40:48 +0200
Message-Id: <20181022134048.19693-1-david.engraf@sysgo.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unpacking an external initrd may fail e.g. not enough memory. This leads
to an incomplete rootfs because some files might be extracted already.
Fixed by cleaning the rootfs so the kernel is not using an incomplete
rootfs.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 init/initramfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 640557788026..aa3a46cfcb4e 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -548,7 +548,6 @@ static void __init free_initrd(void)
 	initrd_end = 0;
 }
 
-#ifdef CONFIG_BLK_DEV_RAM
 #define BUF_SIZE 1024
 static void __init clean_rootfs(void)
 {
@@ -595,7 +594,6 @@ static void __init clean_rootfs(void)
 	ksys_close(fd);
 	kfree(buf);
 }
-#endif
 
 static int __init populate_rootfs(void)
 {
@@ -638,8 +636,10 @@ static int __init populate_rootfs(void)
 		printk(KERN_INFO "Unpacking initramfs...\n");
 		err = unpack_to_rootfs((char *)initrd_start,
 			initrd_end - initrd_start);
-		if (err)
+		if (err) {
 			printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
+			clean_rootfs();
+		}
 		free_initrd();
 #endif
 	}
-- 
2.17.1

