Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7187C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784772154F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784772154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389748AbeHNU2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:28:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58784 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbeHNU2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:28:36 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 49112DF2;
        Tue, 14 Aug 2018 17:40:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Dae R. Jeong" <threeearcat@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.9 012/107] make sure that __dentry_kill() always invalidates d_seq, unhashed or not
Date:   Tue, 14 Aug 2018 19:16:35 +0200
Message-Id: <20180814171521.521706424@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
References: <20180814171520.883143803@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 4c0d7cd5c8416b1ef41534d19163cb07ffaa03ab upstream.

RCU pathwalk relies upon the assumption that anything that changes
->d_inode of a dentry will invalidate its ->d_seq.  That's almost
true - the one exception is that the final dput() of already unhashed
dentry does *not* touch ->d_seq at all.  Unhashing does, though,
so for anything we'd found by RCU dcache lookup we are fine.
Unfortunately, we can *start* with an unhashed dentry or jump into
it.

We could try and be careful in the (few) places where that could
happen.  Or we could just make the final dput() invalidate the damn
thing, unhashed or not.  The latter is much simpler and easier to
backport, so let's do it that way.

Reported-by: "Dae R. Jeong" <threeearcat@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dcache.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -352,14 +352,11 @@ static void dentry_unlink_inode(struct d
 	__releases(dentry->d_inode->i_lock)
 {
 	struct inode *inode = dentry->d_inode;
-	bool hashed = !d_unhashed(dentry);
 
-	if (hashed)
-		raw_write_seqcount_begin(&dentry->d_seq);
+	raw_write_seqcount_begin(&dentry->d_seq);
 	__d_clear_type_and_inode(dentry);
 	hlist_del_init(&dentry->d_u.d_alias);
-	if (hashed)
-		raw_write_seqcount_end(&dentry->d_seq);
+	raw_write_seqcount_end(&dentry->d_seq);
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&inode->i_lock);
 	if (!inode->i_nlink)


