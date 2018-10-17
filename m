Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0F7ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA1321486
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Iofzfast"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA1321486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeJRGbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:31:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41341 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeJRGbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:31:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id x31-v6so26403080edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h6zpXh4i5eIM+drsN4SvLq8wPNxO7li5Sdn/DfuQ6co=;
        b=IofzfastchHRk/G2RikDS9cgIyMCrQBCopuhiPLO6QxZf3+7ZRG2KAboDn2Ydywmro
         KU8+Nc4ZFe6zz0VR57pWLy6RNJPuJms0m9AT+S3BWr+LOAakoKx/VuJoENra/+ycr06J
         GCpApXoJjBU/bt1gMdu5BB30Je3qW1+u4wsOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h6zpXh4i5eIM+drsN4SvLq8wPNxO7li5Sdn/DfuQ6co=;
        b=N2anAJxlln+GgG1eZXhup5iGNF2dkI6aDMcqXlz0nu+44FEYwaSqk27OlmGuqRVDuR
         Iu1dYIhhtKoLGqeojpSgqPDzbNSNq+HdNqCmCQCh6TEp6IaD55EDDqIvnOr0bRwGZh4A
         ipG5nPf73S49RuhFVNnQK53rRZ2TE7gwwLHuscyEwPveskrIc5aTWNmjng3hq5YdG4qE
         PF6e08sbGoBplgJhioR3tfUImROCW44jboHEh2hPGldouLsPVqzxwryRsy9Apw+5IUty
         E7XqJ+8lwyLxNtScz6izSZSba509Nxhes0X5OKsdL+FwMX8c3CAQnLkOt6cyM/BaIqFM
         HOXA==
X-Gm-Message-State: ABuFfoi4GtLqATQRWHVdZFxDG8O7h8poEdPUvlJw0OnHcRWVmjPQfaXA
        w7vbD69YOYPZuqAAddNJhnGMuwk6FZA=
X-Google-Smtp-Source: ACcGV62icILRYMLj/coSp/4U+X9FvbWkoIN4cGJiIZe3gpK4aolaWyGhfgn5mJVhjEz2zYdkdI8myA==
X-Received: by 2002:a50:89ab:: with SMTP id g40-v6mr1580491edg.257.1539815628579;
        Wed, 17 Oct 2018 15:33:48 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id e30-v6sm7001555edd.25.2018.10.17.15.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 15:33:48 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [POC 10/12] hack: /proc/rai: add rai_bucket_shift use
Date:   Thu, 18 Oct 2018 00:33:30 +0200
Message-Id: <20181017223332.11964-10-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
References: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/x86/kernel/rai.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/rai.c b/arch/x86/kernel/rai.c
index e55e85f11a2e..c4284ce7478f 100644
--- a/arch/x86/kernel/rai.c
+++ b/arch/x86/kernel/rai.c
@@ -63,11 +63,21 @@ update_rai_access(void)
 static int one, two;
 static long three;
 
+static struct hlist_head *ht1;
+static unsigned shift1;
+
 static int
 rai_proc_show(struct seq_file *m, void *v) {
+	unsigned hash = 0xdeadbeef;
+
 	seq_printf(m, "one: %d, two: %d, three: %ld\n",
 		   rai_load(one), rai_load(two), rai_load(three));
+	seq_printf(m, "ht1: %016lx, bucket 0x%08x: %016lx\n",
+		   (long)rai_load(ht1), hash, (long)rai_bucket_shift(ht1, shift1, hash));
+
 	one = two = three = -1;
+	ht1 = NULL;
+	shift1 = 2;
 
 	return 0;
 }
@@ -89,6 +99,8 @@ static int __init rai_proc_init(void) {
 	one = 1;
 	two = 2;
 	three = 3;
+	ht1 = (void*)0xffffffffabcd0000UL;
+	shift1 = 26;
 
 	proc_create("rai", 0, NULL, &rai_proc_fops);
 	return 0;
-- 
2.19.1.6.gbde171bbf5

