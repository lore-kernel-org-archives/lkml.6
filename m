Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABA8C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAADD21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAADD21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbeITSqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:46:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:5264 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388040AbeITSqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:46:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 06:02:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="74829248"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by orsmga008.jf.intel.com with ESMTP; 20 Sep 2018 06:02:48 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 6/6] perf intel-pt: Implement decoder flags for trace begin / end
Date:   Thu, 20 Sep 2018 16:00:48 +0300
Message-Id: <20180920130048.31432-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920130048.31432-1-adrian.hunter@intel.com>
References: <20180920130048.31432-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Have the Intel PT decoder implement the new Intel PT decoder flags for
trace begin / end.

Previously, the decoder would indicate begin / end by a branch from / to
zero. That hides useful information, in particular when a trace ends with a
call. That happens when using address filters, for example:

$ perf record -e intel_pt/cyc,mtc_period=0,noretcomp/u --filter='filter main @ /bin/uname ' uname
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.031 MB perf.data ]

Before:

$ perf script --itrace=cre -Ftime,flags,ip,sym,symoff,addr --ns
 7249.622183310:   tr strt         0 [unknown] =>   401590 main+0x0
 7249.622183311:   call       4015b9 main+0x29 =>        0 [unknown]
 7249.622183711:   tr strt         0 [unknown] =>   4015be main+0x2e
 7249.622183714:   call       4015c8 main+0x38 =>        0 [unknown]
 7249.622247731:   tr strt         0 [unknown] =>   4015cd main+0x3d
 7249.622247760:   call       4015d7 main+0x47 =>        0 [unknown]
 7249.622248340:   tr strt         0 [unknown] =>   4015dc main+0x4c
 7249.622248341:   call       4015e1 main+0x51 =>        0 [unknown]
 7249.622248681:   tr strt         0 [unknown] =>   4015e6 main+0x56
 7249.622248682:   call       4015eb main+0x5b =>        0 [unknown]
 7249.622248970:   tr strt         0 [unknown] =>   4015f0 main+0x60
 7249.622248971:   call       401612 main+0x82 =>        0 [unknown]
 7249.622249757:   tr strt         0 [unknown] =>   401617 main+0x87
 7249.622249770:   call       401847 main+0x2b7 =>        0 [unknown]
 7249.622250606:   tr strt         0 [unknown] =>   40184c main+0x2bc
 7249.622250612:   call       4019bf main+0x42f =>        0 [unknown]
 7249.622256823:   tr strt         0 [unknown] =>   4019c4 main+0x434
 7249.622256863:   call       4019f5 main+0x465 =>        0 [unknown]
 7249.622264217:   tr strt         0 [unknown] =>   4019fa main+0x46a
 7249.622264235:   call       401832 main+0x2a2 =>        0 [unknown]

After:

$ perf script --itrace=cre -Ftime,flags,ip,sym,symoff,addr --ns
 7249.622183310:   tr strt              0 [unknown] =>   401590 main+0x0
 7249.622183311:   tr end  call    4015b9 main+0x29 =>   401ef0 set_program_name+0x0
 7249.622183711:   tr strt              0 [unknown] =>   4015be main+0x2e
 7249.622183714:   tr end  call    4015c8 main+0x38 =>   4014b0 setlocale@plt+0x0
 7249.622247731:   tr strt              0 [unknown] =>   4015cd main+0x3d
 7249.622247760:   tr end  call    4015d7 main+0x47 =>   4012d0 bindtextdomain@plt+0x0
 7249.622248340:   tr strt              0 [unknown] =>   4015dc main+0x4c
 7249.622248341:   tr end  call    4015e1 main+0x51 =>   4012b0 textdomain@plt+0x0
 7249.622248681:   tr strt              0 [unknown] =>   4015e6 main+0x56
 7249.622248682:   tr end  call    4015eb main+0x5b =>   404340 atexit+0x0
 7249.622248970:   tr strt              0 [unknown] =>   4015f0 main+0x60
 7249.622248971:   tr end  call    401612 main+0x82 =>   401320 getopt_long@plt+0x0
 7249.622249757:   tr strt              0 [unknown] =>   401617 main+0x87
 7249.622249770:   tr end  call    401847 main+0x2b7 =>   401360 uname@plt+0x0
 7249.622250606:   tr strt              0 [unknown] =>   40184c main+0x2bc
 7249.622250612:   tr end  call    4019bf main+0x42f =>   401b10 print_element+0x0
 7249.622256823:   tr strt              0 [unknown] =>   4019c4 main+0x434
 7249.622256863:   tr end  call    4019f5 main+0x465 =>   401340 __overflow@plt+0x0
 7249.622264217:   tr strt              0 [unknown] =>   4019fa main+0x46a
 7249.622264235:   tr end  call    401832 main+0x2a2 =>   401520 exit@plt+0x0

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 34 +++++++++++++------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index d404bed7003a..58f6a9ceb590 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1165,7 +1165,7 @@ static int intel_pt_walk_tip(struct intel_pt_decoder *decoder)
 		decoder->pge = false;
 		decoder->continuous_period = false;
 		decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
