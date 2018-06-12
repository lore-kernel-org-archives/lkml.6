Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 376B7C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1779208BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgGA+IXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1779208BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933779AbeFLQsN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:48:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934947AbeFLQsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:48:05 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B565208B7;
        Tue, 12 Jun 2018 16:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822085;
        bh=w72pDsf1zlgltY+4KdYrsYI7usLj0Exu/QM9ZIFClSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JgGA+IXOYHuDJoJFAz5mWJ6qUes+68okNbfKcyCtGE43EPvk7wAyNpSRDNzNAO8Kt
         53cSxq1hnRwx4zz9yPPLQ8pMlEpceWVWZ4ntxc3yNL48GKVytvgif/dZJRrXXsXQW6
         hzvqxLDlK2FpTUsTPM2xDyZheoke3X4l9JP8B81A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 29/31] dm bufio: avoid false-positive Wmaybe-uninitialized warning
Date:   Tue, 12 Jun 2018 18:46:32 +0200
Message-Id: <20180612164621.948353741@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164620.797338191@linuxfoundation.org>
References: <20180612164620.797338191@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 590347e4000356f55eb10b03ced2686bd74dab40 upstream.

gcc-6.3 and earlier show a new warning after a seemingly unrelated
change to the arm64 PAGE_KERNEL definition:

In file included from drivers/md/dm-bufio.c:14:0:
drivers/md/dm-bufio.c: In function 'alloc_buffer':
include/linux/sched/mm.h:182:56: warning: 'noio_flag' may be used uninitialized in this function [-Wmaybe-uninitialized]
  current->flags = (current->flags & ~PF_MEMALLOC_NOIO) | flags;
                                                        ^

The same warning happened earlier on linux-3.18 for MIPS and I did a
workaround for that, but now it's come back.

gcc-7 and newer are apparently smart enough to figure this out, and
other architectures don't show it, so the best I could come up with is
to rework the caller slightly in a way that makes it obvious enough to
all arm64 compilers what is happening here.

Fixes: 41acec624087 ("arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0()")
Link: https://patchwork.kernel.org/patch/9692829/
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[snitzer: moved declarations inside conditional, altered vmalloc return]
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
[nc: Backport to 4.9, adjust context for lack of 19809c2da28a]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-bufio.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -373,9 +373,6 @@ static void __cache_size_refresh(void)
 static void *alloc_buffer_data(struct dm_bufio_client *c, gfp_t gfp_mask,
 			       enum data_mode *data_mode)
 {
-	unsigned noio_flag;
-	void *ptr;
-
 	if (c->block_size <= DM_BUFIO_BLOCK_SIZE_SLAB_LIMIT) {
 		*data_mode = DATA_MODE_SLAB;
 		return kmem_cache_alloc(DM_BUFIO_CACHE(c), gfp_mask);
@@ -399,16 +396,16 @@ static void *alloc_buffer_data(struct dm
 	 * all allocations done by this process (including pagetables) are done
 	 * as if GFP_NOIO was specified.
 	 */
+	if (gfp_mask & __GFP_NORETRY) {
+		unsigned noio_flag = memalloc_noio_save();
+		void *ptr = __vmalloc(c->block_size, gfp_mask | __GFP_HIGHMEM,
+				      PAGE_KERNEL);
 
-	if (gfp_mask & __GFP_NORETRY)
-		noio_flag = memalloc_noio_save();
-
-	ptr = __vmalloc(c->block_size, gfp_mask | __GFP_HIGHMEM, PAGE_KERNEL);
-
-	if (gfp_mask & __GFP_NORETRY)
 		memalloc_noio_restore(noio_flag);
+		return ptr;
+	}
 
-	return ptr;
+	return __vmalloc(c->block_size, gfp_mask | __GFP_HIGHMEM, PAGE_KERNEL);
 }
 
 /*


