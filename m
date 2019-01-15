Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A033CC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7039220675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570443;
	bh=c9VZdVHbLKhF1KAa4kwYWVnakYQ4ls2YzGBwSnDVs2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EIbCEQDC8omPn+mmHHfVizE7nc6aZLLi+64vejtUQLrFwvEAryremEj6WfpKY5h/O
	 wel8I5yZILYnxP7yNFHxI0sZ7D74TowgA1QrTS7jTtgdOXmjNRo6B01fefb4iomvhy
	 AReNyXHHeGggZ8i8AVpInd929YyGaoHMwlEJLu2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732648AbfAOQkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:40:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730407AbfAOQkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:40:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C79DA20675;
        Tue, 15 Jan 2019 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570435;
        bh=c9VZdVHbLKhF1KAa4kwYWVnakYQ4ls2YzGBwSnDVs2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WoatfrP4gV5tEVi0oB2/ze27P9/c/8cqfzOgBpabHxalJkESNg5gyPBPtPxw3joRr
         dKyV3fObB5ZuzHDNK0GARGVfFgM6eeS7vjdEO5wjjiy3H8KjpMphxMUvq2uAavkBB2
         nWOoBHjK1xeg0KEnCpMM5culbeaBu8Wqm/YtW3Wc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.14 22/27] ext4: fix a potential fiemap/page fault deadlock w/ inline_data
Date:   Tue, 15 Jan 2019 17:36:11 +0100
Message-Id: <20190115154902.717175122@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154901.189747728@linuxfoundation.org>
References: <20190115154901.189747728@linuxfoundation.org>
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

From: Theodore Ts'o <tytso@mit.edu>

commit 2b08b1f12cd664dc7d5c84ead9ff25ae97ad5491 upstream.

The ext4_inline_data_fiemap() function calls fiemap_fill_next_extent()
while still holding the xattr semaphore.  This is not necessary and it
triggers a circular lockdep warning.  This is because
fiemap_fill_next_extent() could trigger a page fault when it writes
into page which triggers a page fault.  If that page is mmaped from
the inline file in question, this could very well result in a
deadlock.

This problem can be reproduced using generic/519 with a file system
configuration which has the inline_data feature enabled.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inline.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1864,12 +1864,12 @@ int ext4_inline_data_fiemap(struct inode
 	physical += (char *)ext4_raw_inode(&iloc) - iloc.bh->b_data;
 	physical += offsetof(struct ext4_inode, i_block);
 
-	if (physical)
-		error = fiemap_fill_next_extent(fieinfo, start, physical,
-						inline_len, flags);
 	brelse(iloc.bh);
 out:
 	up_read(&EXT4_I(inode)->xattr_sem);
+	if (physical)
+		error = fiemap_fill_next_extent(fieinfo, start, physical,
+						inline_len, flags);
 	return (error < 0 ? error : 0);
 }
 


