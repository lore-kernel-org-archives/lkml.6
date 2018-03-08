Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2782356-1520539269-2-4933317377419438799
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520539268; b=mt1YYaygt+YrHosFCu1mJH6aRTs8Yjt1NXMy63XoKXQICQr
    cC2rdxZfA9Zf79QjZb30EsG9RhycK5CT2tSWDXa5r+flXbSYF9E/05X0O7GPpTBn
    upaGZWoGlRhAT7jqzH70OdsxzCmD1l4tdtQI49kRF0x6qNBYEswVBJINIgr8wERN
    1r0MrX4xyADAPjJl5W7SpbsEIMlfJdby6CiVEo7BbYV+Vi7pnRo5UYr5tRQzOmjQ
    dJTBl/LzAn8g72XXm6PE/s23tsdwXKkKSifjLrzA+uHkidDnjz6Ni0mwCKZJsc7b
    VreQReYICg+dxB2Q0rO2lppbTZlntC8vVFm3x+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520539268;
    bh=KkLEDJsUy0ala/mUT46kyeNyFXwC1P84ZFXrxBlElpM=; b=ImH6DNlqYUxb
    6OFHcFiC38lVQR3FEOnzzcCs4e+if1+hyUG9L2TLo4jZ61naE2FXGPhvfCOBi7vj
    lvsT9GLOcm4/wxonNrcXPy6bPQtoVM/wK28pjwYlgD2/GXHE98MW4LmRMBA0zRK3
    sgCI16zPxJghIXWLqt87n403lLF9zHrozg9MSdYR1a660w32+opejXud1eqM3XH5
    zhZXieyHyeO+RPvJd3XBumK6vwfc0VnvyvVlf1qEkrzSAoQpED3Q+Mzh1IuXsg7i
    NfNLSlF/3QiWOd94743GEsF8pUx8DteKiw7atWL1w1rZZMnpHgLWiD9g7AHN8kKh
    6fhDBsJixw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbeCHTwJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 14:52:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752065AbeCHTwG (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 14:52:06 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769A921795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 30/54] perf intel-pt: Fix overlap detection to identify consecutive buffers correctly
Date: Thu,  8 Mar 2018 16:50:05 -0300
Message-Id: <20180308195029.14991-31-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adrian Hunter <adrian.hunter@intel.com>

Overlap detection was not not updating the buffer's 'consecutive' flag.
Marking buffers consecutive has the advantage that decoding begins from
the start of the buffer instead of the first PSB. Fix overlap detection
to identify consecutive buffers correctly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1520431349-30689-2-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 62 ++++++++++------------
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |  2 +-
 tools/perf/util/intel-pt.c                         |  5 +-
 3 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index aa1593ce551d..00f25f4b5f48 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -2390,14 +2390,6 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 	return &decoder->state;
 }
 
-static bool intel_pt_at_psb(unsigned char *buf, size_t len)
-{
-	if (len < INTEL_PT_PSB_LEN)
-		return false;
-	return memmem(buf, INTEL_PT_PSB_LEN, INTEL_PT_PSB_STR,
-		      INTEL_PT_PSB_LEN);
-}
-
 /**
  * intel_pt_next_psb - move buffer pointer to the start of the next PSB packet.
  * @buf: pointer to buffer pointer
@@ -2486,6 +2478,7 @@ static unsigned char *intel_pt_last_psb(unsigned char *buf, size_t len)
  * @buf: buffer
  * @len: size of buffer
  * @tsc: TSC value returned
+ * @rem: returns remaining size when TSC is found
  *
  * Find a TSC packet in @buf and return the TSC value.  This function assumes
  * that @buf starts at a PSB and that PSB+ will contain TSC and so stops if a
@@ -2493,7 +2486,8 @@ static unsigned char *intel_pt_last_psb(unsigned char *buf, size_t len)
  *
  * Return: %true if TSC is found, false otherwise.
  */