-		decoder->state.to_ip = 0;
+		decoder->state.type |= INTEL_PT_TRACE_END;
 		return 0;
 	}
 	if (err == INTEL_PT_RETURN)
@@ -1179,9 +1179,13 @@ static int intel_pt_walk_tip(struct intel_pt_decoder *decoder)
 			decoder->continuous_period = false;
 			decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
 			decoder->state.from_ip = decoder->ip;
-			decoder->state.to_ip = 0;
-			if (decoder->packet.count != 0)
+			if (decoder->packet.count == 0) {
+				decoder->state.to_ip = 0;
+			} else {
+				decoder->state.to_ip = decoder->last_ip;
 				decoder->ip = decoder->last_ip;
+			}
+			decoder->state.type |= INTEL_PT_TRACE_END;
 		} else {
 			decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
 			decoder->state.from_ip = decoder->ip;
@@ -1208,7 +1212,8 @@ static int intel_pt_walk_tip(struct intel_pt_decoder *decoder)
 			decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
 			decoder->ip = to_ip;
 			decoder->state.from_ip = decoder->ip;
-			decoder->state.to_ip = 0;
+			decoder->state.to_ip = to_ip;
+			decoder->state.type |= INTEL_PT_TRACE_END;
 			return 0;
 		}
 		intel_pt_log_at("ERROR: Conditional branch when expecting indirect branch",
@@ -1640,14 +1645,15 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 
 		case INTEL_PT_TIP_PGD:
 			decoder->state.from_ip = decoder->ip;
-			decoder->state.to_ip = 0;
-			if (decoder->packet.count != 0) {
+			if (decoder->packet.count == 0) {
+				decoder->state.to_ip = 0;
+			} else {
 				intel_pt_set_ip(decoder);
-				intel_pt_log("Omitting PGD ip " x64_fmt "\n",
-					     decoder->ip);
+				decoder->state.to_ip = decoder->ip;
 			}
 			decoder->pge = false;
 			decoder->continuous_period = false;
+			decoder->state.type |= INTEL_PT_TRACE_END;
 			return 0;
 
 		case INTEL_PT_TIP_PGE:
@@ -1661,6 +1667,7 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 				intel_pt_set_ip(decoder);
 				decoder->state.to_ip = decoder->ip;
 			}
+			decoder->state.type |= INTEL_PT_TRACE_BEGIN;
 			return 0;
 
 		case INTEL_PT_TIP:
@@ -1739,6 +1746,7 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 			intel_pt_set_ip(decoder);
 			decoder->state.from_ip = 0;
 			decoder->state.to_ip = decoder->ip;
+			decoder->state.type |= INTEL_PT_TRACE_BEGIN;
 			return 0;
 		}
 
@@ -2077,9 +2085,13 @@ static int intel_pt_walk_to_ip(struct intel_pt_decoder *decoder)
 			decoder->pge = decoder->packet.type != INTEL_PT_TIP_PGD;
 			if (intel_pt_have_ip(decoder))
 				intel_pt_set_ip(decoder);
-			if (decoder->ip)
-				return 0;
-			break;
+			if (!decoder->ip)
+				break;
+			if (decoder->packet.type == INTEL_PT_TIP_PGE)
+				decoder->state.type |= INTEL_PT_TRACE_BEGIN;
+			if (decoder->packet.type == INTEL_PT_TIP_PGD)
+				decoder->state.type |= INTEL_PT_TRACE_END;
+			return 0;
 
 		case INTEL_PT_FUP:
 			if (intel_pt_have_ip(decoder))
-- 
2.17.1

