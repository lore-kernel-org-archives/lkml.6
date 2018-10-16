Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F64C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA2E2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA2E2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeJPSFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:05:25 -0400
Received: from foss.arm.com ([217.140.101.70]:33798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbeJPSFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:05:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD38B341;
        Tue, 16 Oct 2018 03:15:41 -0700 (PDT)
Received: from queper01-lin.local (unknown [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C0E33F59C;
        Tue, 16 Oct 2018 03:15:37 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org,
        quentin.perret@arm.com
Subject: [PATCH v8 04/15] PM / EM: Expose the Energy Model in sysfs
Date:   Tue, 16 Oct 2018 11:15:02 +0100
Message-Id: <20181016101513.26919-5-quentin.perret@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016101513.26919-1-quentin.perret@arm.com>
References: <20181016101513.26919-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the Energy Model (read-only) of all performance domains in sysfs
for convenience. To do so, add a kobject to the CPU subsystem under the
umbrella of which a kobject for each performance domain is attached.

The resulting hierarchy is as follows for a platform with two
performance domains for example:

   /sys/devices/system/cpu/energy_model
   ├── pd0
   │   ├── cost
   │   ├── cpus
   │   ├── frequency
   │   └── power
   └── pd4
       ├── cost
       ├── cpus
       ├── frequency
       └── power

In this implementation, the kobject abstraction is only used as a
convenient way of exposing data to sysfs. However, it could also be
used in the future to allocate and release performance domains in a more
dynamic way using reference counting.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 include/linux/energy_model.h |  2 +
 kernel/power/energy_model.c  | 90 ++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index aa027f7bcb3e..55deab2b38dc 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -27,6 +27,7 @@ struct em_cap_state {
  * em_perf_domain - Performance domain
  * @table:		List of capacity states, in ascending order
  * @nr_cap_states:	Number of capacity states
+ * @kobj:		Kobject used to expose the domain in sysfs
  * @cpus:		Cpumask covering the CPUs of the domain
  *
  * A "performance domain" represents a group of CPUs whose performance is
@@ -37,6 +38,7 @@ struct em_cap_state {
 struct em_perf_domain {
 	struct em_cap_state *table;
 	int nr_cap_states;
+	struct kobject kobj;
 	unsigned long cpus[0];
 };
 
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index d9dc2c38764a..5ec376d4f2f3 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -23,6 +23,82 @@ static DEFINE_PER_CPU(struct em_perf_domain *, em_data);
  */
 static DEFINE_MUTEX(em_pd_mutex);
 
+static struct kobject *em_kobject;
+
+/* Getters for the attributes of em_perf_domain objects */
+struct em_pd_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct em_perf_domain *pd, char *buf);
+	ssize_t (*store)(struct em_perf_domain *pd, const char *buf, size_t s);
+};
+
+#define EM_ATTR_LEN 13
+#define show_table_attr(_attr) \
+static ssize_t show_##_attr(struct em_perf_domain *pd, char *buf) \
+{ \
+	ssize_t cnt = 0; \
+	int i; \
+	for (i = 0; i < pd->nr_cap_states; i++) { \
+		if (cnt >= (ssize_t) (PAGE_SIZE / sizeof(char) \
+				      - (EM_ATTR_LEN + 2))) \
+			goto out; \
+		cnt += scnprintf(&buf[cnt], EM_ATTR_LEN + 1, "%lu ", \
+				 pd->table[i]._attr); \
+	} \
+out: \
+	cnt += sprintf(&buf[cnt], "\n"); \
+	return cnt; \
+}
+
+show_table_attr(power);
+show_table_attr(frequency);
+show_table_attr(cost);
+
+static ssize_t show_cpus(struct em_perf_domain *pd, char *buf)
+{
+	return sprintf(buf, "%*pbl\n", cpumask_pr_args(to_cpumask(pd->cpus)));
+}
+
+#define pd_attr(_name) em_pd_##_name##_attr
+#define define_pd_attr(_name) static struct em_pd_attr pd_attr(_name) = \
+		__ATTR(_name, 0444, show_##_name, NULL)
+
+define_pd_attr(power);
+define_pd_attr(frequency);
+define_pd_attr(cost);
+define_pd_attr(cpus);
+
+static struct attribute *em_pd_default_attrs[] = {
+	&pd_attr(power).attr,
+	&pd_attr(frequency).attr,
+	&pd_attr(cost).attr,
+	&pd_attr(cpus).attr,
+	NULL
+};
+
+#define to_pd(k) container_of(k, struct em_perf_domain, kobj)
+#define to_pd_attr(a) container_of(a, struct em_pd_attr, attr)
+
+static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	struct em_perf_domain *pd = to_pd(kobj);
+	struct em_pd_attr *pd_attr = to_pd_attr(attr);
+	ssize_t ret;
+
+	ret = pd_attr->show(pd, buf);
+
+	return ret;
+}
+
+static const struct sysfs_ops em_pd_sysfs_ops = {
+	.show	= show,
+};
+
+static struct kobj_type ktype_em_pd = {
+	.sysfs_ops	= &em_pd_sysfs_ops,
+	.default_attrs	= em_pd_default_attrs,
+};
+
 static struct em_perf_domain *em_create_pd(cpumask_t *span, int nr_states,
 						struct em_data_callback *cb)
 {
@@ -102,6 +178,11 @@ static struct em_perf_domain *em_create_pd(cpumask_t *span, int nr_states,
 	pd->nr_cap_states = nr_states;
 	cpumask_copy(to_cpumask(pd->cpus), span);
 
+	ret = kobject_init_and_add(&pd->kobj, &ktype_em_pd, em_kobject,
+				   "pd%u", cpu);
+	if (ret)
+		pr_err("pd%d: failed kobject_init_and_add(): %d\n", cpu, ret);
+
 	return pd;
 
 free_cs_table:
@@ -155,6 +236,15 @@ int em_register_perf_domain(cpumask_t *span, unsigned int nr_states,
 	 */
 	mutex_lock(&em_pd_mutex);
 
+	if (!em_kobject) {
+		em_kobject = kobject_create_and_add("energy_model",
+						&cpu_subsys.dev_root->kobj);
+		if (!em_kobject) {
+			ret = -ENODEV;
+			goto unlock;
+		}
+	}
+
 	for_each_cpu(cpu, span) {
 		/* Make sure we don't register again an existing domain. */
 		if (READ_ONCE(per_cpu(em_data, cpu))) {
-- 
2.19.1

