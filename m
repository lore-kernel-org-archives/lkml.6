Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78E2C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B0C27022
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B0C27022
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753682AbeF1HQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:16:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:21208 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753262AbeF1HQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:16:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 00:16:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,282,1526367600"; 
   d="scan'208";a="60773124"
Received: from keunhyun-mobl1.amr.corp.intel.com (HELO haswell-OptiPlex-9020.ccr.corp.intel.com) ([10.255.29.56])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jun 2018 00:16:06 -0700
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test record+probe_libc_inet_pton: expect [unknown] for ping as well
Date:   Thu, 28 Jun 2018 15:16:00 +0800
Message-Id: <1530170160-4979-1-git-send-email-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On system which has not installed debuginfo of iputils(ping) will fail like:
~/lkp/linux/tools/perf$ sudo ./perf test ping -v
63: probe libc's inet_pton & backtrace it with ping       :
--- start ---
test child forked, pid 4207
ping 4224 [007] 3034121.295510: probe_libc:inet_pton: (7fedfccb2200)
7fedfccb2200 __GI___inet_pton+0x0 (/lib/x86_64-linux-gnu/libc-2.23.so)
7fedfcc7ad5e getaddrinfo+0xee (/lib/x86_64-linux-gnu/libc-2.23.so)
55e3239a9f4d [unknown] (/bin/ping)
FAIL: expected backtrace entry 3
".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" got "55e3239a9f4d [unknown] (/bin/ping)"
test child finished with -1
---- end ----
probe libc's inet_pton & backtrace it with ping: FAILED!

To be compatible with this system, expects [unknown] as well

Fixes: 7903a7086723 ("perf script: Show symbol offsets by default")
CC: Sandipan Das <sandipan@linux.vnet.ibm.com>
CC: Thomas Richter <tmricht@linux.ibm.com>
Reported-by: kernel test robot <xiaolong.ye@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 2630570..ebb6549 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -22,12 +22,12 @@ trace_libc_inet_pton_backtrace() {
 		eventattr='call-graph=dwarf,max-stack=4'
 		expected[2]="gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
 		expected[3]="(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
-		expected[4]="main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
+		expected[4]=".*(\+0x[[:xdigit:]]|\[unknown\])+[[:space:]]\(.*/bin/ping.*\)$"
 		;;
 	*)
 		eventattr='max-stack=3'
 		expected[2]="getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$"
-		expected[3]=".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
+		expected[3]=".*(\+0x[[:xdigit:]]|\[unknown\])+[[:space:]]\(.*/bin/ping.*\)$"
 		;;
 	esac
 
-- 
2.7.4

