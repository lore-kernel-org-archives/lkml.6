Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA12C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5150620896
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="XlxCUD2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfANVFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:05:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33505 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfANVFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:05:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so573688wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 13:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i/bOQhFshSmpVSiHQYq/FLoYC60BmIPec/Ps2bdXVyQ=;
        b=XlxCUD2ehgHuL3rYmYyRJQtVBooqXu6XVHr/YBbtgpE8LibUGi1mvR4fMFOae8OW1G
         YjP0ei93VoH5CotKCaCpXSwbZoIWf77k/0HlXUroPUB/DQoMaq814XdwhS2oCRY2KT+x
         p7V189mQu5z4z6lddo39ey4RpQqKaX7Pyzuujai2jEsxF9FP+G3GiCxUGDhBL7bhezwQ
         4MN2zAZ7JR3zQCVUZX0d/k6kD5gQUEYuu/u44TbEk6UfYG8nPdmUhnfFKkTnylJ/0R2g
         kzyMWHuM7He3qp8+613MWrfSwJjONtqLYbqg41YhUcODFhkq6BC2Tih2W2zHlmrdALVi
         Zzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i/bOQhFshSmpVSiHQYq/FLoYC60BmIPec/Ps2bdXVyQ=;
        b=cuzVaJAfDsq1yiHUdx58sMfho8m1zQJ5c/WE8mhBu/27aEllfmWGMpYhnKOb9b5Fxm
         R+c6vLiARJ5ApEKofWVcYm3ZlPoUPYp2Jphbx7STtzom82BIOImNFi7rEQiBTi4Pc1JF
         xTGB0bTigMRIMw+MKuSiXEuxLEw23mRt3Zi/nUgyotGAwkhh3lLqcQ8ibCyaWLQK5M2v
         xCIWfZ2rl65GRtetZ8QBhpNr7KWkP04FeBiSecCEcxxh9npEmZLVIl1Jc92j1nQO4Gti
         QIUv8/wOqi/xYOB9WVBz2imCnCOrCc0wQjSSAc64EE3+KcIrKS0rxXhISyJTYyRekfHp
         jicg==
X-Gm-Message-State: AJcUukeVO40gWtXSp6bZXp1Hs1QNSLtIE2DNoBb7blLQD0sdCYyGs5Qg
        4l6RRLpW8kdakF1f6BIiwKL34g==
X-Google-Smtp-Source: ALg8bN7jbUgZvnIfFsZ41vIieeqIbjlSauv8uHVA/AslPCwOE2dBcTY9+lMFFDRSjiortMhBUFb1IQ==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr294125wrv.116.1547499904307;
        Mon, 14 Jan 2019 13:05:04 -0800 (PST)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:c43f:8c1b:f6ef:3dce])
        by smtp.gmail.com with ESMTPSA id s1sm106981548wro.9.2019.01.14.13.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 13:05:03 -0800 (PST)
From:   Tri Vo <trong@android.com>
To:     oberpar@linux.ibm.com
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Greg Hackmann <ghackmann@google.com>,
        Tri Vo <trong@android.com>, Trilok Soni <tsoni@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>
Subject: [PATCH 1/4] gcov: clang: move common gcc code into gcc_base.c
Date:   Mon, 14 Jan 2019 13:04:23 -0800
Message-Id: <20190114210426.177543-2-trong@android.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190114210426.177543-1-trong@android.com>
References: <20190114210426.177543-1-trong@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Hackmann <ghackmann@google.com>

base.c contains a few callbacks specific to GCC's gcov implementation.
Move these into their own module in preparation for clang support.

Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Tri Vo <trong@android.com>
Tested-by: Trilok Soni <tsoni@quicinc.com>
Tested-by: Prasad Sodagudi <psodagud@quicinc.com>
Tested-by: Tri Vo <trong@android.com>
---
 kernel/gcov/Makefile   |  4 +--
 kernel/gcov/base.c     | 78 ++---------------------------------------
 kernel/gcov/gcc_base.c | 79 ++++++++++++++++++++++++++++++++++++++++++
 kernel/gcov/gcov.h     |  3 ++
 4 files changed, 86 insertions(+), 78 deletions(-)
 create mode 100644 kernel/gcov/gcc_base.c

diff --git a/kernel/gcov/Makefile b/kernel/gcov/Makefile
index ff06d64df397..45431ed679d1 100644
--- a/kernel/gcov/Makefile
+++ b/kernel/gcov/Makefile
@@ -2,5 +2,5 @@
 ccflags-y := -DSRCTREE='"$(srctree)"' -DOBJTREE='"$(objtree)"'
 
 obj-y := base.o fs.o
-obj-$(CONFIG_GCOV_FORMAT_3_4) += gcc_3_4.o
-obj-$(CONFIG_GCOV_FORMAT_4_7) += gcc_4_7.o
+obj-$(CONFIG_GCOV_FORMAT_3_4) += gcc_base.o gcc_3_4.o
+obj-$(CONFIG_GCOV_FORMAT_4_7) += gcc_base.o gcc_4_7.o
diff --git a/kernel/gcov/base.c b/kernel/gcov/base.c
index 9c7c8d5c18f2..5262bb784597 100644
--- a/kernel/gcov/base.c
+++ b/kernel/gcov/base.c
@@ -22,82 +22,8 @@
 #include <linux/sched.h>
 #include "gcov.h"
 
