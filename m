Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAA6C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEA2214C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789426;
	bh=38dU37KPweIhlzE/wEcAO1Dwymrjnb59yAp9J2nMHHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ui1DbJBTw6g9Ten2gtK66kQoaaUiVcRq/5WdFIzBpXmKT9rkJ0ZklbwuRqBXHrVfH
	 XrWIpBWGgauc6XJ2wv0ULdoNMh+r9PXfuNZmj2BL+WpADWEGkd8+fB2A4cHlfOVtMP
	 Efn+W+50zBxj7cv04+VGG+jMzqucyzYmdmWRsTPg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEA2214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbeLNMKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:10:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730990AbeLNMKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:10:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2F10214C4;
        Fri, 14 Dec 2018 12:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789421;
        bh=38dU37KPweIhlzE/wEcAO1Dwymrjnb59yAp9J2nMHHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oN46KmcRWlwFWp/7Si3u9E2EAZesoKUTlkr+9AvNevmPDFpXxYuRqo1Fes7HsKOTF
         0sQ4HfvdttQ/r4+seIyMxWhpdbv8DflU8/9athG9mdjKJwL7VTGKDcuRHbUVy4XkiN
         Tc2b9OCmXa4fxarRsFMCWtlI6d8Wa+UtEhthw/C8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Ernesto A. Fernandez" <ernesto.mnd.fernandez@gmail.com>,
        Joe Perches <joe@perches.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 76/89] hfsplus: do not free node before using
Date:   Fri, 14 Dec 2018 13:00:29 +0100
Message-Id: <20181214115733.442862941@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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
2.19.1



