Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933474AbeCMMG7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933437AbeCMMG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:06:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10987217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Martin Vuille <jpmv27@aim.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 25/31] perf unwind: Unwind with libdw doesn't take symfs into account
Date: Tue, 13 Mar 2018 09:05:02 -0300
Message-Id: <20180313120508.29327-26-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Vuille <jpmv27@aim.com>

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
-- 
2.14.3
