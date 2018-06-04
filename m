Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbeFDM6Y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:58:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:38826 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753149AbeFDM6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:58:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,476,1520924400";
   d="scan'208";a="46607143"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf tools: Fix symbol and object code resolution for vdso32 and vdsox32
Date: Mon,  4 Jun 2018 15:56:54 +0300
Message-Id: <1528117014-30032-3-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528117014-30032-1-git-send-email-adrian.hunter@intel.com>
References: <1528117014-30032-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix __kmod_path__parse() so that perf tools does not treat vdso32 and
vdsox32 as kernel modules and fail to find the object.

Fixes: 1f121b03d058 ("perf tools: Deal with kernel module names in '[]' correctly")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
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
1.9.1
