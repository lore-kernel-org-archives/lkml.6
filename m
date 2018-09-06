Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320F5C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE5C206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE5C206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbeIFS1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:27:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39589 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeIFS1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:27:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86Dn8Ee311446
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:49:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86Dn7p2311443;
        Thu, 6 Sep 2018 06:49:07 -0700
Date:   Thu, 6 Sep 2018 06:49:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-hnizqwqrs03vcq1b74yao0f6@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mpetlan@redhat.com,
        namhyung@kernel.org, peterz@infradead.org,
        tmricht@linux.vnet.ibm.com, jolsa@kernel.org, tglx@linutronix.de,
        acme@redhat.com, kim.phillips@arm.com, adrian.hunter@intel.com,
        naveen.n.rao@linux.vnet.ibm.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, sandipan@linux.vnet.ibm.com,
        brueckner@linux.vnet.ibm.com, dsahern@gmail.com,
        sukadev@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
        wangnan0@huawei.com, hpa@zytor.com
Reply-To: adrian.hunter@intel.com, kim.phillips@arm.com, acme@redhat.com,
          tglx@linutronix.de, jolsa@kernel.org, tmricht@linux.vnet.ibm.com,
          peterz@infradead.org, namhyung@kernel.org, mpetlan@redhat.com,
          linux-kernel@vger.kernel.org, ravi.bangoria@linux.ibm.com,
          hpa@zytor.com, wangnan0@huawei.com, dsahern@gmail.com,
          sukadev@linux.vnet.ibm.com, brueckner@linux.vnet.ibm.com,
          sandipan@linux.vnet.ibm.com, mingo@kernel.org,
          alexander.shishkin@linux.intel.com,
          naveen.n.rao@linux.vnet.ibm.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests: Fix record+probe_libc_inet_pton.sh
 without ping's debuginfo
Git-Commit-ID: 1632936480a53d85ef3012cd9f290e247251cbb9
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

Commit-ID:  1632936480a53d85ef3012cd9f290e247251cbb9
Gitweb:     https://git.kernel.org/tip/1632936480a53d85ef3012cd9f290e247251cbb9
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 5 Sep 2018 10:47:56 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Sep 2018 10:47:56 -0300

perf tests: Fix record+probe_libc_inet_pton.sh without ping's debuginfo

When we don't have the iputils-debuginfo package installed, i.e. when we
don't have the DWARF information needed to resolve ping's samples, we
end up failing this 'perf test' entry:

  # perf test ping
  62: probe libc's inet_pton & backtrace it with ping       : Ok
  # rpm -e iputils-debuginfo
  # perf test ping
  62: probe libc's inet_pton & backtrace it with ping       : FAILED!
  #

Fix it to accept "[unknown]" where the symbol + offset, when resolved,
is expected.

I think this will fail in the other arches as well, but since I can't
test now, I'm leaving s390x and ppc cases as-is.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 7903a7086723 ("perf script: Show symbol offsets by default")
Link: https://lkml.kernel.org/n/tip-hnizqwqrs03vcq1b74yao0f6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 3013ac8f83d0..cab7b0aea6ea 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -48,7 +48,7 @@ trace_libc_inet_pton_backtrace() {
 	*)
 		eventattr='max-stack=3'
 		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
-		echo ".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
+		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
 	esac
 
