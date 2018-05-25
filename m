Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965618AbeEYKUI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:20:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55289 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936153AbeEYKUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:20:04 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bigeasy@linutronix.de
Subject: [PATCH 2/2] cpufreq: Use static SRCU initializer
Date: Fri, 25 May 2018 12:19:58 +0200
Message-Id: <20180525101958.13277-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525101958.13277-1-bigeasy@linutronix.de>
References: <20180525101958.13277-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the static SRCU initializer for `cpufreq_transition_notifier_list'.
This avoids the init_cpufreq_transition_notifier_list() initcall. Its
only purpose is to initialize the SRCU notifier once during boot and set
another variable which is used as an indicator whether the init was
perfromed before cpufreq_register_notifier() was used.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/cpufreq/cpufreq.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 075d18f6ba7a..3f7b502cfb1e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -89,16 +89,7 @@ static void cpufreq_governor_limits(struct cpufreq_polic=
y *policy);
  * The mutex locks both lists.
  */
 static BLOCKING_NOTIFIER_HEAD(cpufreq_policy_notifier_list);
-static struct srcu_notifier_head cpufreq_transition_notifier_list;
-
-static bool init_cpufreq_transition_notifier_list_called;
-static int __init init_cpufreq_transition_notifier_list(void)
-{
-	srcu_init_notifier_head(&cpufreq_transition_notifier_list);
-	init_cpufreq_transition_notifier_list_called =3D true;
-	return 0;
-}
-pure_initcall(init_cpufreq_transition_notifier_list);
+SRCU_NOTIFIER_HEAD_STATIC(cpufreq_transition_notifier_list);
=20
 static int off __read_mostly;
 static int cpufreq_disabled(void)
@@ -1764,8 +1755,6 @@ int cpufreq_register_notifier(struct notifier_block *=
nb, unsigned int list)
 	if (cpufreq_disabled())
 		return -EINVAL;
=20
-	WARN_ON(!init_cpufreq_transition_notifier_list_called);
-
 	switch (list) {
 	case CPUFREQ_TRANSITION_NOTIFIER:
 		mutex_lock(&cpufreq_fast_switch_lock);
--=20
2.17.0
