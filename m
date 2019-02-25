Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A65C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF4B21841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130602;
	bh=UWQktnvDxUE1dE0K4PGkVzwcAGdrfQvqd5+wvSAO7Yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Q0mZ6dDWmDPOhMhE4iBVTCBAbqzAysU8fU7+Z/Wy5+YuK9Nb9YkNjHKM/vw3U394
	 uHaLpKEWip427HTZzIxEM6E5wUv4yHyOBLHJyC167kxOuPwR0F+zpzwZZSKTrFabwR
	 6oKQc2dmW2x3JmfVny7TczrWArKA33XFBnwiDCOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbfBYVgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:36:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733206AbfBYVgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:36:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A972217F5;
        Mon, 25 Feb 2019 21:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130596;
        bh=UWQktnvDxUE1dE0K4PGkVzwcAGdrfQvqd5+wvSAO7Yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OsyjrtmX91GimMRD3v7XK6nXVwHzhLxRiryIRwgcEfDKIbzPOjiwrz4xL+2vUsI3d
         F7wwePSvvpJinQnSTLez+NbUI4GSOMJ77hwZUXId/GqA41DQlugGrJU+Z6yAvggPBn
         x5oKVUYHtn9PP074XUvoftih1HsTvuiWDXOVZ550=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 4.20 170/183] staging: erofs: remove the redundant d_rehash() for the root dentry
Date:   Mon, 25 Feb 2019 22:12:23 +0100
Message-Id: <20190225195123.811715524@linuxfoundation.org>
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

From: Gao Xiang <gaoxiang25@huawei.com>

commit e9c892465583c8f42d61fafe30970d36580925df upstream.

There is actually no need at all to d_rehash() for the root dentry
as Al pointed out, fix it.

Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/erofs/super.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -442,12 +442,6 @@ static int erofs_read_super(struct super
 
 	erofs_register_super(sb);
 
-	/*
-	 * We already have a positive dentry, which was instantiated
-	 * by d_make_root. Just need to d_rehash it.
-	 */
-	d_rehash(sb->s_root);
-
 	if (!silent)
 		infoln("mounted on %s with opts: %s.", dev_name,
 			(char *)data);


