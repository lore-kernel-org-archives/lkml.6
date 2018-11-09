Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E6FC4161B
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A6520855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A6520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbeKJFyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:54:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbeKJFyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:54:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8712489AD5;
        Fri,  9 Nov 2018 20:11:53 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BFED608C1;
        Fri,  9 Nov 2018 20:11:52 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v11 3/3] ipc: Do cyclic id allocation with ipcmni_extend mode
Date:   Fri,  9 Nov 2018 15:11:32 -0500
Message-Id: <1541794292-19425-4-git-send-email-longman@redhat.com>
In-Reply-To: <1541794292-19425-1-git-send-email-longman@redhat.com>
References: <1541794292-19425-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 09 Nov 2018 20:11:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For ipcmni_extend mode, the sequence number space is only 7 bits. So
the chance of id reuse is relatively high compared with the non-extended
mode.

To alleviate this id reuse problem, the id allocation will be done
cyclically to cycle through all the 24-bit id space before wrapping
around when in ipcmni_extend mode. This may cause the use of more memory
in term of the number of xa_nodes allocated as well as potentially more
cachelines used as the xa_nodes may be spread more sparsely in this case.

There is probably a slight memory and performance cost in doing cyclic
id allocation. For applications that really need more than 32k unique IPC
identifiers, this is a small price to pay to avoid the id reuse problem.

As a result, the chance of id reuse should be even smaller in the
ipcmni_extend mode. For users who worry about id reuse, they can
turn on ipcmni_extend mode, even if they don't need more than 32k
IPC identifiers.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 ++++-
 ipc/ipc_sysctl.c                                | 2 ++
 ipc/util.c                                      | 6 +++++-
 ipc/util.h                                      | 2 ++
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 93d1454..49620b9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1800,7 +1800,10 @@
 			See Documentation/filesystems/nfs/nfsroot.txt.
 
 	ipcmni_extend	[KNL] Extend the maximum number of unique System V
-			IPC identifiers from 32,768 to 16,777,216.
+			IPC identifiers from 32,768 to 16,777,216. Also do
+			cyclical identifier allocation through the entire
+			24-bit identifier space to reduce the chance of
+			identifier reuse.
 
 	irqaffinity=	[SMP] Set the default irq affinity mask
 			The argument is a cpu list, as described above.
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 73b7782..d9ac6ca 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -122,6 +122,7 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 static int int_max = INT_MAX;
 int ipc_mni = IPCMNI;
 int ipc_mni_shift = IPCMNI_SHIFT;
+bool ipc_mni_extended;
 
 static struct ctl_table ipc_kern_table[] = {
 	{
@@ -252,6 +253,7 @@ static int __init ipc_mni_extend(char *str)
 {
 	ipc_mni = IPCMNI_EXTEND;
 	ipc_mni_shift = IPCMNI_EXTEND_SHIFT;
+	ipc_mni_extended = true;
 	pr_info("IPCMNI extended to %d.\n", ipc_mni);
 	return 0;
 }
diff --git a/ipc/util.c b/ipc/util.c
index 00000a1..634b190 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -228,7 +228,11 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 			ids->deleted = false;
 		}
 		new->seq = ids->seq;
-		idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
+		if (ipc_mni_extended)
+			idx = idr_alloc_cyclic(&ids->ipcs_idr, new, 0, ipc_mni,
+						GFP_NOWAIT);
+		else
+			idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
 	} else {
 		new->seq = ipcid_to_seqx(next_id);
 		idx = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
diff --git a/ipc/util.h b/ipc/util.h
index 6a88d51..9f0dd79 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -33,6 +33,7 @@
 #ifdef CONFIG_SYSVIPC_SYSCTL
 extern int ipc_mni;
 extern int ipc_mni_shift;
+extern bool ipc_mni_extended;
 
 #define IPCMNI_SEQ_SHIFT	ipc_mni_shift
 #define IPCMNI_IDX_MASK		((1 << ipc_mni_shift) - 1)
@@ -40,6 +41,7 @@
 #else /* CONFIG_SYSVIPC_SYSCTL */
 
 #define ipc_mni			IPCMNI
+#define ipc_mni_extended	false
 #define IPCMNI_SEQ_SHIFT	IPCMNI_SHIFT
 #define IPCMNI_IDX_MASK		((1 << IPCMNI_SHIFT) - 1)
 #endif /* CONFIG_SYSVIPC_SYSCTL */
-- 
1.8.3.1

