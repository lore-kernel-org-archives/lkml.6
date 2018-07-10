Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E647C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003F720B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003F720B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbeGJSaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:30:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45524 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732565AbeGJSaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:30:16 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3078EEB4;
        Tue, 10 Jul 2018 18:30:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.9 26/52] jbd2: dont mark block as modified if the handle is out of credits
Date:   Tue, 10 Jul 2018 20:24:54 +0200
Message-Id: <20180710182451.959928409@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182449.285532226@linuxfoundation.org>
References: <20180710182449.285532226@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit e09463f220ca9a1a1ecfda84fcda658f99a1f12a upstream.

Do not set the b_modified flag in block's journal head should not
until after we're sure that jbd2_journal_dirty_metadat() will not
abort with an error due to there not being enough space reserved in
the jbd2 handle.

Otherwise, future attempts to modify the buffer may lead a large
number of spurious errors and warnings.

This addresses CVE-2018-10883.

https://bugzilla.kernel.org/show_bug.cgi?id=200071

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/jbd2/transaction.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1353,6 +1353,13 @@ int jbd2_journal_dirty_metadata(handle_t
 		if (jh->b_transaction == transaction &&
 		    jh->b_jlist != BJ_Metadata) {
 			jbd_lock_bh_state(bh);
+			if (jh->b_transaction == transaction &&
+			    jh->b_jlist != BJ_Metadata)
+				pr_err("JBD2: assertion failure: h_type=%u "
+				       "h_line_no=%u block_no=%llu jlist=%u\n",
+				       handle->h_type, handle->h_line_no,
+				       (unsigned long long) bh->b_blocknr,
+				       jh->b_jlist);
 			J_ASSERT_JH(jh, jh->b_transaction != transaction ||
 					jh->b_jlist == BJ_Metadata);
 			jbd_unlock_bh_state(bh);
@@ -1372,11 +1379,11 @@ int jbd2_journal_dirty_metadata(handle_t
 		 * of the transaction. This needs to be done
 		 * once a transaction -bzzz
 		 */
-		jh->b_modified = 1;
 		if (handle->h_buffer_credits <= 0) {
 			ret = -ENOSPC;
 			goto out_unlock_bh;
 		}
+		jh->b_modified = 1;
 		handle->h_buffer_credits--;
 	}
 


