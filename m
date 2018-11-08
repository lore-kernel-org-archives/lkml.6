Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A6AECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D1F214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6lPIbHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D1F214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbeKIHnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:43:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:35140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbeKIHnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:01 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05BC420844;
        Thu,  8 Nov 2018 22:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714731;
        bh=cYrAD7BrGtU7SJ9vQailvW5Gyt1DlGoHIx9WhcX43PQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L6lPIbHNyELg8H3TX7beBkVxEESk/HtDrJKstemlLoDE54OClvF91+WWe2C/XaX+/
         t2MiRgh1GKbdppbDZD87G1xvjOJQm8l/1hyLXmUFJwoJ0HpcLxwPjBqxVj5anIuA1K
         QK5/WzaOhCUykck53DPYRTXmyWpr7yCubrGDtliA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 072/171] ufs: we need to sync inode before freeing it
Date:   Thu,  8 Nov 2018 13:50:42 -0800
Message-Id: <20181108215132.781022752@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
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

[ Upstream commit 67a70017fa0a152657bc7e337e69bb9c9f5549bf ]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ufs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index a2760a2869f4..0f22c036699a 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -846,6 +846,7 @@ void ufs_evict_inode(struct inode * inode)
 		inode->i_size = 0;
 		if (inode->i_blocks)
 			ufs_truncate_blocks(inode);
+		ufs_update_inode(inode, inode_needs_sync(inode));
 	}
 
 	invalidate_inode_buffers(inode);
-- 
2.17.1



