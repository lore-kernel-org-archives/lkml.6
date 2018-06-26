Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0FEC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCE624F11
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCE624F11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeFZGw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:52:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55323 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeFZGw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:52:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5Q6qHSM1591129
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Jun 2018 23:52:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5Q6qHvl1591126;
        Mon, 25 Jun 2018 23:52:17 -0700
Date:   Mon, 25 Jun 2018 23:52:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-b930e62ecd362843002bdf84c2940439822af321@git.kernel.org>
Cc:     hpa@zytor.com, schwidefsky@de.ibm.com, acme@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        tmricht@linux.ibm.com, brueckner@linux.ibm.com, tglx@linutronix.de,
        heiko.carstens@de.ibm.com
Reply-To: tmricht@linux.ibm.com, heiko.carstens@de.ibm.com,
          tglx@linutronix.de, brueckner@linux.ibm.com, mingo@kernel.org,
          acme@redhat.com, schwidefsky@de.ibm.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180611073153.15592-2-tmricht@linux.ibm.com>
References: <20180611073153.15592-2-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf test session topology: Fix test on s390
Git-Commit-ID: b930e62ecd362843002bdf84c2940439822af321
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

Commit-ID:  b930e62ecd362843002bdf84c2940439822af321
Gitweb:     https://git.kernel.org/tip/b930e62ecd362843002bdf84c2940439822af321
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Mon, 11 Jun 2018 09:31:53 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Jun 2018 11:59:35 -0300

perf test session topology: Fix test on s390

On s390 this test case fails because the socket identifiction numbers
assigned to the CPU are higher than the CPU identification numbers.

F/ix this by adding the platform architecture into the perf data header
flag information. This helps identifiing the test platform and handles
s390 specifics in process_cpu_topology().

Before:

  [root@p23lp27 perf]# perf test -vvvvv -F 39
  39: Session topology                                      :
  --- start ---
  templ file: /tmp/perf-test-iUv755
  socket_id number is too big.You may need to upgrade the perf tool.
  ---- end ----
  Session topology: Skip
  [root@p23lp27 perf]#

After:

  [root@p23lp27 perf]# perf test -vvvvv -F 39
  39: Session topology                                      :
  --- start ---
  templ file: /tmp/perf-test-8X8VTs
  CPU 0, core 0, socket 6
  CPU 1, core 1, socket 3
  ---- end ----
  Session topology: Ok
  [root@p23lp27 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Fixes: c84974ed9fb6 ("perf test: Add entry to test cpu topology")
Link: http://lkml.kernel.org/r/20180611073153.15592-2-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 40e30a26b23c..9497d02f69e6 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -45,6 +45,7 @@ static int session_write_header(char *path)
 
 	perf_header__set_feat(&session->header, HEADER_CPU_TOPOLOGY);
 	perf_header__set_feat(&session->header, HEADER_NRCPUS);
+	perf_header__set_feat(&session->header, HEADER_ARCH);
 
 	session->header.data_size += DATA_SIZE;
 
