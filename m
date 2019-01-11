Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA67CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DB22084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="VgILSKCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfAKU7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:59:12 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35074 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfAKU7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:59:11 -0500
Received: by mail-qt1-f196.google.com with SMTP id v11so20377993qtc.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 12:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nLURB8lQzG7p+sod0PD/WoOlCEtowuu31PoAPAwMNgI=;
        b=VgILSKCfyJyAdjO7qv/SJK+Bd/WLFBcLoOPmoaHAwVR+AayYvZ+zBXwlfXLzl/h8xT
         /JGW8zy+aucb1hTfa2/qpQ/z+f7DKSj+/d5wyai+hEzuFGU4NBDmyhGX2BAe4lUAJuLt
         epZ/l7haqkqOuZdV2hKFnGtECjQxkkGxn9dDwO9XC+nRRHPY9ggczJbwFY/aS4K327c8
         n41Mm+WWJqEhMcWaAqaIbC086RcC3lk+RJU/qd6E+34ffSqWCMIhyzzDbTxxfqcgBf6d
         rD6TViRAFUztGNq9jfnRjEfReYX1RrU31BR/A13+ZZMsQLIWoPVOvxymfRx3CR0VO0Gu
         vq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nLURB8lQzG7p+sod0PD/WoOlCEtowuu31PoAPAwMNgI=;
        b=azI2f680YkoAMzplBdWMVrt519h9kEBUMxCN6Br8BrOVdvUfVKaRZXN071fU+dl/Pq
         djow6dQhCvOwzVViym+ByrdjqpzythW3rti12m5dTwRRbToIW3f/7WW2WUTl8gD7oXM8
         go3UiQxak77Dvna/ArhM+lYXdT/lm2woFNYNgDaKQmCZ+3ILwScm+vMEFELpo4gs9BWb
         LQOrvtNKmBuYwyAlIPM6fTR40AgNsDO9Jxtt2MpXxdLvr8OuLSX4oB4y8/ziLYl08uLK
         a5u0/rJ8XnoG9zuvrynR/hbMnXGAm9WR5KIpPdY5Byf9BMsqZ/dq61BXocsIh87zJ4fU
         9tOw==
X-Gm-Message-State: AJcUukcWoQl3TwWNJiUwgloBM1c2Q7GsPhNFvSbFMf5Cyz8SEr8XMfLA
        O5eS2PK/+F2QvDFbAiFyAZhkug==
X-Google-Smtp-Source: ALg8bN6XquNmyONIg6xRMXqhZKP/c2GM+PdUT8aDISEi1yVWjES6wf565ksToUTx1qwZlaMJexLR1A==
X-Received: by 2002:aed:2dc5:: with SMTP id i63mr15674257qtd.173.1547240349039;
        Fri, 11 Jan 2019 12:59:09 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u67sm39861353qki.22.2019.01.11.12.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 12:59:08 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     esploit@protonmail.ch, jejb@linux.ibm.com, dgilbert@interlog.com,
        martin.petersen@oracle.com, joeypabalinas@gmail.com,
        walken@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] rbtree: fix the red root
Date:   Fri, 11 Jan 2019 15:58:43 -0500
Message-Id: <20190111205843.25761-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190111181600.GJ6310@bombadil.infradead.org>
References: <20190111181600.GJ6310@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A GPF was reported,

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
tmp = gparent->rb_right; <-- GPF was triggered here.

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

Hence, it violates the rule #1 (the root can't be red) and need a fix
up, and also add a regression test for it. This looks like was
introduced by 6d58452dc06 where it no longer always paint the root as
black.

Fixes: 6d58452dc06 (rbtree: adjust root color in rb_insert_color() only
when necessary)
Reported-by: Esme <esploit@protonmail.ch>
Tested-by: Joey Pabalinas <joeypabalinas@gmail.com>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: add a regression test.

 lib/rbtree.c      |  7 +++++++
 lib/rbtree_test.c | 11 +++++++++++
 2 files changed, 18 insertions(+)

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
diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
index b7055b2a07d3..afad0213a117 100644
--- a/lib/rbtree_test.c
+++ b/lib/rbtree_test.c
@@ -345,6 +345,17 @@ static int __init rbtree_test_init(void)
 		check(0);
 	}
 
+	/*
+	 * a little regression test to catch a bug may be introduced by
+	 * 6d58452dc06 (rbtree: adjust root color in rb_insert_color() only when
+	 * necessary)
+	 */
+	insert(nodes, &root);
+	nodes->rb.__rb_parent_color = RB_RED;
+	insert(nodes + 1, &root);
+	erase(nodes + 1, &root);
+	erase(nodes, &root);
+
 	printk(KERN_ALERT "augmented rbtree testing");
 
 	init();
-- 
2.17.2 (Apple Git-113)

