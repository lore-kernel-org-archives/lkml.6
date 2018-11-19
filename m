Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403C9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DF721104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiL++vtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DF721104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbeKTDBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:01:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730719AbeKTDBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:01:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C729520989;
        Mon, 19 Nov 2018 16:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645462;
        bh=+oShAXByvRILOqXXDWbQpKhtTskWfah/GmYqoObqqeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SiL++vtK4stLmT8t8uAHv7ZhWHy3qH5QYna5/2QqEjsBnlFVYhNiyXFqRFQWZlF28
         +58ihzw3ikPcATmKz+MIqSEK+BCx36N/cQLvPr90+niUadC9tYHRVxjYp5vH7oGVvd
         qMINqi8yLv6ZKvpEIAhJ+LAIVpmz7xrFIfdTf5n0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Spock <dairinin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 171/205] mm: dont reclaim inodes with many attached pages
Date:   Mon, 19 Nov 2018 17:27:58 +0100
Message-Id: <20181119162640.474322772@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Gushchin <guro@fb.com>

commit a76cf1a474d7dbcd9336b5f5afb0162baa142cf0 upstream.

Spock reported that commit 172b06c32b94 ("mm: slowly shrink slabs with a
relatively small number of objects") leads to a regression on his setup:
periodically the majority of the pagecache is evicted without an obvious
reason, while before the change the amount of free memory was balancing
around the watermark.

The reason behind is that the mentioned above change created some
minimal background pressure on the inode cache.  The problem is that if
an inode is considered to be reclaimed, all belonging pagecache page are
stripped, no matter how many of them are there.  So, if a huge
multi-gigabyte file is cached in the memory, and the goal is to reclaim
only few slab objects (unused inodes), we still can eventually evict all
gigabytes of the pagecache at once.

The workload described by Spock has few large non-mapped files in the
pagecache, so it's especially noticeable.

To solve the problem let's postpone the reclaim of inodes, which have
more than 1 attached page.  Let's wait until the pagecache pages will be
evicted naturally by scanning the corresponding LRU lists, and only then
reclaim the inode structure.

Link: http://lkml.kernel.org/r/20181023164302.20436-1-guro@fb.com
Signed-off-by: Roman Gushchin <guro@fb.com>
Reported-by: Spock <dairinin@gmail.com>
Tested-by: Spock <dairinin@gmail.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: <stable@vger.kernel.org>	[4.19.x]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/inode.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/fs/inode.c
+++ b/fs/inode.c
@@ -730,8 +730,11 @@ static enum lru_status inode_lru_isolate
 		return LRU_REMOVED;
 	}
 
-	/* recently referenced inodes get one more pass */
-	if (inode->i_state & I_REFERENCED) {
+	/*
+	 * Recently referenced inodes and inodes with many attached pages
+	 * get one more pass.
+	 */
+	if (inode->i_state & I_REFERENCED || inode->i_data.nrpages > 1) {
 		inode->i_state &= ~I_REFERENCED;
 		spin_unlock(&inode->i_lock);
 		return LRU_ROTATE;


