Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EAEC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E3121471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E3121471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbeGLOMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:12:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45735 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbeGLOMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:12:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6CE1PXN3934703
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Jul 2018 07:01:25 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6CE1P3s3934700;
        Thu, 12 Jul 2018 07:01:25 -0700
Date:   Thu, 12 Jul 2018 07:01:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kim Phillips <tipbot@zytor.com>
Message-ID: <tip-98c6c8a1d00fba66625311730f80c6ceaa9c1d19@git.kernel.org>
Cc:     peterz@infradead.org, hpa@zytor.com, tmricht@linux.vnet.ibm.com,
        namhyung@kernel.org, acme@redhat.com, kim.phillips@arm.com,
        linux-kernel@vger.kernel.org, mpetlan@redhat.com,
        sandipan@linux.vnet.ibm.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        brueckner@linux.vnet.ibm.com, mingo@kernel.org
Reply-To: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
          mingo@kernel.org, brueckner@linux.vnet.ibm.com,
          namhyung@kernel.org, acme@redhat.com, peterz@infradead.org,
          hpa@zytor.com, tmricht@linux.vnet.ibm.com, kim.phillips@arm.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          sandipan@linux.vnet.ibm.com, mpetlan@redhat.com
In-Reply-To: <20180629124643.2089b3ce59960eba34e87b27@arm.com>
References: <20180629124643.2089b3ce59960eba34e87b27@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf test shell: Make perf's inet_pton test more
 portable
Git-Commit-ID: 98c6c8a1d00fba66625311730f80c6ceaa9c1d19
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

Commit-ID:  98c6c8a1d00fba66625311730f80c6ceaa9c1d19
Gitweb:     https://git.kernel.org/tip/98c6c8a1d00fba66625311730f80c6ceaa9c1d19
Author:     Kim Phillips <kim.phillips@arm.com>
AuthorDate: Fri, 29 Jun 2018 12:46:43 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 11 Jul 2018 10:01:51 -0300

perf test shell: Make perf's inet_pton test more portable

Debian based systems such as Ubuntu have dash as their default shell.
Even if the normal or root user's shell is bash, certain scripts still
call /bin/sh, which points to dash, so we fix this perf test by
rewriting it in a more portable way.

BEFORE:

 $ sudo perf test -v 64
 64: probe libc's inet_pton & backtrace it with ping       :
 --- start ---
 test child forked, pid 31942
 ./tests/shell/record+probe_libc_inet_pton.sh: 18: ./tests/shell/record+probe_libc_inet_pton.sh: expected[0]=ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\): not found
 ./tests/shell/record+probe_libc_inet_pton.sh: 19: ./tests/shell/record+probe_libc_inet_pton.sh: expected[1]=.*inet_pton\+0x[[:xdigit:]]+[[:space:]]\(/lib/x86_64-linux-gnu/libc-2.27.so|inlined\)$: not found
 ./tests/shell/record+probe_libc_inet_pton.sh: 29: ./tests/shell/record+probe_libc_inet_pton.sh: expected[2]=getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\(/lib/x86_64-linux-gnu/libc-2.27.so\)$: not found
 ./tests/shell/record+probe_libc_inet_pton.sh: 30: ./tests/shell/record+probe_libc_inet_pton.sh: expected[3]=.*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$: not found
 ping 31963 [004] 83577.670613: probe_libc:inet_pton: (7fe15f87f4b0)
 ./tests/shell/record+probe_libc_inet_pton.sh: 39: ./tests/shell/record+probe_libc_inet_pton.sh: Bad substitution
 ./tests/shell/record+probe_libc_inet_pton.sh: 41: ./tests/shell/record+probe_libc_inet_pton.sh: Bad substitution
 test child finished with -2
 ---- end ----
 probe libc's inet_pton & backtrace it with ping: Skip

AFTER:

 $ sudo perf test -v 64
 64: probe libc's inet_pton & backtrace it with ping       :
 --- start ---
 test child forked, pid 32277
 ping 32295 [001] 83679.690020: probe_libc:inet_pton: (7ff244f504b0)
 7ff244f504b0 __GI___inet_pton+0x0 (/lib/x86_64-linux-gnu/libc-2.27.so)
 7ff244f14ce4 getaddrinfo+0x124 (/lib/x86_64-linux-gnu/libc-2.27.so)
 556ac036b57d _init+0xb75 (/bin/ping)
 test child finished with 0
 ---- end ----
 probe libc's inet_pton & backtrace it with ping: Ok

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20180629124643.2089b3ce59960eba34e87b27@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../tests/shell/record+probe_libc_inet_pton.sh     | 37 ++++++++++++----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 263057039693..94e513e62b34 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -14,35 +14,40 @@ libc=$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1
 nm -Dg $libc 2>/dev/null | fgrep -q inet_pton || exit 254
 
 trace_libc_inet_pton_backtrace() {
-	idx=0
-	expected[0]="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
-	expected[1]=".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
+
+	expected=`mktemp -u /tmp/expected.XXX`
+
+	echo "ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)" > $expected
+	echo ".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 	case "$(uname -m)" in
 	s390x)
 		eventattr='call-graph=dwarf,max-stack=4'
-		expected[2]="gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
-		expected[3]="(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
-		expected[4]="main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
+		echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
+		echo "(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
+		echo "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
 	*)
 		eventattr='max-stack=3'
-		expected[2]="getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$"
-		expected[3]=".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
+		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
+		echo ".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
 	esac
 
-	file=`mktemp -u /tmp/perf.data.XXX`
+	perf_data=`mktemp -u /tmp/perf.data.XXX`
+	perf_script=`mktemp -u /tmp/perf.script.XXX`
+	perf record -e probe_libc:inet_pton/$eventattr/ -o $perf_data ping -6 -c 1 ::1 > /dev/null 2>&1
+	perf script -i $perf_data > $perf_script
 
-	perf record -e probe_libc:inet_pton/$eventattr/ -o $file ping -6 -c 1 ::1 > /dev/null 2>&1
-	perf script -i $file | while read line ; do
+	exec 3<$perf_script
+	exec 4<$expected
+	while read line <&3 && read -r pattern <&4; do
+		[ -z "$pattern" ] && break
 		echo $line
-		echo "$line" | egrep -q "${expected[$idx]}"
+		echo "$line" | egrep -q "$pattern"
 		if [ $? -ne 0 ] ; then
-			printf "FAIL: expected backtrace entry %d \"%s\" got \"%s\"\n" $idx "${expected[$idx]}" "$line"
+			printf "FAIL: expected backtrace entry \"%s\" got \"%s\"\n" "$pattern" "$line"
 			exit 1
 		fi
-		let idx+=1
-		[ -z "${expected[$idx]}" ] && break
 	done
 
 	# If any statements are executed from this point onwards,
@@ -58,6 +63,6 @@ skip_if_no_perf_probe && \
 perf probe -q $libc inet_pton && \
 trace_libc_inet_pton_backtrace
 err=$?
-rm -f ${file}
+rm -f ${perf_data} ${perf_script} ${expected}
 perf probe -q -d probe_libc:inet_pton
 exit $err
