Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbeDXVDB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 17:03:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeDXVC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 17:02:58 -0400
Date: Tue, 24 Apr 2018 14:02:57 -0700
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Andres Freund <andres@anarazel.de>
Subject: [PATCH v2] Always report a writeback error once
Message-ID: <20180424210257.GC26559@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The errseq_t infrastructure assumes that errors which occurred before
the file descriptor was opened are of no interest to the application.
This turns out to be a regression for some applications, notably Postgres.

Before errseq_t, a writeback error would be reported exactly once (as
long as the inode remained in memory), so Postgres could open a file,
call fsync() and find out whether there had been a writeback error on
that file from another process.

This patch changes the errseq infrastructure to report errors to all
file descriptors which are opened after the error occurred, but before
it was reported to any file descriptor.  This restores the user-visible
behaviour.

Cc: stable@vger.kernel.org
Fixes: 5660e13d2fd6 ("fs: new infrastructure for writeback error handling and reporting")
Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>

diff --git a/lib/errseq.c b/lib/errseq.c
index df782418b333..81f9e33aa7e7 100644
--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -111,27 +111,22 @@ EXPORT_SYMBOL(errseq_set);
  * errseq_sample() - Grab current errseq_t value.
  * @eseq: Pointer to errseq_t to be sampled.
  *
- * This function allows callers to sample an errseq_t value, marking it as
- * "seen" if required.
+ * This function allows callers to initialise their errseq_t variable.
+ * If the error has been "seen", new callers will not see an old error.
+ * If there is an unseen error in @eseq, the caller of this function will
+ * see it the next time it checks for an error.
  *
+ * Context: Any context.
  * Return: The current errseq value.
  */
 errseq_t errseq_sample(errseq_t *eseq)
 {
 	errseq_t old = READ_ONCE(*eseq);
-	errseq_t new = old;
 
-	/*
-	 * For the common case of no errors ever having been set, we can skip
-	 * marking the SEEN bit. Once an error has been set, the value will
-	 * never go back to zero.
-	 */
-	if (old != 0) {
-		new |= ERRSEQ_SEEN;
-		if (old != new)
-			cmpxchg(eseq, old, new);
-	}
-	return new;
+	/* If nobody has seen this error yet, then we can be the first. */
+	if (!(old & ERRSEQ_SEEN))
+		old = 0;
+	return old;
 }
 EXPORT_SYMBOL(errseq_sample);
 
