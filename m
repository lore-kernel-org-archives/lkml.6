Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4570AC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FE72729E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FE72729E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965610AbeF1LlX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:41:23 -0400
Received: from foss.arm.com ([217.140.101.70]:45772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965570AbeF1LlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:41:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA33116A3;
        Thu, 28 Jun 2018 04:41:17 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2F0C3F266;
        Thu, 28 Jun 2018 04:41:13 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org, quentin.perret@arm.com
Subject: [RFC PATCH v4 04/12] PM / EM: Expose the Energy Model in sysfs
Date:   Thu, 28 Jun 2018 12:40:35 +0100
Message-Id: <20180628114043.24724-5-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628114043.24724-1-quentin.perret@arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the Energy Model (read-only) of all frequency domains in sysfs
for convenience. To do so, add a kobject to the CPU subsystem under the
umbrella of which a kobject for each frequency domain is attached.

The resulting hierarchy is as follows for a platform with two frequency
domains for example:

   /sys/devices/system/cpu/energy_model
   ├── fd0
   │   ├── capacity
   │   ├── cpus
   │   ├── frequency
   │   └── power
   └── fd4
       ├── capacity
       ├── cpus
       ├── frequency
       └── power

In this implementation, the kobject abstraction is only used as a
convenient way of exposing data to sysfs. However, it could also be
used in the future to allocate and release frequency domains in a more
dynamic way using reference counting.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 include/linux/energy_model.h |  1 +
 kernel/power/energy_model.c  | 94 ++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 88c2f0b9bcb3..0f109cefed62 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -23,6 +23,7 @@ struct em_cs_table {
 
 struct em_freq_domain {
 	struct em_cs_table *cs_table; /* Capacity state table, RCU-protected */
+	struct kobject kobj;
 	unsigned long cpus[0]; /* CPUs of the frequency domain. */
 };
 
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 08ce4035a6d6..53456147e656 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -23,6 +23,86 @@ static DEFINE_PER_CPU(struct em_freq_domain *, em_data);
  */
 static DEFINE_MUTEX(em_fd_mutex);
 
+static struct kobject *em_kobject;
+
+/* Getters for the attributes of em_freq_domain objects */
+struct em_fd_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct em_freq_domain *fd, char *buf);
+	ssize_t (*store)(struct em_freq_domain *fd, const char *buf, size_t s);
+};
+
+#define EM_ATTR_LEN 13
+#define show_table_attr(_attr) \
+static ssize_t show_##_attr(struct em_freq_domain *fd, char *buf) \
+{ \
+	ssize_t cnt = 0; \
+	int i; \
+	struct em_cs_table *table; \
+	rcu_read_lock(); \
+	table = rcu_dereference(fd->cs_table);\
+	for (i = 0; i < table->nr_cap_states; i++) { \
+		if (cnt >= (ssize_t) (PAGE_SIZE / sizeof(char) \
+				      - (EM_ATTR_LEN + 2))) \
+			goto out; \
+		cnt += scnprintf(&buf[cnt], EM_ATTR_LEN + 1, "%lu ", \
+				 table->state[i]._attr); \
+	} \
+out: \
+	rcu_read_unlock(); \
+	cnt += sprintf(&buf[cnt], "\n"); \
+	return cnt; \
+}
+
+show_table_attr(power);
+show_table_attr(frequency);
+show_table_attr(capacity);
+
+static ssize_t show_cpus(struct em_freq_domain *fd, char *buf)
+{
+	return sprintf(buf, "%*pbl\n", cpumask_pr_args(to_cpumask(fd->cpus)));
+}
+
+#define fd_attr(_name) em_fd_##_name##_attr
+#define define_fd_attr(_name) static struct em_fd_attr fd_attr(_name) = \
+		__ATTR(_name, 0444, show_##_name, NULL)
+
+define_fd_attr(power);
+define_fd_attr(frequency);
+define_fd_attr(capacity);
+define_fd_attr(cpus);
+
+static struct attribute *em_fd_default_attrs[] = {
+	&fd_attr(power).attr,
+	&fd_attr(frequency).attr,
+	&fd_attr(capacity).attr,
+	&fd_attr(cpus).attr,
+	NULL
+};
+
+#define to_fd(k) container_of(k, struct em_freq_domain, kobj)
+#define to_fd_attr(a) container_of(a, struct em_fd_attr, attr)
+
+static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	struct em_freq_domain *fd = to_fd(kobj);
+	struct em_fd_attr *fd_attr = to_fd_attr(attr);
+	ssize_t ret;
+
+	ret = fd_attr->show(fd, buf);
+
+	return ret;
+}
+
+static const struct sysfs_ops em_fd_sysfs_ops = {
+	.show	= show,
+};
+
+static struct kobj_type ktype_em_fd = {
+	.sysfs_ops	= &em_fd_sysfs_ops,
+	.default_attrs	= em_fd_default_attrs,
+};
+
 static struct em_cs_table *alloc_cs_table(int nr_cs)
 {
 	struct em_cs_table *cs_table;
@@ -142,6 +222,11 @@ static struct em_freq_domain *em_create_fd(cpumask_t *span, int nr_states,
 	/* Copy the span of the frequency domain */
 	cpumask_copy(to_cpumask(fd->cpus), span);
 
+	ret = kobject_init_and_add(&fd->kobj, &ktype_em_fd, em_kobject,
+				   "fd%u", cpu);
+	if (ret)
+		pr_err("fd%d: failed kobject_init_and_add(): %d\n", cpu, ret);
+
 	return fd;
 
 free_cs_table:
@@ -247,6 +332,15 @@ int em_register_freq_domain(cpumask_t *span, unsigned int nr_states,
 	 */
 	mutex_lock(&em_fd_mutex);
 
+	if (!em_kobject) {
+		em_kobject = kobject_create_and_add("energy_model",
+						&cpu_subsys.dev_root->kobj);
+		if (!em_kobject) {
+			ret = -ENODEV;
+			goto unlock;
+		}
+	}
+
 	/* Make sure we don't register again an existing domain. */
 	for_each_cpu(cpu, span) {
 		if (READ_ONCE(per_cpu(em_data, cpu))) {
-- 
2.17.1

