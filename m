Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F4FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FBE2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FBE2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeGQF5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 01:57:53 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:36682 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeGQF5w (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 17 Jul 2018 01:57:52 -0400
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Mon, 16 Jul 2018 23:27:02 -0600
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     manfred@colorfullife.com, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH -next] ipc/sem: prevent queue.status tearing in semop
Date:   Mon, 16 Jul 2018 22:26:54 -0700
Message-Id: <20180717052654.676-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for load/store tearing to work, _all_ accesses to
the variable in question need to be done around READ and
WRITE_ONCE() macros. Ensure everyone does so for q->status
variable for semtimedop().

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 ipc/sem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index 6cbbf34a44ac..ccab4e51d351 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -2125,7 +2125,7 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 	}
 
 	do {
-		queue.status = -EINTR;
+		WRITE_ONCE(queue.status, -EINTR);
 		queue.sleeper = current;
 
 		__set_current_state(TASK_INTERRUPTIBLE);
-- 
2.16.4

