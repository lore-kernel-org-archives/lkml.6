Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FD2C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A692133F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789610;
	bh=ZKmyDZ8jgTv+OIK0DQi90VT6dZiJ/5f5rJotRyqaaf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1/rN+p976yyRzxX1wm88Eg6rXwT6LIYGKs2By3iNXJpLpdve34czqlYQ3cgExEe+a
	 yuAd2IAfi9+XpQxE+7HnfL45RyyEjeSWkNU33m7R/VU/3Ih01lJbhz7fWDTvgN5ks8
	 bB63kgi0uWjEEp0ITS/AHzJuFct/Yf0314PnKq8E=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A692133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbeLNMN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:13:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:32814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732119AbeLNMNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:13:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D71E32133F;
        Fri, 14 Dec 2018 12:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789605;
        bh=ZKmyDZ8jgTv+OIK0DQi90VT6dZiJ/5f5rJotRyqaaf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BzGsi8NSGUBOuNQv99J6t6JVtxj6zw6C6llt4MK7bVsTmWTw1mWWmHrQp1d5Adcxo
         4C5yDaeUQxaI/09hvSK7Tk9h4kkIyvXPT2pjLh3D2N0dG3MMT9KCVuvwD3DNHE1w54
         ZqVExJA+chaOuzUdp0sSmX0Cb28jewFRZDSDJcrc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        "Ernesto A. Fernandez" <ernesto.mnd.fernandez@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 46/51] hfs: do not free node before using
Date:   Fri, 14 Dec 2018 13:00:48 +0100
Message-Id: <20181214115717.232339477@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
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

[ Upstream commit ce96a407adef126870b3f4a1b73529dd8aa80f49 ]

hfs_bmap_free() frees the node via hfs_bnode_put(node).  However, it
then reads node->this when dumping error message on an error path, which
may result in a use-after-free bug.  This patch frees the node only when
it is never again used.

Link: http://lkml.kernel.org/r/1542963889-128825-1-git-send-email-bianpan2016@163.com
Fixes: a1185ffa2fc ("HFS rewrite")
Signed-off-by: Pan Bian <bianpan2016@163.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Joe Perches <joe@perches.com>
Cc: Ernesto A. Fernandez <ernesto.mnd.fernandez@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfs/btree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 37cdd955eceb..320f4372f172 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -328,13 +328,14 @@ void hfs_bmap_free(struct hfs_bnode *node)
 
 		nidx -= len * 8;
 		i = node->next;
-		hfs_bnode_put(node);
 		if (!i) {
 			/* panic */;
 			pr_crit("unable to free bnode %u. bmap not found!\n",
 				node->this);
+			hfs_bnode_put(node);
 			return;
 		}
+		hfs_bnode_put(node);
 		node = hfs_bnode_find(tree, i);
 		if (IS_ERR(node))
 			return;
-- 
2.19.1



