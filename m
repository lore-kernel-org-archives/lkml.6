Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF64ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787FC2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787FC2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbeKFBGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:06:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730166AbeKFBGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:06:18 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 53CC8307EAA5;
        Mon,  5 Nov 2018 15:46:00 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF05810B034B;
        Mon,  5 Nov 2018 15:45:58 +0000 (UTC)
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
Subject: [PATCH v10 4/4] ipc: Add a cyclic mode for id generation
Date:   Mon,  5 Nov 2018 10:43:46 -0500
Message-Id: <1541432626-27780-5-git-send-email-longman@redhat.com>
In-Reply-To: <1541432626-27780-1-git-send-email-longman@redhat.com>
References: <1541432626-27780-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 05 Nov 2018 15:46:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea of using the cyclic mode to reduce id reuse came from Manfred
Spraul <manfred@colorfullife.com>. There may be a little bit of
additional memory/performance overhead in doing cyclic id allocation,
but it is a slow path anyway and a bit of overhead shouldn't be an issue.

This patch differs from his as the cyclic mode is not the default and
has to be explicitly opted in for users who want that.

Note that it is possible to use an identifier larger than the given
IPC mni number in cyclic mode.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/sysctl/kernel.txt | 10 ++++++++--
 include/linux/ipc_namespace.h   |  1 +
 ipc/ipc_sysctl.c                |  3 ++-
 ipc/util.c                      |  6 +++++-
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index 91bada1..6de0679 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -406,12 +406,18 @@ are being generated.
 
 0: legacy mode
 1: delete mode
+2: cyclic mode
 
 There are two components in an IPC id - an integer identifier and a
 sequence number. In the legacy mode, the sequence number is incremented
 every time a new id is generated. In the delete mode, the sequence number
-is only incremented if one or more ids have been previously deleted. The
-delete mode reduces the chance that a given id will be reused again.
+is only incremented if one or more ids have been previously deleted.
+In the cyclic mode, the sequence number increments in the same way as the
+delete mode, but the identifier is allocated cyclically through the whole
+IPC identifier number space instead of using the lowest available number.
+
+The cyclic mode has the lowest chance of IPC id reuse followed by the
+delete mode and the legacy mode.
 
 ==============================================================
 
diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index 79d9d50..481dc02 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -33,6 +33,7 @@ struct ipc_ids {
 enum ipc_id_mode {
 	ipc_id_legacy,	/* Sequence # incremented on every allocation */
 	ipc_id_delete,	/* Sequence # incremented only if an ID was deleted */
+	ipc_id_cyclic,	/* Identifier is allocated cyclically */
 };
 
 struct ipc_namespace {
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 4c30e62..8d114d0 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -119,6 +119,7 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 
 static int zero;
 static int one = 1;
+static int two = 2;
 static int int_max = INT_MAX;
 int ipc_mni = IPCMNI;
 int ipc_mni_shift = IPCMNI_SHIFT;
@@ -207,7 +208,7 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
 		.extra1		= &zero,
-		.extra2		= &one,
+		.extra2		= &two,
 	},
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	{
diff --git a/ipc/util.c b/ipc/util.c
index 04c8e31..8d73d17 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -230,7 +230,11 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new,
 			ids->deleted = false;
 		}
 		new->seq = ids->seq;
-		idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
+		if (idmode == ipc_id_cyclic)
+			idx = idr_alloc_cyclic(&ids->ipcs_idr, new, 0, IPCMNI,
+						GFP_NOWAIT);
+		else
+			idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
 	} else {
 		new->seq = ipcid_to_seqx(next_id);
 		idx = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
-- 
1.8.3.1

