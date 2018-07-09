Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1E3C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECEC20852
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OGNWP7j0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECEC20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754572AbeGINqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:46:03 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:50569 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754474AbeGINqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:46:02 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1CB0410C1AEC;
        Mon,  9 Jul 2018 06:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531143961; bh=3aWVddgH12qJ2jufho7qehBlYzGcE/wYwvNkcazYKjY=;
        h=From:To:Cc:Subject:Date:From;
        b=OGNWP7j0Nw8OowbXlaQ/TFAdyPEL5EgSZdGhiMOLUnbLsDfJY4OGqEOU7ow6b7LWO
         K5LKOaFqUfI4tIBMUdLsr58AU9ibGX/uE1gLbxDz7+K00AF5hrsM5n5r9DtHzrzLm/
         FFOB7q8QaQ1dV6UA+0pwDECBNZZfnjpg+kxu7ltEeGWz7y6s6ER0ewZe17Mz4VEdDH
         CtJXd85vBw1JncdFwIHI46BNvjLu0ifj9DZ+KW59K/A0dLgOdNtzncfUDdHeoTVQGL
         bf0a33nY4/pSc+iWYnzPbP8t5RPyYoGio+EczEwTuycDkYI3nFUtltFctHe1iG7waT
         E73YZ363BTLig==
Received: from abrodkin-7480l.internal.synopsys.com (unknown [10.121.8.87])
        by mailhost.synopsys.com (Postfix) with ESMTP id 382273717;
        Mon,  9 Jul 2018 06:45:58 -0700 (PDT)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>,
        stable@vger.kernel.org
Subject: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Date:   Mon,  9 Jul 2018 16:45:50 +0300
Message-Id: <20180709134550.29541-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

data[] must be 64-bit aligned even on 32-bit architectures because
it might be accessed by instructions that require aligned memory arguments.

One example is "atomic64_t" type accessed by special atomic instructions
which may read/write entire 64-bit word.

Atomic instructions are a bit special compared to normal loads and stores.
Even if normal loads and stores may deal with unaligned data, atomic
instructions still require data to be aligned because it's hard to manage
atomic value that spans through multiple cache lines or even MMU pages.
And hardware just raises an alignment fault exception.

The problem with previously used approach is that depending on ABI
"long long" type of a particular 32-bit CPU might be aligned to
8-, 16-, 32- or 64-bit boundary. Which will get in the way of mentioned
above atomic instructions.

Consider the following snippet:
|        struct mystruct {
|                atomic64_t myvar;
|        }
|
|        struct mystruct *p;
|        p = devm_kzalloc(dev, sizeof(*p), GFP_KERNEL);

Here address of "myvar" will match  data[] in "struct devres",
that said if "data" is not 64-bit aligned atomic instruction will
fail on the first access to "myvar".

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg KH <greg@kroah.com>
Cc: <stable@vger.kernel.org> # 4.8+
---

Changes v2 -> v3:

 * Align explicitly to 8 bytes [David]
 * Rephrased in-line comment [David]
 * Added more techinical details to commit message [Greg]
 * Mention more alignment options in commit message [Geert]

Changes v1 -> v2:

 * Reworded commit message
 * Inserted comment right in source [Thomas]

 drivers/base/devres.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index f98a097e73f2..d65327cb83c9 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -24,8 +24,12 @@ struct devres_node {
 
 struct devres {
 	struct devres_node		node;
-	/* -- 3 pointers */
-	unsigned long long		data[];	/* guarantee ull alignment */
+	/*
+	 * data[] must be 64 bit aligned even on 32 bit architectures
+	 * because it might be accessed by instructions that require
+	 * aligned memory arguments such as atomic64_t.
+	 */
+	u8 __aligned(8)			data[];
 };
 
 struct devres_group {
-- 
2.17.1

