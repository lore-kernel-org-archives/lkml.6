Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeFERw2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:52:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752769AbeFERwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:52:25 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Wang Nan <wangnan0@huawei.com>, stable@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 35/46] perf tools: Fix symbol and object code resolution for vdso32 and vdsox32
Date: Tue,  5 Jun 2018 14:50:19 -0300
Message-Id: <20180605175030.32549-36-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Fix __kmod_path__parse() so that perf tools does not treat vdso32 and
vdsox32 as kernel modules and fail to find the object.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: stable@vger.kernel.org
Fixes: 1f121b03d058 ("perf tools: Deal with kernel module names in '[]' correctly")
Link: http://lkml.kernel.org/r/1528117014-30032-3-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index cdfc2e5f55f5..51cf82cf1882 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -354,6 +354,8 @@ int __kmod_path__parse(struct kmod_path *m, const char *path,
 		if ((strncmp(name, "[kernel.kallsyms]", 17) == 0) ||
 		    (strncmp(name, "[guest.kernel.kallsyms", 22) == 0) ||
 		    (strncmp(name, "[vdso]", 6) == 0) ||
+		    (strncmp(name, "[vdso32]", 8) == 0) ||
+		    (strncmp(name, "[vdsox32]", 9) == 0) ||
 		    (strncmp(name, "[vsyscall]", 10) == 0)) {
 			m->kmod = false;
 
-- 
2.14.3
