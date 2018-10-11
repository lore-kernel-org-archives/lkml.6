Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61EEC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C3921470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NI0riSf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C3921470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbeJKXIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeJKXIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:08:45 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A937E20652;
        Thu, 11 Oct 2018 15:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272461;
        bh=/cnBi5pNXOyKFgJyQ/CSrD93UwUv0+BXqZlA3jpmvbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NI0riSf9WMcT25sH8aecjfLHxfAhRMxO+JnNCwo8DL2e992+MVcblz1MRZW8kIhgm
         ZtR+GG+RgKtWI8mlWfcf4/0dNS6US5tVezucQ2Z5qNdbaPO5OLnbJlwGJTTdf+1E80
         0PbypR7NpGuoSABOQrrJJUXsTo2VHe2mtATI4N3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prateek Sood <prsood@codeaurora.org>,
        Tejun Heo <tj@kernel.org>, Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 3.18 118/120] cgroup: Fix deadlock in cpu hotplug path
Date:   Thu, 11 Oct 2018 17:34:59 +0200
Message-Id: <20181011152554.667496109@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prateek Sood <prsood@codeaurora.org>

commit 116d2f7496c51b2e02e8e4ecdd2bdf5fb9d5a641 upstream.

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
[AmitP: Upstream commit cherry-pick failed, so I picked the
        backported changes from CAF/msm-4.9 tree instead:
        https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?id=49b74f1696417b270c89cd893ca9f37088928078]
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
This patch can be cleanly applied and build tested on 4.4.y and 3.18.y
as well but I couldn't find it in msm-4.4 and msm-3.18 trees. So this
patch is really untested on those stable trees.
Build tested on 4.9.131, 4.4.159 and 3.18.123 for ARCH=arm/arm64 allmodconfig.

 kernel/cgroup.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/kernel/cgroup.c
+++ b/kernel/cgroup.c
@@ -3669,7 +3669,11 @@ int cgroup_transfer_tasks(struct cgroup
 	 */
 	do {
 		css_task_iter_start(&from->self, &it);
-		task = css_task_iter_next(&it);
+
+		do {
+			task = css_task_iter_next(&it);
+		} while (task && (task->flags & PF_EXITING));
+
 		if (task)
 			get_task_struct(task);
 		css_task_iter_end(&it);


