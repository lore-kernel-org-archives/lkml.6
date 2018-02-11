Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753801AbeBKVY1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 16:24:27 -0500
Received: from omr-m003e.mx.aol.com ([204.29.186.3]:33962 "EHLO
        omr-m003e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752948AbeBKVY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 16:24:26 -0500
From: Martin Vuille <jpmv27@aim.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf unwind: Unwind with libdw doesn't take symfs into account
Date: Sun, 11 Feb 2018 16:24:20 -0500
Message-Id: <20180211212420.18388-1-jpmv27@aim.com>
X-Mailer: git-send-email 2.13.6
x-aol-global-disposition: G
x-aol-sid: 3039ac1afc0e5a80b4881071
X-AOL-IP: 99.246.128.134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Path passed to libdw for unwinding doesn't include symfs path
if specified, so unwinding fails because ELF file is not found.

Similar to unwinding with libunwind, pass symsrc_filename instead
of long_name. If there is no symsrc_filename, fallback to long_name.

Signed-off-by: Martin Vuille <jpmv27@aim.com>
---
 tools/perf/util/unwind-libdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 967323c958fd..7bdd239c795c 100644
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
2.13.6
