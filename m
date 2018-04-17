Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx493yPML+IQxPkh3vPTmyMCf0HGmdLqCXW5d3QRv18aqlHHTyihl5D4UdzrxIQWxRCPWXgGI
ARC-Seal: i=1; a=rsa-sha256; t=1523981125; cv=none;
        d=google.com; s=arc-20160816;
        b=CvqWzMqO3hDlozLu5iLx5dbXajvFKLn1L/91EM5aM97WEXpHf2cq7gRn1A81bCbt0g
         WIes2K/vI+390Ucp0RDPfHl8Ey6C7NTGqUaXLzhQaqdd5J2CrW7BoxOhjXHT76nKexJt
         DeLguOxj+G54C9IQJ00rZuV+1kMuOxN7BMsSckkFa/DG3hRxb5XeNnErxci8DnplIjim
         6+wlXffL2pg12R4ZOu8wdWgFPQL21rieOIxUIY24xt9syBMECbExDqsCvtp+er+c4GkZ
         6YkFcuXcfrjgTXLDjVeHHWqRwhXiGOQeX4sjiqpoPEfbZB8qzi/0k4KFG+YZ3jJKcrEx
         huOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Tt0g7DR5Cj9fmXGKU4l/yqilzlptq19wM0QMNqY0fXA=;
        b=OZuehhNTsgY9JIm//rJTvULft2qeHfaqO1YBYMQ9sxBzMM6+vkDLfN9+QV4Gy9DDTE
         ui9naPUvoKFZzrxWuO2J+cvDxgBRQJdxIsz+Ai1DSheG/BRNb6j0v8UDZPMIefzS7LCf
         VIV8nvD0MFQwFoMuBbTGwaSZnIAh8NUnE5gZpVPCGu5FAXmZHHyAGHekq65jXIjKxAL2
         PodHRSJzMdX1rrAy8sbDtOcBQZU/XFYVntRf3qQiZP1a6OE37771D3tOIxjgxsx+SkzX
         3YrcFsnqMEGSZ3RkcTPdluMY7pE+cZGaq9UmWIwT5lcRECtUGxndO8i1BoC0X6sk1BuL
         mGSw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	Ursula Braun <ubraun@linux.vnet.ibm.com>,
	Benjamin Block <bblock@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.15 44/53] s390/qdio: dont merge ERROR output buffers
Date: Tue, 17 Apr 2018 17:59:09 +0200
Message-Id: <20180417155725.236665808@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009846096502118?=
X-GMAIL-MSGID: =?utf-8?q?1598010032377298250?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -206,7 +206,10 @@ again:
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
@@ -217,17 +220,23 @@ static inline int get_buf_states(struct
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
