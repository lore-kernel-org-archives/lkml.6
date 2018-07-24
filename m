Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA26C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44E120880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44E120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388477AbeGXNcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:32:05 -0400
Received: from foss.arm.com ([217.140.101.70]:49942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388264AbeGXNcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:32:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D187880D;
        Tue, 24 Jul 2018 05:25:50 -0700 (PDT)
Received: from e108498-lin.Emea.Arm.com (e108498-lin.emea.arm.com [10.4.13.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62F613F6A8;
        Tue, 24 Jul 2018 05:25:46 -0700 (PDT)
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
Subject: [PATCH v5 04/14] PM / EM: Expose the Energy Model in sysfs
Date:   Tue, 24 Jul 2018 13:25:11 +0100
Message-Id: <20180724122521.22109-5-quentin.perret@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724122521.22109-1-quentin.perret@arm.com>
References: <20180724122521.22109-1-quentin.perret@arm.com>
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
   │   ├── cost
   │   ├── cpus
   │   ├── frequency
   │   └── power
   └── fd4
       ├── cost
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
 kernel/power/energy_model.c  | 90 ++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index be822ce05c17..4c3a98bd1df4 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -19,6 +19,7 @@ struct em_cap_state {
 struct em_freq_domain {
 	struct em_cap_state *table; /* Capacity states, in ascending order. */
 	int nr_cap_states;
+	struct kobject kobj;
 	unsigned long cpus[0]; /* CPUs of the frequency domain. */
 };
 
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 39740fe728ea..aa6c0bc5e784 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -23,6 +23,82 @@ static DEFINE_PER_CPU(struct em_freq_domain *, em_data);
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
+	for (i = 0; i < fd->nr_cap_states; i++) { \
+		if (cnt >= (ssize_t) (PAGE_SIZE / sizeof(char) \
+				      - (EM_ATTR_LEN + 2))) \
+			goto out; \
+		cnt += scnprintf(&buf[cnt], EM_ATTR_LEN + 1, "%lu ", \
+				 fd->table[i]._attr); \
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
+define_fd_attr(cost);
+define_fd_attr(cpus);
+
+static struct attribute *em_fd_default_attrs[] = {
+	&fd_attr(power).attr,
+	&fd_attr(frequency).attr,
+	&fd_attr(cost).attr,
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
 static struct em_freq_domain *em_create_fd(cpumask_t *span, int nr_states,
 						struct em_data_callback *cb)
 {
@@ -102,6 +178,11 @@ static struct em_freq_domain *em_create_fd(cpumask_t *span, int nr_states,
 	fd->nr_cap_states = nr_states;
 	cpumask_copy(to_cpumask(fd->cpus), span);
 
+	ret = kobject_init_and_add(&fd->kobj, &ktype_em_fd, em_kobject,
+				   "fd%u", cpu);
+	if (ret)
+		pr_err("fd%d: failed kobject_init_and_add(): %d\n", cpu, ret);
+
 	return fd;
 
 free_cs_table:
@@ -155,6 +236,15 @@ int em_register_freq_domain(cpumask_t *span, unsigned int nr_states,
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
 	for_each_cpu(cpu, span) {
 		/* Make sure we don't register again an existing domain. */
 		if (READ_ONCE(per_cpu(em_data, cpu))) {
-- 
2.18.0

