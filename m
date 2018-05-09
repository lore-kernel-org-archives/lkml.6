Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933838AbeEIHpq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:45:46 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:30075 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933772AbeEIHpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:45:45 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="39725230"
From: Li Zhijian <lizhijian@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <acme@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <philip.li@intel.com>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2] perf test shell: Add -D to check dynamic symbols for ubuntu/debian
Date: Wed, 9 May 2018 15:45:29 +0800
Message-ID: <1525851929-20233-1-git-send-email-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.45]
X-yoursite-MailScanner-ID: 8EECA4D0EFC7.A523F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Ubuntu and Debian, we can't find any symbol including "inet_pton" from 'nm -g'
root@vm-lkp-nex04-8G-5 ~# nm -g /lib/x86_64-linux-gnu/libc-2.25.so | grep inet_pton
nm: /lib/x86_64-linux-gnu/libc-2.25.so: no symbols

it looks libc.so has different symbol compositions at different distros

Usage: nm [option(s)] [file(s)]
 List symbols in [file(s)] (a.out by default).
 The options are:
...snip...
  -D, --dynamic          Display dynamic symbols instead of normal symbols
      --defined-only     Display only defined symbols
  -e                     (ignored)
  -f, --format=FORMAT    Use the output format FORMAT.  FORMAT can be `bsd',
                           `sysv' or `posix'.  The default is `bsd'
  -g, --extern-only      Display only external symbols

I tested both debian/ubuntu and RHEL, they work as expected

CC: Thomas Richter <tmricht@linux.vnet.ibm.com>
CC: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 016882d..deec366 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -11,7 +11,7 @@
 . $(dirname $0)/lib/probe.sh
 
 libc=$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1/g')
-nm -g $libc 2>/dev/null | fgrep -q inet_pton || exit 254
+nm -gD $libc 2>/dev/null | fgrep -q inet_pton || exit 254
 
 trace_libc_inet_pton_backtrace() {
 	idx=0
-- 
2.7.4
