Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33918C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8952133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAfuaHMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8952133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbeLEJrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:47:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbeLEJq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:46:58 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03B5820878;
        Wed,  5 Dec 2018 09:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003217;
        bh=D+ZOTnvoKwJz9xwjDGe8daEFHxGg1oDmrOogwgdet38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jAfuaHMDPh6Lf27jidUWOTiyIeu/rjILptceg2VV3/FMvBRK0YX2e4iX8ySggsEtA
         zTNqS3+yYFxBAupKTEwToSODls6/9pLOhqjDjFFhdfV+BiaXXIYgR9PNl00aO3EyeO
         SWIfPVamRCchVV4CTTWYKP3bJkqhtuRTtaPDo/iA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pan Bian <bianpan2016@163.com>,
        "Ernesto A . Fernandez" <ernesto.mnd.fernandez@gmail.com>,
        Joe Perches <joe@perches.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 67/69] hfsplus: do not free node before using
Date:   Wed,  5 Dec 2018 04:42:45 -0500
Message-Id: <20181205094247.6556-67-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094247.6556-1-sashal@kernel.org>
References: <20181205094247.6556-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit c7d7d620dcbd2a1c595092280ca943f2fced7bbd ]

hfs_bmap_free() frees node via hfs_bnode_put(node).  However it then
reads node->this when dumping error message on an error path, which may
result in a use-after-free bug.  This patch frees node only when it is
never used.

Link: http://lkml.kernel.org/r/1543053441-66942-1-git-send-email-bianpan2016@163.com
Signed-off-by: Pan Bian <bianpan2016@163.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Ernesto A. Fernandez <ernesto.mnd.fernandez@gmail.com>
Cc: Joe Perches <joe@perches.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/btree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index de14b2b6881b..3de3bc4918b5 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -454,14 +454,15 @@ void hfs_bmap_free(struct hfs_bnode *node)
 
 		nidx -= len * 8;
 		i = node->next;
-		hfs_bnode_put(node);
 		if (!i) {
 			/* panic */;
 			pr_crit("unable to free bnode %u. "
 					"bmap not found!\n",
 				node->this);
+			hfs_bnode_put(node);
 			return;
 		}
+		hfs_bnode_put(node);
 		node = hfs_bnode_find(tree, i);
 		if (IS_ERR(node))
 			return;
-- 
2.17.1

