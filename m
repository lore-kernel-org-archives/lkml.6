Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NCRFO/mBHlv2AgAAmS7hNA
	; Mon, 11 Jun 2018 14:06:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D996E60850; Mon, 11 Jun 2018 14:06:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i9+vRjZA"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 559096074D;
	Mon, 11 Jun 2018 14:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 559096074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933488AbeFKOGr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:06:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933223AbeFKOGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X1L/lNU3X/ge1Nfw3qLsCs8ltR97g23r4GAfLRjj7Uc=; b=i9+vRjZAnFxqSPtOjBtrGY51p
        8rDNxb6SrjlvZW0HgswAPhmPaoJpe8tmxyss5lQzSnpCrTxaN6uw4zFGzIrHOC4dN/mPtIIRsoVUX
        zx230RSsAxMbIW1KKWAtL2UXwE74DPcUY4XdZNiAy5SMIF1j4jnfG3bMJF87DcMz9r5VVSm6bkUJO
        Neb8EkhttGqUHd+2rpC9upuSosw5ovGWujxmfN85Q2c/MbTKGeGLfKajzxrFo0hUVKLJ3IAfTHMTx
        u2MwJMaGvjw/vWvJ9EvW4VDKNauBDBki/vVF8SoFBTzuDQTa9xyekrcIjj5KCgDCo9nwzLO/pj1qS
        9zIcXX4XQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNSy-0004Xf-Vd; Mon, 11 Jun 2018 14:06:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v13 01/72] radix tree test suite: Enable ubsan
Date: Mon, 11 Jun 2018 07:05:28 -0700
Message-Id: <20180611140639.17215-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Add support for the undefined behaviour sanitizer and fix the bugs
that ubsan pointed out.  Nothing major, and all in the test suite,
not the code.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 tools/testing/radix-tree/Makefile |  5 +++--
 tools/testing/radix-tree/main.c   | 20 +++++++++++---------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
index db66f8a0d4be..da030a65d6d6 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address
-LDFLAGS += -fsanitize=address
+CFLAGS += -I. -I../../include -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address \
+	  -fsanitize=undefined
+LDFLAGS += -fsanitize=address -fsanitize=undefined
 LDLIBS+= -lpthread -lurcu
 TARGETS = main idr-test multiorder
 CORE_OFILES := radix-tree.o idr.o linux.o test.o find_bit.o
diff --git a/tools/testing/radix-tree/main.c b/tools/testing/radix-tree/main.c
index 257f3f8aacaa..584a8732f5ce 100644
--- a/tools/testing/radix-tree/main.c
+++ b/tools/testing/radix-tree/main.c
@@ -27,20 +27,22 @@ void __gang_check(unsigned long middle, long down, long up, int chunk, int hop)
 		item_check_present(&tree, middle + idx);
 	item_check_absent(&tree, middle + up);
 
-	item_gang_check_present(&tree, middle - down,
-			up + down, chunk, hop);
-	item_full_scan(&tree, middle - down, down + up, chunk);
+	if (chunk > 0) {
+		item_gang_check_present(&tree, middle - down, up + down,
+				chunk, hop);
+		item_full_scan(&tree, middle - down, down + up, chunk);
+	}
 	item_kill_tree(&tree);
 }
 
 void gang_check(void)
 {
-	__gang_check(1 << 30, 128, 128, 35, 2);
-	__gang_check(1 << 31, 128, 128, 32, 32);
-	__gang_check(1 << 31, 128, 128, 32, 100);
-	__gang_check(1 << 31, 128, 128, 17, 7);
-	__gang_check(0xffff0000, 0, 65536, 17, 7);
-	__gang_check(0xfffffffe, 1, 1, 17, 7);
+	__gang_check(1UL << 30, 128, 128, 35, 2);
+	__gang_check(1UL << 31, 128, 128, 32, 32);
+	__gang_check(1UL << 31, 128, 128, 32, 100);
+	__gang_check(1UL << 31, 128, 128, 17, 7);
+	__gang_check(0xffff0000UL, 0, 65536, 17, 7);
+	__gang_check(0xfffffffeUL, 1, 1, 17, 7);
 }
 
 void __big_gang_check(void)
-- 
2.17.1
