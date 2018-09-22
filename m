Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC476C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858D62157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858D62157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392175AbeIVGN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:13:29 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44237 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392006AbeIVGKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:48 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdy-0008BP-77; Sat, 22 Sep 2018 01:19:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdo-0000sa-BE; Sat, 22 Sep 2018 01:19:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.371864357@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 36/63] jbd2: don't mark block as modified if the
 handle is out of credits
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: Drop the added logging statement, as it's on
 a code path that doesn't exist here]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1288,11 +1288,11 @@ int jbd2_journal_dirty_metadata(handle_t
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
 

