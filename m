Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933034AbeEWNWU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:22:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39263 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932957AbeEWNWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:22:15 -0400
X-Google-Smtp-Source: AB8JxZqFuadRFCTPtS7ykkVyZJEi9jVLGNMrlRhg5oAhZlXnRnbc9fVUUoZ7VGlQcxFdZnhB4zEEbQ==
Date: Wed, 23 May 2018 21:22:03 +0800
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
Message-ID: <20180523132203.GA30299@leoy-ThinkPad-X240s>
References: <1526892748-326-1-git-send-email-leo.yan@linaro.org>
 <1526892748-326-2-git-send-email-leo.yan@linaro.org>
 <bc320d6d-a21d-b5a4-e30d-511bb69aba32@arm.com>
 <20180522083920.GD31075@leoy-ThinkPad-X240s>
 <20180522095249.GE31075@leoy-ThinkPad-X240s>
 <3c9cdb5c-e1e0-f76d-5367-02aaf668b232@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c9cdb5c-e1e0-f76d-5367-02aaf668b232@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, May 23, 2018 at 12:21:18PM +0100, Robert Walker wrote:
> Hi Leo,
> 
> On 22/05/18 10:52, Leo Yan wrote:
> >On Tue, May 22, 2018 at 04:39:20PM +0800, Leo Yan wrote:
> >
> >[...]
> >
> >Rather than the patch I posted in my previous email, I think below new
> >patch is more reasonable for me.
> >
> >In the below change, 'etmq->prev_packet' is only used to store the
> >previous CS_ETM_RANGE packet, we don't need to save CS_ETM_TRACE_ON
> >packet into 'etmq->prev_packet'.
> >
> >On the other hand, cs_etm__flush() can use 'etmq->period_instructions'
> >to indicate if need to generate instruction sample or not.  If it's
> >non-zero, then generate instruction sample and
> >'etmq->period_instructions' will be cleared; so next time if there
> >have more tracing CS_ETM_TRACE_ON packet, it can skip to generate
> >instruction sample due 'etmq->period_instructions' is zero.
> >
> >How about you think for this?
> >
> >Thanks,
> >Leo Yan
> >
> 
> I don't think this covers the cases where CS_ETM_TRACE_ON is used to
> indicate a discontinuity in the trace.  For example, there is work in
> progress to configure the ETM so that it only traces a few thousand cycles
> with a gap of many thousands of cycles between each chunk of trace - this
> can be used to sample program execution in the form of instruction events
> with branch stacks for feedback directed optimization (AutoFDO).
> 
> In this case, the raw trace is something like:
> 
>     ...
>     I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0x0000007E7B886908;
>     I_ATOM_F3 : Atom format 3.; EEN
>     I_ATOM_F1 : Atom format 1.; E
> # Trace stops here
> 
> # Some time passes, and then trace is turned on again
>     I_TRACE_ON : Trace On.
>     I_ADDR_CTXT_L_64IS0 : Address & Context, Long, 64 bit, IS0.;
> Addr=0x00000057224322F4; Ctxt: AArch64,EL0, NS;
>     I_ATOM_F3 : Atom format 3.; ENN
>     I_ATOM_F5 : Atom format 5.; ENENE
>     ...
> 
> This results in the following packets from the decoder:
> 
> CS_ETM_RANGE: [0x7e7b886908-0x7e7b886930] br
> CS_ETM_RANGE: [0x7e7b88699c-0x7e7b8869a4] br
> CS_ETM_RANGE: [0x7e7b8869d8-0x7e7b8869f0]
> CS_ETM_RANGE: [0x7e7b8869f0-0x7e7b8869fc] br
> CS_ETM_TRACE_ON
> CS_ETM_RANGE: [0x57224322f4-0x5722432304] br
> CS_ETM_RANGE: [0x57224320e8-0x57224320ec]
> CS_ETM_RANGE: [0x57224320ec-0x57224320f8]
> CS_ETM_RANGE: [0x57224320f8-0x572243212c] br
> CS_ETM_RANGE: [0x5722439b80-0x5722439bec]
> CS_ETM_RANGE: [0x5722439bec-0x5722439c14] br
> CS_ETM_RANGE: [0x5722437c30-0x5722437c6c]
> CS_ETM_RANGE: [0x5722437c6c-0x5722437c7c] br
> 
> Without handling the CS_ETM_TRACE_ON, this would be interpreted as a branch
> from 0x7e7b8869f8 to 0x57224322f4, when there is actually a gap of many
> thousand instructions between these.
> 
> I think this patch will break the branch stacks - by removing the
> prev_packet swap from cs_etm__flush(), the next time a CS_ETM_RANGE packet
> is handled, cs_etm__sample() will see prev_packet contains the last
> CS_ETM_RANGE from the previous block of trace, causing an erroneous call to
> cs_etm__update_last_branch_rb().  In the example above, the branch stack
> will contain an erroneous branch from 0x7e7b8869f8 to 0x57224322f4.
> 
> I think what you need to do is add a check for the previous packet being a
> CS_ETM_TRACE_ON when determining the generate_sample value.

I still can see there have hole for packets handling with your
suggestion, let's focus on below three packets:

CS_ETM_RANGE:    [0x7e7b8869f0-0x7e7b8869fc] br
CS_ETM_TRACE_ON: [0xdeadbeefdeadbeef-0xdeadbeefdeadbeef]
CS_ETM_RANGE:    [0x57224322f4-0x5722432304] br

When the CS_ETM_TRACE_ON packet is coming, cs_etm__flush() doesn't
handle for 'etmq->prev_packet' to generate branch sample, this results
in we miss the info for 0x7e7b8869fc, and with packet swapping
'etmq->prev_packet' is assigned to CS_ETM_TRACE_ON packet.

When the last CS_ETM_RANGE packet is coming, cs_etm__sample() will
combine the values from CS_ETM_TRACE_ON packet and the last
CS_ETM_RANGE packet to generate branch sample packet; at the end
we get below sample packets:

  packet(n):   sample::addr=0x7e7b8869f0
  packet(n+1): sample::ip=0xdeadbeefdeadbeeb sample::addr=0x57224322f4

So I think we also need to generate branch sample, and we can get
below results:

  packet(n):   sample::addr=0x7e7b8869f0
  packet(n+1): sample::ip=0x7e7b8869f8 sample::addr=0xdeadbeefdeadbeef
  packet(n+2): sample::ip=0xdeadbeefdeadbeeb sample::addr=0x57224322f4

So we also can rely on this to get to know there have one address
range is [0xdeadbeefdeadbeef..0xdeadbeefdeadbeeb] to indicate there
have a discontinuity in the trace.

> Regards
> 
> Rob
> 
> >
> >diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> >index 822ba91..dd354ad 100644
> >--- a/tools/perf/util/cs-etm.c
> >+++ b/tools/perf/util/cs-etm.c
> >@@ -495,6 +495,13 @@ static inline void cs_etm__reset_last_branch_rb(struct cs_etm_queue *etmq)
> >  static inline u64 cs_etm__last_executed_instr(struct cs_etm_packet *packet)
> >  {
> >  	/*
> >+	 * The packet is the start tracing packet if the end_addr is zero,
> >+	 * returns 0 for this case.
> >+	 */
> >+	if (!packet->end_addr)
> >+		return 0;
> >+
> >+	/*
> >  	 * The packet records the execution range with an exclusive end address
> >  	 *
> >  	 * A64 instructions are constant size, so the last executed
> >@@ -897,13 +904,27 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
> >  		etmq->period_instructions = instrs_over;
> >  	}
> >-	if (etm->sample_branches &&
> >-	    etmq->prev_packet &&
> >-	    etmq->prev_packet->sample_type == CS_ETM_RANGE &&
> >-	    etmq->prev_packet->last_instr_taken_branch) {
> >-		ret = cs_etm__synth_branch_sample(etmq);
> >-		if (ret)
> >-			return ret;
> >+	if (etm->sample_branches && etmq->prev_packet) {
> >+		bool generate_sample = false;
> >+
> >+		/* Generate sample for start tracing packet */
> >+		if (etmq->prev_packet->sample_type == 0)
> >+			generate_sample = true;
> 
> Also check for etmq->prev_packet->sample_type == CS_ETM_TRACE_ON here and
> set generate_sample = true.

Agree, will add this.

> >+
> >+		/* Generate sample for exception packet */
> >+		if (etmq->prev_packet->exc == true)
> >+			generate_sample = true;
> >+
> >+		/* Generate sample for normal branch packet */
> >+		if (etmq->prev_packet->sample_type == CS_ETM_RANGE &&
> >+		    etmq->prev_packet->last_instr_taken_branch)
> >+			generate_sample = true;
> >+
> >+		if (generate_sample) {
> >+			ret = cs_etm__synth_branch_sample(etmq);
> >+			if (ret)
> >+				return ret;
> >+		}
> >  	}
> >  	if (etm->sample_branches || etm->synth_opts.last_branch) {
> >@@ -922,11 +943,12 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
> >  static int cs_etm__flush(struct cs_etm_queue *etmq)
> >  {
> >  	int err = 0;
> >-	struct cs_etm_packet *tmp;
> >  	if (etmq->etm->synth_opts.last_branch &&
> >  	    etmq->prev_packet &&
> >-	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
> >+	    etmq->prev_packet->sample_type == CS_ETM_RANGE &&
> >+	    etmq->period_instructions) {
> >+
> 
> I don't think this is needed.

Okay, I will keep this.

> >  		/*
> >  		 * Generate a last branch event for the branches left in the
> >  		 * circular buffer at the end of the trace.
> >@@ -940,14 +962,6 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
> >  			etmq, addr,
> >  			etmq->period_instructions);
> >  		etmq->period_instructions = 0;
> >-
> >-		/*
> >-		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
> >-		 * the next incoming packet.
> >-		 */
> >-		tmp = etmq->packet;
> >-		etmq->packet = etmq->prev_packet;
> >-		etmq->prev_packet = tmp;
> 
> This should not be changed as discussed above.

Okay, will keep this.  But I suggest we add some change like below:

+    if (etm->sample_branches) {
+        err = cs_etm__synth_branch_sample(etmq);
+        if (err)
+            return err;
+    }

If so, could you review my posted another patch for this?
http://archive.armlinux.org.uk/lurker/message/20180522.083920.184f1f78.en.html

Thanks,
Leo Yan

> >  	}
> >  	return err;
> >
