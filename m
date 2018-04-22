Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/bORQAseNn/F81/PstySDF962WZIx427zNQfx+vtuz2aVWmxAHD5g3pFLFoW9SNO56eVmg
ARC-Seal: i=1; a=rsa-sha256; t=1524406533; cv=none;
        d=google.com; s=arc-20160816;
        b=GwhcdZY2IMOuPXGMjm4+a1LJyiV/HHcy4VAhjDI48MLw133o9lJMrRhIax9Vfhd+LU
         6m7pn5R0y58LhPuxRSQSYTxPNe9pbsM7xQrEsODTukCtqYyFJthlgDDjt9Z27anokIbh
         y9qRdlizXlc19xavSXufZAPCMzMPXwOR65NtV7Ll53uh/d8woKHFSabx8prRC3TnnILv
         a/9zdNv678GnNaKDb/Ujk1s3/cdCMqr+0D1lC76V6pFG1HBa55V/DbpR7RU6FJ7P1SO3
         /yZHaKtygp82UjcuD1oWrNDGot29MB6YIn7LoVFrP6EMHrKlasKA4120W68MDoWEiwgm
         +2rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FDyAQDqBD44bvJohCxFXYt2KJRUYZZPUcdKQaLdZry8=;
        b=rWLRGZDlE/6ptBEnnnvAvjkduR5r0dPPT+GIbA+jBZ933vLvttXNGsoKKsW0JJLHjb
         lo6b9r2qM63R3c1lu5kcIDnUxHlCnVcAHlGj+lSkJDqa6zso8qXx8bzEdthZDRKxDHa1
         ozsG/S/CDN8PBJVKXE+MVjOpKrXKWKxuQn+LCzAel9kpWDws46wbZXgU3YoPgn1jd2VT
         ZzUApibJrxxDk8CfGQAHz27gNL1kJONq43jWE/ac2xn23h4zKT5ShMlDkasfdzRx8358
         mykoI+xM9EvQOK/9I/gtL/o63OkzrDAtoBXaovWx9oxHsxtAJI+fO8/SavvVxujPnLwa
         jIfw==
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
Subject: [PATCH 4.4 11/97] s390/qdio: dont merge ERROR output buffers
Date: Sun, 22 Apr 2018 15:52:49 +0200
Message-Id: <20180422135305.268750746@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598456104559684533?=
X-GMAIL-MSGID: =?utf-8?q?1598456104559684533?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
