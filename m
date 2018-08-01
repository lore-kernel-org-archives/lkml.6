Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B182C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B5420862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B5420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408056AbeHATWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:22:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52934 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436591AbeHATSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8C060E39;
        Wed,  1 Aug 2018 16:53:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 021/336] skip LAYOUTRETURN if layout is invalid
Date:   Wed,  1 Aug 2018 18:45:56 +0200
Message-Id: <20180801165029.814867890@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Olga Kornievskaia <olga.kornievskaia@gmail.com>

[ Upstream commit 93b7f7ad2018d2037559b1d0892417864c78b371 ]

Currently, when IO to DS fails, client returns the layout and
retries against the MDS. However, then on umounting (inode eviction)
it returns the layout again.

This is because pnfs_return_layout() was changed in
commit d78471d32bb6 ("pnfs/blocklayout: set PNFS_LAYOUTRETURN_ON_ERROR")
to always set NFS_LAYOUT_RETURN_REQUESTED so even if we returned
the layout, it will be returned again. Instead, let's also check
if we have already marked the layout invalid.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/pnfs.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1144,7 +1144,7 @@ _pnfs_return_layout(struct inode *ino)
 	LIST_HEAD(tmp_list);
 	nfs4_stateid stateid;
 	int status = 0;
-	bool send;
+	bool send, valid_layout;
 
 	dprintk("NFS: %s for inode %lu\n", __func__, ino->i_ino);
 
@@ -1165,6 +1165,7 @@ _pnfs_return_layout(struct inode *ino)
 			goto out_put_layout_hdr;
 		spin_lock(&ino->i_lock);
 	}
+	valid_layout = pnfs_layout_is_valid(lo);
 	pnfs_clear_layoutcommit(ino, &tmp_list);
 	pnfs_mark_matching_lsegs_invalid(lo, &tmp_list, NULL, 0);
 
@@ -1178,7 +1179,8 @@ _pnfs_return_layout(struct inode *ino)
 	}
 
 	/* Don't send a LAYOUTRETURN if list was initially empty */
-	if (!test_bit(NFS_LAYOUT_RETURN_REQUESTED, &lo->plh_flags)) {
+	if (!test_bit(NFS_LAYOUT_RETURN_REQUESTED, &lo->plh_flags) ||
+			!valid_layout) {
 		spin_unlock(&ino->i_lock);
 		dprintk("NFS: %s no layout segments to return\n", __func__);
 		goto out_put_layout_hdr;


