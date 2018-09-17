Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C64EECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392882146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392882146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbeIREkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:40:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50522 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731765AbeIREkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:40:51 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A4971C9D;
        Mon, 17 Sep 2018 23:11:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sunil K Pandey <sunil.k.pandey@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 088/158] perf evlist: Fix error out while applying initial delay and LBR
Date:   Tue, 18 Sep 2018 00:41:58 +0200
Message-Id: <20180917211715.287489145@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit 95035c5e167ae6e740b1ddd30210ae0eaf39a5db ]

'perf record' will error out if both --delay and LBR are applied.

For example:

  # perf record -D 1000 -a -e cycles -j any -- sleep 2
  Error:
  dummy:HG: PMU Hardware doesn't support sampling/overflow-interrupts.
  Try 'perf stat'
  #

A dummy event is added implicitly for initial delay, which has the same
configurations as real sampling events. The dummy event is a software
event. If LBR is configured, perf must error out.

The dummy event will only be used to track PERF_RECORD_MMAP while perf
waits for the initial delay to enable the real events. The BRANCH_STACK
bit can be safely cleared for the dummy event.

After applying the patch:

  # perf record -D 1000 -a -e cycles -j any -- sleep 2
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.054 MB perf.data (828 samples) ]
  #

Reported-by: Sunil K Pandey <sunil.k.pandey@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1531145722-16404-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/evsel.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -848,6 +848,12 @@ static void apply_config_terms(struct pe
 	}
 }
 
+static bool is_dummy_event(struct perf_evsel *evsel)
+{
+	return (evsel->attr.type == PERF_TYPE_SOFTWARE) &&
+	       (evsel->attr.config == PERF_COUNT_SW_DUMMY);
+}
+
 /*
  * The enable_on_exec/disabled value strategy:
  *
@@ -1086,6 +1092,14 @@ void perf_evsel__config(struct perf_evse
 		else
 			perf_evsel__reset_sample_bit(evsel, PERIOD);
 	}
+
+	/*
+	 * For initial_delay, a dummy event is added implicitly.
+	 * The software event will trigger -EOPNOTSUPP error out,
+	 * if BRANCH_STACK bit is set.
+	 */
+	if (opts->initial_delay && is_dummy_event(evsel))
+		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
 }
 
 static int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)


