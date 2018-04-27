Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758425AbeD0Nk6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:40:58 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:49771 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932728AbeD0Nkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:40:32 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4/5] timekeeping: Add ktime_get_coarse_with_offset
Date: Fri, 27 Apr 2018 15:40:15 +0200
Message-Id: <20180427134016.2525989-5-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180427134016.2525989-1-arnd@arndb.de>
References: <20180427134016.2525989-1-arnd@arndb.de>
X-Provags-ID: V03:K1:RZWbfBd495UtIPPmKrvnzN/a9HzJiJ80X6Y8lzzcCpZJ0v+dV35
 S/63rgDRKFOqGpm1o7y626SW6rEDVoAd19NhWAfYtriTogYDiwUe4yQbeCfE0qUcJ9aJH4r
 bD8+GdqQ1sSrdu9Qq3MjZNDvWiokRmcjmP3LvM17hrWizL9MDeg/fzQHiZJyOKbn5Px3N/g
 EPNkKdUxtPqLVNQu06nsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:y+Dh7RdS9eY=:Q4L63o5WT/0FT+v4JitE3o
 o7qb5MZ12vnoRbB4Yx2mAM5GI3EjE+qBR+kidZl+uLzmcvo2KDnkBIl/I5zjq1bzIHeTyNM0C
 5gCDgi2iu8XS3RDWQ021IiMWWm7N8rYHhyqFopnqGLduq4zNOHAoXhKdYlEpxqxwF9OVM6GG0
 xnlpZlUhxFZ33+JiKBLCgN/LkkyyP7BLFrFC8NB5rvYrqPKu8SesgOP5qVy2hPe8pGC4GHFHq
 XbLRihNA9ro9Dfq9UxQrtXdGFECDmbLH02wOXGIoMMYbGppooudhsc085eoq5ZQKqyz9O5jbI
 NOIAoxcAeI6Bh/swrctrBTwtOQTyZISxM46uWaK/mxuO7JqNBH6YApCJEnjUBSS2qf1sMW8Qu
 NDnxMI8jSX941tzKwzBgjIdeHRwZOXZ7zoujr5oBY4JpmKf0a3RBCZyCrR344oQ//bjRBkjDE
 /MSqEIQ+lfpRI2kPbvGEptiygwmuQBxU9pbx6MkccYo8j0jHFMSZwyRxgizJCXa042cSjdYAP
 6mstjF3EmOnBJCEXzldmZaCtKngFSCYX32Kj1FbtiwAsCsrr7UAo2f89gpX150WgWIeASAWDE
 Ch6u53i3DEUYel0pknJYjbqeRDONFLJnMsT71jRtZrdXIalcq91pa/fRiGrlt7Nw0UpvwQCga
 GNhayqBvE3acTYvM+4pEylijAGbkbjmEA3i1dtQj5myHdD/Q5Mv+8HzmQw19P3lhFOHQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have run into a couple of drivers using current_kernel_time()
suffering from the y2038 problem, and they could be converted
to using ktime_t, but don't have interfaces that skip the nanosecond
calculation at the moment.

This introduces ktime_get_coarse_with_offset() as a simpler
variant of ktime_get_with_offset(), and adds wrappers for the
three time domains we support with the existing function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/timekeeping.h | 16 ++++++++++++++++
 kernel/time/timekeeping.c   | 19 +++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 3ef9791d7d75..42f71f4b658a 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -51,6 +51,7 @@ enum tk_offsets {
 
 extern ktime_t ktime_get(void);
 extern ktime_t ktime_get_with_offset(enum tk_offsets offs);
+extern ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs);
 extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
 extern ktime_t ktime_get_raw(void);
 extern u32 ktime_get_resolution_ns(void);
@@ -63,6 +64,11 @@ static inline ktime_t ktime_get_real(void)
 	return ktime_get_with_offset(TK_OFFS_REAL);
 }
 
+static inline ktime_t ktime_get_coarse_real(void)
+{
+	return ktime_get_coarse_with_offset(TK_OFFS_REAL);
+}
+
 /**
  * ktime_get_boottime - Returns monotonic time since boot in ktime_t format
  *
@@ -74,6 +80,11 @@ static inline ktime_t ktime_get_boottime(void)
 	return ktime_get_with_offset(TK_OFFS_BOOT);
 }
 
+static inline ktime_t ktime_get_coarse_boottime(void)
+{
+	return ktime_get_coarse_with_offset(TK_OFFS_BOOT);
+}
+
 /**
  * ktime_get_clocktai - Returns the TAI time of day in ktime_t format
  */
@@ -82,6 +93,11 @@ static inline ktime_t ktime_get_clocktai(void)
 	return ktime_get_with_offset(TK_OFFS_TAI);
 }
 
+static inline ktime_t ktime_get_coarse_clocktai(void)
+{
+	return ktime_get_coarse_with_offset(TK_OFFS_TAI);
+}
+
 /**
  * ktime_mono_to_real - Convert monotonic time to clock realtime
  */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ed9b74ec9c0b..4786df904c22 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -795,6 +795,25 @@ ktime_t ktime_get_with_offset(enum tk_offsets offs)
 }
 EXPORT_SYMBOL_GPL(ktime_get_with_offset);
 
+ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	unsigned int seq;
+	ktime_t base, *offset = offsets[offs];
+
+	WARN_ON(timekeeping_suspended);
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		base = ktime_add(tk->tkr_mono.base, *offset);
+
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	return base;
+
+}
+EXPORT_SYMBOL_GPL(ktime_get_coarse_with_offset);
+
 /**
  * ktime_mono_to_any() - convert mononotic time to any other time
  * @tmono:	time to convert.
-- 
2.9.0
