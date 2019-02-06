Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56B7C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A18920821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="lZsldrUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfBFALT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:11:19 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39623 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfBFALP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:15 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so4466584edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GFov86CCJ7xFlNfkIQ3jbjtgQ9PYS66dlHr6jTlhCYM=;
        b=lZsldrUi7XP4sWo1TIvIIWnpIOLUCLztKZr7XwZDkEcqznwziVVU3LbpvBpn6dlntv
         zc+V7qgmR7K+YNewcjcjQSGJtaVLYEQpGq5BoY/1tHr3j9u6lI2hppetl0VlH5ZxvngO
         f349JPXs6cUVuL259UOnGlHYrkM8FMUk+sblbcD+x7sbujsg/2yslymsI6+w/5XGhubC
         HO/rcZPldCTgaX38cOMFjI0lolYYOvxFFa3uJXf9zBq9v+EQNdxSEf5To09/5jOhLx+I
         jGGFb1g5TQQOX/kCjpVFvI0bncR8nlRyvxocyKXtN+cQeZn6i7hZvdQ/TaUD4XhaEzP5
         RvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GFov86CCJ7xFlNfkIQ3jbjtgQ9PYS66dlHr6jTlhCYM=;
        b=FaAsKR3dhr5rtHOO8MnS6Br37vpkP+Q3SngScE2prz5e3uAgXV+J1+zQLBCLZFYNGK
         Wd85O52uOvrU6lNWNjIxZha6x65grUDl/PRGSGq6MQRHxJdzXmMEpOLyWYT6Ge6WF1D8
         C70dS11//k0rhuQgtgum13PvwXzoxUBi8wo7skVk/ReIf1cfNP9P4jSdjDClbJSRUoxq
         R5iK6BnpP1A04g0VHXt1dJENXHIHAv8t6SZayjXcD3TIOWSwtUorupg0RQahWbkylWL6
         Z3zg+SKFHrz5x45QKwv2nQez/Mwfz179xAf2H5zECXksisx2//kp3PP1O0Orz3p+46sZ
         cyPw==
X-Gm-Message-State: AHQUAubq5nZhuDOExH9q2lC8PCzX9DkFH9jC8dEys98FLdKqQpbDmlIH
        obj1YoW+X6TnFVKg5OQW13zFDwHoqCA=
X-Google-Smtp-Source: AHgI3IYz3UURyTayalvZAkGXOu93UeNz6YCFe09xkngmktQeQKKnJMgNpN0ni/c+Hj23tLEqkePtbg==
X-Received: by 2002:a17:906:4201:: with SMTP id z1mr5510908ejk.81.1549411873289;
        Tue, 05 Feb 2019 16:11:13 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:12 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 03/32] timens: Introduce CLOCK_MONOTONIC offsets
Date:   Wed,  6 Feb 2019 00:10:37 +0000
Message-Id: <20190206001107.16488-4-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Add monotonic time virtualisation for time namespace.
Introduce timespec for monotionic clock into timens offsets and wire
clock_gettime() syscall.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/time_namespace.h | 11 ++++++++++
 include/linux/timens_offsets.h |  1 +
 kernel/time/posix-timers.c     | 10 +++++++++
 kernel/time/posix-timers.h     |  1 +
 kernel/time_namespace.c        | 38 ++++++++++++++++++++++++++++++++++
 5 files changed, 61 insertions(+)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index b6985aa87479..f1807d7f524d 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -41,6 +41,9 @@ static inline void put_time_ns(struct time_namespace *ns)
 }
 
 
+extern void timens_clock_to_host(int clockid, struct timespec64 *val);
+extern void timens_clock_from_host(int clockid, struct timespec64 *val);
+
 #else
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
@@ -65,6 +68,14 @@ static inline int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *ts
 	return 0;
 }
 
+static inline void timens_clock_to_host(int clockid, struct timespec64 *val)
+{
+}
+
+static inline void timens_clock_from_host(int clockid, struct timespec64 *val)
+{
+}
+
 #endif
 
 #endif /* _LINUX_TIMENS_H */
diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
index 7d7cb68ea778..248b0c0bb92a 100644
--- a/include/linux/timens_offsets.h
+++ b/include/linux/timens_offsets.h
@@ -3,6 +3,7 @@
 #define _LINUX_TIME_OFFSETS_H
 
 struct timens_offsets {
+	struct timespec64  monotonic_time_offset;
 };
 
 #endif
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 0e84bb72a3da..b6d5145858a3 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -30,6 +30,7 @@
 #include <linux/hashtable.h>
 #include <linux/compat.h>
 #include <linux/nospec.h>
+#include <linux/time_namespace.h>
 
 #include "timekeeping.h"
 #include "posix-timers.h"
@@ -1041,6 +1042,9 @@ SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
 
 	error = kc->clock_get(which_clock, &kernel_tp);
 
+	if (!error && kc->clock_timens_adjust)
+		timens_clock_from_host(which_clock, &kernel_tp);
+
 	if (!error && put_timespec64(&kernel_tp, tp))
 		error = -EFAULT;
 
@@ -1117,6 +1121,9 @@ COMPAT_SYSCALL_DEFINE2(clock_gettime, clockid_t, which_clock,
 
 	err = kc->clock_get(which_clock, &ts);
 
+	if (!err && kc->clock_timens_adjust)
+		timens_clock_from_host(which_clock, &ts);
+
 	if (!err && put_old_timespec32(&ts, tp))
 		err = -EFAULT;
 
@@ -1259,6 +1266,7 @@ static const struct k_clock clock_realtime = {
 static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get		= posix_ktime_get_ts,
+	.clock_timens_adjust	= true,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
@@ -1274,6 +1282,7 @@ static const struct k_clock clock_monotonic = {
 static const struct k_clock clock_monotonic_raw = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get		= posix_get_monotonic_raw,
+	.clock_timens_adjust	= true,
 };
 
 static const struct k_clock clock_realtime_coarse = {
@@ -1284,6 +1293,7 @@ static const struct k_clock clock_realtime_coarse = {
 static const struct k_clock clock_monotonic_coarse = {
 	.clock_getres		= posix_get_coarse_res,
 	.clock_get		= posix_get_monotonic_coarse,
+	.clock_timens_adjust	= true,
 };
 
 static const struct k_clock clock_tai = {
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index ddb21145211a..1cf306bde639 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -24,6 +24,7 @@ struct k_clock {
 	int	(*timer_try_to_cancel)(struct k_itimer *timr);
 	void	(*timer_arm)(struct k_itimer *timr, ktime_t expires,
 			     bool absolute, bool sigev_none);
+	bool	clock_timens_adjust;
 };
 
 extern const struct k_clock clock_posix_cpu;
diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
index 4828447721ec..57694be9e9db 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -191,6 +191,44 @@ static struct user_namespace *timens_owner(struct ns_common *ns)
 	return to_time_ns(ns)->user_ns;
 }
 
+static void clock_timens_fixup(int clockid, struct timespec64 *val, bool to_ns)
+{
+	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
+	struct timespec64 *offsets = NULL;
+
+	if (!ns_offsets)
+		return;
+
+	if (val->tv_sec == 0 && val->tv_nsec == 0)
+		return;
+
+	switch (clockid) {
+	case CLOCK_MONOTONIC:
+	case CLOCK_MONOTONIC_RAW:
+	case CLOCK_MONOTONIC_COARSE:
+		offsets = &ns_offsets->monotonic_time_offset;
+		break;
+	}
+
+	if (!offsets)
+		return;
+
+	if (to_ns)
+		*val = timespec64_add(*val, *offsets);
+	else
+		*val = timespec64_sub(*val, *offsets);
+}
+
+void timens_clock_to_host(int clockid, struct timespec64 *val)
+{
+	clock_timens_fixup(clockid, val, false);
+}
+
+void timens_clock_from_host(int clockid, struct timespec64 *val)
+{
+	clock_timens_fixup(clockid, val, true);
+}
+
 const struct proc_ns_operations timens_operations = {
 	.name		= "time",
 	.type		= CLONE_NEWTIME,
-- 
2.20.1

