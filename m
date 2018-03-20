Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeCTG2Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:28:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43087 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbeCTG2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:28:20 -0400
Date: Mon, 19 Mar 2018 23:28:05 -0700
From: tip-bot for Martin Vuille <tipbot@zytor.com>
Message-ID: <tip-3d20c6246690219881786de10d2dda93f616d0ac@git.kernel.org>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, jpmv27@aim.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@kernel.org,
        wangnan0@huawei.com, tglx@linutronix.de, dsahern@gmail.com,
        hpa@zytor.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, jolsa@kernel.org, wangnan0@huawei.com,
        dsahern@gmail.com, hpa@zytor.com, mingo@kernel.org,
        namhyung@kernel.org, jpmv27@aim.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, acme@redhat.com
In-Reply-To: <20180211212420.18388-1-jpmv27@aim.com>
References: <20180211212420.18388-1-jpmv27@aim.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf unwind: Unwind with libdw doesn't take symfs
 into account
Git-Commit-ID: 3d20c6246690219881786de10d2dda93f616d0ac
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3d20c6246690219881786de10d2dda93f616d0ac
Gitweb:     https://git.kernel.org/tip/3d20c6246690219881786de10d2dda93f616d0ac
Author:     Martin Vuille <jpmv27@aim.com>
AuthorDate: Sun, 11 Feb 2018 16:24:20 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:55:51 -0300

perf unwind: Unwind with libdw doesn't take symfs into account

Path passed to libdw for unwinding doesn't include symfs path
if specified, so unwinding fails because ELF file is not found.

Similar to unwinding with libunwind, pass symsrc_filename instead
of long_name. If there is no symsrc_filename, fallback to long_name.

Signed-off-by: Martin Vuille <jpmv27@aim.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20180211212420.18388-1-jpmv27@aim.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/unwind-libdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 1e9c974faf67..8e969f28cc59 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -50,7 +50,7 @@ static int __report_module(struct addr_location *al, u64 ip,
 
 	if (!mod)
 		mod = dwfl_report_elf(ui->dwfl, dso->short_name,
-				      dso->long_name, -1, al->map->start,
+				      (dso->symsrc_filename ? dso->symsrc_filename : dso->long_name), -1, al->map->start,
 				      false);
 
 	return mod && dwfl_addrmodule(ui->dwfl, ip) == mod ? 0 : -1;
