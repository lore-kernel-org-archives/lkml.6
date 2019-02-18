Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D4EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEF621902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498815;
	bh=jwc6gL1JcXEPP/zaW9Dg4y1ENlChbmlW+gEjnVuSdws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=afFKhqq+p8gQiACdaWmH12fKpeVUeLpV69gNdSDI+dE6rX9WZVj6p0jH9S/eiSNDk
	 waivFDD3mXs5/eVSpCP6iXJMySv6MmEjoBgca3fRjaT/iKMe2zvnUiHfdHt1xWipan
	 4uNU5Xgn0yLB8HuQETYWA02YReHeEtNAdq2oAHpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390507AbfBROGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:06:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390485AbfBROGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:06:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD58421929;
        Mon, 18 Feb 2019 14:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498808;
        bh=jwc6gL1JcXEPP/zaW9Dg4y1ENlChbmlW+gEjnVuSdws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBaBJqYHfiCpXu/z3lwowA8YhdKcsxrF4N1gcF5Ir0W8qmd/upi15urEixLnbcae4
         FyZH7i23u0aDphxn6axs5F0leWF4SM87Ctvhm5z8rFtS2VAmEBDcxgK5Lm4ryV3Zdj
         +oJpGdhhFaFpr9xpeLolEFVjWKgo5Oq2fHVTn+SA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.4 102/143] debugfs: fix debugfs_rename parameter checking
Date:   Mon, 18 Feb 2019 14:43:50 +0100
Message-Id: <20190218133532.766776385@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit d88c93f090f708c18195553b352b9f205e65418f upstream.

debugfs_rename() needs to check that the dentries passed into it really
are valid, as sometimes they are not (i.e. if the return value of
another debugfs call is passed into this one.)  So fix this up by
properly checking if the two parent directories are errors (they are
allowed to be NULL), and if the dentry to rename is not NULL or an
error.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/debugfs/inode.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -671,6 +671,13 @@ struct dentry *debugfs_rename(struct den
 	struct dentry *dentry = NULL, *trap;
 	struct name_snapshot old_name;
 
+	if (IS_ERR(old_dir))
+		return old_dir;
+	if (IS_ERR(new_dir))
+		return new_dir;
+	if (IS_ERR_OR_NULL(old_dentry))
+		return old_dentry;
+
 	trap = lock_rename(new_dir, old_dir);
 	/* Source or destination directories don't exist? */
 	if (d_really_is_negative(old_dir) || d_really_is_negative(new_dir))


