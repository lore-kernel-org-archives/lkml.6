Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4BDC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07716208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07716208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbeGLOLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:11:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48755 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbeGLOLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:11:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6CE0uqS3934673
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Jul 2018 07:00:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6CE0udT3934670;
        Thu, 12 Jul 2018 07:00:56 -0700
Date:   Thu, 12 Jul 2018 07:00:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kim Phillips <tipbot@zytor.com>
Message-ID: <tip-508ef3e737bbb9858a30e7bb153507429ea89644@git.kernel.org>
Cc:     acme@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kim.phillips@arm.com, sandipan@linux.vnet.ibm.com,
        mpetlan@redhat.com, tmricht@linux.vnet.ibm.com,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        brueckner@linux.vnet.ibm.com, jolsa@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: jolsa@redhat.com, brueckner@linux.vnet.ibm.com, hpa@zytor.com,
          tglx@linutronix.de, mingo@kernel.org, mpetlan@redhat.com,
          sandipan@linux.vnet.ibm.com, kim.phillips@arm.com,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          acme@redhat.com, alexander.shishkin@linux.intel.com,
          tmricht@linux.vnet.ibm.com, peterz@infradead.org
In-Reply-To: <20180629124633.0a9f4bea54b8d2c28f265de2@arm.com>
References: <20180629124633.0a9f4bea54b8d2c28f265de2@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf test shell: Replace '|&' with '2>&1 |' to
 work with more shells
Git-Commit-ID: 508ef3e737bbb9858a30e7bb153507429ea89644
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

Commit-ID:  508ef3e737bbb9858a30e7bb153507429ea89644
Gitweb:     https://git.kernel.org/tip/508ef3e737bbb9858a30e7bb153507429ea89644
Author:     Kim Phillips <kim.phillips@arm.com>
AuthorDate: Fri, 29 Jun 2018 12:46:33 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 11 Jul 2018 10:01:51 -0300

perf test shell: Replace '|&' with '2>&1 |' to work with more shells

Since we do not specify bash (and/or zsh) as a requirement, use the
standard error redirection that is more widely supported.

BEFORE:

 $ sudo perf test -v 62
 62: Check open filename arg using perf trace + vfs_getname:
 --- start ---
 test child forked, pid 27305
 ./tests/shell/trace+probe_vfs_getname.sh: 20: ./tests/shell/trace+probe_vfs_getname.sh: Syntax error: "&" unexpected
 test child finished with -2
 ---- end ----
 Check open filename arg using perf trace + vfs_getname: Skip

AFTER:

 $ sudo perf test -v 62
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

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20180629124633.0a9f4bea54b8d2c28f265de2@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
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
