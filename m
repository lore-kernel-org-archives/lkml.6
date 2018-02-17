Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbeBQLje (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:39:34 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54407 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbeBQLjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:39:32 -0500
Date: Sat, 17 Feb 2018 03:39:16 -0800
From: tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-0f19a038afdc592176c9a302f0d08be6a68ad74a@git.kernel.org>
Cc: tmricht@linux.vnet.ibm.com, acme@redhat.com, heiko.carstens@de.ibm.com,
        linux-kernel@vger.kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org
Reply-To: schwidefsky@de.ibm.com, brueckner@linux.vnet.ibm.com, hpa@zytor.com,
        tglx@linutronix.de, mingo@kernel.org, tmricht@linux.vnet.ibm.com,
        acme@redhat.com, linux-kernel@vger.kernel.org,
        heiko.carstens@de.ibm.com
In-Reply-To: <20180214070303.55757-1-tmricht@linux.vnet.ibm.com>
References: <20180214070303.55757-1-tmricht@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test: Fix test case inet_pton to accept
 inlines.
Git-Commit-ID: 0f19a038afdc592176c9a302f0d08be6a68ad74a
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

Commit-ID:  0f19a038afdc592176c9a302f0d08be6a68ad74a
Gitweb:     https://git.kernel.org/tip/0f19a038afdc592176c9a302f0d08be6a68ad74a
Author:     Thomas Richter <tmricht@linux.vnet.ibm.com>
AuthorDate: Wed, 14 Feb 2018 08:03:03 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 15:16:58 -0300

perf test: Fix test case inet_pton to accept inlines.

Using Fedora 27 and latest Linux kernel the test case
trace+probe_libc_inet_pton.sh fails again on s390.  This time is the
inlining of functions which does not match.  After an update of the
glibc (from 2.26-16 to 2.26-24) the output is different

The expected output is:

             __inet_pton (/usr/lib64/libc-2.26.so)
             gaih_inet (inlined)
             ....

The actual output is:

  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev = 0.061/0.061/0.061/0.000 ms
       0.000 probe_libc:inet_pton:(3ffb2140448))
             __inet_pton (inlined)
             gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
             ...

Fix this by being less strict on 'inlined' verses library name and
accept both

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180214070303.55757-1-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/trace+probe_libc_inet_pton.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
index c446c89..8c4ab0b 100755
--- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
@@ -21,12 +21,12 @@ trace_libc_inet_pton_backtrace() {
 	expected[3]=".*packets transmitted.*"
 	expected[4]="rtt min.*"
 	expected[5]="[0-9]+\.[0-9]+[[:space:]]+probe_libc:inet_pton:\([[:xdigit:]]+\)"
-	expected[6]=".*inet_pton[[:space:]]\($libc\)$"
+	expected[6]=".*inet_pton[[:space:]]\($libc|inlined\)$"
 	case "$(uname -m)" in
 	s390x)
 		eventattr='call-graph=dwarf'
-		expected[7]="gaih_inet[[:space:]]\(inlined\)$"
-		expected[8]="__GI_getaddrinfo[[:space:]]\(inlined\)$"
+		expected[7]="gaih_inet.*[[:space:]]\($libc|inlined\)$"
+		expected[8]="__GI_getaddrinfo[[:space:]]\($libc|inlined\)$"
 		expected[9]="main[[:space:]]\(.*/bin/ping.*\)$"
 		expected[10]="__libc_start_main[[:space:]]\($libc\)$"
 		expected[11]="_start[[:space:]]\(.*/bin/ping.*\)$"
