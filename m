Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBA8C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A2A2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276750;
	bh=D/C0Ac8ZqrV2Ph4+DCBXnwvvPLG6as+2yq19b6ZYIQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GSvMifLDrOd7NPe6D0p3m8WScCopSViLzm1Jbr6bnCwjM6VieiaQwSTQoWUvzrUh4
	 fQh+FHrSK71QCbwNbVQ5jbLmtW9WNRU9zfCBGqc/P2qV8q27dJ9QnAfHLJNFY2Paas
	 /SVswKpxhiCt5mDzY0gcR5y7GqQmJc+2mH54T8W0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfBDKjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:39:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729607AbfBDKjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:39:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FF5E2070C;
        Mon,  4 Feb 2019 10:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276745;
        bh=D/C0Ac8ZqrV2Ph4+DCBXnwvvPLG6as+2yq19b6ZYIQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VP7VkKE5Bys4ZXD8um5mCuz4dv3EJ/5plCQOFH59PvXw0wKSmnZq9lnVqcAOmtCQE
         cRTdzwSr9xDoBIGZzaSmpw+3mXW2h72R500MZaJeWeyk4t1BLQewxIoCyvGdjN7ufj
         UkkCnq3OEvU83ThvgJ2Xk1ksn3xSO5mud1naixp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Waiman Long <longman@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3.18 25/31] fs/dcache: Fix incorrect nr_dentry_unused accounting in shrink_dcache_sb()
Date:   Mon,  4 Feb 2019 11:36:40 +0100
Message-Id: <20190204103603.193262901@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103557.903263774@linuxfoundation.org>
References: <20190204103557.903263774@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1103,15 +1103,11 @@ static enum lru_status dentry_lru_isolat
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


