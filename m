Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC40C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592862083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yFrl3qWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592862083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733256AbeIXVIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733069AbeIXVH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:07:59 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A4BB2083A;
        Mon, 24 Sep 2018 15:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537801524;
        bh=EsBxKDUUJlZMRpXxvnZ3eI+xI16UyY4BeANKAF8cGps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yFrl3qWDn2EehaEdnRoW2Vc7m/mgHfge1fUzB3TsiWFD4AZXF11XExvF7IQ2acbRa
         EJ/6jyESNTIc/nUaL9GcAaU8cslVJ2UzZmfgovwB+VAb/hkpXMP7vvESzPQ8GQGH1q
         /u1idoc8beAXM+uvb51sneW7bm3LdAQas9OkUiEg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 25/27] perf intel-pt: Add decoder flags for trace begin / end
Date:   Mon, 24 Sep 2018 12:02:40 -0300
Message-Id: <20180924150242.14235-26-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
-- 
2.14.4

