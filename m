Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+yTbsZfxsJAMtu811Sgwbdk4CgAPgrHgBL7olhVPFzdODrtKmuaj3jfBwJiIvpFgcVjcm1
ARC-Seal: i=1; a=rsa-sha256; t=1523980837; cv=none;
        d=google.com; s=arc-20160816;
        b=GS4tdsoknIcgjjdbboOYflBAjcbxznf0IWysHjiuoDiyozHF8XWifwnnXdTWGv4ifC
         iOq2uy3rbwtaRXB4+JOGQAgFRq36tEH+9wWA4yULs5iU4Mfvyt6pKf49VxAjsPN3qxdw
         rdiK7Kbb0VdD/k1VKuCXiZvnAZZfQyY8wxei5NXOxFONBPTKEYnoixIMnYtD7iFnxggh
         HfX+n0nr3RAuiDtLkxbC5++ELZYDYUsb6buXIBDz1H78BWvaNckV2gTvz1TaC19s0o0z
         tKhUo+RPxZ3G9gtyfqARe18Rw5dOGJ/80CjjJtJWLCxMh9WNl7wFMLo9ZwVXRbBFhAU3
         xR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hFDXMmEzZVLr5SxWRIVryLYMS5npX09KOuDHatG862Q=;
        b=i0LaLM4K2Yo2DoBxkyhtKHQIARg7OZmPq4DFKhi2IFIjNUAxZ4BO73+i+rnMPQ1X64
         yYtOqhlXIokOaAWJ3o0W+BP5K1ygDtbvxqzyt9IYDhn3ro+22m+f3UvgLIziW9pI8Occ
         Wypdy0h9gwjh6vhwHDY7A3djplCGZY6zxaM+LsofZx9V6noUd50gAX9KigyQN99uArVl
         mNFlmEuS0nUBd2tb7vHjxDYvUXZZeEgvg7e+b8FQLB7udmV5+pS3UWH1lg5x8V/nlCkP
         uU6wRr+12ceiCYPMDTafaQLFHE8w4YWMkTErrEapS2RT1kLCRKhE6fpjb88TUGG74Zmv
         dWPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.16 22/68] perf intel-pt: Fix overlap detection to identify consecutive buffers correctly
Date: Tue, 17 Apr 2018 17:57:35 +0200
Message-Id: <20180417155750.246366602@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009730584360732?=
X-GMAIL-MSGID: =?utf-8?q?1598009730584360732?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 117db4b27bf08dba412faf3924ba55fe970c57b8 upstream.

Overlap detection was not not updating the buffer's 'consecutive' flag.
Marking buffers consecutive has the advantage that decoding begins from
the start of the buffer instead of the first PSB. Fix overlap detection
to identify consecutive buffers correctly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1520431349-30689-2-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |   62 +++++++++-----------
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h |    2 
 tools/perf/util/intel-pt.c                          |    5 +
 3 files changed, 34 insertions(+), 35 deletions(-)

--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -2390,14 +2390,6 @@ const struct intel_pt_state *intel_pt_de
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
@@ -2486,6 +2478,7 @@ static unsigned char *intel_pt_last_psb(
  * @buf: buffer
  * @len: size of buffer
  * @tsc: TSC value returned
+ * @rem: returns remaining size when TSC is found
  *
  * Find a TSC packet in @buf and return the TSC value.  This function assumes
  * that @buf starts at a PSB and that PSB+ will contain TSC and so stops if a
@@ -2493,7 +2486,8 @@ static unsigned char *intel_pt_last_psb(
  *
  * Return: %true if TSC is found, false otherwise.
  */
-static bool intel_pt_next_tsc(unsigned char *buf, size_t len, uint64_t *tsc)
+static bool intel_pt_next_tsc(unsigned char *buf, size_t len, uint64_t *tsc,
+			      size_t *rem)
 {
 	struct intel_pt_pkt packet;
 	int ret;
@@ -2504,6 +2498,7 @@ static bool intel_pt_next_tsc(unsigned c
 			return false;
 		if (packet.type == INTEL_PT_TSC) {
 			*tsc = packet.payload;
+			*rem = len;
 			return true;
 		}
 		if (packet.type == INTEL_PT_PSBEND)
@@ -2554,6 +2549,8 @@ static int intel_pt_tsc_cmp(uint64_t tsc
  * @len_a: size of first buffer
  * @buf_b: second buffer
  * @len_b: size of second buffer
+ * @consecutive: returns true if there is data in buf_b that is consecutive
+ *               to buf_a
  *
  * If the trace contains TSC we can look at the last TSC of @buf_a and the
  * first TSC of @buf_b in order to determine if the buffers overlap, and then
@@ -2566,33 +2563,41 @@ static int intel_pt_tsc_cmp(uint64_t tsc
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
@@ -2606,6 +2611,8 @@ static unsigned char *intel_pt_find_over
  * @buf_b: second buffer
  * @len_b: size of second buffer
  * @have_tsc: can use TSC packets to detect overlap
+ * @consecutive: returns true if there is data in buf_b that is consecutive
+ *               to buf_a
  *
  * When trace samples or snapshots are recorded there is the possibility that
  * the data overlaps.  Note that, for the purposes of decoding, data is only
@@ -2616,7 +2623,7 @@ static unsigned char *intel_pt_find_over
  */
 unsigned char *intel_pt_find_overlap(unsigned char *buf_a, size_t len_a,
 				     unsigned char *buf_b, size_t len_b,
-				     bool have_tsc)
+				     bool have_tsc, bool *consecutive)
 {
 	unsigned char *found;
 
@@ -2628,7 +2635,8 @@ unsigned char *intel_pt_find_overlap(uns
 		return buf_b; /* No overlap */
 
 	if (have_tsc) {
-		found = intel_pt_find_overlap_tsc(buf_a, len_a, buf_b, len_b);
+		found = intel_pt_find_overlap_tsc(buf_a, len_a, buf_b, len_b,
+						  consecutive);
 		if (found)
 			return found;
 	}
@@ -2643,28 +2651,16 @@ unsigned char *intel_pt_find_overlap(uns
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
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -117,7 +117,7 @@ const struct intel_pt_state *intel_pt_de
 
 unsigned char *intel_pt_find_overlap(unsigned char *buf_a, size_t len_a,
 				     unsigned char *buf_b, size_t len_b,
-				     bool have_tsc);
+				     bool have_tsc, bool *consecutive);
 
 int intel_pt__strerror(int code, char *buf, size_t buflen);
 
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -207,14 +207,17 @@ static void intel_pt_dump_event(struct i
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
 
