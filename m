Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeEVTrv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:47:51 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39406 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeEVTru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:47:50 -0400
X-Google-Smtp-Source: AB8JxZrsna/PrKhn9UHf/bA8IXhTlNXuW5zafxTxTUIk0d7+dliG/NMMWOm4HjcLDQW+QdsoK6TYwg==
From: Mathieu Malaterre <malat@debian.org>
To: Tejun Heo <tj@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: move function definitions within CONFIG_SMP block
Date: Tue, 22 May 2018 21:47:32 +0200
Message-Id: <20180522194732.29140-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 7ee681b25284 ("workqueue: Convert to state machine callbacks"),
three new function definitions were added: ‘workqueue_prepare_cpu’,
‘workqueue_online_cpu’ and ‘workqueue_offline_cpu’.

Move these function definitions within a CONFIG_SMP block since they are
not used outside of it. This will match function declarations in header
<include/linux/workqueue.h>, and silence the following gcc warning (W=1):

  kernel/workqueue.c:4743:5: warning: no previous prototype for ‘workqueue_prepare_cpu’ [-Wmissing-prototypes]
  kernel/workqueue.c:4756:5: warning: no previous prototype for ‘workqueue_online_cpu’ [-Wmissing-prototypes]
  kernel/workqueue.c:4783:5: warning: no previous prototype for ‘workqueue_offline_cpu’ [-Wmissing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/workqueue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ca7959be8aaa..c1544225c696 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4579,6 +4579,8 @@ void show_workqueue_state(void)
 	rcu_read_unlock_sched();
 }
 
+#ifdef CONFIG_SMP
+
 /*
  * CPU hotplug.
  *
@@ -4799,8 +4801,6 @@ int workqueue_offline_cpu(unsigned int cpu)
 	return 0;
 }
 
-#ifdef CONFIG_SMP
-
 struct work_for_cpu {
 	struct work_struct work;
 	long (*fn)(void *);
-- 
2.11.0