-static bool intel_pt_next_tsc(unsigned char *buf, size_t len, uint64_t *tsc)
+static bool intel_pt_next_tsc(unsigned char *buf, size_t len, uint64_t *tsc,
+			      size_t *rem)
 {
 	struct intel_pt_pkt packet;
 	int ret;
@@ -2504,6 +2498,7 @@ static bool intel_pt_next_tsc(unsigned char *buf, size_t len, uint64_t *tsc)
 			return false;
 		if (packet.type == INTEL_PT_TSC) {
 			*tsc = packet.payload;
+			*rem = len;
 			return true;
 		}
 		if (packet.type == INTEL_PT_PSBEND)
@@ -2554,6 +2549,8 @@ static int intel_pt_tsc_cmp(uint64_t tsc1, uint64_t tsc2)
  * @len_a: size of first buffer
  * @buf_b: second buffer
  * @len_b: size of second buffer
+ * @consecutive: returns true if there is data in buf_b that is consecutive
+ *               to buf_a
  *
  * If the trace contains TSC we can look at the last TSC of @buf_a and the
  * first TSC of @buf_b in order to determine if the buffers overlap, and then
@@ -2566,33 +2563,41 @@ static int intel_pt_tsc_cmp(uint64_t tsc1, uint64_t tsc2)
 static unsigned char *intel_pt_find_overlap_tsc(unsigned char *buf_a,
 						size_t len_a,
 						unsigned char *buf_b,
-						size_t len_b)
+						size_t len_b, bool *consecutive)
 {
 	uint64_t tsc_a, tsc_b;
 	unsigned char *p;
-	size_t len;
+	size_t len, rem_a, rem_b;
 
 	p = intel_pt_last_psb(buf_a, len_a);
 	if (!p)
 		return buf_b; /* No PSB in buf_a => no overlap */
 
 	len = len_a - (p - buf_a);
-	if (!intel_pt_next_tsc(p, len, &tsc_a)) {
+	if (!intel_pt_next_tsc(p, len, &tsc_a, &rem_a)) {
 		/* The last PSB+ in buf_a is incomplete, so go back one more */
 		len_a -= len;
 		p = intel_pt_last_psb(buf_a, len_a);
 		if (!p)
 			return buf_b; /* No full PSB+ => assume no overlap */
 		len = len_a - (p - buf_a);
-		if (!intel_pt_next_tsc(p, len, &tsc_a))
+		if (!intel_pt_next_tsc(p, len, &tsc_a, &rem_a))
 			return buf_b; /* No TSC in buf_a => assume no overlap */
 	}
 
 	while (1) {
 		/* Ignore PSB+ with no TSC */
-		if (intel_pt_next_tsc(buf_b, len_b, &tsc_b) &&
-		    intel_pt_tsc_cmp(tsc_a, tsc_b) < 0)
-			return buf_b; /* tsc_a < tsc_b => no overlap */
+		if (intel_pt_next_tsc(buf_b, len_b, &tsc_b, &rem_b)) {
+			int cmp = intel_pt_tsc_cmp(tsc_a, tsc_b);
+
+			/* Same TSC, so buffers are consecutive */
+			if (!cmp && rem_b >= rem_a) {
+				*consecutive = true;
+				return buf_b + len_b - (rem_b - rem_a);
+			}
+			if (cmp < 0)
+				return buf_b; /* tsc_a < tsc_b => no overlap */
+		}
 
 		if (!intel_pt_step_psb(&buf_b, &len_b))
 			return buf_b + len_b; /* No PSB in buf_b => no data */
@@ -2606,6 +2611,8 @@ static unsigned char *intel_pt_find_overlap_tsc(unsigned char *buf_a,
  * @buf_b: second buffer
  * @len_b: size of second buffer
  * @have_tsc: can use TSC packets to detect overlap
+ * @consecutive: returns true if there is data in buf_b that is consecutive
+ *               to buf_a
  *
  * When trace samples or snapshots are recorded there is the possibility that
  * the data overlaps.  Note that, for the purposes of decoding, data is only
@@ -2616,7 +2623,7 @@ static unsigned char *intel_pt_find_overlap_tsc(unsigned char *buf_a,
  */
 unsigned char *intel_pt_find_overlap(unsigned char *buf_a, size_t len_a,
 				     unsigned char *buf_b, size_t len_b,
-				     bool have_tsc)
+				     bool have_tsc, bool *consecutive)
 {
 	unsigned char *found;
 
@@ -2628,7 +2635,8 @@ unsigned char *intel_pt_find_overlap(unsigned char *buf_a, size_t len_a,
 		return buf_b; /* No overlap */
 
 	if (have_tsc) {
-		found = intel_pt_find_overlap_tsc(buf_a, len_a, buf_b, len_b);
+		found = intel_pt_find_overlap_tsc(buf_a, len_a, buf_b, len_b,
+						  consecutive);
 		if (found)
 			return found;
 	}
@@ -2643,28 +2651,16 @@ unsigned char *intel_pt_find_overlap(unsigned char *buf_a, size_t len_a,
 	}
 
 	/* Now len_b >= len_a */
-	if (len_b > len_a) {
-		/* The leftover buffer 'b' must start at a PSB */
-		while (!intel_pt_at_psb(buf_b + len_a, len_b - len_a)) {
-			if (!intel_pt_step_psb(&buf_a, &len_a))
-				return buf_b; /* No overlap */
-		}
-	}
-
 	while (1) {
 		/* Potential overlap so check the bytes */
 		found = memmem(buf_a, len_a, buf_b, len_a);
-		if (found)
+		if (found) {
+			*consecutive = true;
 			return buf_b + len_a;
+		}
 
 		/* Try again at next PSB in buffer 'a' */
 		if (!intel_pt_step_psb(&buf_a, &len_a))
 			return buf_b; /* No overlap */
-
-		/* The leftover buffer 'b' must start at a PSB */
-		while (!intel_pt_at_psb(buf_b + len_a, len_b - len_a)) {
-			if (!intel_pt_step_psb(&buf_a, &len_a))
-				return buf_b; /* No overlap */
-		}
 	}
 }
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index 921b22e8ca0e..fc1752d50019 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -117,7 +117,7 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder);
 
 unsigned char *intel_pt_find_overlap(unsigned char *buf_a, size_t len_a,
 				     unsigned char *buf_b, size_t len_b,
-				     bool have_tsc);
+				     bool have_tsc, bool *consecutive);
 
 int intel_pt__strerror(int code, char *buf, size_t buflen);
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 3773d9c54f45..4a7746249999 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -207,14 +207,17 @@ static void intel_pt_dump_event(struct intel_pt *pt, unsigned char *buf,
 static int intel_pt_do_fix_overlap(struct intel_pt *pt, struct auxtrace_buffer *a,
 				   struct auxtrace_buffer *b)
 {
+	bool consecutive = false;
 	void *start;
 
 	start = intel_pt_find_overlap(a->data, a->size, b->data, b->size,
-				      pt->have_tsc);
+				      pt->have_tsc, &consecutive);
 	if (!start)
 		return -EINVAL;
 	b->use_size = b->data + b->size - start;
 	b->use_data = start;
+	if (b->use_size && consecutive)
+		b->consecutive = true;
 	return 0;
 }
 
-- 
2.14.3
