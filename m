Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0082C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FCA206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FCA206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeIZPIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:08:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45377 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbeIZPIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:08:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8Q8u3Mm3772972
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Sep 2018 01:56:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8Q8u3193772969;
        Wed, 26 Sep 2018 01:56:03 -0700
Date:   Wed, 26 Sep 2018 01:56:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-c6b5da093a8ba740b71dd0052f3846016986fd21@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, jolsa@redhat.com,
        tglx@linutronix.de, ak@linux.intel.com, mingo@kernel.org,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org
Reply-To: jolsa@redhat.com, hpa@zytor.com, acme@redhat.com,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, tglx@linutronix.de, ak@linux.intel.com
In-Reply-To: <20180920130048.31432-6-adrian.hunter@intel.com>
References: <20180920130048.31432-6-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Add decoder flags for trace begin /
 end
Git-Commit-ID: c6b5da093a8ba740b71dd0052f3846016986fd21
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

Commit-ID:  c6b5da093a8ba740b71dd0052f3846016986fd21
Gitweb:     https://git.kernel.org/tip/c6b5da093a8ba740b71dd0052f3846016986fd21
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 20 Sep 2018 16:00:47 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 20 Sep 2018 15:19:51 -0300

perf intel-pt: Add decoder flags for trace begin / end

Previously, the decoder would indicate begin / end by a branch from / to
zero. That hides useful information, in particular when a trace ends
with a call. To prepare for remedying that, add Intel PT decoder flags
for trace begin / end and map them to the existing sample flags.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20180920130048.31432-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h | 2 ++
 tools/perf/util/intel-pt.c                          | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index 51c18d67f4ca..ed088d4726ba 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -37,6 +37,8 @@ enum intel_pt_sample_type {
 	INTEL_PT_EX_STOP	= 1 << 6,
 	INTEL_PT_PWR_EXIT	= 1 << 7,
 	INTEL_PT_CBR_CHG	= 1 << 8,
+	INTEL_PT_TRACE_BEGIN	= 1 << 9,
+	INTEL_PT_TRACE_END	= 1 << 10,
 };
 
 enum intel_pt_period_type {
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index aec68908d604..48c1d415c6b0 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -908,6 +908,11 @@ static void intel_pt_sample_flags(struct intel_pt_queue *ptq)
 		ptq->insn_len = ptq->state->insn_len;
 		memcpy(ptq->insn, ptq->state->insn, INTEL_PT_INSN_BUF_SZ);
 	}
+
+	if (ptq->state->type & INTEL_PT_TRACE_BEGIN)
+		ptq->flags |= PERF_IP_FLAG_TRACE_BEGIN;
+	if (ptq->state->type & INTEL_PT_TRACE_END)
+		ptq->flags |= PERF_IP_FLAG_TRACE_END;
 }
 
 static int intel_pt_setup_queue(struct intel_pt *pt,
