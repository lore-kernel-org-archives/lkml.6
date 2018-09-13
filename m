Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAD_ENC_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4374C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B3220C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B3220C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbeIMSpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:45:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59082 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbeIMSo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:44:57 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A3878D18;
        Thu, 13 Sep 2018 13:35:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "=?UTF-8?q?Ernesto=20A . =20Fern=C3=A1ndez?=" 
        <ernesto.mnd.fernandez@gmail.com>,
        Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 18/78] hfs: prevent crash on exit from failed search
Date:   Thu, 13 Sep 2018 15:31:05 +0200
Message-Id: <20180913131806.925084472@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
References: <20180913131805.732342940@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Ernesto A. Fern·ndez" <ernesto.mnd.fernandez@gmail.com>

[ Upstream commit dc2572791d3a41bab94400af2b6bca9d71ccd303 ]

hfs_find_exit() expects fd->bnode to be NULL after a search has failed.
hfs_brec_insert() may instead set it to an error-valued pointer.  Fix
this to prevent a crash.

Link: http://lkml.kernel.org/r/53d9749a029c41b4016c495fc5838c9dba3afc52.1530294815.git.ernesto.mnd.fernandez@gmail.com
Signed-off-by: Ernesto A. Fern√°ndez <ernesto.mnd.fernandez@gmail.com>
Cc: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/hfs/brec.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -74,9 +74,10 @@ int hfs_brec_insert(struct hfs_find_data
 	if (!fd->bnode) {
 		if (!tree->root)
 			hfs_btree_inc_height(tree);
-		fd->bnode = hfs_bnode_find(tree, tree->leaf_head);
-		if (IS_ERR(fd->bnode))
-			return PTR_ERR(fd->bnode);
+		node = hfs_bnode_find(tree, tree->leaf_head);
+		if (IS_ERR(node))
+			return PTR_ERR(node);
+		fd->bnode = node;
 		fd->record = -1;
 	}
 	new_node = NULL;


