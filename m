Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA65AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1D120820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mhhomcu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1D120820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405438AbeKVVif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:38:35 -0500
Received: from m12-13.163.com ([220.181.12.13]:43218 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732079AbeKVVie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=aClJPX8egxi1YmcUD5
        svqn+icjHahKdxQJbe/meIE4Y=; b=mhhomcu0TAYxRn3srVClvk3+OxZx3T+GnG
        UIPqdu9gGmegksLjivYvCddk4ggpYnVjUzk4btF2ezsI+xZxM6A1IV0KTFBbxF8b
        4hTZkz5iJ/ZjVrEb2/42svSMHzTjC/YVOPBJ7WRXbMzgT0na4o0Lluphopkfkt3t
        S8I0FaeyQ=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp9 (Coremail) with SMTP id DcCowAAnPCXni_Zb588gBQ--.32863S3;
        Thu, 22 Nov 2018 18:58:54 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH] f2fs: read page index before freeing
Date:   Thu, 22 Nov 2018 18:58:46 +0800
Message-Id: <1542884326-74903-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DcCowAAnPCXni_Zb588gBQ--.32863S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr4DAryfJryDZr1rKrWfXwb_yoWkGrg_Jw
        1kZ3yvgFW8Kr1fGan0y3sxJryvyr40gr47W342k3W5tw1rJrZ8AFs8Jrn3Ga4DWr47X34U
        Crs8tw13uF4fCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnjLvtUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBUQ4HclaD0RNDpAAAsa
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function truncate_node frees the page with f2fs_put_page. However,
the page index is read after that. So, the patch reads the index before
freeing the page.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d338740..88be946 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -826,6 +826,7 @@ static int truncate_node(struct dnode_of_data *dn)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct node_info ni;
 	int err;
+	pgoff_t index;
 
 	err = f2fs_get_node_info(sbi, dn->nid, &ni);
 	if (err)
@@ -845,10 +846,11 @@ static int truncate_node(struct dnode_of_data *dn)
 	clear_node_page_dirty(dn->node_page);
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 
+	index = dn->node_page->index;
 	f2fs_put_page(dn->node_page, 1);
 
 	invalidate_mapping_pages(NODE_MAPPING(sbi),
-			dn->node_page->index, dn->node_page->index);
+			index, index);
 
 	dn->node_page = NULL;
 	trace_f2fs_truncate_node(dn->inode, dn->nid, ni.blk_addr);
-- 
2.7.4


