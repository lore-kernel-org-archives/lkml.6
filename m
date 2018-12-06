Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667FDC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EACB21479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107684;
	bh=uj41PPN0C8iNBqG2AdXb/gcKO7OlzYS7H/bqgRhy87Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K8Mrp9fWtIo2qU/t6ltaSihmdPFRzUviOfBTxHGkRbBu/vsRLyKSqU5RIcep4uEMu
	 uWhswvzrix8Awy+BELe7FdTn7kpiPg30QVb+gr28UJpyG3r9wX6zH0pJTDL/tG+wsA
	 1zIYHdXW/hT+zYirVgfIpX/pfsjd2QPQ6JQ8up3I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EACB21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbeLFOsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:48:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730774AbeLFOr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:47:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 889B22082B;
        Thu,  6 Dec 2018 14:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107679;
        bh=uj41PPN0C8iNBqG2AdXb/gcKO7OlzYS7H/bqgRhy87Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0nBCkbPGrl64mjPsfhb4fwq1c+XM2KyZbQQluCuPEoBpLb8EDpgcNevKN3RlxvxWK
         eJT5klo+DamPrTY+b1uM4aZNwpusF9HMxlD73uAG9T7MkAHfBOOuW5qFZOeGvseu+E
         q2ehBu7M/vQpwYwiYyPy5prERmCs3Vb17Xjb1Urg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 097/101] f2fs: fix missing up_read
Date:   Thu,  6 Dec 2018 15:39:36 +0100
Message-Id: <20181206143018.764350495@linuxfoundation.org>
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

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit 89d13c38501df730cbb2e02c4499da1b5187119d upstream.

This patch fixes missing up_read call.

Fixes: c9b60788fc76 ("f2fs: fix to do sanity check with block address in main area")
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/node.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1606,8 +1606,10 @@ static int f2fs_write_node_page(struct p
 	}
 
 	if (__is_valid_data_blkaddr(ni.blk_addr) &&
-		!f2fs_is_valid_blkaddr(sbi, ni.blk_addr, DATA_GENERIC))
+		!f2fs_is_valid_blkaddr(sbi, ni.blk_addr, DATA_GENERIC)) {
+		up_read(&sbi->node_write);
 		goto redirty_out;
+	}
 
 	set_page_writeback(page);
 	fio.old_blkaddr = ni.blk_addr;


