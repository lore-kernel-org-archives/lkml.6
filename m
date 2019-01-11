Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81ABC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960F920872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="U8nAz1g3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388253AbfAKQwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:52:14 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36619 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbfAKQwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:52:13 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so19535751qtn.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 08:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5c0IsZMMIxSQRMKEkH3v3tXYrnoS8N4XvTLcKo9Se1Y=;
        b=U8nAz1g3ESsFYCPhG703DwbhJD3GHpUuQSi5LfSjD9Lu5AiTsJd8+LqwAjLvEiDNMT
         bzbAE8zFDRQT+kFKdMtXoPl1l5ugc2osfIGsWhL9Ed5rfVF81c7ltG9Djop6yr6ZrqLJ
         J5SpialTHWqLdXzDovGiTBwgUrGDApBvrqwbWVKcVPKJ4Wz2GpEAVz7iwzaNQrVkhxJN
         EOMObyAMW8uG9a2IlBmrpjTpUExPFSVvt29T7EfpfkZR7X3qyWKWiL3jeropPhNOA/3B
         CAARnAriqjPQFfm2d1Lft2SC7Iuy9OQNx7MmK2KTzL73uyrYQ24dcCrdqzYB1QdpetYE
         yl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5c0IsZMMIxSQRMKEkH3v3tXYrnoS8N4XvTLcKo9Se1Y=;
        b=j1HOM02prf7x0vu+ROkhrUsXFROKSqNAbZh57wHXffVSJpz7AfVVe/nZngiZlMakpz
         7ahd2MAgOWLtxlrsV2GXWQWEgx6EQ7NZ43KaVLu+BeqeN/bKsAKalvYmC9lJzYasLMEn
         P9Alp4B2Dkek9vl1JBgMjgI680w+XEIkzW6zEmu50P6DjBv3QE/6OYZTsfKrc+7fGaZM
         nVBWcADAGOWvyjWVLCVFxmXg5UjUF+VK/wTmxtNGRpBqotG1tDwf8soXEv5FpFeRQmN8
         WYEF9EvgYQa29kOQeAjUgsq20GXdScY8EPzBwEOf4J48U/e3YPif6kRpeKV4PeYqCJQV
         f/Xg==
X-Gm-Message-State: AJcUukfTPLPY7/yBt4TOUkj43Wxqy1I2dGNWKb5zufxe4IA9AnZ/MY9M
        sx4fggoqnKgGIrBD/BheTpBvwA==
X-Google-Smtp-Source: ALg8bN6l/X/kTFWF+wU4UZuoqtOti0ggC3CBf2nJG8iuG6wQzULOv6yZtoC2wZL3nEzBQs78Czqxtw==
X-Received: by 2002:a0c:8382:: with SMTP id k2mr15111726qva.0.1547225531638;
        Fri, 11 Jan 2019 08:52:11 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n71sm21946926qkl.72.2019.01.11.08.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 08:52:11 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     esploit@protonmail.ch, jejb@linux.ibm.com, dgilbert@interlog.com,
        martin.petersen@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] rbtree: fix the red root
Date:   Fri, 11 Jan 2019 11:51:45 -0500
Message-Id: <20190111165145.23628-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <YrcPMrGmYbPe_xgNEV6Q0jqc5XuPYmL2AFSyeNmg1gW531bgZnBGfEUK5_ktqDBaNW37b-NP2VXvlliM7_PsBRhSfB649MaW1Ne7zT9lHc=@protonmail.ch>
References: <YrcPMrGmYbPe_xgNEV6Q0jqc5XuPYmL2AFSyeNmg1gW531bgZnBGfEUK5_ktqDBaNW37b-NP2VXvlliM7_PsBRhSfB649MaW1Ne7zT9lHc=@protonmail.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A GFP was reported,

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
        kasan_die_handler.cold.22+0x11/0x31
        notifier_call_chain+0x17b/0x390
        atomic_notifier_call_chain+0xa7/0x1b0
        notify_die+0x1be/0x2e0
        do_general_protection+0x13e/0x330
        general_protection+0x1e/0x30
        rb_insert_color+0x189/0x1480
        create_object+0x785/0xca0
        kmemleak_alloc+0x2f/0x50
        kmem_cache_alloc+0x1b9/0x3c0
        getname_flags+0xdb/0x5d0
        getname+0x1e/0x20
        do_sys_open+0x3a1/0x7d0
        __x64_sys_open+0x7e/0xc0
        do_syscall_64+0x1b3/0x820
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

It turned out,

gparent = rb_red_parent(parent);
tmp = gparent->rb_right; <-- GFP triggered here.

Apparently, "gparent" is NULL which indicates "parent" is rbtree's root
which is red. Otherwise, it will be treated properly a few lines above.

/*
 * If there is a black parent, we are done.
 * Otherwise, take some corrective action as,
 * per 4), we don't want a red root or two
 * consecutive red nodes.
 */
if(rb_is_black(parent))
	break;

Hence, it violates the rule #1 and need a fix up.

Reported-by: Esme <esploit@protonmail.ch>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 lib/rbtree.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/rbtree.c b/lib/rbtree.c
index d3ff682fd4b8..acc969ad8de9 100644
--- a/lib/rbtree.c
+++ b/lib/rbtree.c
@@ -127,6 +127,13 @@ __rb_insert(struct rb_node *node, struct rb_root *root,
 			break;
 
 		gparent = rb_red_parent(parent);
+		if (unlikely(!gparent)) {
+			/*
+			 * The root is red so correct it.
+			 */
+			rb_set_parent_color(parent, NULL, RB_BLACK);
+			break;
+		}
 
 		tmp = gparent->rb_right;
 		if (parent != tmp) {	/* parent == gparent->rb_left */
-- 
2.17.2 (Apple Git-113)

