Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1ECC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E6820882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762225;
	bh=S405Nio0cPrc1jeD32TVs3mVSOHJ8Ptem3hfuKN9w9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UT/MbXOjQYeBQgTc/bfG+L3tDaiLK9cqf8EdHcP/RkP32yEnLAjwtIj4K8ee+IXIM
	 AF/7z/i4G7QkXhGvQIjIm7BJawy7sSZhEE/+Xtjkc69WI3cmGXQjS4ugY7+tPhJWPU
	 UKXBavfWTfaZT4rNVuNLR5y30Tg2IVcXgeRuUceA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbfA2Lno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:43:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:33690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729882AbfA2Lnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:43:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3772D20882;
        Tue, 29 Jan 2019 11:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762221;
        bh=S405Nio0cPrc1jeD32TVs3mVSOHJ8Ptem3hfuKN9w9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJqbqMIM9n3l6gsXtotoinY0OpcKJbPHf5DdN2vqerlO2QOg20dvCzyGLMc0qUBi1
         5SHCxfuPGGnQOJWBihy7mIic7/pomejWluKii4aI+n7dckiD7oKfFHletC5Ct48SYL
         RC8T84WooIuy6VVTYAJHhyrJrW/XB748Gaka3548=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4.19 033/103] inotify: Fix fd refcount leak in inotify_add_watch().
Date:   Tue, 29 Jan 2019 12:35:10 +0100
Message-Id: <20190129113201.551200774@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 125892edfe69915a227d8d125ff0e1cd713178f4 upstream.

Commit 4d97f7d53da7dc83 ("inotify: Add flag IN_MASK_CREATE for
inotify_add_watch()") forgot to call fdput() before bailing out.

Fixes: 4d97f7d53da7dc83 ("inotify: Add flag IN_MASK_CREATE for inotify_add_watch()")
CC: stable@vger.kernel.org
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/notify/inotify/inotify_user.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -724,8 +724,10 @@ SYSCALL_DEFINE3(inotify_add_watch, int,
 		return -EBADF;
 
 	/* IN_MASK_ADD and IN_MASK_CREATE don't make sense together */
-	if (unlikely((mask & IN_MASK_ADD) && (mask & IN_MASK_CREATE)))
-		return -EINVAL;
+	if (unlikely((mask & IN_MASK_ADD) && (mask & IN_MASK_CREATE))) {
+		ret = -EINVAL;
+		goto fput_and_out;
+	}
 
 	/* verify that this is indeed an inotify instance */
 	if (unlikely(f.file->f_op != &inotify_fops)) {


