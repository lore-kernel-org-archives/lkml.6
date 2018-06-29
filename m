Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBF9C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C921D279F4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C921D279F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934816AbeF2Rqi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:46:38 -0400
Received: from foss.arm.com ([217.140.101.70]:37900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934656AbeF2Rqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:46:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C740518A;
        Fri, 29 Jun 2018 10:46:35 -0700 (PDT)
Received: from dupont (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D27283F5AD;
        Fri, 29 Jun 2018 10:46:34 -0700 (PDT)
Date:   Fri, 29 Jun 2018 12:46:33 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        =?ISO-8859-1?Q? "Hendrik_Br=FCckner" ?= 
        <brueckner@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>
Subject: [PATCH v2 1/4] perf test shell: Replace '|&' with '2>&1 |' to work
 with more shells
Message-Id: <20180629124633.0a9f4bea54b8d2c28f265de2@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we do not specify bash (and/or zsh) as a requirement, use the
standard error redirection that is more widely supported.

BEFORE:

 $ sudo ./perf test -v 62
 62: Check open filename arg using perf trace + vfs_getname:
 --- start ---
 test child forked, pid 27305
 ./tests/shell/trace+probe_vfs_getname.sh: 20: ./tests/shell/trace+probe_vfs_getname.sh: Syntax error: "&" unexpected
 test child finished with -2
 ---- end ----
 Check open filename arg using perf trace + vfs_getname: Skip

AFTER:

 $ sudo ./perf test -v 62
 64: Check open filename arg using perf trace + vfs_getname               :
 --- start ---
 test child forked, pid 23008
 Added new event:
   probe:vfs_getname    (on getname_flags:72 with pathname=result->name:string)

 You can now use it in all perf tools, such as:

         perf record -e probe:vfs_getname -aR sleep 1

      0.361 ( 0.008 ms): touch/23032 openat(dfd: CWD, filename: /tmp/temporary_file.VEh0n, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 4
 test child finished with 0
 ---- end ----
 Check open filename arg using perf trace + vfs_getname: Ok

Similar to commit 35435cd06081, with the same title.

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
v2: indent terminal session logs with a space to avoid git-am parsing
'--- start ---' as the end of the description text.

 tools/perf/tests/shell/trace+probe_vfs_getname.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 55ad9793d544..4ce276efe6b4 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -17,7 +17,7 @@ skip_if_no_perf_probe || exit 2
 file=$(mktemp /tmp/temporary_file.XXXXX)
 
 trace_open_vfs_getname() {
-	evts=$(echo $(perf list syscalls:sys_enter_open* |& egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
+	evts=$(echo $(perf list syscalls:sys_enter_open* 2>&1 | egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
 	perf trace -e $evts touch $file 2>&1 | \
 	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
 }
-- 
2.17.1

