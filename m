Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9B4C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98207218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfBKNWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:22:34 -0500
Received: from foss.arm.com ([217.140.101.70]:48392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbfBKNWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:22:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C96F80D;
        Mon, 11 Feb 2019 05:22:30 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8390B3F557;
        Mon, 11 Feb 2019 05:22:28 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org
Cc:     akpm@linux-foundation.org, anders.roxell@linaro.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        naresh.kamboju@linaro.org, peterz@infradead.org,
        will.deacon@arm.com
Subject: [PATCHv2 2/2] locking/atomics: Check atomic headers with sha1sum
Date:   Mon, 11 Feb 2019 13:22:13 +0000
Message-Id: <20190211132213.15249-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190211132213.15249-1-mark.rutland@arm.com>
References: <20190211132213.15249-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently check the atomic headers at build-time to ensure they
haven't been modified directly, and these checks require regenerating
the headers in full. As this takes a few seconds, even when
parallelized, this is too slow to run for every kernel build.

Instead, we can generate a hash of each header as we generate them,
which we can cheaply check at build time (~0.16s for all headers).

This patch does so, updating headers with their hashes using the new
gen-atomics.sh script. As some users apparently build the kernel wihout
coreutils, lacking sha1sum, the checks are skipped in this case.
Presumably, most developers have a working coreutils installation.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/asm-generic/atomic-instrumented.h |  1 +
 include/asm-generic/atomic-long.h         |  1 +
 include/linux/atomic-fallback.h           |  1 +
 scripts/atomic/check-atomics.sh           | 26 ++++++++++++++++++++------
 scripts/atomic/gen-atomics.sh             | 20 ++++++++++++++++++++
 5 files changed, 43 insertions(+), 6 deletions(-)
 create mode 100755 scripts/atomic/gen-atomics.sh

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index b8f5b35216e1..e8730c6b9fe2 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -1785,3 +1785,4 @@ atomic64_dec_if_positive(atomic64_t *v)
 })
 
 #endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
+// b29b625d5de9280f680e42c7be859b55b15e5f6a
diff --git a/include/asm-generic/atomic-long.h b/include/asm-generic/atomic-long.h
index a833d385a70b..881c7e27af28 100644
--- a/include/asm-generic/atomic-long.h
+++ b/include/asm-generic/atomic-long.h
@@ -1010,3 +1010,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 
 #endif /* CONFIG_64BIT */
 #endif /* _ASM_GENERIC_ATOMIC_LONG_H */
+// 77558968132ce4f911ad53f6f52ce423006f6268
diff --git a/include/linux/atomic-fallback.h b/include/linux/atomic-fallback.h
index 1c02c0112fbb..a7d240e465c0 100644
--- a/include/linux/atomic-fallback.h
+++ b/include/linux/atomic-fallback.h
@@ -2292,3 +2292,4 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
+// 25de4a2804d70f57e994fe3b419148658bb5378a
diff --git a/scripts/atomic/check-atomics.sh b/scripts/atomic/check-atomics.sh
index c30101cddf2d..cfa0c2f71c84 100755
--- a/scripts/atomic/check-atomics.sh
+++ b/scripts/atomic/check-atomics.sh
@@ -7,13 +7,27 @@ ATOMICDIR=$(dirname $0)
 ATOMICTBL=${ATOMICDIR}/atomics.tbl
 LINUXDIR=${ATOMICDIR}/../..
 
+echo '' | sha1sum - > /dev/null 2>&1
+if [ $? -ne 0 ]; then
+	printf "sha1sum not available, skipping atomic header checks.\n"
+	exit 0
+fi
+
 cat <<EOF |
-gen-atomic-instrumented.sh      asm-generic/atomic-instrumented.h
-gen-atomic-long.sh              asm-generic/atomic-long.h
-gen-atomic-fallback.sh          linux/atomic-fallback.h
+asm-generic/atomic-instrumented.h
+asm-generic/atomic-long.h
+linux/atomic-fallback.h
 EOF
-while read script header; do
-	if ! (${ATOMICDIR}/${script} ${ATOMICTBL} | diff - ${LINUXDIR}/include/${header} > /dev/null); then
-		printf "warning: include/${header} is out-of-date.\n"
+while read header; do
+	OLDSUM="$(tail -n 1 ${LINUXDIR}/include/${header})"
+	OLDSUM="${OLDSUM#// }"
+
+	NEWSUM="$(head -n -1 ${LINUXDIR}/include/${header} | sha1sum)"
+	NEWSUM="${NEWSUM%% *}"
+
+	if [ "${OLDSUM}" != "${NEWSUM}" ]; then
+		printf "warning: generated include/${header} has been modified.\n"
 	fi
 done
+
+exit 0
diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
new file mode 100755
index 000000000000..27400b0cd732
--- /dev/null
+++ b/scripts/atomic/gen-atomics.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Generate atomic headers
+
+ATOMICDIR=$(dirname $0)
+ATOMICTBL=${ATOMICDIR}/atomics.tbl
+LINUXDIR=${ATOMICDIR}/../..
+
+cat <<EOF |
+gen-atomic-instrumented.sh      asm-generic/atomic-instrumented.h
+gen-atomic-long.sh              asm-generic/atomic-long.h
+gen-atomic-fallback.sh          linux/atomic-fallback.h
+EOF
+while read script header; do
+	${ATOMICDIR}/${script} ${ATOMICTBL} > ${LINUXDIR}/include/${header}
+	HASH="$(sha1sum ${LINUXDIR}/include/${header})"
+	HASH="${HASH%% *}"
+	printf "// %s\n" "${HASH}" >> ${LINUXDIR}/include/${header}
+done
-- 
2.11.0

