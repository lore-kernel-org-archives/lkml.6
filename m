Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF51C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A51520869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXEu7q9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A51520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388289AbeKFVcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:32:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387593AbeKFVcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:32:15 -0500
Received: from jouet.infradead.org (unknown [189.40.102.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 582C52086C;
        Tue,  6 Nov 2018 12:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541506041;
        bh=/o62ZdA16Jwg5ZnloQM0h07/q5btfodDjCEOHA+52vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nXEu7q9P4kS4HGbZXEusL1uey58oVZHnQDQqWYdp027C/KofIjAAKXmSE8iK6sEx2
         WVRPSxTPZZgRY4txvUf7m1tElsC9L1ekWXgPzPzTYuV9wvoWeKerOmlKrtYWly/u1W
         HFDCyErym3DUZOvo06C4rUyXOTEmag7Mv9W2E9Ak=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/18] perf intel-pt: Add MTC and CYC timestamps to debug log
Date:   Tue,  6 Nov 2018 09:06:09 -0300
Message-Id: <20181106120612.8262-16-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
-- 
2.14.4

