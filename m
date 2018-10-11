Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADABC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D3F21476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEkibAys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D3F21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbeJKXNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:13:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:13:46 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23E162098A;
        Thu, 11 Oct 2018 15:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272760;
        bh=4EuDm2RNtvY4oXJUizH9r7zcvxmSRnAMVLAZHIFwVr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CEkibAyszbkojPrzRSvCTyK4oYJIIIAUQZ8YGTBR1551xj6IbdOY4RikY+hS4FROT
         ws9YMJns0/sQolT68/jNw+auPdOIIPuRYnyqYhtd0nlTJMizlYQeA7QkbhBb/Dw64W
         n1q82uwW5jsjdYlp6iHslLGFW0X+KknGWLvHEgUg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prateek Sood <prsood@codeaurora.org>,
        Tejun Heo <tj@kernel.org>, Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.14 29/45] cgroup/cpuset: remove circular dependency deadlock
Date:   Thu, 11 Oct 2018 17:39:56 +0200
Message-Id: <20181011152510.156825448@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
References: <20181011152508.885515042@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prateek Sood <prsood@codeaurora.org>

commit aa24163b2ee5c92120e32e99b5a93143a0f4258e upstream.

Remove circular dependency deadlock in a scenario where hotplug of CPU is
being done while there is updation in cgroup and cpuset triggered from
userspace.

Process A => kthreadd => Process B => Process C => Process A

Process A
cpu_subsys_offline();
  cpu_down();
    _cpu_down();
      percpu_down_write(&cpu_hotplug_lock); //held
      cpuhp_invoke_callback();
	     workqueue_offline_cpu();
            queue_work_on(); // unbind_work on system_highpri_wq
               __queue_work();
                 insert_work();
                    wake_up_worker();
            flush_work();
               wait_for_completion();

worker_thread();
   manage_workers();
      create_worker();
	     kthread_create_on_node();
		    wake_up_process(kthreadd_task);

kthreadd
kthreadd();
  kernel_thread();
    do_fork();
      copy_process();
        percpu_down_read(&cgroup_threadgroup_rwsem);
          __rwsem_down_read_failed_common(); //waiting

Process B
kernfs_fop_write();
  cgroup_file_write();
    cgroup_procs_write();
      percpu_down_write(&cgroup_threadgroup_rwsem); //held
      cgroup_attach_task();
        cgroup_migrate();
          cgroup_migrate_execute();
            cpuset_can_attach();
              mutex_lock(&cpuset_mutex); //waiting

Process C
kernfs_fop_write();
  cgroup_file_write();
    cpuset_write_resmask();
      mutex_lock(&cpuset_mutex); //held
      update_cpumask();
        update_cpumasks_hier();
          rebuild_sched_domains_locked();
            get_online_cpus();
              percpu_down_read(&cpu_hotplug_lock); //waiting

Eliminating deadlock by reversing the locking order for cpuset_mutex and
cpu_hotplug_lock.

Signed-off-by: Prateek Sood <prsood@codeaurora.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/cgroup/cpuset.c |   53 +++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -817,6 +817,18 @@ done:
 	return ndoms;
 }
 
+static void cpuset_sched_change_begin(void)
+{
+	cpus_read_lock();
+	mutex_lock(&cpuset_mutex);
+}
+
+static void cpuset_sched_change_end(void)
+{
+	mutex_unlock(&cpuset_mutex);
+	cpus_read_unlock();
+}
+
 /*
  * Rebuild scheduler domains.
  *
@@ -826,16 +838,14 @@ done:
  * 'cpus' is removed, then call this routine to rebuild the
  * scheduler's dynamic sched domains.
  *
- * Call with cpuset_mutex held.  Takes get_online_cpus().
  */
