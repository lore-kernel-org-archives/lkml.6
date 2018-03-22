Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AG47ELts1xw6vZ7SmNxXnWI4/7f7gghSPmAKpiA/bNpD8GwIGNzZ40iTU9rZrM3AvspDqhojWjvy
ARC-Seal: i=1; a=rsa-sha256; t=1521718541; cv=none;
        d=google.com; s=arc-20160816;
        b=cvl/OQK/zQeq8wW3hTi5DkwsKt/ZwVIaEG4ClthFjJPMWclfD5YrO512yIDCQmq646
         3FbougqmijVDwSXQGbPnWyQtIZWgVkr8QjkbITHAACdaiRXm/Od23UgE8k/MnHChTQKG
         RTt9Zx4KhqB6u8XQDAwHF0Vq0AYy4XxD7qG156xY+vTeMfpvNKGyV88BjE8LHJV5S5IL
         DDonBl3btYuMJs7SpK3eGjCHayHg2y1MNCOX3SqSjafeMIDfxpwL/FJPeqCgoRAH8G+G
         r+4OmNo6Xrm8zFd/MTdjAK20eIP5kSIa06rDgOPk3QuS4CwiW9Nr3wT91MWKtHniLv08
         26Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=Ij30qKQTRew4BWVgEsmupxA1y6SDQyLpL315HZpzG7w=;
        b=agBluYG+e5KuumMgFEo1SFzW/BNATO60m99AXxQ5a3+XXnXOJfjuzQ6atRtsp8rMIk
         uSMhrkIsC3oBrwZSNgip2oLDLQvpHDbZ/vYlxkUH6O7EqGAU2ripyseZACgQIL6V0hG7
         PW9L+4JRfiwgOIIV62Ocms2Y9/K1Y4/OOYKEjkgITjlFUOtRjxzj6mAh4+A0pnxLwV1r
         ldt1NUL5eZWNU9WnBSUVe4QxXhwhJP6cjXeXmTA6jwsRJkX/24rzBz91RuZgFzD8bk6z
         UPUoLU2qQiPcBZfEwdObw7QMezOM9OVGE5BrBHLm+b/sInmf5QPcf/YYD4Q6OMo31RMw
         II1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Thu, 22 Mar 2018 04:34:55 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-19b558db12f9f4e45a22012bae7b4783e62224da@git.kernel.org>
Cc: dwmw@amazon.co.uk, linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, rasmus.villemoes@prevas.dk,
        dan.j.williams@intel.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, gregkh@linuxfoundation.org, hpa@zytor.com
Reply-To: rasmus.villemoes@prevas.dk, dan.j.williams@intel.com,
        tglx@linutronix.de, torvalds@linux-foundation.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, dwmw@amazon.co.uk, mingo@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.1802151718320.1296@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1802151718320.1296@nanos.tec.linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] posix-timers: Protect posix clock array access
 against speculation
Git-Commit-ID: 19b558db12f9f4e45a22012bae7b4783e62224da
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592473683460033132?=
X-GMAIL-MSGID: =?utf-8?q?1595637541254494302?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  19b558db12f9f4e45a22012bae7b4783e62224da
Gitweb:     https://git.kernel.org/tip/19b558db12f9f4e45a22012bae7b4783e62224da
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 15 Feb 2018 17:21:55 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 22 Mar 2018 12:29:27 +0100

posix-timers: Protect posix clock array access against speculation

The clockid argument of clockid_to_kclock() comes straight from user space
via various syscalls and is used as index into the posix_clocks array.

Protect it against spectre v1 array out of bounds speculation. Remove the
redundant check for !posix_clock[id] as this is another source for
speculation and does not provide any advantage over the return
posix_clock[id] path which returns NULL in that case anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1802151718320.1296@nanos.tec.linutronix.de

---
 kernel/time/posix-timers.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 75043046914e..10b7186d0638 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -50,6 +50,7 @@
 #include <linux/export.h>
 #include <linux/hashtable.h>
 #include <linux/compat.h>
+#include <linux/nospec.h>
 
 #include "timekeeping.h"
 #include "posix-timers.h"
@@ -1346,11 +1347,15 @@ static const struct k_clock * const posix_clocks[] = {
 
 static const struct k_clock *clockid_to_kclock(const clockid_t id)
 {
-	if (id < 0)
+	clockid_t idx = id;
+
+	if (id < 0) {
 		return (id & CLOCKFD_MASK) == CLOCKFD ?
 			&clock_posix_dynamic : &clock_posix_cpu;
+	}
 
-	if (id >= ARRAY_SIZE(posix_clocks) || !posix_clocks[id])
+	if (id >= ARRAY_SIZE(posix_clocks))
 		return NULL;
-	return posix_clocks[id];
+
+	return posix_clocks[array_index_nospec(idx, ARRAY_SIZE(posix_clocks))];
 }
