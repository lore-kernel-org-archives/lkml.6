Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9BFC7C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51582208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51582208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754675AbeFNGZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:25:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48907 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752671AbeFNGZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:25:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5E6OswF765488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Jun 2018 23:24:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5E6OsN6765485;
        Wed, 13 Jun 2018 23:24:54 -0700
Date:   Wed, 13 Jun 2018 23:24:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Seeteena Thoufeek <tipbot@zytor.com>
Message-ID: <tip-fad76d4333fe73cf3f73704aa34d4ce523b1c458@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, namhyung@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, s1seetee@linux.vnet.ibm.com,
        alexander.shishkin@linux.intel.com, acme@redhat.com
Reply-To: linux-kernel@vger.kernel.org, s1seetee@linux.vnet.ibm.com,
          alexander.shishkin@linux.intel.com, jolsa@redhat.com,
          acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, peterz@infradead.org, namhyung@kernel.org
In-Reply-To: <1528455748-20087-1-git-send-email-s1seetee@linux.vnet.ibm.com>
References: <1528455748-20087-1-git-send-email-s1seetee@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Show hw-cache events
Git-Commit-ID: fad76d4333fe73cf3f73704aa34d4ce523b1c458
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

Commit-ID:  fad76d4333fe73cf3f73704aa34d4ce523b1c458
Gitweb:     https://git.kernel.org/tip/fad76d4333fe73cf3f73704aa34d4ce523b1c458
Author:     Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
AuthorDate: Fri, 8 Jun 2018 16:32:28 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 8 Jun 2018 13:41:30 -0300

perf script: Show hw-cache events

'perf script' fails to report hardware cache events (PERF_TYPE_HW_CACHE)
where as 'perf report' shows the samples. Fix it. Ex,

  # perf record -e L1-dcache-loads ./a.out
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.008 MB perf.data (11 samples)]

Before patch:

  # perf script | wc -l
  0

After patch:

  # perf script | wc -l
  11

Committer testing:

  [root@jouet ~]# perf script | head -30 | tail
        Timer 9803 [2] 8.963330:  1554 L1-dcache-loads: 7ffef89baae4 __vdso_clock_gettime+0xf4 ([vdso])
      swapper    0 [2] 8.963343:  5626 L1-dcache-loads: ffffffffa66f4f6b cpuidle_not_av+0xb (/lib/modules/4.17.0-rc5/build/vmlinux)
      firefox 4853 [2] 8.964070: 18935 L1-dcache-loads: 7f0b9a00dc30 xcb_poll_for_event+0x0 (/usr/lib64/libxcb.so.1.1.0)
  Softwar~cTh 4928 [2] 8.964548: 15928 L1-dcache-loads: ffffffffa60d795c update_curr+0x10c (/lib/modules/4.17.0-rc5/build/vmlinux)
      firefox 4853 [2] 8.964675: 14978 L1-dcache-loads: ffffffffa6897018 mutex_unlock+0x18 (/lib/modules/4.17.0-rc5/build/vmlinux)
  gnome-shell 2026 [3] 8.964693: 50670 L1-dcache-loads: 7fa08854de6d g_source_iter_next+0x6d (/usr/lib64/libglib-2.0.so.0.5400.3)
   Compositor 4929 [1] 8.964784: 71772 L1-dcache-loads: 7f0b936bf078 [unknown] (/usr/lib64/firefox/libxul.so)
     Xwayland 2096 [2] 8.964919: 16799 L1-dcache-loads: 7f68ce2fcb8a glXGetCurrentContext+0x1a (/usr/lib64/libGLX.so.0.0.0)
  gnome-shell 2026 [3] 8.964997: 50670 L1-dcache-loads: 7fa08854de6d g_source_iter_next+0x6d (/usr/lib64/libglib-2.0.so.0.5400.3)
  [root@jouet ~]#

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1528455748-20087-1-git-send-email-s1seetee@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b3bf35512d21..a31d7082188e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -180,6 +180,18 @@ static struct {
 				  PERF_OUTPUT_EVNAME | PERF_OUTPUT_TRACE
 	},
 
+	[PERF_TYPE_HW_CACHE] = {
+		.user_set = false,
+
+		.fields = PERF_OUTPUT_COMM | PERF_OUTPUT_TID |
+			      PERF_OUTPUT_CPU | PERF_OUTPUT_TIME |
+			      PERF_OUTPUT_EVNAME | PERF_OUTPUT_IP |
+			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
+			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD,
+
+		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
+	},
+
 	[PERF_TYPE_RAW] = {
 		.user_set = false,
 
