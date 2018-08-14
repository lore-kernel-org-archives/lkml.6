Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F838C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3A32150B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3A32150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389235AbeHNU2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:28:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58568 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbeHNU2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:28:01 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5036BD4A;
        Tue, 14 Aug 2018 17:39:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.9 011/107] root dentries need RCU-delayed freeing
Date:   Tue, 14 Aug 2018 19:16:34 +0200
Message-Id: <20180814171521.473522006@linuxfoundation.org>
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

commit 90bad5e05bcdb0308cfa3d3a60f5c0b9c8e2efb3 upstream.

Since mountpoint crossing can happen without leaving lazy mode,
root dentries do need the same protection against having their
memory freed without RCU delay as everything else in the tree.

It's partially hidden by RCU delay between detaching from the
mount tree and dropping the vfsmount reference, but the starting
point of pathwalk can be on an already detached mount, in which
case umount-caused RCU delay has already passed by the time the
lazy pathwalk grabs rcu_read_lock().  If the starting point
happens to be at the root of that vfsmount *and* that vfsmount
covers the entire filesystem, we get trouble.

Fixes: 48a066e72d97 ("RCU'd vsfmounts")
Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dcache.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1914,10 +1914,12 @@ struct dentry *d_make_root(struct inode
 
 	if (root_inode) {
 		res = __d_alloc(root_inode->i_sb, NULL);
-		if (res)
+		if (res) {
+			res->d_flags |= DCACHE_RCUACCESS;
 			d_instantiate(res, root_inode);
-		else
+		} else {
 			iput(root_inode);
+		}
 	}
 	return res;
 }


