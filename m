Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbeEOGj5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:39:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40225 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752315AbeEOGj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:39:56 -0400
Date: Mon, 14 May 2018 23:39:44 -0700
From: tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-f8207b987fdc3768257704579bf29a717b4ea520@git.kernel.org>
Cc: mingo@kernel.org, schwidefsky@de.ibm.com, tmricht@linux.ibm.com,
        acme@redhat.com, tglx@linutronix.de, heiko.carstens@de.ibm.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        brueckner@linux.vnet.ibm.com
Reply-To: brueckner@linux.vnet.ibm.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com,
        tglx@linutronix.de, acme@redhat.com, tmricht@linux.ibm.com,
        mingo@kernel.org, schwidefsky@de.ibm.com
In-Reply-To: <20180503065837.71043-1-tmricht@linux.ibm.com>
References: <20180503065837.71043-1-tmricht@linux.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf test: "probe libc's inet_pton" fails on s390
 due to missing inline
Git-Commit-ID: f8207b987fdc3768257704579bf29a717b4ea520
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

Commit-ID:  f8207b987fdc3768257704579bf29a717b4ea520
Gitweb:     https://git.kernel.org/tip/f8207b987fdc3768257704579bf29a717b4ea520
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Thu, 3 May 2018 08:58:37 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 10 May 2018 15:19:30 -0300

perf test: "probe libc's inet_pton" fails on s390 due to missing inline

perf test "probe libc's inet_pton & backtrace it with ping" fails on
4.17.0rc3 on s/390. It turned out that function __inet_pton is reported
as inline:

  [root@s8360047 perf]# ./perf script -i /tmp/perf.data.111
  ping 12457 [000]  1584.478959: probe_libc:inet_pton: (3ffb5a347e8)
                    1347e8 __inet_pton (inlined)
                     f19d7 gaih_inet.constprop.5 (/usr/lib64/libc-2.24.so)
                     f4c3f __GI_getaddrinfo (inlined)
                      410b main (/usr/bin/ping)

Allow __inet_pton listed as inline.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180503065837.71043-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 016882dbbc16..ee86473643be 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -16,7 +16,7 @@ nm -g $libc 2>/dev/null | fgrep -q inet_pton || exit 254
 trace_libc_inet_pton_backtrace() {
 	idx=0
 	expected[0]="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
-	expected[1]=".*inet_pton[[:space:]]\($libc\)$"
+	expected[1]=".*inet_pton[[:space:]]\($libc|inlined\)$"
 	case "$(uname -m)" in
 	s390x)
 		eventattr='call-graph=dwarf,max-stack=4'
