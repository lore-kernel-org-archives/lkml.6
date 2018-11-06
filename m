Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEF3C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD0320827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD0320827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388475AbeKGEot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:44:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37075 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388320AbeKGEot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:44:49 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6JI0qb912315
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 11:18:00 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6JI0cn912312;
        Tue, 6 Nov 2018 11:18:00 -0800
Date:   Tue, 6 Nov 2018 11:18:00 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-f6c23e3b55cb93f32a724f41af8d38888bc2ab6b@git.kernel.org>
Cc:     tglx@linutronix.de, adrian.hunter@intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, acme@redhat.com, adrian.hunter@intel.com,
          mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20181105073505.8129-3-adrian.hunter@intel.com>
References: <20181105073505.8129-3-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf intel-pt: Add MTC and CYC timestamps to
 debug log
Git-Commit-ID: f6c23e3b55cb93f32a724f41af8d38888bc2ab6b
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

Commit-ID:  f6c23e3b55cb93f32a724f41af8d38888bc2ab6b
Gitweb:     https://git.kernel.org/tip/f6c23e3b55cb93f32a724f41af8d38888bc2ab6b
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 5 Nov 2018 09:35:05 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Nov 2018 14:53:54 -0300

perf intel-pt: Add MTC and CYC timestamps to debug log

One cause of decoding errors is un-synchronized side-band data.
Timestamps are needed to debug such cases. TSC packet timestamps are
logged. Log also MTC and CYC timestamps.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/r/20181105073505.8129-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 58f6a9ceb590..4503f3ca45ab 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1474,6 +1474,8 @@ static void intel_pt_calc_mtc_timestamp(struct intel_pt_decoder *decoder)
 		decoder->have_calc_cyc_to_tsc = false;
 		intel_pt_calc_cyc_to_tsc(decoder, true);
 	}
+
+	intel_pt_log_to("Setting timestamp", decoder->timestamp);
 }
 
 static void intel_pt_calc_cbr(struct intel_pt_decoder *decoder)
@@ -1514,6 +1516,8 @@ static void intel_pt_calc_cyc_timestamp(struct intel_pt_decoder *decoder)
 		decoder->timestamp = timestamp;
 
 	decoder->timestamp_insn_cnt = 0;
+
+	intel_pt_log_to("Setting timestamp", decoder->timestamp);
 }
 
 /* Walk PSB+ packets when already in sync. */
