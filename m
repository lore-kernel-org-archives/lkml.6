Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB719C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FF521905
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499191;
	bh=CJ7L/Etu0IvEAsMZnh3FnPSE5ugBj+HHjrGxbpr3cgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P0vHLwhq5XkNQ4CYViiNhZkpvQOKCI1B861r9+vBMmCAltMfNAG0EWC16VRsZ374E
	 li9D5NFmrwwqJahFvte8VgE3i2JHIzy5dDITfjE6oxD8pcR7iSH+uDVnGhS5gpUskz
	 O7CzPh5B6mNdnR9lSMOG/fmKVUCV19e1tCExKc/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392269AbfBRONK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:13:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392215AbfBRONF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:13:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5748218AD;
        Mon, 18 Feb 2019 14:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499185;
        bh=CJ7L/Etu0IvEAsMZnh3FnPSE5ugBj+HHjrGxbpr3cgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZQ4yLDH1K8io6arYBw6Xyhm7iJNcluRvJ93TsJN0RLKJHzg1udDMQw6BBpxsvuVQ
         o9IY7zsVACqTA38jZyPqxHsv241yj9qZ/iUIRQXHvIAK2tDzPOfSQLgedKuvJGHEOY
         kZuZh7TB4MaNd+835M/h25l1DcW/WjBslmD0ktOs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 3.18 079/108] debugfs: fix debugfs_rename parameter checking
Date:   Mon, 18 Feb 2019 14:44:15 +0100
Message-Id: <20190218133523.182186159@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -622,6 +622,13 @@ struct dentry *debugfs_rename(struct den
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
 	if (!old_dir->d_inode || !new_dir->d_inode)


