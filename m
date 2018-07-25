Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C696C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2348720671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2348720671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbeGYWAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:00:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58685 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729335AbeGYWAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:00:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKlD5Q500903
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:47:13 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKlCjn500899;
        Wed, 25 Jul 2018 13:47:12 -0700
Date:   Wed, 25 Jul 2018 13:47:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sandipan Das <tipbot@zytor.com>
Message-ID: <tip-60089e42d38438772e2f83334e3e5b7497009366@git.kernel.org>
Cc:     naveen.n.rao@linux.vnet.ibm.com, ravi.bangoria@linux.vnet.ibm.com,
        mingo@kernel.org, jolsa@redhat.com, kim.phillips@arm.com,
        acme@redhat.com, hpa@zytor.com, sandipan@linux.ibm.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, sandipan@linux.ibm.com,
          naveen.n.rao@linux.vnet.ibm.com, mingo@kernel.org,
          jolsa@redhat.com, kim.phillips@arm.com,
          ravi.bangoria@linux.vnet.ibm.com
In-Reply-To: <e11fecff96e6cf4c65cdbd9012463513d7b8356c.1530724939.git.sandipan@linux.ibm.com>
References: <e11fecff96e6cf4c65cdbd9012463513d7b8356c.1530724939.git.sandipan@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests: Fix record+probe_libc_inet_pton.sh when
 event exists
Git-Commit-ID: 60089e42d38438772e2f83334e3e5b7497009366
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

Commit-ID:  60089e42d38438772e2f83334e3e5b7497009366
Gitweb:     https://git.kernel.org/tip/60089e42d38438772e2f83334e3e5b7497009366
Author:     Sandipan Das <sandipan@linux.ibm.com>
AuthorDate: Tue, 10 Jul 2018 19:28:17 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:52:19 -0300

perf tests: Fix record+probe_libc_inet_pton.sh when event exists

If the event 'probe_libc:inet_pton' already exists, this test fails and
deletes the existing event before exiting. This will then pass for any
subsequent executions.

Instead of skipping to deleting the existing event because of failing to
add a new event, a duplicate event is now created and the script
continues with the usual checks. Only the new duplicate event that is
created at the beginning of the test is deleted as a part of the
cleanups in the end. All existing events remain as it is.

This can be observed on a powerpc64 system running Fedora 27 as shown
below.

  # perf probe -x /usr/lib64/power8/libc-2.26.so -a inet_pton

  Added new event:
    probe_libc:inet_pton (on inet_pton in /usr/lib64/power8/libc-2.26.so)

Before:

  # perf test -v "probe libc's inet_pton & backtrace it with ping"

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 21302
  test child finished with -1
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: FAILED!

  # perf probe --list

After:

  # perf test -v "probe libc's inet_pton & backtrace it with ping"

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 21490
  ping 21513 [035] 39357.565561: probe_libc:inet_pton_1: (7fffa4c623b0)
  7fffa4c623b0 __GI___inet_pton+0x0 (/usr/lib64/power8/libc-2.26.so)
  7fffa4c190dc gaih_inet.constprop.7+0xf4c (/usr/lib64/power8/libc-2.26.so)
  7fffa4c19c4c getaddrinfo+0x15c (/usr/lib64/power8/libc-2.26.so)
  111d93c20 main+0x3e0 (/usr/bin/ping)
  test child finished with 0
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: Ok

  # perf probe --list

    probe_libc:inet_pton (on __inet_pton@resolv/inet_pton.c in /usr/lib64/power8/libc-2.26.so)

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/e11fecff96e6cf4c65cdbd9012463513d7b8356c.1530724939.git.sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../tests/shell/record+probe_libc_inet_pton.sh     | 28 ++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 0502a9e04c79..3013ac8f83d0 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -13,11 +13,24 @@
 libc=$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1/g')
 nm -Dg $libc 2>/dev/null | fgrep -q inet_pton || exit 254
 
+event_pattern='probe_libc:inet_pton(\_[[:digit:]]+)?'
+
+add_libc_inet_pton_event() {
+
+	event_name=$(perf probe -f -x $libc -a inet_pton 2>&1 | tail -n +2 | head -n -5 | \
+			grep -P -o "$event_pattern(?=[[:space:]]\(on inet_pton in $libc\))")
+
+	if [ $? -ne 0 -o -z "$event_name" ] ; then
+		printf "FAIL: could not add event\n"
+		return 1
+	fi
+}
+
 trace_libc_inet_pton_backtrace() {
 
 	expected=`mktemp -u /tmp/expected.XXX`
 
-	echo "ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)" > $expected
+	echo "ping[][0-9 \.:]+$event_name: \([[:xdigit:]]+\)" > $expected
 	echo ".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 	case "$(uname -m)" in
 	s390x)
@@ -41,7 +54,7 @@ trace_libc_inet_pton_backtrace() {
 
 	perf_data=`mktemp -u /tmp/perf.data.XXX`
 	perf_script=`mktemp -u /tmp/perf.script.XXX`
-	perf record -e probe_libc:inet_pton/$eventattr/ -o $perf_data ping -6 -c 1 ::1 > /dev/null 2>&1
+	perf record -e $event_name/$eventattr/ -o $perf_data ping -6 -c 1 ::1 > /dev/null 2>&1
 	perf script -i $perf_data > $perf_script
 
 	exec 3<$perf_script
@@ -62,13 +75,20 @@ trace_libc_inet_pton_backtrace() {
 	# even if the perf script output does not match.
 }
 
+delete_libc_inet_pton_event() {
+
+	if [ -n "$event_name" ] ; then
+		perf probe -q -d $event_name
+	fi
+}
+
 # Check for IPv6 interface existence
 ip a sh lo | fgrep -q inet6 || exit 2
 
 skip_if_no_perf_probe && \
-perf probe -q $libc inet_pton && \
+add_libc_inet_pton_event && \
 trace_libc_inet_pton_backtrace
 err=$?
 rm -f ${perf_data} ${perf_script} ${expected}
-perf probe -q -d probe_libc:inet_pton
+delete_libc_inet_pton_event
 exit $err
