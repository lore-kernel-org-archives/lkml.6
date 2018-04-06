Return-Path: <dietmar.eggemann@arm.com>
X-Google-Smtp-Source: AIpwx4+vROseLfOQ86rOFgpJp5j27ravZg0axo1nyNQorhvVH30/vRGKlT0taMCRwN9FdOu46abh
ARC-Seal: i=1; a=rsa-sha256; t=1523029020; cv=none;
        d=google.com; s=arc-20160816;
        b=lfyy8VPV6+6DOVvFtfj6FQdFPpY6O1TWfLXZ58YS+rB/CMxOZNIZnzkkPAUM8OtsMf
         lha2WhBsiuIaheLQ9WU+AbeskGviTuYIKrITanuLOepWZo/lJK1q1XPMh1pACuF1v73A
         4Y7G59SjkPp6PbFZ0gpxMlbTco80yo4fEpJuak6wLeCGXqw9hpdIfhoemPJZJaGFDrBd
         vkoo84TxVPendxBJxqCP8zvXHWBt9kG6KT7T4Ao2cv2W3k4OSMeii+0qdnPp0ALqhxsv
         GhlbVlOtQcfgI8MiDM0faC/8Zfic6O6S0Yh9Ba5nbilhAhwyPX6MyE7Yts8lSNZ6wvsF
         iZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=bzoJDBmbDeCuM7YYPaEK/imuGaxN9mX+raBFo67tLvU=;
        b=baehzg4+KXcCG8eSMLppW5HQKTM1bCX+pV70E8cJUf+MtmkPQKeEI6tZnABTgHGlmI
         EowCZTDo1EHoz5dZinxnMB0PjzrFYYQHr3pmQR5iagDL6ep9AhGahiaYfyNWzPxhGlkN
         DTU1Yg2SjSG5Kyhpj5983rT3xZMl/b12ioH/YOeOkNlsQEVGz/8oY5YOT23dI4NtClMR
         NJksTpGr2zuCZKmMgmvr8g+J5LKhgrrdpdsDG5EVzWgrYPDXk8weYpex0oavm7+1iKJO
         CjQT+XBerVv8ZOnUvFPGp9Nu80B0WapeiRYbEf8rpkmXjkd8cR4yVh5y4O4ttWGDdXqU
         Dggg==
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
Subject: [RFC PATCH v2 1/6] sched/fair: Create util_fits_capacity()
Date: Fri,  6 Apr 2018 16:36:02 +0100
Message-Id: <20180406153607.17815-2-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180406153607.17815-1-dietmar.eggemann@arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011678153302942?=
X-GMAIL-MSGID: =?utf-8?q?1597011678153302942?=
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
index 0951d1c58d2f..0a76ad2ef022 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6574,6 +6574,11 @@ static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
 	return min_t(unsigned long, util, capacity_orig_of(cpu));
 }
 
+static inline int util_fits_capacity(unsigned long util, unsigned long capacity)
+{
+	return capacity * 1024 > util * capacity_margin;
+}
+
 /*
  * Disable WAKE_AFFINE in the case where task @p doesn't fit in the
  * capacity of either the waking CPU @cpu or the previous CPU @prev_cpu.
@@ -6595,7 +6600,7 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 	/* Bring task utilization in sync with prev_cpu */
 	sync_entity_load_avg(&p->se);
 
-	return min_cap * 1024 < task_util(p) * capacity_margin;
+	return !util_fits_capacity(task_util(p), min_cap);
 }
 
 /*
-- 
2.11.0
