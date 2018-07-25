Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88406C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE4620843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE4620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbeGYV7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:59:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49825 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730535AbeGYV7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:59:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKkAhf500774
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:46:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKkAMA500768;
        Wed, 25 Jul 2018 13:46:10 -0700
Date:   Wed, 25 Jul 2018 13:46:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sandipan Das <tipbot@zytor.com>
Message-ID: <tip-3eae52f842329a95f8549124079518231c0daba8@git.kernel.org>
Cc:     mingo@kernel.org, sandipan@linux.ibm.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        ravi.bangoria@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, maynard@us.ibm.com,
        tglx@linutronix.de, kim.phillips@arm.com, hpa@zytor.com
Reply-To: maynard@us.ibm.com, tglx@linutronix.de, kim.phillips@arm.com,
          hpa@zytor.com, mingo@kernel.org, sandipan@linux.ibm.com,
          acme@redhat.com, linux-kernel@vger.kernel.org, jolsa@redhat.com,
          sukadev@linux.vnet.ibm.com, ravi.bangoria@linux.vnet.ibm.com,
          naveen.n.rao@linux.vnet.ibm.com
In-Reply-To: <49621ec5f37109f0655e5a8c32287ad68d85a1e5.1530724939.git.sandipan@linux.ibm.com>
References: <49621ec5f37109f0655e5a8c32287ad68d85a1e5.1530724939.git.sandipan@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests: Fix record+probe_libc_inet_pton.sh for
 powerpc64
Git-Commit-ID: 3eae52f842329a95f8549124079518231c0daba8
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

Commit-ID:  3eae52f842329a95f8549124079518231c0daba8
Gitweb:     https://git.kernel.org/tip/3eae52f842329a95f8549124079518231c0daba8
Author:     Sandipan Das <sandipan@linux.ibm.com>
AuthorDate: Tue, 10 Jul 2018 19:28:15 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:51:37 -0300

perf tests: Fix record+probe_libc_inet_pton.sh for powerpc64

For powerpc64, this test currently fails due to a mismatch in the
expected output.

This can be observed on a powerpc64le system running Fedora 27 as shown
below.

  # perf test -v "probe libc's inet_pton & backtrace it with ping"

Before:

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 23948
  ping 23965 [003] 71136.075084: probe_libc:inet_pton: (7fff996aaf28)
  7fff996aaf28 __GI___inet_pton+0x8 (/usr/lib64/libc-2.26.so)
  7fff9965fa54 gaih_inet.constprop.7+0xf44 (/usr/lib64/libc-2.26.so)
  FAIL: expected backtrace entry 2 "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/libc-2.26.so\)$" got "7fff9965fa54 gaih_inet.constprop.7+0xf44 (/usr/lib64/libc-2.26.so)"
  test child finished with -1
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: FAILED!

After:

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 24638
  ping 24655 [001] 71208.525396: probe_libc:inet_pton: (7fffa245af28)
  7fffa245af28 __GI___inet_pton+0x8 (/usr/lib64/libc-2.26.so)
  7fffa240fa54 gaih_inet.constprop.7+0xf44 (/usr/lib64/libc-2.26.so)
  7fffa24105b4 getaddrinfo+0x164 (/usr/lib64/libc-2.26.so)
  138d52d70 main+0x3e0 (/usr/bin/ping)
  test child finished with 0
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: Ok

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Maynard Johnson <maynard@us.ibm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Fixes: e07d585e2454 ("perf tests: Switch trace+probe_libc_inet_pton to use record")
Link: http://lkml.kernel.org/r/49621ec5f37109f0655e5a8c32287ad68d85a1e5.1530724939.git.sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 94e513e62b34..1220e5e052bb 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -26,6 +26,12 @@ trace_libc_inet_pton_backtrace() {
 		echo "(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 		echo "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
+	ppc64|ppc64le)
+		eventattr='max-stack=4'
+		echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
+		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
+		echo ".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
+		;;
 	*)
 		eventattr='max-stack=3'
 		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
