Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3F0C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB9D20876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB9D20876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbeJNXXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:23:54 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36951 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbeJNXXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:23:53 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiME-0004cH-Qh; Sun, 14 Oct 2018 16:31:06 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLP-0000Dk-CQ; Sun, 14 Oct 2018 16:30:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Davidlohr Bueso" <dave@stgolabs.net>,
        "Manfred Spraul" <manfred@colorfullife.com>,
        "Davidlohr Bueso" <dbueso@suse.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.110847064@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 064/366] ipc: convert invalid scenarios to use WARN_ON
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

commit d0edd8528362c07216498340e928159510595e7b upstream.

Considering Linus' past rants about the (ab)use of BUG in the kernel, I
took a look at how we deal with such calls in ipc.  Given that any errors
or corruption in ipc code are most likely contained within the set of
processes participating in the broken mechanisms, there aren't really many
strong fatal system failure scenarios that would require a BUG call.
Also, if something is seriously wrong, ipc might not be the place for such
a BUG either.

1. For example, recently, a customer hit one of these BUG_ONs in shm
   after failing shm_lock().  A busted ID imho does not merit a BUG_ON,
   and WARN would have been better.

2. MSG_COPY functionality of posix msgrcv(2) for checkpoint/restore.
   I don't see how we can hit this anyway -- at least it should be IS_ERR.
    The 'copy' arg from do_msgrcv is always set by calling prepare_copy()
   first and foremost.  We could also probably drop this check altogether.
    Either way, it does not merit a BUG_ON.

3. No ->fault() callback for the fs getting the corresponding page --
   seems selfish to make the system unusable.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 ipc/msgutil.c | 2 +-
 ipc/shm.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -120,7 +120,7 @@ struct msg_msg *copy_msg(struct msg_msg
 	size_t len = src->m_ts;
 	size_t alen;
 
-	BUG_ON(dst == NULL);
+	WARN_ON(dst == NULL);
 	if (src->m_ts > dst->m_ts)
 		return ERR_PTR(-EINVAL);
 
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -159,7 +159,7 @@ static inline struct shmid_kernel *shm_l
 	 * We raced in the idr lookup or with shm_destroy().  Either way, the
 	 * ID is busted.
 	 */
-	BUG_ON(IS_ERR(ipcp));
+	WARN_ON(IS_ERR(ipcp));
 
 	return container_of(ipcp, struct shmid_kernel, shm_perm);
 }
@@ -390,7 +390,7 @@ static int shm_mmap(struct file *file, s
 		return ret;
 	sfd->vm_ops = vma->vm_ops;
 #ifdef CONFIG_MMU
-	BUG_ON(!sfd->vm_ops->fault);
+	WARN_ON(!sfd->vm_ops->fault);
 #endif
 	vma->vm_ops = &shm_vm_ops;
 	shm_open(vma);

