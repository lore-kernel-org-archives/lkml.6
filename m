Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE220C28CF6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A10420841
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A10420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbeG3To5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:44:57 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40063 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731722AbeG3To4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:44:56 -0400
Received: by mail-it0-f67.google.com with SMTP id h23-v6so495987ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 11:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MFMBHcVszMReAIP7tFEJDW4UxwV2wJOiTuvxrwFhE/w=;
        b=A3H+weNlN+eCRU+8BGdiourEfbWnWPYBj104MEEx606LKEm1rC6iX1kTeM5GFVriOW
         Tg1BhRhWynPA9VixYxTV4P25M5NPIs/X/W46VztNj1EHkwfc9anJbzfcKBnGpebxCFFf
         QE837jEqVot3wVwK4754zK4Drua+HxPdhOeG/NF3tyDwoWS/iQa/82hLKcQEqKuav2Tp
         C1bT04FC4V7yu8VDTXUAo1LSjPjBJQEVGlUAb3Nmo4czzYW+GJuDunVTo4j/yTxi6/f5
         c3fEY7VHxrLMZgD/ZCLDMkRFKiUrXTlcmuShYi3zM1KXVcAd9wdGEjiG8KwHwZrxZQoy
         kGgg==
X-Gm-Message-State: AOUpUlHeYAEIspe8ejExsOMVtQ95Q/FQsxEFTyu+73E9vdgtNOGn8XgX
        Km8x16fneA1g4aA+2Hw37mTj9w==
X-Google-Smtp-Source: AAOMgpdrxBqk36W1F+6B5lOToaF1jmIs3w5ywBRG9IjXVavnrppVkOR5nQ/BxRrUnx5cjnJ1zqWAQw==
X-Received: by 2002:a24:1a94:: with SMTP id 142-v6mr319224iti.19.1532974125630;
        Mon, 30 Jul 2018 11:08:45 -0700 (PDT)
Received: from builder.jcline.org ([2605:a601:80ce:4700:77a5:8983:ea8b:82ec])
        by smtp.gmail.com with ESMTPSA id e142-v6sm113737itc.7.2018.07.30.11.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 11:08:45 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, stable@vger.kernel.org
Subject: [PATCH v2] ext4: mballoc: Fix spectre gadget in ext4_mb_regular_allocator
Date:   Mon, 30 Jul 2018 18:07:47 +0000
Message-Id: <20180730180747.25200-1-jcline@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: stable@vger.kernel.org
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---

I broke this out of the "ext4: fix spectre v1 gadgets" patch set since
the other patches in that series could, as Josh noted, be replaced with
one fix in do_quotactl. I'll send that fix to the disk quota folks
separately.

Changes from v1:
  - Sanitize ac_2order on assignment, rather than down the call chain in
    ext4_mb_simple_scan_group.

 fs/ext4/mballoc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f7ab34088162..8b24d3d42cb3 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -14,6 +14,7 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/nospec.h>
 #include <linux/backing-dev.h>
 #include <trace/events/ext4.h>
 
@@ -2140,7 +2141,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		 * This should tell if fe_len is exactly power of 2
 		 */
 		if ((ac->ac_g_ex.fe_len & (~(1 << (i - 1)))) == 0)
-			ac->ac_2order = i - 1;
+			ac->ac_2order = array_index_nospec(i - 1,
+							   sb->s_blocksize_bits + 2);
 	}
 
 	/* if stream allocation is enabled, use global goal */
-- 
2.17.1

