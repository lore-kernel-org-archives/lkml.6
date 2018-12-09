Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ECCC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B31220661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B31220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbeLIWZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:25:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34882 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726441AbeLIVzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:15 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0002ih-JG; Sun, 09 Dec 2018 21:55:12 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0003Kc-IV; Sun, 09 Dec 2018 21:55:09 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jeremy Cline" <jcline@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.636772784@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 093/328] ext4: fix spectre gadget in ext4_mb_regular_allocator()
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Cline <jcline@redhat.com>

commit 1a5d5e5d51e75a5bca67dadbcea8c841934b7b85 upstream.

'ac->ac_g_ex.fe_len' is a user-controlled value which is used in the
derivation of 'ac->ac_2order'. 'ac->ac_2order', in turn, is used to
index arrays which makes it a potential spectre gadget. Fix this by
sanitizing the value assigned to 'ac->ac2_order'.  This covers the
following accesses found with the help of smatch:

* fs/ext4/mballoc.c:1896 ext4_mb_simple_scan_group() warn: potential
  spectre issue 'grp->bb_counters' [w] (local cap)

* fs/ext4/mballoc.c:445 mb_find_buddy() warn: potential spectre issue
  'EXT4_SB(e4b->bd_sb)->s_mb_offsets' [r] (local cap)

* fs/ext4/mballoc.c:446 mb_find_buddy() warn: potential spectre issue
  'EXT4_SB(e4b->bd_sb)->s_mb_maxs' [r] (local cap)

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Jeremy Cline <jcline@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/mballoc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -26,6 +26,7 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/nospec.h>
 #include <trace/events/ext4.h>
 
 #ifdef CONFIG_EXT4_DEBUG
@@ -2124,7 +2125,8 @@ ext4_mb_regular_allocator(struct ext4_al
 		 * This should tell if fe_len is exactly power of 2
 		 */
 		if ((ac->ac_g_ex.fe_len & (~(1 << (i - 1)))) == 0)
-			ac->ac_2order = i - 1;
+			ac->ac_2order = array_index_nospec(i - 1,
+							   sb->s_blocksize_bits + 2);
 	}
 
 	/* if stream allocation is enabled, use global goal */

