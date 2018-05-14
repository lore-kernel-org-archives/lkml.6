Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbeENMXh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753270AbeENMXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:23:34 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/5] perf test: "probe libc's inet_pton" fails on s390 due to missing inline
Date: Mon, 14 May 2018 09:23:17 -0300
Message-Id: <20180514122321.27304-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180514122321.27304-1-acme@kernel.org>
References: <20180514122321.27304-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

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
-- 
2.14.3
