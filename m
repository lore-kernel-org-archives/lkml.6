Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A35CECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DC821479
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QynausN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DC821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeJRGxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbeJRGxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:53:38 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A50B21476;
        Wed, 17 Oct 2018 22:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539816945;
        bh=GT989+y6HJ76YcZ+jTuFDV2v+s295IJcuhTcyu7if9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QynausN5+hh8XaHxqxIkX1Zg9UMwf6kvMqdfgYmThCG9N1udG0lcyWcVGP7ixl9Gd
         RfjV1gY+Y52Lm/xAeJ4Ij+UoPU/LDvWQKJaFtuVUl57/quVz8Uo+D6hNuSWs45EYV1
         9qJ+AZ8LYZr8LJQo6AGcozqnvPosgh1eoXYqtClM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/11] perf tools: Fix tracing_path_mount proper path
Date:   Wed, 17 Oct 2018 19:54:57 -0300
Message-Id: <20181017225501.32150-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181017225501.32150-1-acme@kernel.org>
References: <20181017225501.32150-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.14.4

