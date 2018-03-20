Return-Path: <dietmar.eggemann@arm.com>
X-Google-Smtp-Source: AG47ELse114KTEIC9G3LuJstPuVVARMyez5UYjkZWKxuRHPkk/16uxbxaI3l1XtIzqQue+uk6OXQ
ARC-Seal: i=1; a=rsa-sha256; t=1521539050; cv=none;
        d=google.com; s=arc-20160816;
        b=tuRBP7dBSu07zRx6i2YKjlqxb4aJ/3JaEPq6+ie7KFmo6UB9HY8M/ddeeopJWb37cm
         So6MfExQUcGn544H2u5wzOygG8tX9ctFBQoJpH3F4WyYZttyTVrnXrIS9I72/6YZF27a
         4lzNOD/VMeNw7Hoqu6B45O7VJag2aCSZn+SCZd/pX/frddwIHD+n0v6EI0K3bZqPZwER
         zQyqkQBxaSexyYZVyj5UjxBeeED5pt1QzyfFaRYXjLh0onJFPTPu50zxUD8+ZhJd/1ge
         XhaNHT4IXwwsfaNhiveob4PE/5mYgsjeFDn5o6zCRGJKTLWBg5tfUqSvj/Rny4Owaztw
         7sGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=z2eGD7sMS6n2Xu0+PF0ObPLSE0/fOQUVp8lL2WPm55M=;
        b=O6GxGdVGpShumvsMu1bHh6W8KhAA18oRfopopVAm5LyoEDwobSSpqrV1KdcY56w+Wn
         R7yZ+dpDNOx0X2iJinKdA+UX1PJ45stPd1K7glcCl5vtM5OtA9g6XIKrIsXGI/SHjl0L
         Jw+rrl+y4gVywIMQ3dSlXjoluc51q6MvrIVcEn1hk3Igi0HWFoygc9HJOH8fq07LVfO9
         aNeeJNVfeBdv4UT+q14faq4OTvJLR1QKOCcI6i/FNEiCYnAlHJwbnZSbS0lLy9w0CEKm
         4bRbbwS7meHa/L+3QRr26YNCYSzl5xEkaESlxbNo8zp/XweRjbJe6K2TTH3TC52WBoNz
         mT1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Quentin Perret <quentin.perret@arm.com>,
	Thara Gopinath <thara.gopinath@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>,
	Joel Fernandes <joelaf@google.com>
Subject: [RFC PATCH 1/6] sched/fair: Create util_fits_capacity()
Date: Tue, 20 Mar 2018 09:43:07 +0000
Message-Id: <20180320094312.24081-2-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180320094312.24081-1-dietmar.eggemann@arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449331370136556?=
X-GMAIL-MSGID: =?utf-8?q?1595449331370136556?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The functionality that a given utilization fits into a given capacity
is factored out into a separate function.

Currently it is only used in wake_cap() but will be re-used to figure
out if a cpu or a scheduler group is over-utilized.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3582117e1580..bf7b485ddf60 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6374,6 +6374,11 @@ static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
 	return (util >= capacity) ? capacity : util;
 }
 
+static inline int util_fits_capacity(unsigned long util, unsigned long capacity)
+{
+	return capacity * 1024 > util * capacity_margin;
+}
+
 /*
  * Disable WAKE_AFFINE in the case where task @p doesn't fit in the
  * capacity of either the waking CPU @cpu or the previous CPU @prev_cpu.
@@ -6395,7 +6400,7 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 	/* Bring task utilization in sync with prev_cpu */
 	sync_entity_load_avg(&p->se);
 
-	return min_cap * 1024 < task_util(p) * capacity_margin;
+	return !util_fits_capacity(task_util(p), min_cap);
 }
 
 /*
-- 
2.11.0
