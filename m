Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBD9C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21B4205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21B4205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388879AbeG0RsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:48:05 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35863 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388822AbeG0RsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:48:05 -0400
Received: by mail-qk0-f196.google.com with SMTP id a132-v6so3638206qkg.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 09:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iIFGek2TeGaOl6TdxTq+XC8TXnIhRl2UfHIJFNsmdc8=;
        b=Q5oZ9CLMyut2YVpHq7VkNlmiGKYPkhtFnTZXjAUBZhmJqxuzuKsvF+TZWGdp6sdO0C
         EyIiGOUCqjY08hOlesDBhbWHkJowck+/F3WB++t44fuOXTD3VuOiQQbMxANsa5RI34sc
         h1XGHPbMJJddz2S1PXYe+WTz5+IWaPtIn83TbobQa7DKjE+TkB+FLmC0bSkkzYSCchTp
         sv+/Rd18Xk+Umc7UR1XkpDWBuCoBx0/5WPBfFvub57qiESgnAwtqVQKofVQNQL7axHoW
         vg2P5Xh7RZklWQBK6le9WwZj0YZHQIQrpOLlGJwgbNZOpdeJsDr8N4x86cS3Fq5a2p/r
         RW5w==
X-Gm-Message-State: AOUpUlF+gzt5FNYidS66pu/mUQbKPrQ9m3BE7fM0lHTq4SKU2wpp63A2
        INZAF1yjz7Tjl93Z/GZN4pUPlg==
X-Google-Smtp-Source: AAOMgpf2fA6QIV5B1YLPEbATuzKEkNKuVNvYzZ4guNIh6fNb28PQ3GO9ySvE+qWFq3U9I95BwF9GnQ==
X-Received: by 2002:a37:d197:: with SMTP id o23-v6mr6563761qkl.210.1532708726931;
        Fri, 27 Jul 2018 09:25:26 -0700 (PDT)
Received: from builder.jcline.org.com ([2605:a601:80ce:4700:77a5:8983:ea8b:82ec])
        by smtp.gmail.com with ESMTPSA id s73-v6sm3137342qkl.65.2018.07.27.09.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 09:25:26 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeremy Cline <jcline@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH 3/3] ext4: mballoc: Fix spectre gadget in ext4_mb_simple_scan_group
Date:   Fri, 27 Jul 2018 16:23:57 +0000
Message-Id: <20180727162357.30801-4-jcline@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727162357.30801-1-jcline@redhat.com>
References: <20180727162357.30801-1-jcline@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ac->ac_2order' is a user-controlled value used to index into
'grp->bb_counters' and based on the value at that index, 'ac->ac_found'
is written to. Clamp the value right after the bounds check to avoid a
speculative out-of-bounds read of 'grp->bb_counters'.

This also protects the access of the s_mb_offsets and s_mb_maxs arrays
inside mb_find_buddy().

These gadgets were discovered with the help of smatch:

* fs/ext4/mballoc.c:1896 ext4_mb_simple_scan_group() warn: potential
  spectre issue 'grp->bb_counters' [w] (local cap)

* fs/ext4/mballoc.c:445 mb_find_buddy() warn: potential spectre issue
  'EXT4_SB(e4b->bd_sb)->s_mb_offsets' [r] (local cap)

* fs/ext4/mballoc.c:446 mb_find_buddy() warn: potential spectre issue
  'EXT4_SB(e4b->bd_sb)->s_mb_maxs' [r] (local cap)

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 fs/ext4/mballoc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f7ab34088162..c0866007a949 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -14,6 +14,7 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/nospec.h>
 #include <linux/backing-dev.h>
 #include <trace/events/ext4.h>
 
@@ -1893,6 +1894,7 @@ void ext4_mb_simple_scan_group(struct ext4_allocation_context *ac,
 
 	BUG_ON(ac->ac_2order <= 0);
 	for (i = ac->ac_2order; i <= sb->s_blocksize_bits + 1; i++) {
+		i = array_index_nospec(i, sb->s_blocksize_bits + 2);
 		if (grp->bb_counters[i] == 0)
 			continue;
 
-- 
2.17.1

