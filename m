Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E028C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D0821726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="TmIhS5QZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfAVXir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:38:47 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37283 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfAVXir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:38:47 -0500
Received: by mail-io1-f65.google.com with SMTP id g8so271871iok.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3oKNKC4WrYEDzwRkI5rHCOueRSVCM7sp5QK6n0Didw8=;
        b=TmIhS5QZu2KHWYCLK1t3JoWdvkTXUJrqP92VNv2T34ik6pOktiAbg7eYropvmIlVXU
         pLRH96CnA+myYzjf9lo5eF3nkzFG3nNgdSpwG8SLPklyjb3fgSrKMHUE9Z6PnV5g3QYt
         UqpErO4X5VcRxr7nn67EAXEB26c4ceZFB4w9DUQnUqhrqxfMAko9OCkD6dv0CHA6knE7
         +aRBseaoVfMXsKGYnHYz2644+QHqsygVwXZ/06Ga3wGpuULc2zZYJLKmXaoR4696q3pI
         JoWEg6bpW68xSbRPkyzItX0rCQESx4k0wKekjixtrOTMclzMer2QdtIcik/J1bLoQ5iv
         MC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3oKNKC4WrYEDzwRkI5rHCOueRSVCM7sp5QK6n0Didw8=;
        b=FO9PvLhLHzBrHne66DVwY8gcjD5wyb+cW2vZGXKMYLDAyGnZWTkeah1U3e6oNABDpW
         u6u4utPU3XlvCsCtMeioYKDwPCZAgQRTs8mZiK0HaxPoacEX85NhwhcQh1CV8O47aL5E
         xuKuPelgZlIqHpNUsrqTUwis+PodeEbn3UeWp9tG1dPw5lITo6OutgFVoYvL340+0ON3
         xPo0GFqDa/OyGsgBVqe1CmogaCTYATsxOOcze0MdQibVbHQi87J7zw+vBsznZD+d99h2
         XHzkhnRvcQcLbpJSDgTfgqJrUSNlgzZQoUEQstZsweWPx8Ydwj8UVuaQZMQfFRRBkr0q
         ZcAA==
X-Gm-Message-State: AJcUukce9pyXOyzpTQIeBZN5EjqumX0KEdclUqgfyh9RICU6ud+kcpSI
        lIpE2zckHaV8QD3GVScXX2lyNw==
X-Google-Smtp-Source: ALg8bN5p88aUaB7mk1bsEiZUeFYfZRAvgV+aLTRbC/+xibzbJ9NVclm25pdRbtKJVqBNOCC26xYKjg==
X-Received: by 2002:a6b:4f06:: with SMTP id d6mr19057838iob.263.1548200325598;
        Tue, 22 Jan 2019 15:38:45 -0800 (PST)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:c43f:8c1b:f6ef:3dce])
        by smtp.gmail.com with ESMTPSA id g186sm8058823ite.39.2019.01.22.15.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 15:38:45 -0800 (PST)
From:   Tri Vo <trong@android.com>
To:     oberpar@linux.ibm.com
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        yamada.masahiro@socionext.com, Tri Vo <trong@android.com>,
        Trilok Soni <tsoni@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>
Subject: [PATCH v3 1/3] gcov: Clang: move common GCC code into gcc_base.c
Date:   Tue, 22 Jan 2019 15:37:47 -0800
Message-Id: <20190122233749.42220-2-trong@android.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190122233749.42220-1-trong@android.com>
References: <20190122233749.42220-1-trong@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Hackmann <ghackmann@android.com>

base.c contains a few callbacks specific to GCC's gcov implementation.
Move these into their own module in preparation for Clang support.

Signed-off-by: Greg Hackmann <ghackmann@android.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Tri Vo <trong@android.com>
Tested-by: Trilok Soni <tsoni@quicinc.com>
Tested-by: Prasad Sodagudi <psodagud@quicinc.com>
Tested-by: Tri Vo <trong@android.com>
---
 kernel/gcov/Makefile   |  4 +-
 kernel/gcov/base.c     | 84 +----------------------------------------
 kernel/gcov/gcc_base.c | 86 ++++++++++++++++++++++++++++++++++++++++++
 kernel/gcov/gcov.h     |  3 ++
 4 files changed, 93 insertions(+), 84 deletions(-)
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
index 9c7c8d5c18f2..799d42072727 100644
--- a/kernel/gcov/base.c
+++ b/kernel/gcov/base.c
@@ -22,88 +22,8 @@
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
-
-void __gcov_exit(void)
-{
-	/* Unused. */
-}
-EXPORT_SYMBOL(__gcov_exit);
+int gcov_events_enabled;
+DEFINE_MUTEX(gcov_lock);
 
 /**
  * gcov_enable_events - enable event reporting through gcov_event()
diff --git a/kernel/gcov/gcc_base.c b/kernel/gcov/gcc_base.c
new file mode 100644
index 000000000000..3cf736b9f880
--- /dev/null
+++ b/kernel/gcov/gcc_base.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
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
+
+void __gcov_exit(void)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_exit);
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
2.20.1.321.g9e740568ce-goog

