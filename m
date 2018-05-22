Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbeEVJxF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:53:05 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43132 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbeEVJxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:53:02 -0400
X-Google-Smtp-Source: AB8JxZqZsemCDh6sF1HAr1BnWpras/puJiy8co1gGVmZ5efZClBAzo8L7YBUwNeE1K7HXsnkvQOw3w==
Date: Tue, 22 May 2018 17:52:49 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Robert Walker <robert.walker@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tor Jeremiassen <tor@ti.com>,
        mike.leach@linaro.org, kim.phillips@arm.com,
        coresight@lists.linaro.org, Mike Leach <mike.leach@arm.com>
Subject: Re: [RFT v2 1/4] perf cs-etm: Generate sample for missed packets
Message-ID: <20180522095249.GE31075@leoy-ThinkPad-X240s>
References: <1526892748-326-1-git-send-email-leo.yan@linaro.org>
 <1526892748-326-2-git-send-email-leo.yan@linaro.org>
 <bc320d6d-a21d-b5a4-e30d-511bb69aba32@arm.com>
 <20180522083920.GD31075@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522083920.GD31075@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 04:39:20PM +0800, Leo Yan wrote:

[...]

Rather than the patch I posted in my previous email, I think below new
patch is more reasonable for me.

In the below change, 'etmq->prev_packet' is only used to store the
previous CS_ETM_RANGE packet, we don't need to save CS_ETM_TRACE_ON
packet into 'etmq->prev_packet'.

On the other hand, cs_etm__flush() can use 'etmq->period_instructions'
to indicate if need to generate instruction sample or not.  If it's
non-zero, then generate instruction sample and
'etmq->period_instructions' will be cleared; so next time if there
have more tracing CS_ETM_TRACE_ON packet, it can skip to generate
instruction sample due 'etmq->period_instructions' is zero.

How about you think for this?

Thanks,
Leo Yan


diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 822ba91..dd354ad 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -495,6 +495,13 @@ static inline void cs_etm__reset_last_branch_rb(struct cs_etm_queue *etmq)
 static inline u64 cs_etm__last_executed_instr(struct cs_etm_packet *packet)
 {
 	/*
+	 * The packet is the start tracing packet if the end_addr is zero,
+	 * returns 0 for this case.
+	 */
+	if (!packet->end_addr)
+		return 0;
+
+	/*
 	 * The packet records the execution range with an exclusive end address
 	 *
 	 * A64 instructions are constant size, so the last executed
@@ -897,13 +904,27 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 		etmq->period_instructions = instrs_over;
 	}
 
-	if (etm->sample_branches &&
-	    etmq->prev_packet &&
-	    etmq->prev_packet->sample_type == CS_ETM_RANGE &&
-	    etmq->prev_packet->last_instr_taken_branch) {
-		ret = cs_etm__synth_branch_sample(etmq);
-		if (ret)
-			return ret;
+	if (etm->sample_branches && etmq->prev_packet) {
+		bool generate_sample = false;
+
+		/* Generate sample for start tracing packet */
+		if (etmq->prev_packet->sample_type == 0)
+			generate_sample = true;
+
+		/* Generate sample for exception packet */
+		if (etmq->prev_packet->exc == true)
+			generate_sample = true;
+
+		/* Generate sample for normal branch packet */
+		if (etmq->prev_packet->sample_type == CS_ETM_RANGE &&
+		    etmq->prev_packet->last_instr_taken_branch)
+			generate_sample = true;
+
+		if (generate_sample) {
+			ret = cs_etm__synth_branch_sample(etmq);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (etm->sample_branches || etm->synth_opts.last_branch) {
@@ -922,11 +943,12 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 static int cs_etm__flush(struct cs_etm_queue *etmq)
 {
 	int err = 0;
-	struct cs_etm_packet *tmp;
 
 	if (etmq->etm->synth_opts.last_branch &&
 	    etmq->prev_packet &&
-	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
+	    etmq->prev_packet->sample_type == CS_ETM_RANGE &&
+	    etmq->period_instructions) {
+
 		/*
 		 * Generate a last branch event for the branches left in the
 		 * circular buffer at the end of the trace.
@@ -940,14 +962,6 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 			etmq, addr,
 			etmq->period_instructions);
 		etmq->period_instructions = 0;
-
-		/*
-		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
-		 * the next incoming packet.
-		 */
-		tmp = etmq->packet;
-		etmq->packet = etmq->prev_packet;
-		etmq->prev_packet = tmp;
 	}
 
 	return err;
-- 
2.7.4
