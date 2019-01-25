Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997E8C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6116D20844
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458403;
	bh=6Y0N18pSZIr8QY4VbWBkQZPXv/rt1VrqqsRjXi2QfVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=le2TyAu0JV0oWgfiUB0PGcwgPWsDFSr758q51GJW+grem2Uin0kWscie+0aNbK6iP
	 Z/fWqjjnD5QJ2KUF33qSqaoXZ1qFNzq9/VloA7uScjX9nZEiPgYyiXab5qfosL2wqr
	 zlHzx7TFuW6f5by51+xERDcu3xFGPE+bNg3/raY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbfAYXT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:19:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729976AbfAYXTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:19:52 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8EF920844;
        Fri, 25 Jan 2019 23:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458391;
        bh=6Y0N18pSZIr8QY4VbWBkQZPXv/rt1VrqqsRjXi2QfVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJDK6isYAnNjd5Vv5UrVNJI/vxduCMOica0bn1VpzNB3LuKSg19NIElB8MvSI7otK
         QuThpZMgZKujsMkCRRmoC8ezYI4AF66DrXg4J6+1zNr3FnC4wEENjY0K7nrQOgkjk0
         7ZEbizefn8oIH/v4i9YgQyro/7+h8pPdgJFFsZc4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 27/29] perf trace: Fixup etcsnoop example
Date:   Sat, 26 Jan 2019 00:18:41 +0100
Message-Id: <20190125231843.2895-28-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Where we don't have "raw_syscalls:sys_enter", so we need to look for a
"*syscalls:sys_enter*" to initialize the offsets for the
__augmented_syscalls__ evsel, which is the case with etcsnoop, that was
segfaulting, fixed:

  # trace -e /home/acme/git/perf/tools/perf/examples/bpf/etcsnoop.c
     0.000 (         ): gnome-shell/2105 openat(dfd: CWD, filename: "/etc/localtime")                       ...
   631.834 (         ): cat/6521 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) ...
   632.637 (         ): bash/6521 openat(dfd: CWD, filename: "/etc/passwd")                          ...
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: b9b6a2ea2baf ("perf trace: Do not hardcode the size of the tracepoint common_ fields")
Link: https://lkml.kernel.org/n/tip-0tjwcit8qitsmh4nyvf2b0jo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ed4583128b9c..1447993e1ee3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3854,7 +3854,8 @@ int cmd_trace(int argc, const char **argv)
 				goto init_augmented_syscall_tp;
 			}
 
-			if (strcmp(perf_evsel__name(evsel), "raw_syscalls:sys_enter") == 0) {
+			if (trace.syscalls.events.augmented->priv == NULL &&
+			    strstr(perf_evsel__name(evsel), "syscalls:sys_enter")) {
 				struct perf_evsel *augmented = trace.syscalls.events.augmented;
 				if (perf_evsel__init_augmented_syscall_tp(augmented, evsel) ||
 				    perf_evsel__init_augmented_syscall_tp_args(augmented))
-- 
2.20.1

