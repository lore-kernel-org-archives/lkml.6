Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE18C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D66121841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130500;
	bh=wBPMrdg7x4K4mkimPpACCGXdQrBZg+dirlRsJEwAg/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lG3b+GVZxBrGW+u9PfVOp3wSXbddRoKSYR7lS0QGoFaUXiDT3VrvB9CL+Ec5fkfd9
	 sdGUgSqvY+hZ6olYSI/JRyip35NDNq0UdQxtGThj7Rh4qTvIzGuUZyrtsGcw92BoyQ
	 evLHklPFvnzfbfKKk+2naF4LPjl67Q8JUpXcdRJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732901AbfBYVe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:41086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732889AbfBYVe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:34:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1BA421850;
        Mon, 25 Feb 2019 21:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130495;
        bh=wBPMrdg7x4K4mkimPpACCGXdQrBZg+dirlRsJEwAg/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0fCld01viIv7PhD1vPoM7rgOBepuquDQWpUSepjymIQM05l/Ob6cdTEVvbbc0c/+b
         T5yTZrgkXzF0tzqBZ874KtVbjJRC0lMYUl0cUInAam3skMp3cSAWKLvMzHG1BgiIQQ
         Ne3anuYSVG/D5n/vxCAVSq76hWpn+/U7+P54nEaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 102/183] afs: Dont set vnode->cb_s_break in afs_validate()
Date:   Mon, 25 Feb 2019 22:11:15 +0100
Message-Id: <20190225195111.885639018@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4882a27cec24319d10f95e978ecc80050e3e3e15 ]

A cb_interest record is not necessarily attached to the vnode on entry to
afs_validate(), which can cause an oops when we try to bring the vnode's
cb_s_break up to date in the default case (ie. no current callback promise
and the vnode has not been deleted).

Fix this by simply removing the line, as vnode->cb_s_break will be set when
needed by afs_register_server_cb_interest() when we next get a callback
promise from RPC call.

The oops looks something like:

    BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
    ...
    RIP: 0010:afs_validate+0x66/0x250 [kafs]
    ...
    Call Trace:
     afs_d_revalidate+0x8d/0x340 [kafs]
     ? __d_lookup+0x61/0x150
     lookup_dcache+0x44/0x70
     ? lookup_dcache+0x44/0x70
     __lookup_hash+0x24/0xa0
     do_unlinkat+0x11d/0x2c0
     __x64_sys_unlink+0x23/0x30
     do_syscall_64+0x4d/0xf0
     entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: ae3b7361dc0e ("afs: Fix validation/callback interaction")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 6b17d36204142..211343831c304 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -414,7 +414,6 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 	} else if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
 		valid = true;
 	} else {
-		vnode->cb_s_break = vnode->cb_interest->server->cb_s_break;
 		vnode->cb_v_break = vnode->volume->cb_v_break;
 		valid = false;
 	}
-- 
2.19.1



