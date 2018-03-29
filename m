Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbeC2OX2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:23:28 -0400
Received: from aer-iport-3.cisco.com ([173.38.203.53]:42839 "EHLO
        aer-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeC2OX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:23:27 -0400
X-IronPort-AV: E=Sophos;i="5.48,376,1517875200";
   d="scan'208";a="2848594"
From: Stefan Strogin <sstrogin@cisco.com>
To: Evgeniy Polyakov <zbr@ioremap.net>, netdev@vger.kernel.org
Cc: Stefan Strogin <sstrogin@cisco.com>, linux-kernel@vger.kernel.org,
        xe-linux-external@cisco.com, Jesper Derehag <jderehag@hotmail.com>,
        Matt Helsley <matt.helsley@gmail.com>,
        Mathias Krause <minipli@googlemail.com>
Subject: [PATCH] connector: add parent pid and tgid to coredump and exit events
Date: Thu, 29 Mar 2018 17:12:47 +0300
Message-Id: <20180329141247.20943-1-sstrogin@cisco.com>
X-Mailer: git-send-email 2.11.0
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Authenticated-User: sstrogin
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intention is to get notified of process failures as soon
as possible, before a possible core dumping (which could be very long)
(e.g. in some process-manager). Coredump and exit process events
are perfect for such use cases (see 2b5faa4c553f "connector: Added
coredumping event to the process connector").

The problem is that for now the process-manager cannot know the parent
of a dying process using connectors. This could be useful if the
process-manager should monitor for failures only children of certain
parents, so we could filter the coredump and exit events by parent
process and/or thread ID.

Add parent pid and tgid to coredump and exit process connectors event
data.

Signed-off-by: Stefan Strogin <sstrogin@cisco.com>
---
 drivers/connector/cn_proc.c  | 4 ++++
 include/uapi/linux/cn_proc.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index a782ce87715c..ed5e42461094 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -262,6 +262,8 @@ void proc_coredump_connector(struct task_struct *task)
 	ev->what = PROC_EVENT_COREDUMP;
 	ev->event_data.coredump.process_pid = task->pid;
 	ev->event_data.coredump.process_tgid = task->tgid;
+	ev->event_data.coredump.parent_pid = task->real_parent->pid;
+	ev->event_data.coredump.parent_tgid = task->real_parent->tgid;
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
@@ -288,6 +290,8 @@ void proc_exit_connector(struct task_struct *task)
 	ev->event_data.exit.process_tgid = task->tgid;
 	ev->event_data.exit.exit_code = task->exit_code;
 	ev->event_data.exit.exit_signal = task->exit_signal;
+	ev->event_data.exit.parent_pid = task->real_parent->pid;
+	ev->event_data.exit.parent_tgid = task->real_parent->tgid;
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
index 68ff25414700..db210625cee8 100644
--- a/include/uapi/linux/cn_proc.h
+++ b/include/uapi/linux/cn_proc.h
@@ -116,12 +116,16 @@ struct proc_event {
 		struct coredump_proc_event {
 			__kernel_pid_t process_pid;
 			__kernel_pid_t process_tgid;
+			__kernel_pid_t parent_pid;
+			__kernel_pid_t parent_tgid;
 		} coredump;
 
 		struct exit_proc_event {
 			__kernel_pid_t process_pid;
 			__kernel_pid_t process_tgid;
 			__u32 exit_code, exit_signal;
+			__kernel_pid_t parent_pid;
+			__kernel_pid_t parent_tgid;
 		} exit;
 
 	} event_data;
-- 
2.11.0
