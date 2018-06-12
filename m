Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 65CAFC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1982B208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="afCsxVC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1982B208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934773AbeFLQx4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934788AbeFLQxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:53:51 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3960F208B4;
        Tue, 12 Jun 2018 16:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822430;
        bh=7jqvK6RJ1Mc8+JY+rqZit9u65P2dMcCETFM0H9zdgMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=afCsxVC+wJTujVntTjYdXHGv8mpb0Uk7OaliSANoF8dLBb/TJ8gioqLdkKrZOupm0
         ECl53MDwUsWH5zViW+tAuk9sN35xNfEvtJkK5IcCdS/zyPNNoNTnwRJM4ngtWLJJhF
         tk0VVJfoCcTWn7wCNxiQeDlB/wEH5PvY+zncuOg8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 3.18 01/21] tracing: Fix crash when freeing instances with event triggers
Date:   Tue, 12 Jun 2018 18:51:58 +0200
Message-Id: <20180612164825.456945220@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164825.401145490@linuxfoundation.org>
References: <20180612164825.401145490@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

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

Cc: stable@vger.kernel.org
Fixes: 85f2b08268c01 ("tracing: Add basic event trigger framework")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_events_trigger.c |    5 +++--
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


