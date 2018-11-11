Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60330C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28569214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28569214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbeKLFtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:49:24 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51324 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730845AbeKLFsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:35 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsw-0000tu-DS; Sun, 11 Nov 2018 19:59:06 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsU-0001do-Hg; Sun, 11 Nov 2018 19:58:38 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "J. Bruce Fields" <bfields@redhat.com>,
        "Jeff Layton" <jlayton@primarydata.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.655951405@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 201/366] nfsd: silence sparse warning about accessing
 credentials
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@primarydata.com>

commit ae4b884fc6316b3190be19448cea24b020c1cad6 upstream.

sparse says:

    fs/nfsd/auth.c:31:38: warning: incorrect type in argument 1 (different address spaces)
    fs/nfsd/auth.c:31:38:    expected struct cred const *cred
    fs/nfsd/auth.c:31:38:    got struct cred const [noderef] <asn:4>*real_cred

Add a new accessor for the ->real_cred and use that to fetch the
pointer. Accessing current->real_cred directly is actually quite safe
since we know that they can't go away so this is mostly a cosmetic fixup
to silence sparse.

Signed-off-by: Jeff Layton <jlayton@primarydata.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/nfsd/auth.c       | 2 +-
 include/linux/cred.h | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

--- a/fs/nfsd/auth.c
+++ b/fs/nfsd/auth.c
@@ -28,7 +28,7 @@ int nfsd_setuser(struct svc_rqst *rqstp,
 	validate_process_creds();
 
 	/* discard any old override before preparing the new set */
-	revert_creds(get_cred(current->real_cred));
+	revert_creds(get_cred(current_real_cred()));
 	new = prepare_creds();
 	if (!new)
 		return -ENOMEM;
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -261,6 +261,15 @@ static inline void put_cred(const struct
 	rcu_dereference_protected(current->cred, 1)
 
 /**
+ * current_real_cred - Access the current task's objective credentials
+ *
+ * Access the objective credentials of the current task.  RCU-safe,
+ * since nobody else can modify it.
+ */
+#define current_real_cred() \
+	rcu_dereference_protected(current->real_cred, 1)
+
+/**
  * __task_cred - Access a task's objective credentials
  * @task: The task to query
  *

