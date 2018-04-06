Return-Path: <dietmar.eggemann@arm.com>
X-Google-Smtp-Source: AIpwx48DaCYGdRovdwT0b0Zq/CNNST4jzHplqI+Jo8391SvTT+zDj1nWJjhH1wE1u9eaMOHD2Qyo
ARC-Seal: i=1; a=rsa-sha256; t=1523029036; cv=none;
        d=google.com; s=arc-20160816;
        b=xay7IJheT8uZzwdhsr3rTN6S4ZvIdxgbyNXEgMnHxpTPSSyvbFvUuCv8Lbo+2qnUwE
         wxlqQtX3B523gj8iazq+kgYy/fkdxIM+FcYfwOk0z1MdoE7YqKaJ+aXshunrNMnFgUJY
         OFbxF/bF0Y7EXudJxl4LkDBjlc+6GKjM8gXmdGQMUEYowUl6JHodMVwo+Hd746/HKze2
         O04yOKiCXtx/95oK0FfZqMSkv7FufB5Bl8iQ2eA+cGrVlYYwF5y30b5IhSjkFWwTM0f8
         d6GKF/ws3Xa+M3M/B2+2LextV29JayaHbNX60yZCApyfBPpY6c5GopxMHXPe8E6pLKIm
         7g1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=bGg790ld8yQQhclKQOYhOJLXPjmlYSVR8dvNt6PH4Dw=;
        b=fHn+qJ8YL5qi5Jz0tOxQPz/vKrti2bIVlkpKfscUdnxc3YAtVZZnZgGB7yXTzlYtDj
         tNiyHFRCmc9zLCm24uP8u8Vv8skMAXxCy+I77mKIwwayEd+RgpGz0iMNg8M6ICYrd983
         x2spSluHPcaUQ81XYpvZQeFIkXTFXI10wzQbjbI8kaWsF5/LZIQ2FsCHl+A2mkf487x0
         Yi/x9hXb5c+6k0Wf90uCfBX2cP3KnidpCF6NzNULicbMX0N8qjrORqnB3wCUivmeElue
         Kb3G5rKCLlkxNIGYTT2UfZsNCqHnNbiae1cow1H0rHeJdzs2EJxJG2OkJmDnax37sYls
         pkWg==
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
	Joel Fernandes <joelaf@google.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steve Muckle <smuckle@google.com>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: [RFC PATCH v2 6/6] drivers: base: arch_topology.c: Enable EAS for arm/arm64 platforms
Date: Fri,  6 Apr 2018 16:36:07 +0100
Message-Id: <20180406153607.17815-7-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180406153607.17815-1-dietmar.eggemann@arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011694863880023?=
X-GMAIL-MSGID: =?utf-8?q?1597011694863880023?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Quentin Perret <quentin.perret@arm.com>

Energy Aware Scheduling (EAS) has to be started from the arch code.
This commit enables it from the arch topology driver for arm/arm64
systems, hence enabling a better support for Arm big.LITTLE and future
DynamIQ architectures.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 drivers/base/arch_topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 52ec5174bcb1..25a70c21860f 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sched/topology.h>
+#include <linux/sched/energy.h>
 
 DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
 
@@ -247,6 +248,7 @@ static void __init parsing_done_workfn(struct work_struct *work)
 	cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
 					 CPUFREQ_POLICY_NOTIFIER);
 	free_cpumask_var(cpus_to_visit);
+	init_sched_energy();
 }
 
 #else
-- 
2.11.0
