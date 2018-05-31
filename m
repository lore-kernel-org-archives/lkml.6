Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754457AbeEaK0E (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:26:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:26155 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754362AbeEaKZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:25:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="52233003"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] perf intel-pt: Fix sync_switch INTEL_PT_SS_NOT_TRACING
Date: Thu, 31 May 2018 13:23:42 +0300
Message-Id: <1527762225-26024-2-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527762225-26024-1-git-send-email-adrian.hunter@intel.com>
References: <1527762225-26024-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sync_switch is a facility to synchronize decoding more closely with the
point in the kernel when the context actually switched.

In one case, INTEL_PT_SS_NOT_TRACING state was not correctly transitioning
to INTEL_PT_SS_TRACING state due to a missing case clause. Add it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 tools/perf/util/intel-pt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 492986a25ef6..3db7f0ee52a8 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1521,6 +1521,7 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 
 	if (intel_pt_is_switch_ip(ptq, state->to_ip)) {
 		switch (ptq->switch_state) {
+		case INTEL_PT_SS_NOT_TRACING:
 		case INTEL_PT_SS_UNKNOWN:
 		case INTEL_PT_SS_EXPECTING_SWITCH_IP:
 			err = intel_pt_next_tid(pt, ptq);
-- 
1.9.1
