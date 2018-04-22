Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx488NT1cxOvhqqOHc2jY9VRbKbwTUYsYdcfS5NEawjZUQz5hlHZ+4WqmSPIdYi94XzB4I+58
ARC-Seal: i=1; a=rsa-sha256; t=1524406832; cv=none;
        d=google.com; s=arc-20160816;
        b=nyjmbdmyLNVyzTDLGZNijKAgXVjHGquBu3x+16sjBF0pBXQHIywjxin3nq2tBKuUds
         tHj6U+yt+paAyN/v1g2fxmH1FkKDcjqZON1xX8FJLiDDnU/YanUeVTdzFQlp7p8JwKB8
         wpMXfYoiuIfS1G+6Cntq5QOEJzGsX7fiPvydwKaSGlLW8IxpqYoB5s3MHj4FjfmNf0pQ
         K758H9bGAd9qxBAsvJKUWlrMJv8keIqB00IVPcXhg26E9RC0NRccINRs224/CN0ZgCsa
         5kRGfZPAGt3aHzwuPqb8y7E0ySWYPC3btZBOmpvtooE1To0MHdU32Dogrp8qgNqvJb+I
         l/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=U8G01TGY6rvvSvad/OJYNmSdfNgdgZw3bzzEXyskFpc=;
        b=lqYRBtmUkvr5dv5xXeYT6k9WrIocAjfDFovnCBTD7pwjka/SZr+VGyBSLCJuPDIQAR
         bpfrKG7qK/Kn3YH7CO3esAZGCcTExNLCjboxb6PxTmMWee32HLg+GzbP8ogbXK+6LgnR
         Hiq5qqRWueJy+tG5fmiS7lcNlgpn0lSZqucyh4Vji/GI5sS5lutGR4vHW+7GbHfbZ7bW
         ROsuQa9SRS7Qpbbsjc+KNB1eLN4PeTTBFA/KktNIqjebUTCIP+EcVSno5Ep64YAE8FAF
         0ReWST/1fKg+hG3/t1GivcQ1mJCEC9S/4VYpdqW9PfXknnTr8pvDu9rO9nHSRsbmwjmN
         FCPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	Ursula Braun <ubraun@linux.vnet.ibm.com>,
	Benjamin Block <bblock@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 3.18 04/52] s390/qdio: dont merge ERROR output buffers
Date: Sun, 22 Apr 2018 15:53:37 +0200
Message-Id: <20180422135315.430171671@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598456104559684533?=
X-GMAIL-MSGID: =?utf-8?q?1598456418678206255?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

commit 0cf1e05157b9e5530dcc3ca9fec9bf617fc93375 upstream.

On an Output queue, both EMPTY and PENDING buffer states imply that the
buffer is ready for completion-processing by the upper-layer drivers.

So for a non-QEBSM Output queue, get_buf_states() merges mixed
batches of PENDING and EMPTY buffers into one large batch of EMPTY
buffers. The upper-layer driver (ie. qeth) later distuingishes PENDING
from EMPTY by inspecting the slsb_state for
QDIO_OUTBUF_STATE_FLAG_PENDING.

But the merge logic in get_buf_states() contains a bug that causes us to
erronously also merge ERROR buffers into such a batch of EMPTY buffers
(ERROR is 0xaf, EMPTY is 0xa1; so ERROR & EMPTY == EMPTY).
Effectively, most outbound ERROR buffers are currently discarded
silently and processed as if they had succeeded.

Note that this affects _all_ non-QEBSM device types, not just IQD with CQ.

Fix it by explicitly spelling out the exact conditions for merging.

For extracting the "get initial state" part out of the loop, this relies
on the fact that get_buf_states() is never called with a count of 0. The
QEBSM path already strictly requires this, and the two callers with
variable 'count' make sure of it.

Fixes: 104ea556ee7f ("qdio: support asynchronous delivery of storage blocks")
Cc: <stable@vger.kernel.org> #v3.2+
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/cio/qdio_main.c |   31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -205,7 +205,10 @@ again:
 	return 0;
 }
 
-/* returns number of examined buffers and their common state in *state */
+/*
+ * Returns number of examined buffers and their common state in *state.
+ * Requested number of buffers-to-examine must be > 0.
+ */
 static inline int get_buf_states(struct qdio_q *q, unsigned int bufnr,
 				 unsigned char *state, unsigned int count,
 				 int auto_ack, int merge_pending)
@@ -216,17 +219,23 @@ static inline int get_buf_states(struct
 	if (is_qebsm(q))
 		return qdio_do_eqbs(q, state, bufnr, count, auto_ack);
 
-	for (i = 0; i < count; i++) {
-		if (!__state) {
-			__state = q->slsb.val[bufnr];
-			if (merge_pending && __state == SLSB_P_OUTPUT_PENDING)
-				__state = SLSB_P_OUTPUT_EMPTY;
-		} else if (merge_pending) {
-			if ((q->slsb.val[bufnr] & __state) != __state)
-				break;
-		} else if (q->slsb.val[bufnr] != __state)
-			break;
+	/* get initial state: */
+	__state = q->slsb.val[bufnr];
+	if (merge_pending && __state == SLSB_P_OUTPUT_PENDING)
+		__state = SLSB_P_OUTPUT_EMPTY;
+
+	for (i = 1; i < count; i++) {
 		bufnr = next_buf(bufnr);
+
+		/* merge PENDING into EMPTY: */
+		if (merge_pending &&
+		    q->slsb.val[bufnr] == SLSB_P_OUTPUT_PENDING &&
+		    __state == SLSB_P_OUTPUT_EMPTY)
+			continue;
+
+		/* stop if next state differs from initial state: */
+		if (q->slsb.val[bufnr] != __state)
+			break;
 	}
 	*state = __state;
 	return i;
