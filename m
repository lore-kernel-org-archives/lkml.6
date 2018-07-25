Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACDEC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3203620671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3203620671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbeGYWAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:00:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46391 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731168AbeGYWAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:00:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKke00500828
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:46:40 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKkeK3500825;
        Wed, 25 Jul 2018 13:46:40 -0700
Date:   Wed, 25 Jul 2018 13:46:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sandipan Das <tipbot@zytor.com>
Message-ID: <tip-83e3b6d73e66a10088f362b08b99c36fec3a14e7@git.kernel.org>
Cc:     hpa@zytor.com, naveen.n.rao@linux.vnet.ibm.com, tglx@linutronix.de,
        sandipan@linux.ibm.com, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, mingo@kernel.org, kim.phillips@arm.com,
        ravi.bangoria@linux.vnet.ibm.com, acme@redhat.com
Reply-To: kim.phillips@arm.com, ravi.bangoria@linux.vnet.ibm.com,
          acme@redhat.com, tglx@linutronix.de,
          naveen.n.rao@linux.vnet.ibm.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, sandipan@linux.ibm.com,
          mingo@kernel.org, jolsa@redhat.com
In-Reply-To: <ce9fb091dd3028fba8749a1a267cfbcb264bbfb1.1530724939.git.sandipan@linux.ibm.com>
References: <ce9fb091dd3028fba8749a1a267cfbcb264bbfb1.1530724939.git.sandipan@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests: Fix record+probe_libc_inet_pton.sh to
 ensure cleanups
Git-Commit-ID: 83e3b6d73e66a10088f362b08b99c36fec3a14e7
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

Commit-ID:  83e3b6d73e66a10088f362b08b99c36fec3a14e7
Gitweb:     https://git.kernel.org/tip/83e3b6d73e66a10088f362b08b99c36fec3a14e7
Author:     Sandipan Das <sandipan@linux.ibm.com>
AuthorDate: Tue, 10 Jul 2018 19:28:16 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:52:09 -0300

perf tests: Fix record+probe_libc_inet_pton.sh to ensure cleanups

If there is a mismatch in the perf script output, this test fails and
exits before the event and temporary files created during its execution
are cleaned up.

This can be observed on a powerpc64 system running Fedora 27 as shown
below.

  # perf test -v "probe libc's inet_pton & backtrace it with ping"

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 18655
  ping 18674 [013] 24511.496995: probe_libc:inet_pton: (7fffa6b423b0)
  7fffa6b423b0 __GI___inet_pton+0x0 (/usr/lib64/power8/libc-2.26.so)
  7fffa6af90dc gaih_inet.constprop.7+0xf4c (/usr/lib64/power8/libc-2.26.so)
  FAIL: expected backtrace entry "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/power8/libc-2.26.so\)$" got "7fffa6af90dc gaih_inet.constprop.7+0xf4c (/usr/lib64/power8/libc-2.26.so)"
  test child finished with -1
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: FAILED!

  # ls /tmp/expected.* /tmp/perf.data.* /tmp/perf.script.*

  /tmp/expected.u31  /tmp/perf.data.Pki  /tmp/perf.script.Bhs

  # perf probe --list

    probe_libc:inet_pton (on __inet_pton@resolv/inet_pton.c in /usr/lib64/power8/libc-2.26.so)

Cleanup of the event and the temporary files are now ensured by allowing
the cleanup code to be executed even if the lines from the backtrace do
not match their expected patterns instead of simply exiting from the
point of failure.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/ce9fb091dd3028fba8749a1a267cfbcb264bbfb1.1530724939.git.sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 1220e5e052bb..0502a9e04c79 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -52,7 +52,7 @@ trace_libc_inet_pton_backtrace() {
 		echo "$line" | egrep -q "$pattern"
 		if [ $? -ne 0 ] ; then
 			printf "FAIL: expected backtrace entry \"%s\" got \"%s\"\n" "$pattern" "$line"
-			exit 1
+			return 1
 		fi
 	done
 
