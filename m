Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B82C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744D220645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744D220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbeJNXkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:40:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35927 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727478AbeJNXLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:51 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLe-0004cj-Sr; Sun, 14 Oct 2018 16:30:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0000lS-E4; Sun, 14 Oct 2018 16:30:27 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.303206874@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 359/366] tracing: Fix crash when freeing instances
 with event triggers
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

commit 86b389ff22bd6ad8fd3cb98e41cd271886c6d023 upstream.

If a instance has an event trigger enabled when it is freed, it could cause
an access of free memory. Here's the case that crashes:

 # cd /sys/kernel/tracing
 # mkdir instances/foo
 # echo snapshot > instances/foo/events/initcall/initcall_start/trigger
 # rmdir instances/foo

Would produce:

 general protection fault: 0000 [#1] PREEMPT SMP PTI
 Modules linked in: tun bridge ...
 CPU: 5 PID: 6203 Comm: rmdir Tainted: G        W         4.17.0-rc4-test+ #933
 Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
 RIP: 0010:clear_event_triggers+0x3b/0x70
 RSP: 0018:ffffc90003783de0 EFLAGS: 00010286
 RAX: 0000000000000000 RBX: 6b6b6b6b6b6b6b2b RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8800c7130ba0
 RBP: ffffc90003783e00 R08: ffff8801131993f8 R09: 0000000100230016
 R10: ffffc90003783d80 R11: 0000000000000000 R12: ffff8800c7130ba0
 R13: ffff8800c7130bd8 R14: ffff8800cc093768 R15: 00000000ffffff9c
 FS:  00007f6f4aa86700(0000) GS:ffff88011eb40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f6f4a5aed60 CR3: 00000000cd552001 CR4: 00000000001606e0
 Call Trace:
  event_trace_del_tracer+0x2a/0xc5
  instance_rmdir+0x15c/0x200
  tracefs_syscall_rmdir+0x52/0x90
  vfs_rmdir+0xdb/0x160
  do_rmdir+0x16d/0x1c0
  __x64_sys_rmdir+0x17/0x20
  do_syscall_64+0x55/0x1a0
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

This was due to the call the clears out the triggers when an instance is
being deleted not removing the trigger from the link list.

Fixes: 85f2b08268c01 ("tracing: Add basic event trigger framework")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/trace/trace_events_trigger.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -469,9 +469,10 @@ clear_event_triggers(struct trace_array
 	struct ftrace_event_file *file;
 
 	list_for_each_entry(file, &tr->events, list) {
-		struct event_trigger_data *data;
-		list_for_each_entry_rcu(data, &file->triggers, list) {
+		struct event_trigger_data *data, *n;
+		list_for_each_entry_safe(data, n, &file->triggers, list) {
 			trace_event_trigger_enable_disable(file, 0);
+			list_del_rcu(&data->list);
 			if (data->ops->free)
 				data->ops->free(data->ops, data);
 		}

