Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YT4KG+zqGFsXZwAAmS7hNA
	; Thu, 07 Jun 2018 08:21:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A3EF2607F7; Thu,  7 Jun 2018 08:21:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1BC446063F;
	Thu,  7 Jun 2018 08:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1BC446063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932558AbeFGIVX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:21:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47633 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753044AbeFGIVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:21:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578L7lT2126204
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:21:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578L7qr2126201;
        Thu, 7 Jun 2018 01:21:07 -0700
Date: Thu, 7 Jun 2018 01:21:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-zlfnbauad3ljlmtjgo0v660u@git.kernel.org>
Cc: naveen.n.rao@linux.vnet.ibm.com, namhyung@kernel.org,
        tmricht@linux.ibm.com, mingo@kernel.org, heiko.carstens@de.ibm.com,
        linux-kernel@vger.kernel.org, brueckner@linux.vnet.ibm.com,
        hpa@zytor.com, adrian.hunter@intel.com, tglx@linutronix.de,
        acme@redhat.com, schwidefsky@de.ibm.com, wangnan0@huawei.com,
        jolsa@kernel.org, dsahern@gmail.com, sandipan@linux.vnet.ibm.com
Reply-To: naveen.n.rao@linux.vnet.ibm.com, tmricht@linux.ibm.com,
          namhyung@kernel.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, heiko.carstens@de.ibm.com, hpa@zytor.com,
          brueckner@linux.vnet.ibm.com, adrian.hunter@intel.com,
          tglx@linutronix.de, acme@redhat.com, jolsa@kernel.org,
          schwidefsky@de.ibm.com, wangnan0@huawei.com,
          sandipan@linux.vnet.ibm.com, dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf test record+probe_libc_inet_pton: Ask 'nm'
 for dynamic symbols
Git-Commit-ID: 005cc008bc188f81f0c1ae53dafb50cdb6df19c2
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

Commit-ID:  005cc008bc188f81f0c1ae53dafb50cdb6df19c2
Gitweb:     https://git.kernel.org/tip/005cc008bc188f81f0c1ae53dafb50cdb6df19c2
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 4 Jun 2018 11:11:13 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Jun 2018 12:52:06 -0300

perf test record+probe_libc_inet_pton: Ask 'nm' for dynamic symbols

Adrian reported that this test fails in his system where:

  probe libc's inet_pton & backtrace it with ping: FAILED!
  root@kbl04:~/git/linux-perf# nm -g /lib/x86_64-linux-gnu/libc-2.19.so | grep inet_pton
  nm: /lib/x86_64-linux-gnu/libc-2.19.so: no symbols

This fails on ubuntu systems, with Adrian's being kubuntu 14.04, I
tested with ubuntu 14.04.4 and 18.04, and there we need to use the
-D/--dynamic 'nm' option to have this test working. And it works as well
with that on fedora 27, so use it.

Reported-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zlfnbauad3ljlmtjgo0v660u@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 650b208f700f..263057039693 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -11,7 +11,7 @@
 . $(dirname $0)/lib/probe.sh
 
 libc=$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1/g')
-nm -g $libc 2>/dev/null | fgrep -q inet_pton || exit 254
+nm -Dg $libc 2>/dev/null | fgrep -q inet_pton || exit 254
 
 trace_libc_inet_pton_backtrace() {
 	idx=0
