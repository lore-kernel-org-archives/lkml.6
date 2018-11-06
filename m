Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D78BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7112086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADBnp3NF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7112086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387818AbeKFVbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:31:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:33280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387745AbeKFVbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:31:25 -0500
Received: from jouet.infradead.org (unknown [189.40.102.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9EC020869;
        Tue,  6 Nov 2018 12:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541505991;
        bh=btg5LkLmStKClLNJMd0pFzPZ7hWRzlCREP8/FBoVML4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ADBnp3NFy6dPnhUC+D3cUepyJ9ZN5RbQwInGMn25YxbniiqTGjtMsHFoaT+1mxWhQ
         bXa+26whG9fwJIQkhq2eFGc6+sNlb23crXKi8PLs+wijPryKBNyx14ny+W/gb7s3iw
         o3CSGITKjPyMBPcDfO8voXYWarulB+bmfV1e9Wv4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/18] tools headers barrier: Fix arm64 tools build failure wrt smp_load_{acquire,release}
Date:   Tue,  6 Nov 2018 09:05:55 -0300
Message-Id: <20181106120612.8262-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

Cheers for reporting this. I managed to reproduce the build failure with
gcc version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1).

The code in question is the arm64 versions of smp_load_acquire() and
smp_store_release(). Unlike other architectures, these are not built
around READ_ONCE() and WRITE_ONCE() since we have instructions we can
use instead of fences. Bringing our macros up-to-date with those (i.e.
tweaking the union initialisation and using the special "uXX_alias_t"
types) appears to fix the issue for me.

Committer notes:

Testing it in the systems previously failing:

  # time dm android-ndk:r12b-arm \
         android-ndk:r15c-arm \
         debian:experimental-x-arm64 \
         ubuntu:14.04.4-x-linaro-arm64 \
         ubuntu:16.04-x-arm \
         ubuntu:16.04-x-arm64 \
         ubuntu:18.04-x-arm \
         ubuntu:18.04-x-arm64
    1 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
    2 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
    3 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.2.0-7) 8.2.0
    4 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
    5 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    6 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    7 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
    8 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181031174408.GA27871@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/asm/barrier.h | 133 +++++++++++++++++----------------
 1 file changed, 67 insertions(+), 66 deletions(-)

diff --git a/tools/arch/arm64/include/asm/barrier.h b/tools/arch/arm64/include/asm/barrier.h
index 12835ea0e417..378c051fa177 100644
--- a/tools/arch/arm64/include/asm/barrier.h
+++ b/tools/arch/arm64/include/asm/barrier.h
@@ -14,74 +14,75 @@
 #define wmb()		asm volatile("dmb ishst" ::: "memory")
 #define rmb()		asm volatile("dmb ishld" ::: "memory")
 
