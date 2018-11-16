Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F65C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23C52146D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23C52146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389292AbeKPKhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:37:48 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:51729 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389204AbeKPKhl (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 16 Nov 2018 05:37:41 -0500
Received: from linux-r8p5.psav.com (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 15 Nov 2018 17:27:23 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     dave@stgolabs.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/6] fs: Remove caller signal_pending branch predictions
Date:   Thu, 15 Nov 2018 16:27:13 -0800
Message-Id: <20181116002713.8474-7-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181116002713.8474-1-dave@stgolabs.net>
References: <20181116002713.8474-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is already done for us internally by the signal machinery.

Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/afs/fs_probe.c             | 2 +-
 fs/afs/vl_probe.c             | 2 +-
 fs/buffer.c                   | 2 +-
 fs/exec.c                     | 4 ++--
 fs/orangefs/orangefs-bufmap.c | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index d049cb459742..428588fb38c6 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -238,7 +238,7 @@ int afs_wait_for_fs_probes(struct afs_server_list *slist, unsigned long untried)
 			}
 		}
 
-		if (!still_probing || unlikely(signal_pending(current)))
+		if (!still_probing || signal_pending(current))
 			goto stop;
 		schedule();
 	}
diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
index c0f616bd70cb..60069640b33d 100644
--- a/fs/afs/vl_probe.c
+++ b/fs/afs/vl_probe.c
@@ -239,7 +239,7 @@ int afs_wait_for_vl_probes(struct afs_vlserver_list *vllist,
 			}
 		}
 
-		if (!still_probing || unlikely(signal_pending(current)))
+		if (!still_probing || signal_pending(current))
 			goto stop;
 		schedule();
 	}
diff --git a/fs/buffer.c b/fs/buffer.c
index 1286c2b95498..f88ee2bb62fc 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2366,7 +2366,7 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 
 		balance_dirty_pages_ratelimited(mapping);
 
-		if (unlikely(fatal_signal_pending(current))) {
+		if (fatal_signal_pending(current))) {
 			err = -EINTR;
 			goto out;
 		}
diff --git a/fs/exec.c b/fs/exec.c
index fc281b738a98..2bb8bece54cc 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1084,7 +1084,7 @@ static int de_thread(struct task_struct *tsk)
 		__set_current_state(TASK_KILLABLE);
 		spin_unlock_irq(lock);
 		schedule();
-		if (unlikely(__fatal_signal_pending(tsk)))
+		if (__fatal_signal_pending(tsk))
 			goto killed;
 		spin_lock_irq(lock);
 	}
@@ -1112,7 +1112,7 @@ static int de_thread(struct task_struct *tsk)
 			write_unlock_irq(&tasklist_lock);
 			cgroup_threadgroup_change_end(tsk);
 			schedule();
-			if (unlikely(__fatal_signal_pending(tsk)))
+			if (__fatal_signal_pending(tsk))
 				goto killed;
 		}
 
diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.c
index c4e98c9c1621..443bcd8c3c19 100644
--- a/fs/orangefs/orangefs-bufmap.c
+++ b/fs/orangefs/orangefs-bufmap.c
@@ -105,7 +105,7 @@ static int wait_for_free(struct slot_map *m)
 			left = t;
 		else
 			left = t + (left - n);
-		if (unlikely(signal_pending(current)))
+		if (signal_pending(current))
 			left = -EINTR;
 	} while (left > 0);
 
-- 
2.16.4

