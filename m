Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384D9C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA19821581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA19821581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeHTPyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:54:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38368 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeHTPyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:54:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so13693065wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 05:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fZlnPHcqfGZWO0vA0m6jg1ljS2GcV/pMA/5Nmzlil6w=;
        b=jUQYKRnDCKL+sc+ERK29CN12iw6aKvvxawCWk6ylGvtt1K34r8TRDEaiBxeKHb54oL
         4ANP1rrhGHdkKM65iVwiLHgyAAjWafG2RAlyxO1D/Awm2jtqR1Jd8i7I4x2u77CT/V6K
         Zpnru+/FLGJmXB3UD2LOH31AXbm3cXIafmc036vkUFQtJmrPJYL0z0BBgqZriZHJqGv7
         VKZZRS7P2nz0UXRTQvIreoh/D8QJWbMyc6HS5vBlpqC51nObnZ2FSSntFxzJsmY0YH+k
         lPu2w+PJ8EDu/DrRH0OSp6F1afKOBxNWzO7gJWacEEULnT0ugfmNYBiQgg+XWsnz4tam
         n9HA==
X-Gm-Message-State: AOUpUlEPxDmNMIoXHRbnhwPvYJbRhgq3dJf5kFTedZtthWVdeLzAp4Rb
        PectdALDn98LgYmo1bn6HyIaFw==
X-Google-Smtp-Source: AA+uWPyvrzSUkjy575zwTbsCI62BRxugr7UtUtmrleaBBM1bIIbFHoT6210tYULgEC5LMz63nSmZLg==
X-Received: by 2002:a1c:3743:: with SMTP id e64-v6mr24888328wma.63.1534768720100;
        Mon, 20 Aug 2018 05:38:40 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v2-v6sm496917wme.36.2018.08.20.05.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 05:38:39 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-audit@redhat.com
Cc:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH ghak10 v4 1/2] audit: Add functions to log time adjustments
Date:   Mon, 20 Aug 2018 14:38:17 +0200
Message-Id: <20180820123818.27547-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180820123818.27547-1-omosnace@redhat.com>
References: <20180820123818.27547-1-omosnace@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds two auxiliary record types that will be used to annotate
the adjtimex SYSCALL records with the NTP/timekeeping values that have
been changed.

Next, it adds two functions to the audit interface:
 - audit_tk_injoffset(), which will be called whenever a timekeeping
   offset is injected by a syscall from userspace,
 - audit_ntp_adjust(), which will be called whenever an NTP internal
   variable is changed by a syscall from userspace.

Quick reference for the fields of the new records:
    AUDIT_TIME_INJOFFSET
        sec - the 'seconds' part of the offset
        nsec - the 'nanoseconds' part of the offset
    AUDIT_TIME_ADJNTPVAL
        op - which value was adjusted:
            offset - corresponding to the time_offset variable
            freq   - corresponding to the time_freq variable
            status - corresponding to the time_status variable
            maxerr - corresponding to the time_maxerror variable
            esterr - corresponding to the time_esterror variable
            const  - corresponding to the time_constant variable
            adjust - corresponding to the time_adjust variable
            tick   - corresponding to the tick_usec variable
            tai    - corresponding to the timekeeping's TAI offset
        old - the old value
        new - the new value

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/audit.h      | 21 +++++++++++++++++++++
 include/uapi/linux/audit.h |  2 ++
 kernel/auditsc.c           | 15 +++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 9334fbef7bae..0d084d4b4042 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -26,6 +26,7 @@
 #include <linux/sched.h>
 #include <linux/ptrace.h>
 #include <uapi/linux/audit.h>
+#include <uapi/linux/timex.h>
 
 #define AUDIT_INO_UNSET ((unsigned long)-1)
 #define AUDIT_DEV_UNSET ((dev_t)-1)
@@ -356,6 +357,8 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
 extern void __audit_mmap_fd(int fd, int flags);
 extern void __audit_log_kern_module(char *name);
 extern void __audit_fanotify(unsigned int response);
+extern void __audit_tk_injoffset(struct timespec64 offset);
+extern void __audit_ntp_adjust(const char *type, s64 oldval, s64 newval);
 
 static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
@@ -458,6 +461,18 @@ static inline void audit_fanotify(unsigned int response)
 		__audit_fanotify(response);
 }
 
+static inline void audit_tk_injoffset(struct timespec64 offset)
+{
+	if (!audit_dummy_context())
+		__audit_tk_injoffset(offset);
+}
+
+static inline void audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
+{
+	if (!audit_dummy_context())
+		__audit_ntp_adjust(type, oldval, newval);
+}
+
 extern int audit_n_rules;
 extern int audit_signals;
 #else /* CONFIG_AUDITSYSCALL */
@@ -584,6 +599,12 @@ static inline void audit_log_kern_module(char *name)
 static inline void audit_fanotify(unsigned int response)
 { }
 
+static inline void audit_tk_injoffset(struct timespec64 offset)
+{ }
+
+static inline void audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
+{ }
+
 static inline void audit_ptrace(struct task_struct *t)
 { }
 #define audit_n_rules 0
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 4e3eaba84175..242ce562b41a 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -114,6 +114,8 @@
 #define AUDIT_REPLACE		1329	/* Replace auditd if this packet unanswerd */
 #define AUDIT_KERN_MODULE	1330	/* Kernel Module events */
 #define AUDIT_FANOTIFY		1331	/* Fanotify access decision */
+#define AUDIT_TIME_INJOFFSET	1332	/* Timekeeping offset injected */
+#define AUDIT_TIME_ADJNTPVAL	1333	/* NTP value adjustment */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index fb207466e99b..d355d32d9765 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2422,6 +2422,21 @@ void __audit_fanotify(unsigned int response)
 		AUDIT_FANOTIFY,	"resp=%u", response);
 }
 
+/* We need to allocate with GFP_ATOMIC here, since these two functions will be
+ * called while holding the timekeeping lock: */
+void __audit_tk_injoffset(struct timespec64 offset)
+{
+	audit_log(audit_context(), GFP_ATOMIC, AUDIT_TIME_INJOFFSET,
+		  "sec=%lli nsec=%li", (long long)offset.tv_sec, offset.tv_nsec);
+}
+
+void __audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
+{
+	audit_log(audit_context(), GFP_ATOMIC, AUDIT_TIME_ADJNTPVAL,
+		  "op=%s old=%lli new=%lli", type,
+		  (long long)oldval, (long long)newval);
+}
+
 static void audit_log_task(struct audit_buffer *ab)
 {
 	kuid_t auid, uid;
-- 
2.17.1