-#define smp_store_release(p, v)					\
-do {								\
-	union { typeof(*p) __val; char __c[1]; } __u =		\
-		{ .__val = (__force typeof(*p)) (v) }; 		\
-								\
-	switch (sizeof(*p)) {					\
-	case 1:							\
-		asm volatile ("stlrb %w1, %0"			\
-				: "=Q" (*p)			\
-				: "r" (*(__u8 *)__u.__c)	\
-				: "memory");			\
-		break;						\
-	case 2:							\
-		asm volatile ("stlrh %w1, %0"			\
-				: "=Q" (*p)			\
-				: "r" (*(__u16 *)__u.__c)	\
-				: "memory");			\
-		break;						\
-	case 4:							\
-		asm volatile ("stlr %w1, %0"			\
-				: "=Q" (*p)			\
-				: "r" (*(__u32 *)__u.__c)	\
-				: "memory");			\
-		break;						\
-	case 8:							\
-		asm volatile ("stlr %1, %0"			\
-				: "=Q" (*p)			\
-				: "r" (*(__u64 *)__u.__c)	\
-				: "memory");			\
-		break;						\
-	default:						\
-		/* Only to shut up gcc ... */			\
-		mb();						\
-		break;						\
-	}							\
+#define smp_store_release(p, v)						\
+do {									\
+	union { typeof(*p) __val; char __c[1]; } __u =			\
+		{ .__val = (v) }; 					\
+									\
+	switch (sizeof(*p)) {						\
+	case 1:								\
+		asm volatile ("stlrb %w1, %0"				\
+				: "=Q" (*p)				\
+				: "r" (*(__u8_alias_t *)__u.__c)	\
+				: "memory");				\
+		break;							\
+	case 2:								\
+		asm volatile ("stlrh %w1, %0"				\
+				: "=Q" (*p)				\
+				: "r" (*(__u16_alias_t *)__u.__c)	\
+				: "memory");				\
+		break;							\
+	case 4:								\
+		asm volatile ("stlr %w1, %0"				\
+				: "=Q" (*p)				\
+				: "r" (*(__u32_alias_t *)__u.__c)	\
+				: "memory");				\
+		break;							\
+	case 8:								\
+		asm volatile ("stlr %1, %0"				\
+				: "=Q" (*p)				\
+				: "r" (*(__u64_alias_t *)__u.__c)	\
+				: "memory");				\
+		break;							\
+	default:							\
+		/* Only to shut up gcc ... */				\
+		mb();							\
+		break;							\
+	}								\
 } while (0)
 
-#define smp_load_acquire(p)					\
-({								\
-	union { typeof(*p) __val; char __c[1]; } __u;		\
-								\
-	switch (sizeof(*p)) {					\
-	case 1:							\
-		asm volatile ("ldarb %w0, %1"			\
-			: "=r" (*(__u8 *)__u.__c)		\
-			: "Q" (*p) : "memory");			\
-		break;						\
-	case 2:							\
-		asm volatile ("ldarh %w0, %1"			\
-			: "=r" (*(__u16 *)__u.__c)		\
-			: "Q" (*p) : "memory");			\
-		break;						\
-	case 4:							\
-		asm volatile ("ldar %w0, %1"			\
-			: "=r" (*(__u32 *)__u.__c)		\
-			: "Q" (*p) : "memory");			\
-		break;						\
-	case 8:							\
-		asm volatile ("ldar %0, %1"			\
-			: "=r" (*(__u64 *)__u.__c)		\
-			: "Q" (*p) : "memory");			\
-		break;						\
-	default:						\
-		/* Only to shut up gcc ... */			\
-		mb();						\
-		break;						\
-	}							\
-	__u.__val;						\
+#define smp_load_acquire(p)						\
+({									\
+	union { typeof(*p) __val; char __c[1]; } __u =			\
+		{ .__c = { 0 } };					\
+									\
+	switch (sizeof(*p)) {						\
+	case 1:								\
+		asm volatile ("ldarb %w0, %1"				\
+			: "=r" (*(__u8_alias_t *)__u.__c)		\
+			: "Q" (*p) : "memory");				\
+		break;							\
+	case 2:								\
+		asm volatile ("ldarh %w0, %1"				\
+			: "=r" (*(__u16_alias_t *)__u.__c)		\
+			: "Q" (*p) : "memory");				\
+		break;							\
+	case 4:								\
+		asm volatile ("ldar %w0, %1"				\
+			: "=r" (*(__u32_alias_t *)__u.__c)		\
+			: "Q" (*p) : "memory");				\
+		break;							\
+	case 8:								\
+		asm volatile ("ldar %0, %1"				\
+			: "=r" (*(__u64_alias_t *)__u.__c)		\
+			: "Q" (*p) : "memory");				\
+		break;							\
+	default:							\
+		/* Only to shut up gcc ... */				\
+		mb();							\
+		break;							\
+	}								\
+	__u.__val;							\
 })
 
 #endif /* _TOOLS_LINUX_ASM_AARCH64_BARRIER_H */
-- 
2.14.4

