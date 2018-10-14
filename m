Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C57C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFD020835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFD020835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbeJNXRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:17:32 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36687 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727252AbeJNXRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:17:32 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiME-0004cm-PR; Sun, 14 Oct 2018 16:31:06 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLP-0000Dg-B2; Sun, 14 Oct 2018 16:30:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Davidlohr Bueso" <dbueso@suse.de>,
        "Manfred Spraul" <manfred@colorfullife.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.89845255@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 063/366] ipc,shm: move BUG_ON check into shm_lock
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Davidlohr Bueso <dave@stgolabs.net>

commit c5c8975b2eb4eb7604e8ce4f762987f56d2a96a2 upstream.

Upon every shm_lock call, we BUG_ON if an error was returned, indicating
racing either in idr or in shm_destroy.  Move this logic into the locking.

[akpm@linux-foundation.org: simplify code]
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 ipc/shm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -155,8 +155,11 @@ static inline struct shmid_kernel *shm_l
 {
 	struct kern_ipc_perm *ipcp = ipc_lock(&shm_ids(ns), id);
 
-	if (IS_ERR(ipcp))
-		return (struct shmid_kernel *)ipcp;
+	/*
+	 * We raced in the idr lookup or with shm_destroy().  Either way, the
+	 * ID is busted.
+	 */
+	BUG_ON(IS_ERR(ipcp));
 
 	return container_of(ipcp, struct shmid_kernel, shm_perm);
 }
@@ -190,7 +193,6 @@ static void shm_open(struct vm_area_stru
 	struct shmid_kernel *shp;
 
 	shp = shm_lock(sfd->ns, sfd->id);
-	BUG_ON(IS_ERR(shp));
 	shp->shm_atim = get_seconds();
 	shp->shm_lprid = task_tgid_vnr(current);
 	shp->shm_nattch++;
@@ -256,7 +258,6 @@ static void shm_close(struct vm_area_str
 	down_write(&shm_ids(ns).rwsem);
 	/* remove from the list of attaches of the shm segment */
 	shp = shm_lock(ns, sfd->id);
-	BUG_ON(IS_ERR(shp));
 	shp->shm_lprid = task_tgid_vnr(current);
 	shp->shm_dtim = get_seconds();
 	shp->shm_nattch--;
@@ -1199,7 +1200,6 @@ out_fput:
 out_nattch:
 	down_write(&shm_ids(ns).rwsem);
 	shp = shm_lock(ns, shmid);
-	BUG_ON(IS_ERR(shp));
 	shp->shm_nattch--;
 	if (shm_may_destroy(ns, shp))
 		shm_destroy(ns, shp);

