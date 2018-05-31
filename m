Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754523AbeEaKZh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:25:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:26155 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754400AbeEaKZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:25:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="52233014"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] perf intel-pt: Fix decoding to accept CBR between FUP and corresponding TIP
Date: Thu, 31 May 2018 13:23:43 +0300
Message-Id: <1527762225-26024-3-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527762225-26024-1-git-send-email-adrian.hunter@intel.com>
References: <1527762225-26024-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to have a CBR packet between a FUP packet and corresponding
TIP packet. Stop treating it as an error.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index f9157aed1289..e5eb91777383 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1604,7 +1604,6 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 		case INTEL_PT_PSB:
 		case INTEL_PT_TSC:
 		case INTEL_PT_TMA:
-		case INTEL_PT_CBR:
 		case INTEL_PT_MODE_TSX:
 		case INTEL_PT_BAD:
 		case INTEL_PT_PSBEND:
@@ -1620,6 +1619,10 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 			decoder->pkt_step = 0;
 			return -ENOENT;
 
+		case INTEL_PT_CBR:
+			intel_pt_calc_cbr(decoder);
+			break;
+
 		case INTEL_PT_OVF:
 			return intel_pt_overflow(decoder);
 
-- 
1.9.1
