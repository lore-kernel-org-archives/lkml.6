Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D80C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CEE20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570438;
	bh=Ejg4304mdjvJhs3KFCY8qa54ViZmfUkoFIJGXwcLbS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V27kd966C4w6fTxWLsQ5mkp1hPeY9sL4bUIEpZL+1nxDPFwUTR3NgqRgUpSrZaVym
	 pErpQszVd6t5p2S6TpdPxmL5hS6zAIKuM2vmZQzuwchaKysqigw05lNSxvQ4f0dR1v
	 jhNa9lPIvSJ8rXJK27oFIZ3zMPOtUl4LLbw3nPqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbfAOQkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:40:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732622AbfAOQkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:40:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 273482173C;
        Tue, 15 Jan 2019 16:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570432;
        bh=Ejg4304mdjvJhs3KFCY8qa54ViZmfUkoFIJGXwcLbS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g3koBxY/Ro99tvkUrmjlrBlNKfQe5epgpY935nVcI1HnBudRDp4/DAK0uWUJYkyxG
         ujfxjDBjWq6tAGKS10bzkg/bLLiBBNzAu+eqSsAQzuiN08Z9r+KiSApRenm7qE9e2H
         tGvBhyoaxdqWB21UPTdMx3almOcNFF35/+E8344k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.14 21/27] ext4: make sure enough credits are reserved for dioread_nolock writes
Date:   Tue, 15 Jan 2019 17:36:10 +0100
Message-Id: <20190115154902.619326895@linuxfoundation.org>
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

commit 812c0cab2c0dfad977605dbadf9148490ca5d93f upstream.

There are enough credits reserved for most dioread_nolock writes;
however, if the extent tree is sufficiently deep, and/or quota is
enabled, the code was not allowing for all eventualities when
reserving journal credits for the unwritten extent conversion.

This problem can be seen using xfstests ext4/034:

   WARNING: CPU: 1 PID: 257 at fs/ext4/ext4_jbd2.c:271 __ext4_handle_dirty_metadata+0x10c/0x180
   Workqueue: ext4-rsv-conversion ext4_end_io_rsv_work
   RIP: 0010:__ext4_handle_dirty_metadata+0x10c/0x180
   	...
   EXT4-fs: ext4_free_blocks:4938: aborting transaction: error 28 in __ext4_handle_dirty_metadata
   EXT4: jbd2_journal_dirty_metadata failed: handle type 11 started at line 4921, credits 4/0, errcode -28
   EXT4-fs error (device dm-1) in ext4_free_blocks:4950: error 28

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2776,7 +2776,8 @@ static int ext4_writepages(struct addres
 		 * We may need to convert up to one extent per block in
 		 * the page and we may dirty the inode.
 		 */
-		rsv_blocks = 1 + (PAGE_SIZE >> inode->i_blkbits);
+		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
+						PAGE_SIZE >> inode->i_blkbits);
 	}
 
 	/*


