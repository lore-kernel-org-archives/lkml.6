Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649F8C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3429A21934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+aSTXHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387681AbfBMD0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:26:42 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44876 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfBMD0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:26:41 -0500
Received: by mail-pl1-f194.google.com with SMTP id p4so475010plq.11;
        Tue, 12 Feb 2019 19:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Olw5XYEppRL5ksytIUvVQFmfyFQWZaUD9SuW/h8fORY=;
        b=N+aSTXHudrGfXNMdE8LElXLtuY5wzCoIRJXD3GMRQIAjy7q8KlZQcJslzP7Qn5P8Rs
         n2jpGb2vp5BRiR4A+g1p9p9YsjD8e2YITwPwd4dR+zpvojD4fRoZV0187Qui1KWL9kH9
         OIuwF4G4ZrPI5kCY0+INKGXF2FbtwG/CP5pDuIwIipMDXngrrpClxBCr+8tW3tdOrNzc
         AMd8Fh54CU/VUJhLhc/uj0UO44A1nrrwKxjNm8q8zm89LmqUdiniC0DnPacQt3eGYXRo
         EeytqB61cVNb+UNbiq7csL11Ez6+LzUjAX8vymXNCnrOD8upNFYJKZ3HUabHuqomQCNN
         CXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Olw5XYEppRL5ksytIUvVQFmfyFQWZaUD9SuW/h8fORY=;
        b=mSieL5ShHkRJrExeDaVTkZPElgXddPBs2R32LtjaNlillVjGJteiErT7ayEPFPd6uj
         1gTq281lNR1YnLBM7qw19RtaQg95wAYU5JiY6GWHlXkbHhY0M2T7sn7aYWJaZzh+brlO
         xqkSZpFN4e/iaPwelpnAZRq7tS9OG7jqqqq5FzYEQw60olEw+cTILflw7p/23mKw8pxw
         nbR5vXVgTWM7Yk3bLvFYujhGUvxJC8pzX7rUTLlEhd077vCr6MtYFktBhIcMpzcdeeYp
         rRyyJiwG2nReiFuDRStnNah9qxQpFzocqA3pgoBemxjMkdtD5KQaz2tVV3JR3iIlINSZ
         HDXg==
X-Gm-Message-State: AHQUAuaA+Upin8B4yfQYjcWATn9177QrS4/f1joBHmSDPlyiLAdZGKPS
        ciVRikHzWPsVEkEspRc/Uu8=
X-Google-Smtp-Source: AHgI3IZIfGOteOT6qK5T+PlN1VjApF9XLlLmdpdHX17x7y6RjZa9sMEvgKf4lnCruj+oXHVlctQ9/Q==
X-Received: by 2002:a17:902:6686:: with SMTP id e6mr7459414plk.208.1550028400633;
        Tue, 12 Feb 2019 19:26:40 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id q7sm17337396pgp.40.2019.02.12.19.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 19:26:40 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, willemb@google.com, tglx@linutronix.de,
        arnd@arndb.de, y2038@lists.linaro.org
Subject: [PATCH net-next 1/2] time: Add time_types.h
Date:   Tue, 12 Feb 2019 19:26:03 -0800
Message-Id: <20190213032604.2655-2-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213032604.2655-1-deepa.kernel@gmail.com>
References: <20190213032604.2655-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sys/time.h is the mandated include for many time related
defines. However, linux/time.h overlaps sys/time.h
significantly and this makes including both from userspace
or one from the other impossible.

This also means that userspace can get away with including
sys/time.h whenever it needs linux/time.h and this is what's
been happening in the user world usually.

But, we have new data types that we plan to use in the uapi time
interfaces also defined in the linux/time.h. But, we are unable
to use these types when sys/time.h is included.

Hence, move the new types to a new header, time_types.h.
We intend to eventually have all the uapi defines that the kernel
uses defined in this header.
Note that the plan is to replace uapi interfaces with timeval to
use __kernel_old_timeval, timespec to use __kernel_old_timespec etc.

Reported-by: Ran Rozenstein <ranro@mellanox.com>
Fixes: 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW")
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/uapi/linux/time.h       | 36 +----------------------------
 include/uapi/linux/time_types.h | 40 +++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 35 deletions(-)
 create mode 100644 include/uapi/linux/time_types.h

diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index b8ad1b86b942..958932effc5e 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -3,7 +3,7 @@
 #define _UAPI_LINUX_TIME_H
 
 #include <linux/types.h>
-
+#include <linux/time_types.h>
 
 #ifndef _STRUCT_TIMESPEC
 #define _STRUCT_TIMESPEC
@@ -23,7 +23,6 @@ struct timezone {
 	int	tz_dsttime;	/* type of dst correction */
 };
 
-
 /*
  * Names of the interval timers, and structure
  * defining a timer setting:
@@ -42,39 +41,6 @@ struct itimerval {
 	struct timeval it_value;	/* current value */
 };
 
-#ifndef __kernel_timespec
-struct __kernel_timespec {
-	__kernel_time64_t       tv_sec;                 /* seconds */
-	long long               tv_nsec;                /* nanoseconds */
-};
-#endif
-
-#ifndef __kernel_itimerspec
-struct __kernel_itimerspec {
-	struct __kernel_timespec it_interval;    /* timer period */
-	struct __kernel_timespec it_value;       /* timer expiration */
-};
-#endif
-
-/*
- * legacy timeval structure, only embedded in structures that
- * traditionally used 'timeval' to pass time intervals (not absolute
- * times). Do not add new users. If user space fails to compile
- * here, this is probably because it is not y2038 safe and needs to
- * be changed to use another interface.
- */
-#ifndef __kernel_old_timeval
-struct __kernel_old_timeval {
-	__kernel_long_t tv_sec;
-	__kernel_long_t tv_usec;
-};
-#endif
-
-struct __kernel_sock_timeval {
-	__s64 tv_sec;
-	__s64 tv_usec;
-};
-
 /*
  * The IDs of the various system clocks (for POSIX.1b interval timers):
  */
diff --git a/include/uapi/linux/time_types.h b/include/uapi/linux/time_types.h
new file mode 100644
index 000000000000..4a51ca37305b
--- /dev/null
+++ b/include/uapi/linux/time_types.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_TIME_TYPES_H
+#define _UAPI_LINUX_TIME_TYPES_H
+
+#include <linux/types.h>
+
+#ifndef __kernel_timespec
+struct __kernel_timespec {
+	__kernel_time64_t       tv_sec;                 /* seconds */
+	long long               tv_nsec;                /* nanoseconds */
+};
+#endif
+
+#ifndef __kernel_itimerspec 
+struct __kernel_itimerspec {
+	struct __kernel_timespec it_interval;    /* timer period */
+	struct __kernel_timespec it_value;       /* timer expiration */
+};
+#endif
+
+/*
+ * legacy timeval structure, only embedded in structures that
+ * traditionally used 'timeval' to pass time intervals (not absolute
+ * times). Do not add new users. If user space fails to compile
+ * here, this is probably because it is not y2038 safe and needs to
+ * be changed to use another interface.
+ */
+#ifndef __kernel_old_timeval
+struct __kernel_old_timeval {
+	__kernel_long_t tv_sec;
+	__kernel_long_t tv_usec;
+};
+#endif
+
+struct __kernel_sock_timeval {
+	__s64 tv_sec;
+	__s64 tv_usec;
+};
+
+#endif /* _UAPI_LINUX_TIME_TYPES_H */
-- 
2.17.1

