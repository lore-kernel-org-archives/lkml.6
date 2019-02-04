Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97DAC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7502073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278266;
	bh=VczQjrUplDLPV6b5FlJUX0IDRDWsFh7/bzIi2T5Yw40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0AOE23tWaq0hAWCQy/wVWQ7VRM9KsFhoHh0URFVJ+xAibvf4imZOnDzq3WvqpaxVx
	 6L/CcbjKPhRe/QsYf8aKvH/n15QyKVPZ4yFtvyZnHwMDVfLrbwMM1RF1gX6St7geXp
	 AadJAyG+WuW2rKZ25pmh+5YqhC0BJ1lhq/k0FKpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbfBDKpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:43456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731176AbfBDKpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:45:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62D002176F;
        Mon,  4 Feb 2019 10:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277120;
        bh=VczQjrUplDLPV6b5FlJUX0IDRDWsFh7/bzIi2T5Yw40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ksbtby1npA9YRfk6cWqY+e+nEqKc1VvvqWARlbq6g8tiZftWrtr2gIS/c+3g+Ytab
         BnFQan/qHXXcOSdon3Da0jSzjl/JkztPBrgWYatlTqdYM3ObDyRtOEujTePX5KFSyz
         cC4EY0TlFSvoYTvYMboJ0eI810+AKrL0QL94VP8g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Waiman Long <longman@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 21/46] fs/dcache: Fix incorrect nr_dentry_unused accounting in shrink_dcache_sb()
Date:   Mon,  4 Feb 2019 11:36:52 +0100
Message-Id: <20190204103612.402923463@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103608.651205056@linuxfoundation.org>
References: <20190204103608.651205056@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

commit 1dbd449c9943e3145148cc893c2461b72ba6fef0 upstream.

The nr_dentry_unused per-cpu counter tracks dentries in both the LRU
lists and the shrink lists where the DCACHE_LRU_LIST bit is set.

The shrink_dcache_sb() function moves dentries from the LRU list to a
shrink list and subtracts the dentry count from nr_dentry_unused.  This
is incorrect as the nr_dentry_unused count will also be decremented in
shrink_dentry_list() via d_shrink_del().

To fix this double decrement, the decrement in the shrink_dcache_sb()
function is taken out.

Fixes: 4e717f5c1083 ("list_lru: remove special case function list_lru_dispose_all."
Cc: stable@kernel.org
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dcache.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1183,15 +1183,11 @@ static enum lru_status dentry_lru_isolat
  */
 void shrink_dcache_sb(struct super_block *sb)
 {
-	long freed;
-
 	do {
 		LIST_HEAD(dispose);
 
-		freed = list_lru_walk(&sb->s_dentry_lru,
+		list_lru_walk(&sb->s_dentry_lru,
 			dentry_lru_isolate_shrink, &dispose, 1024);
-
-		this_cpu_sub(nr_dentry_unused, freed);
 		shrink_dentry_list(&dispose);
 		cond_resched();
 	} while (list_lru_count(&sb->s_dentry_lru) > 0);


