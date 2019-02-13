Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53C9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91183222D8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083347;
	bh=1YtP3QatnmUnizcCk+fPx38C2e837vl2Ech11cJ4sec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BlH2Ui1WjJVBecTsELWvR0yoGNW/GP+3C0UNZO8qRCzOxTZ6hMLAIFb/d0iUsJmaY
	 bboXAMD6jIC9nowldPQtfgMS4snS0hGs8Ek40+wog7SpzsXoLYWAR2BeqNBk1wKL7K
	 LvFhrqECBbHjM6gla5I5AUfxrciSpN6i/w+g0wXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405660AbfBMSm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:42:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405649AbfBMSmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:42:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FC40222D8;
        Wed, 13 Feb 2019 18:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083343;
        bh=1YtP3QatnmUnizcCk+fPx38C2e837vl2Ech11cJ4sec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RMIWstQXGGzizxQn8rcQvGQlNXLytP55hsojja33rcSdrY96md2R5CL3q6LwqBDk+
         8HZ8uIvnWuEyi0xgM96VVHQmcWlfq7IhDFR3wNI1iWKLo+qttxHATVhULRallvilIS
         Em2mXF8+mOipp//mC2sSSYiPYHq7q9vRuRbDGXNs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.14 08/35] debugfs: fix debugfs_rename parameter checking
Date:   Wed, 13 Feb 2019 19:38:03 +0100
Message-Id: <20190213183706.571607396@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183706.176685027@linuxfoundation.org>
References: <20190213183706.176685027@linuxfoundation.org>
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
@@ -766,6 +766,13 @@ struct dentry *debugfs_rename(struct den
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


