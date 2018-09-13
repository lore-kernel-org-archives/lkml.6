Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F74C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87CF20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87CF20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbeIMSq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:46:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59528 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeIMSq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:46:56 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C5057CF3;
        Thu, 13 Sep 2018 13:37:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Vegard Nossum <vegard.nossum@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 27/78] fs/dcache.c: fix kmemcheck splat at take_dentry_name_snapshot()
Date:   Thu, 13 Sep 2018 15:31:14 +0200
Message-Id: <20180913131808.123661883@linuxfoundation.org>
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

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 6cd00a01f0c1ae6a852b09c59b8dd55cc6c35d1d ]

Since only dentry->d_name.len + 1 bytes out of DNAME_INLINE_LEN bytes
are initialized at __d_alloc(), we can't copy the whole size
unconditionally.

 WARNING: kmemcheck: Caught 32-bit read from uninitialized memory (ffff8fa27465ac50)
 636f6e66696766732e746d70000000000010000000000000020000000188ffff
  i i i i i i i i i i i i i u u u u u u u u u u i i i i i u u u u
                                  ^
 RIP: 0010:take_dentry_name_snapshot+0x28/0x50
 RSP: 0018:ffffa83000f5bdf8 EFLAGS: 00010246
 RAX: 0000000000000020 RBX: ffff8fa274b20550 RCX: 0000000000000002
 RDX: ffffa83000f5be40 RSI: ffff8fa27465ac50 RDI: ffffa83000f5be60
 RBP: ffffa83000f5bdf8 R08: ffffa83000f5be48 R09: 0000000000000001
 R10: ffff8fa27465ac00 R11: ffff8fa27465acc0 R12: ffff8fa27465ac00
 R13: ffff8fa27465acc0 R14: 0000000000000000 R15: 0000000000000000
 FS:  00007f79737ac8c0(0000) GS:ffffffff8fc30000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffff8fa274c0b000 CR3: 0000000134aa7002 CR4: 00000000000606f0
  take_dentry_name_snapshot+0x28/0x50
  vfs_rename+0x128/0x870
  SyS_rename+0x3b2/0x3d0
  entry_SYSCALL_64_fastpath+0x1a/0xa4
  0xffffffffffffffff

Link: http://lkml.kernel.org/r/201709131912.GBG39012.QMJLOVFSFFOOtH@I-love.SAKURA.ne.jp
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Vegard Nossum <vegard.nossum@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/dcache.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -286,7 +286,8 @@ void take_dentry_name_snapshot(struct na
 		spin_unlock(&dentry->d_lock);
 		name->name = p->name;
 	} else {
-		memcpy(name->inline_name, dentry->d_iname, DNAME_INLINE_LEN);
+		memcpy(name->inline_name, dentry->d_iname,
+		       dentry->d_name.len + 1);
 		spin_unlock(&dentry->d_lock);
 		name->name = name->inline_name;
 	}


