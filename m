Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36324C43615
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB14C21567
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB14C21567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeHXPev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:34:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38201 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbeHXPet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:34:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so1401297wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 05:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wUNZjBs3x2BpYeObbya9Dwob7XVqYxjZ99LkVl+ORG8=;
        b=hIQRJMa3FtsD1lGLxlGJt7gsckUSORoWoXA1/nLjrzbyaXxS/Tgtgm8A8PheYvrfzz
         Mt92JyS8hQ2TOfl1zLWN4+uHN27QM3bBymL4hg8fhVSyH82KUZfxvW3fScm6o/sZUlL2
         XHniq0ijK/1yhzgrQ14b068XTB/c40Ue4q6gjhhYygGnz12FLdMY9lZsAT659TLt7BLA
         U8oBwdRTgF91flJfbT4HXJxD2NDnE8AdSbt3CMu4feTdOhvybrX8kJ7QHD3yheDfQPn/
         LKeVh6Y0bSW/GkPhDcj5golqEdSmRa99xHy3UZ/1bMy9jpb4y/SxO8Fvg2g2XNIaWn8F
         11Jg==
X-Gm-Message-State: APzg51Al3jxflqJCmr4jZGEAtQY4x83J5nqd5pYkgRiT4Lohb083TZYB
        wB1nCZ1Kl9B+h8o4VTWjRi4zyw==
X-Google-Smtp-Source: ANB0VdYRUgBeYUnpx4w9zMJ62VYRuhZT+e3Likj0R5layslrc6Ld/yBC3iZIp22UqUzoYSMytD0X1w==
X-Received: by 2002:a1c:b45:: with SMTP id 66-v6mr1203959wml.45.1535112027290;
        Fri, 24 Aug 2018 05:00:27 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id r30-v6sm12318999wrc.90.2018.08.24.05.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 05:00:26 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-audit@redhat.com
Cc:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH ghak10 v5 1/2] audit: Add functions to log time adjustments
Date:   Fri, 24 Aug 2018 14:00:00 +0200
Message-Id: <20180824120001.20771-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180824120001.20771-1-omosnace@redhat.com>
References: <20180824120001.20771-1-omosnace@redhat.com>
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