-static int gcov_events_enabled;
-static DEFINE_MUTEX(gcov_lock);
-
-/*
- * __gcov_init is called by gcc-generated constructor code for each object
- * file compiled with -fprofile-arcs.
- */
-void __gcov_init(struct gcov_info *info)
-{
-	static unsigned int gcov_version;
-
-	mutex_lock(&gcov_lock);
-	if (gcov_version == 0) {
-		gcov_version = gcov_info_version(info);
-		/*
-		 * Printing gcc's version magic may prove useful for debugging
-		 * incompatibility reports.
-		 */
-		pr_info("version magic: 0x%x\n", gcov_version);
-	}
-	/*
-	 * Add new profiling data structure to list and inform event
-	 * listener.
-	 */
-	gcov_info_link(info);
-	if (gcov_events_enabled)
-		gcov_event(GCOV_ADD, info);
-	mutex_unlock(&gcov_lock);
-}
-EXPORT_SYMBOL(__gcov_init);
-
-/*
- * These functions may be referenced by gcc-generated profiling code but serve
- * no function for kernel profiling.
- */
-void __gcov_flush(void)
-{
-	/* Unused. */
-}
-EXPORT_SYMBOL(__gcov_flush);
-
-void __gcov_merge_add(gcov_type *counters, unsigned int n_counters)
-{
-	/* Unused. */
-}
-EXPORT_SYMBOL(__gcov_merge_add);
-
-void __gcov_merge_single(gcov_type *counters, unsigned int n_counters)
-{
-	/* Unused. */
-}
-EXPORT_SYMBOL(__gcov_merge_single);
-
-void __gcov_merge_delta(gcov_type *counters, unsigned int n_counters)
-{
-	/* Unused. */
-}
-EXPORT_SYMBOL(__gcov_merge_delta);
-
-void __gcov_merge_ior(gcov_type *counters, unsigned int n_counters)
-{
-	/* Unused. */
-}
-EXPORT_SYMBOL(__gcov_merge_ior);
-
-void __gcov_merge_time_profile(gcov_type *counters, unsigned int n_counters)
-{
-	/* Unused. */
-}
-EXPORT_SYMBOL(__gcov_merge_time_profile);
-
-void __gcov_merge_icall_topn(gcov_type *counters, unsigned int n_counters)
-{
-	/* Unused. */
-}
-EXPORT_SYMBOL(__gcov_merge_icall_topn);
+int gcov_events_enabled;
+DEFINE_MUTEX(gcov_lock);
 
 void __gcov_exit(void)
 {
diff --git a/kernel/gcov/gcc_base.c b/kernel/gcov/gcc_base.c
new file mode 100644
index 000000000000..823565bcf9bf
--- /dev/null
+++ b/kernel/gcov/gcc_base.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include "gcov.h"
+
+/*
+ * __gcov_init is called by gcc-generated constructor code for each object
+ * file compiled with -fprofile-arcs.
+ */
+void __gcov_init(struct gcov_info *info)
+{
+	static unsigned int gcov_version;
+
+	mutex_lock(&gcov_lock);
+	if (gcov_version == 0) {
+		gcov_version = gcov_info_version(info);
+		/*
+		 * Printing gcc's version magic may prove useful for debugging
+		 * incompatibility reports.
+		 */
+		pr_info("version magic: 0x%x\n", gcov_version);
+	}
+	/*
+	 * Add new profiling data structure to list and inform event
+	 * listener.
+	 */
+	gcov_info_link(info);
+	if (gcov_events_enabled)
+		gcov_event(GCOV_ADD, info);
+	mutex_unlock(&gcov_lock);
+}
+EXPORT_SYMBOL(__gcov_init);
+
+/*
+ * These functions may be referenced by gcc-generated profiling code but serve
+ * no function for kernel profiling.
+ */
+void __gcov_flush(void)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_flush);
+
+void __gcov_merge_add(gcov_type *counters, unsigned int n_counters)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_merge_add);
+
+void __gcov_merge_single(gcov_type *counters, unsigned int n_counters)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_merge_single);
+
+void __gcov_merge_delta(gcov_type *counters, unsigned int n_counters)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_merge_delta);
+
+void __gcov_merge_ior(gcov_type *counters, unsigned int n_counters)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_merge_ior);
+
+void __gcov_merge_time_profile(gcov_type *counters, unsigned int n_counters)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_merge_time_profile);
+
+void __gcov_merge_icall_topn(gcov_type *counters, unsigned int n_counters)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_merge_icall_topn);
diff --git a/kernel/gcov/gcov.h b/kernel/gcov/gcov.h
index de118ad4a024..0ecf1d664ec3 100644
--- a/kernel/gcov/gcov.h
+++ b/kernel/gcov/gcov.h
@@ -83,4 +83,7 @@ struct gcov_link {
 };
 extern const struct gcov_link gcov_link[];
 
+extern int gcov_events_enabled;
+extern struct mutex gcov_lock;
+
 #endif /* GCOV_H */
-- 
2.20.1.97.g81188d93c3-goog

