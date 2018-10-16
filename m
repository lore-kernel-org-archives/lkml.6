Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006D5C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF6A2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF6A2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeJPTi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:38:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPTi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:38:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DAF2DA459C;
        Tue, 16 Oct 2018 11:48:21 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3A5C6AE93;
        Tue, 16 Oct 2018 11:48:19 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf tools: Fix tracing_path_mount proper path
Date:   Tue, 16 Oct 2018 13:48:18 +0200
Message-Id: <20181016114818.3595-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 16 Oct 2018 11:48:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
-- 
2.17.2

