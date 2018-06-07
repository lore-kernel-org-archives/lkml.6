Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id sVqRO2hFGVt5HwAAmS7hNA
	; Thu, 07 Jun 2018 14:47:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E7F83608BF; Thu,  7 Jun 2018 14:47:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 69602602FC;
	Thu,  7 Jun 2018 14:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69602602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934911AbeFGOrm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:47:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40808 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933094AbeFGOri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:47:38 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbd-0005Zv-HB; Thu, 07 Jun 2018 15:09:37 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb8-00034Q-1V; Thu, 07 Jun 2018 15:09:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Todd Kjos" <tkjos@google.com>,
        "Todd Kjos" <tkjos@android.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.54027062@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 247/410] binder: replace "%p" with "%pK"
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Todd Kjos <tkjos@android.com>

commit 8ca86f1639ec5890d400fff9211aca22d0a392eb upstream.

The format specifier "%p" can leak kernel addresses. Use
"%pK" instead. There were 4 remaining cases in binder.c.

Signed-off-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/android/binder.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/staging/android/binder.c
+++ b/drivers/staging/android/binder.c
@@ -1242,7 +1242,7 @@ static void binder_transaction_buffer_re
 	int debug_id = buffer->debug_id;
 
 	binder_debug(BINDER_DEBUG_TRANSACTION,
-		     "%d buffer release %d, size %zd-%zd, failed at %p\n",
+		     "%d buffer release %d, size %zd-%zd, failed at %pK\n",
 		     proc->pid, buffer->debug_id,
 		     buffer->data_size, buffer->offsets_size, failed_at);
 
@@ -2059,7 +2059,7 @@ static int binder_thread_write(struct bi
 				}
 			}
 			binder_debug(BINDER_DEBUG_DEAD_BINDER,
-				     "%d:%d BC_DEAD_BINDER_DONE %016llx found %p\n",
+				     "%d:%d BC_DEAD_BINDER_DONE %016llx found %pK\n",
 				     proc->pid, thread->pid, (u64)cookie,
 				     death);
 			if (death == NULL) {
@@ -3162,7 +3162,7 @@ static void print_binder_transaction(str
 				     struct binder_transaction *t)
 {
 	seq_printf(m,
-		   "%s %d: %p from %d:%d to %d:%d code %x flags %x pri %ld r%d",
+		   "%s %d: %pK from %d:%d to %d:%d code %x flags %x pri %ld r%d",
 		   prefix, t->debug_id, t,
 		   t->from ? t->from->proc->pid : 0,
 		   t->from ? t->from->pid : 0,
@@ -3176,7 +3176,7 @@ static void print_binder_transaction(str
 	if (t->buffer->target_node)
 		seq_printf(m, " node %d",
 			   t->buffer->target_node->debug_id);
-	seq_printf(m, " size %zd:%zd data %p\n",
+	seq_printf(m, " size %zd:%zd data %pK\n",
 		   t->buffer->data_size, t->buffer->offsets_size,
 		   t->buffer->data);
 }
