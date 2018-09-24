Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B32ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DC22064D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7/5lc/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DC22064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387433AbeIXVIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733304AbeIXVIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:08:05 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 123BD2064D;
        Mon, 24 Sep 2018 15:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537801528;
        bh=QsaumsbSTxJNtxp8ASx9vGRvGO4oBxZRso9TVAPThvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e7/5lc/rr2qo7C2yodO3HtQ1M+fXm+HEvfooagx/Bise742oN+fFGZepsxcjLkPSB
         asw+bvI+/4MgFlIZR8kRG1NtZAy7Npqy7Ibs/1ydq97hf2DOEvbuycbL0gQlo1rCdp
         uYQXWd2sla8cfddMNC/xCzEEnsy5IY7pa6nws1hI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 26/27] perf intel-pt: Implement decoder flags for trace begin / end
Date:   Mon, 24 Sep 2018 12:02:41 -0300
Message-Id: <20180924150242.14235-27-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Have the Intel PT decoder implement the new Intel PT decoder flags for
trace begin / end.

Previously, the decoder would indicate begin / end by a branch from / to
zero. That hides useful information, in particular when a trace ends
with a call. That happens when using address filters, for example:

  $ perf record -e intel_pt/cyc,mtc_period=0,noretcomp/u --filter='filter main @ /bin/uname ' uname Linux
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
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20180920130048.31432-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 34 +++++++++++++++-------
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
2.14.4

