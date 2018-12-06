Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB10C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DB8214DE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107639;
	bh=CLrj/deo3JVwPbu3+SJaODbAGj13X253vJY6pmx3Prg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TKK42DupKqk2rO4Gmdj6dBeM60T6KiW+yERPJHiYakqC9NZALKXd2XDEHLOa2tOWg
	 F8G8AbHMoID786hKxOoiXEoaAtgkkJFLNghDeQ8wFYU15jE0jh6SAmacG2TCEbk2TF
	 c4qERcxwcXcjsVAnDm+9x9QSdtM2RH3DCsZ49F6k=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DB8214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbeLFOrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:47:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:52048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731380AbeLFOrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:47:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60EA720661;
        Thu,  6 Dec 2018 14:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107631;
        bh=CLrj/deo3JVwPbu3+SJaODbAGj13X253vJY6pmx3Prg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMRGZm2oCC8Hi/FYGd86YI9WTKFtdzBwTcJ4LhC9K5d++Y3PQew6lGy7149EC0q9m
         Vpk9Zqdiaa/LR8bZm+Kp7jxCaT3wAXI98HzKWWx3uJ4gj/HG2yYW68qq25DjRH0euU
         Btq92rh0y4f8ajmgsCg6d/uvFY2k1mvyEQK/Ks/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Jan Kara <jack@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 044/101] mm: cleancache: fix corruption on missed inode invalidation
Date:   Thu,  6 Dec 2018 15:38:43 +0100
Message-Id: <20181206143014.057240257@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

commit 6ff38bd40230af35e446239396e5fc8ebd6a5248 upstream.

If all pages are deleted from the mapping by memory reclaim and also
moved to the cleancache:

__delete_from_page_cache
  (no shadow case)
  unaccount_page_cache_page
    cleancache_put_page
  page_cache_delete
    mapping->nrpages -= nr
    (nrpages becomes 0)

We don't clean the cleancache for an inode after final file truncation
(removal).

truncate_inode_pages_final
  check (nrpages || nrexceptional) is false
    no truncate_inode_pages
      no cleancache_invalidate_inode(mapping)

These way when reading the new file created with same inode we may get
these trash leftover pages from cleancache and see wrong data instead of
the contents of the new file.

Fix it by always doing truncate_inode_pages which is already ready for
nrpages == 0 && nrexceptional == 0 case and just invalidates inode.

[akpm@linux-foundation.org: add comment, per Jan]
Link: http://lkml.kernel.org/r/20181112095734.17979-1-ptikhomirov@virtuozzo.com
Fixes: commit 91b0abe36a7b ("mm + fs: store shadow entries in page cache")
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Reviewed-by: Vasily Averin <vvs@virtuozzo.com>
Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/truncate.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -443,9 +443,13 @@ void truncate_inode_pages_final(struct a
 		 */
 		spin_lock_irq(&mapping->tree_lock);
 		spin_unlock_irq(&mapping->tree_lock);
-
-		truncate_inode_pages(mapping, 0);
 	}
+
+	/*
+	 * Cleancache needs notification even if there are no pages or shadow
+	 * entries.
+	 */
+	truncate_inode_pages(mapping, 0);
 }
 EXPORT_SYMBOL(truncate_inode_pages_final);
 


