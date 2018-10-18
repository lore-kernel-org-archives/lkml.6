Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE716ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8984721476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8984721476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeJROSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:18:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45271 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeJROSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:18:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9I6J8m7707906
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Oct 2018 23:19:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9I6J8SX707903;
        Wed, 17 Oct 2018 23:19:08 -0700
Date:   Wed, 17 Oct 2018 23:19:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-yiwkzexq9fk1ey1xg3gnjlw4@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, mingo@kernel.org,
        acme@redhat.com, mpetlan@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, namhyung@kernel.org, peterz@infradead.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, jolsa@kernel.org
Reply-To: rostedt@goodmis.org, namhyung@kernel.org, tglx@linutronix.de,
          peterz@infradead.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          acme@redhat.com, mpetlan@redhat.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20181016114818.3595-1-jolsa@kernel.org>
References: <20181016114818.3595-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix tracing_path_mount proper path
Git-Commit-ID: c458a6206d2a8600934617ccf88ba7d3a030faba
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

Commit-ID:  c458a6206d2a8600934617ccf88ba7d3a030faba
Gitweb:     https://git.kernel.org/tip/c458a6206d2a8600934617ccf88ba7d3a030faba
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 16 Oct 2018 13:48:18 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 16 Oct 2018 12:27:46 -0300

perf tools: Fix tracing_path_mount proper path

If there's no tracefs (RHEL7) support the tracing_path_mount
returns debugfs path which results in following fail:

  # perf probe sys_write
  kprobe_events file does not exist - please rebuild kernel with CONFIG_KPROBE_EVENTS.
  Error: Failed to add events.

In tracing_path_debugfs_mount function we need to return the
'tracing' path instead of just the mount to make it work:

  # perf probe sys_write
  Added new event:
    probe:sys_write      (on sys_write)

  You can now use it in all perf tools, such as:

          perf record -e probe:sys_write -aR sleep 1

Adding the 'return tracing_path;' also to tracing_path_tracefs_mount
function just for consistency with tracing_path_debugfs_mount.

Upstream keeps working, because it has the tracefs support.

Link: http://lkml.kernel.org/n/tip-yiwkzexq9fk1ey1xg3gnjlw4@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: 23773ca18b39 ("perf tools: Make perf aware of tracefs")
Link: http://lkml.kernel.org/r/20181016114818.3595-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/fs/tracing_path.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/api/fs/tracing_path.c b/tools/lib/api/fs/tracing_path.c
index 120037496f77..5afb11b30fca 100644
--- a/tools/lib/api/fs/tracing_path.c
+++ b/tools/lib/api/fs/tracing_path.c
@@ -36,7 +36,7 @@ static const char *tracing_path_tracefs_mount(void)
 
 	__tracing_path_set("", mnt);
 
-	return mnt;
+	return tracing_path;
 }
 
 static const char *tracing_path_debugfs_mount(void)
@@ -49,7 +49,7 @@ static const char *tracing_path_debugfs_mount(void)
 
 	__tracing_path_set("tracing/", mnt);
 
-	return mnt;
+	return tracing_path;
 }
 
 const char *tracing_path_mount(void)
