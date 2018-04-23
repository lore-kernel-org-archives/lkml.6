Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932345AbeDWUmM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 16:42:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932254AbeDWUmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 16:42:09 -0400
Date: Mon, 23 Apr 2018 13:42:08 -0700
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        linux-kernel@vger.kernel.org
Cc: Andres Freund <andres@anarazel.de>
Subject: [PATCH] Always report a writeback error once
Message-ID: <20180423204208.GG13383@bombadil.infradead.org>
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

This patch restores that behaviour by reporting errors to file descriptors
which are opened after the error occurred, but before it was reported
to any file descriptor.

Cc: stable@vger.kernel.org
Fixes: 5660e13d2fd6 ("fs: new infrastructure for writeback error handling and reporting")
Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

diff --git a/lib/errseq.c b/lib/errseq.c
index df782418b333..093f1fba4ee0 100644
--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -119,19 +119,11 @@ EXPORT_SYMBOL(errseq_set);
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
 
