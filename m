Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE1CC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68242080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790931;
	bh=EhUrk7zXXhMAqfOkEHm4PPxPh1G5SSHaw8CGlPAOB8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WhcFDaK5V+l+1WhVII4W8m1dzGI5f+U4UxrKdQc/CIBeyY+oj3DQu0Kulnyvq0k1F
	 u1iM02esBijfointMa9wFCuu0pkW98jxTCFmHQ/bwfj5+oPYDHJa8gi8bHejy8GRwj
	 6rLUP8OwoM6i2iK3AhRcblWDab3unXWRZyeol/D4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68242080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbeLNMHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731077AbeLNMHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:07:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74675214C1;
        Fri, 14 Dec 2018 12:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789239;
        bh=EhUrk7zXXhMAqfOkEHm4PPxPh1G5SSHaw8CGlPAOB8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w/OtSJdPUpQ9m67jFI83Gvawkv0O/oVg58/GYtlJKw6bVtLMnM5OthgbAa1npM/ml
         u0JaoTnFu6xyzvQp6T61PUFiBBlhTKIc3oLPAV3yDE4G6Snd3bPFmBF+X6YAfV2j1B
         nB9ska2TcdNN0v73x2iHDmdC49Qc/hYgJ5szh6CM=
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
Subject: [PATCH 4.19 126/142] hfs: do not free node before using
Date:   Fri, 14 Dec 2018 13:00:11 +0100
Message-Id: <20181214115752.077848478@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 374b5688e29e..9bdff5e40626 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -329,13 +329,14 @@ void hfs_bmap_free(struct hfs_bnode *node)
 
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



