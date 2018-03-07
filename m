Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933775AbeCGOEr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:04:47 -0500
Received: from mga02.intel.com ([134.134.136.20]:30695 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754433AbeCGODX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:03:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,436,1515484800";
   d="scan'208";a="36206813"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] perf intel-pt: Fix timestamp following overflow
Date: Wed,  7 Mar 2018 16:02:24 +0200
Message-Id: <1520431349-30689-5-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520431349-30689-1-git-send-email-adrian.hunter@intel.com>
References: <1520431349-30689-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

timestamp_insn_cnt is used to estimate the timestamp based on the number of
instructions since the last known timestamp. If the estimate is not
accurate enough decoding might not be correctly synchronized with side-band
events causing more trace errors. However there are always timestamps
following an overflow, so the estimate is not needed and can indeed result
in more errors. Suppress the estimate by setting timestamp_insn_cnt to
zero.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: <stable@vger.kernel.org>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 5e4d0bbafc8b..f9157aed1289 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1378,6 +1378,7 @@ static int intel_pt_overflow(struct intel_pt_decoder *decoder)
 	intel_pt_clear_tx_flags(decoder);
 	decoder->have_tma = false;
 	decoder->cbr = 0;
+	decoder->timestamp_insn_cnt = 0;
 	decoder->pkt_state = INTEL_PT_STATE_ERR_RESYNC;
 	decoder->overflow = true;
 	return -EOVERFLOW;
-- 
1.9.1
