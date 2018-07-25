Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342EAC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D8F20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D8F20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbeGYPnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:43:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37417 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbeGYPnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:43:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEVNN8402926
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:31:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEVNwm402923;
        Wed, 25 Jul 2018 07:31:23 -0700
Date:   Wed, 25 Jul 2018 07:31:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-7f635ff187ab6be0b350b3ec06791e376af238ab@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, vincent.weaver@maine.edu,
        mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
        acme@redhat.com, mathieu.poirier@linaro.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, eranian@google.com,
        jolsa@redhat.com, torvalds@linux-foundation.org
Reply-To: mathieu.poirier@linaro.org, tglx@linutronix.de, acme@redhat.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          peterz@infradead.org, vincent.weaver@maine.edu,
          torvalds@linux-foundation.org, eranian@google.com,
          jolsa@redhat.com, alexander.shishkin@linux.intel.com
In-Reply-To: <1531782831-1186-1-git-send-email-mathieu.poirier@linaro.org>
References: <1531782831-1186-1-git-send-email-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core: Fix crash when using HW tracing kernel
 filters
Git-Commit-ID: 7f635ff187ab6be0b350b3ec06791e376af238ab
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7f635ff187ab6be0b350b3ec06791e376af238ab
Gitweb:     https://git.kernel.org/tip/7f635ff187ab6be0b350b3ec06791e376af238ab
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Mon, 16 Jul 2018 17:13:51 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:46:22 +0200

perf/core: Fix crash when using HW tracing kernel filters

In function perf_event_parse_addr_filter(), the path::dentry of each struct
perf_addr_filter is left unassigned (as it should be) when the pattern
being parsed is related to kernel space.  But in function
perf_addr_filter_match() the same dentries are given to d_inode() where
the value is not expected to be NULL, resulting in the following splat:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000058
  pc : perf_event_mmap+0x2fc/0x5a0
  lr : perf_event_mmap+0x2c8/0x5a0
  Process uname (pid: 2860, stack limit = 0x000000001cbcca37)
  Call trace:
   perf_event_mmap+0x2fc/0x5a0
   mmap_region+0x124/0x570
   do_mmap+0x344/0x4f8
   vm_mmap_pgoff+0xe4/0x110
   vm_mmap+0x2c/0x40
   elf_map+0x60/0x108
   load_elf_binary+0x450/0x12c4
   search_binary_handler+0x90/0x290
   __do_execve_file.isra.13+0x6e4/0x858
   sys_execve+0x3c/0x50
   el0_svc_naked+0x30/0x34

This patch is fixing the problem by introducing a new check in function
perf_addr_filter_match() to see if the filter's dentry is NULL.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Cc: miklos@szeredi.hu
Cc: namhyung@kernel.org
Cc: songliubraving@fb.com
Fixes: 9511bce9fe8e ("perf/core: Fix bad use of igrab()")
Link: http://lkml.kernel.org/r/1531782831-1186-1-git-send-email-mathieu.poirier@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cdb32cf8e33c..eec2d5fb676b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7337,6 +7337,10 @@ static bool perf_addr_filter_match(struct perf_addr_filter *filter,
 				     struct file *file, unsigned long offset,
 				     unsigned long size)
 {
+	/* d_inode(NULL) won't be equal to any mapped user-space file */
+	if (!filter->path.dentry)
+		return false;
+
 	if (d_inode(filter->path.dentry) != file_inode(file))
 		return false;
 
