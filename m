Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688DBC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE3E2510F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE3E2510F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965134AbeGAQUk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:20:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33358 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964904AbeGAQUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:20:18 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1491F86A;
        Sun,  1 Jul 2018 16:20:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Martin Townsend <mtownsend1973@gmail.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.4 073/105] ubi: fastmap: Cancel work upon detach
Date:   Sun,  1 Jul 2018 18:02:23 +0200
Message-Id: <20180701153154.733540545@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153149.382300170@linuxfoundation.org>
References: <20180701153149.382300170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit 6e7d80161066c99d12580d1b985cb1408bb58cf1 upstream.

Ben Hutchings pointed out that 29b7a6fa1ec0 ("ubi: fastmap: Don't flush
fastmap work on detach") does not really fix the problem, it just
reduces the risk to hit the race window where fastmap work races against
free()'ing ubi->volumes[].

The correct approach is making sure that no more fastmap work is in
progress before we free ubi data structures.
So we cancel fastmap work right after the ubi background thread is
stopped.
By setting ubi->thread_enabled to zero we make sure that no further work
tries to wake the thread.

Fixes: 29b7a6fa1ec0 ("ubi: fastmap: Don't flush fastmap work on detach")
Fixes: 74cdaf24004a ("UBI: Fastmap: Fix memory leaks while closing the WL sub-system")
Cc: stable@vger.kernel.org
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Martin Townsend <mtownsend1973@gmail.com>

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/ubi/build.c |    3 +++
 drivers/mtd/ubi/wl.c    |    4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1132,6 +1132,9 @@ int ubi_detach_mtd_dev(int ubi_num, int
 	 */
 	get_device(&ubi->dev);
 
+#ifdef CONFIG_MTD_UBI_FASTMAP
+	cancel_work_sync(&ubi->fm_work);
+#endif
 	ubi_debugfs_exit_dev(ubi);
 	uif_close(ubi);
 
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -1479,6 +1479,7 @@ int ubi_thread(void *u)
 	}
 
 	dbg_wl("background thread \"%s\" is killed", ubi->bgt_name);
+	ubi->thread_enabled = 0;
 	return 0;
 }
 
@@ -1488,9 +1489,6 @@ int ubi_thread(void *u)
  */
 static void shutdown_work(struct ubi_device *ubi)
 {
-#ifdef CONFIG_MTD_UBI_FASTMAP
-	flush_work(&ubi->fm_work);
-#endif
 	while (!list_empty(&ubi->works)) {
 		struct ubi_work *wrk;
 


