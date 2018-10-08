Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA7BC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8A620645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHey3ik0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8A620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbeJICHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:07:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbeJICHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:07:05 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2806720645;
        Mon,  8 Oct 2018 18:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024837;
        bh=dWomnRs3jUX/NbOTgrSt9VS19q6KggzLFkFOJ/BOQsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eHey3ik02i1mYkNt5OegphMwPY9YeqqQ4iegYdGSwH9rXTtpPGepcM7eNpq8iM0nv
         8DH9OneaOTzdPBIUXO1ngbfX0SIdqdHT3C6dWFvqiRECxkzTbCGsErmjD1N4MGUwCQ
         ZKEOL68FC2eOt9snY/ZHRAZDfhRimAffpdluQrbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.18 146/168] ovl: set I_CREATING on inode being created
Date:   Mon,  8 Oct 2018 20:32:06 +0200
Message-Id: <20181008175625.580565339@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <miklos@szeredi.hu>

commit 6faf05c2b2b4fe70d9068067437649401531de0a upstream.

...otherwise there will be list corruption due to inode_sb_list_add() being
called for inode already on the sb list.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: e950564b97fd ("vfs: don't evict uninitialized inode")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
To: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/dir.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -601,6 +601,10 @@ static int ovl_create_object(struct dent
 	if (!inode)
 		goto out_drop_write;
 
+	spin_lock(&inode->i_lock);
+	inode->i_state |= I_CREATING;
+	spin_unlock(&inode->i_lock);
+
 	inode_init_owner(inode, dentry->d_parent->d_inode, mode);
 	attr.mode = inode->i_mode;
 


