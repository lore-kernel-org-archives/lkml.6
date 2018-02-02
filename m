Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2279QuZJJS7jEnjFg4hVJFPvDHWixSPo/TlBjy7nPcd/DOMARBfL6eSZnAOy0ZSxuCtL7yPH
ARC-Seal: i=1; a=rsa-sha256; t=1517591360; cv=none;
        d=google.com; s=arc-20160816;
        b=o4ZgsN/y/jVyC4kIFnAp+5I9EAkkiQtimGP0jg68pdDQ7wX7tt0WLVSCTQYgDwTMO8
         JQ54PhF/Y7dc8PkD/LiRntITGS0M1kUrH2APS6YLnYbd8KqHQvTjQyKh0c5z2Vpp9nfY
         RDBXCKg0oFCuDQKQDST/uJErnhn7bxsoxCove4DQBfG81cA+eXyajCZOwNMcxsvO+iEi
         WcIZMtKb2CDANRN0bzWZDA+kodTqKqulaKAJO5EJm0nkk2jH+cCWx1N2LNPmn9PE0hAo
         F+ayzXMu89iTndSDPgRwBVjyGxqCcC1ZDRUn3FRb0dZlv+ss7FSFVDkpB/kc1jNe9e5u
         yHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RW0H42zTgH2N+vznrbHUo2wynRrWv/IbIC+CENIPIno=;
        b=GSeWPYTYHrea9/nOn58ef3vqLbpZiplr8AS0atF27EbPGuCHhng4MYdA/6Q5igS4FK
         0hs3dq4kJ1nFYk8ayDbU4lv3/kQbR+qiwKAbWwwDFtwNP7rFUO5e3TnALAPydC41nE+L
         dViiMtwEuwnjav/bHhWOOKj+83vMx0ghGtfAii5kTzm/tQpXS0vlYaq7baGno/ry644e
         rwxfUJh4gVslqLlD37r/IeJn8nZYaZmi2CR5Rq0hUvQvhqDSCJHPM9HUX04fwGIY+uJI
         63CSGw5pIg39UFlYAKZXpbQfR9O9bhUwVwyEk7z15ASkJwsk3hh7AJI9rAxQDrWjnVqr
         +Umw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Richter <tmricht@linux.vnet.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 052/156] s390/topology: fix compile error in file arch/s390/kernel/smp.c
Date: Fri,  2 Feb 2018 17:57:13 +0100
Message-Id: <20180202140842.624588367@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309878408349598?=
X-GMAIL-MSGID: =?utf-8?q?1591309878408349598?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Richter <tmricht@linux.vnet.ibm.com>


[ Upstream commit 38389ec84e835fa31a59b7dabb18343106a6d0d5 ]

Commit 1887aa07b676
("s390/topology: add detection of dedicated vs shared CPUs")
introduced following compiler error when CONFIG_SCHED_TOPOLOGY is not set.

 CC      arch/s390/kernel/smp.o
...
arch/s390/kernel/smp.c: In function ‘smp_start_secondary’:
arch/s390/kernel/smp.c:812:6: error: implicit declaration of function
	‘topology_cpu_dedicated’; did you mean ‘topology_cpu_init’?

This patch fixes the compiler error by adding function
topology_cpu_dedicated() to return false when this config option is
not defined.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/topology.h |    1 +
 arch/s390/kernel/smp.c           |    1 +
 2 files changed, 2 insertions(+)

--- a/arch/s390/include/asm/topology.h
+++ b/arch/s390/include/asm/topology.h
@@ -51,6 +51,7 @@ const struct cpumask *cpu_coregroup_mask
 static inline void topology_init_early(void) { }
 static inline void topology_schedule_update(void) { }
 static inline int topology_cpu_init(struct cpu *cpu) { return 0; }
+static inline int topology_cpu_dedicated(int cpu_nr) { return 0; }
 static inline void topology_expect_change(void) { }
 
 #endif /* CONFIG_SCHED_TOPOLOGY */
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -54,6 +54,7 @@
 #include <asm/sigp.h>
 #include <asm/idle.h>
 #include <asm/nmi.h>
+#include <asm/topology.h>
 #include "entry.h"
 
 enum {
