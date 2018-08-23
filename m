Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0F5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57042147C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57042147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbeHWLkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:40:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45936 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbeHWLkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:40:41 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7F7D1C9E;
        Thu, 23 Aug 2018 08:12:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jeremy Cline <jcline@redhat.com>, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.9 118/130] ext4: fix spectre gadget in ext4_mb_regular_allocator()
Date:   Thu, 23 Aug 2018 09:53:54 +0200
Message-Id: <20180823074934.636885825@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
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
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/mballoc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -26,6 +26,7 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/nospec.h>
 #include <linux/backing-dev.h>
 #include <trace/events/ext4.h>
 
@@ -2144,7 +2145,8 @@ ext4_mb_regular_allocator(struct ext4_al
 		 * This should tell if fe_len is exactly power of 2
 		 */
 		if ((ac->ac_g_ex.fe_len & (~(1 << (i - 1)))) == 0)
-			ac->ac_2order = i - 1;
+			ac->ac_2order = array_index_nospec(i - 1,
+							   sb->s_blocksize_bits + 2);
 	}
 
 	/* if stream allocation is enabled, use global goal */


