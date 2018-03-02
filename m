Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuAp6lzpTR+9mZ3qDDL33Elr52gIpaLO1pZdawqQdlf6spB0aEfERj4cBuEsSGPpHp8x1u3
ARC-Seal: i=1; a=rsa-sha256; t=1519981343; cv=none;
        d=google.com; s=arc-20160816;
        b=UIOu6RRfe07dypyX3aeigmBHzruijQ2mzSTxxWSgos8QXSqeK5nbCejIdOX5Zk042Z
         EoyRQ59RXCi6M0KrIjZEUO0+GhblFy3rnnV6cPPb9pv8IMborapRvP5+sRQjScqCGpDD
         GLxoOHVmBWt39vNs/roqWxsYAtI68HaZovacl6s+GEwmgbYiPYyrjzkumRYrPSdG2vhw
         ROe5c0C50wJtVxxgS63BjM2Cgg0q6d2Uz0UTB8ER3dW3QAZrpiRx8lnmV1duMYrrBBTy
         Rwr1V2QUkFFbjKNspkCKVdxZqbTX8a1qxjRJwewPLFIa2a45+0UNKWHJRr/XaeKojEs9
         q4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eTCp3l8pGuEjBW+Jv/uo1Q8hpSuUhpB247/BeVufj3A=;
        b=ZNHZ8j+qhWTSgDVZgvkKAtQAXtYNGTJQz9x99IGDkU118c1DWRgEtJ1BCrxLTpyFvR
         UUbAGb8aGc5A0On6pZwHFwlt6uedxh7LQqdgC3MVkzRXMnQccCEXIHhf/odKlLqegsDS
         ssez58hCYzznww6LDiwYQE9II/f74Nxm5V7qwPI7vVMc1UtEJhnPzrtyTB+034prxcqT
         /OvQ5ug3IF0CVT0k9u+K/8A0QiX+ipHiB6VYHEItUwKz/tY1xM0Pf75hduRaMYHbdcS9
         JS1CSviLXAYlH1+UitwHN6+lfEvjIlssvDpRahHFUJK+pr074Le5ptjQwTKep1PtPh4f
         jaEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Prateek Sood <prsood@codeaurora.org>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 027/115] cgroup: Fix deadlock in cpu hotplug path
Date: Fri,  2 Mar 2018 09:50:30 +0100
Message-Id: <20180302084504.975340030@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815957485893717?=
X-GMAIL-MSGID: =?utf-8?q?1593815957485893717?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prateek Sood <prsood@codeaurora.org>


[ Upstream commit 116d2f7496c51b2e02e8e4ecdd2bdf5fb9d5a641 ]

Deadlock during cgroup migration from cpu hotplug path when a task T is
being moved from source to destination cgroup.

kworker/0:0
cpuset_hotplug_workfn()
   cpuset_hotplug_update_tasks()
      hotplug_update_tasks_legacy()
        remove_tasks_in_empty_cpuset()
          cgroup_transfer_tasks() // stuck in iterator loop
            cgroup_migrate()
              cgroup_migrate_add_task()

In cgroup_migrate_add_task() it checks for PF_EXITING flag of task T.
Task T will not migrate to destination cgroup. css_task_iter_start()
will keep pointing to task T in loop waiting for task T cg_list node
to be removed.

Task T
do_exit()
  exit_signals() // sets PF_EXITING
  exit_task_namespaces()
    switch_task_namespaces()
      free_nsproxy()
        put_mnt_ns()
          drop_collected_mounts()
            namespace_unlock()
              synchronize_rcu()
                _synchronize_rcu_expedited()
                  schedule_work() // on cpu0 low priority worker pool
                  wait_event() // waiting for work item to execute

Task T inserted a work item in the worklist of cpu0 low priority
worker pool. It is waiting for expedited grace period work item
to execute. This work item will only be executed once kworker/0:0
complete execution of cpuset_hotplug_workfn().

kworker/0:0 ==> Task T ==>kworker/0:0

In case of PF_EXITING task being migrated from source to destination
cgroup, migrate next available task in source cgroup.

Signed-off-by: Prateek Sood <prsood@codeaurora.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/cgroup/cgroup-v1.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -123,7 +123,11 @@ int cgroup_transfer_tasks(struct cgroup
 	 */
 	do {
 		css_task_iter_start(&from->self, 0, &it);
-		task = css_task_iter_next(&it);
+
+		do {
+			task = css_task_iter_next(&it);
+		} while (task && (task->flags & PF_EXITING));
+
 		if (task)
 			get_task_struct(task);
 		css_task_iter_end(&it);