-static void rebuild_sched_domains_locked(void)
+static void rebuild_sched_domains_cpuslocked(void)
 {
 	struct sched_domain_attr *attr;
 	cpumask_var_t *doms;
 	int ndoms;
 
 	lockdep_assert_held(&cpuset_mutex);
-	get_online_cpus();
 
 	/*
 	 * We have raced with CPU hotplug. Don't do anything to avoid
@@ -843,27 +853,25 @@ static void rebuild_sched_domains_locked
 	 * Anyways, hotplug work item will rebuild sched domains.
 	 */
 	if (!cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
-		goto out;
+		return;
 
 	/* Generate domain masks and attrs */
 	ndoms = generate_sched_domains(&doms, &attr);
 
 	/* Have scheduler rebuild the domains */
 	partition_sched_domains(ndoms, doms, attr);
-out:
-	put_online_cpus();
 }
 #else /* !CONFIG_SMP */
-static void rebuild_sched_domains_locked(void)
+static void rebuild_sched_domains_cpuslocked(void)
 {
 }
 #endif /* CONFIG_SMP */
 
 void rebuild_sched_domains(void)
 {
-	mutex_lock(&cpuset_mutex);
-	rebuild_sched_domains_locked();
-	mutex_unlock(&cpuset_mutex);
+	cpuset_sched_change_begin();
+	rebuild_sched_domains_cpuslocked();
+	cpuset_sched_change_end();
 }
 
 /**
@@ -949,7 +957,7 @@ static void update_cpumasks_hier(struct
 	rcu_read_unlock();
 
 	if (need_rebuild_sched_domains)
-		rebuild_sched_domains_locked();
+		rebuild_sched_domains_cpuslocked();
 }
 
 /**
@@ -1281,7 +1289,7 @@ static int update_relax_domain_level(str
 		cs->relax_domain_level = val;
 		if (!cpumask_empty(cs->cpus_allowed) &&
 		    is_sched_load_balance(cs))
-			rebuild_sched_domains_locked();
+			rebuild_sched_domains_cpuslocked();
 	}
 
 	return 0;
@@ -1314,7 +1322,6 @@ static void update_tasks_flags(struct cp
  *
  * Call with cpuset_mutex held.
  */
-
 static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 		       int turning_on)
 {
@@ -1347,7 +1354,7 @@ static int update_flag(cpuset_flagbits_t
 	spin_unlock_irq(&callback_lock);
 
 	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed)
-		rebuild_sched_domains_locked();
+		rebuild_sched_domains_cpuslocked();
 
 	if (spread_flag_changed)
 		update_tasks_flags(cs);
@@ -1615,7 +1622,7 @@ static int cpuset_write_u64(struct cgrou
 	cpuset_filetype_t type = cft->private;
 	int retval = 0;
 
-	mutex_lock(&cpuset_mutex);
+	cpuset_sched_change_begin();
 	if (!is_cpuset_online(cs)) {
 		retval = -ENODEV;
 		goto out_unlock;
@@ -1651,7 +1658,7 @@ static int cpuset_write_u64(struct cgrou
 		break;
 	}
 out_unlock:
-	mutex_unlock(&cpuset_mutex);
+	cpuset_sched_change_end();
 	return retval;
 }
 
@@ -1662,7 +1669,7 @@ static int cpuset_write_s64(struct cgrou
 	cpuset_filetype_t type = cft->private;
 	int retval = -ENODEV;
 
-	mutex_lock(&cpuset_mutex);
+	cpuset_sched_change_begin();
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -1675,7 +1682,7 @@ static int cpuset_write_s64(struct cgrou
 		break;
 	}
 out_unlock:
-	mutex_unlock(&cpuset_mutex);
+	cpuset_sched_change_end();
 	return retval;
 }
 
@@ -1714,7 +1721,7 @@ static ssize_t cpuset_write_resmask(stru
 	kernfs_break_active_protection(of->kn);
 	flush_work(&cpuset_hotplug_work);
 
-	mutex_lock(&cpuset_mutex);
+	cpuset_sched_change_begin();
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -1738,7 +1745,7 @@ static ssize_t cpuset_write_resmask(stru
 
 	free_trial_cpuset(trialcs);
 out_unlock:
-	mutex_unlock(&cpuset_mutex);
+	cpuset_sched_change_end();
 	kernfs_unbreak_active_protection(of->kn);
 	css_put(&cs->css);
 	flush_workqueue(cpuset_migrate_mm_wq);
@@ -2039,14 +2046,14 @@ out_unlock:
 /*
  * If the cpuset being removed has its flag 'sched_load_balance'
  * enabled, then simulate turning sched_load_balance off, which
- * will call rebuild_sched_domains_locked().
+ * will call rebuild_sched_domains_cpuslocked().
  */
 
 static void cpuset_css_offline(struct cgroup_subsys_state *css)
 {
 	struct cpuset *cs = css_cs(css);
 
-	mutex_lock(&cpuset_mutex);
+	cpuset_sched_change_begin();
 
 	if (is_sched_load_balance(cs))
 		update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
@@ -2054,7 +2061,7 @@ static void cpuset_css_offline(struct cg
 	cpuset_dec();
 	clear_bit(CS_ONLINE, &cs->flags);
 
-	mutex_unlock(&cpuset_mutex);
+	cpuset_sched_change_end();
 }
 
 static void cpuset_css_free(struct cgroup_subsys_state *css)


