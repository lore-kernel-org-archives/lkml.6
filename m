Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22361C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC36E20844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761898;
	bh=7bj5jtkY5PtTm5DRLbzQex9pitepWEky4hV5g1bQ4q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YetNwGbyKvHLaaN44c0PfclQxyyGjJ6DzoV0cPCeiukeoXEYQ1XvYIR7BwgKh0Y58
	 u+kaoXnGexFsEkM1QVuS9nFQkzZBDgqLHr/0bT0XK78xcREWyoU3Guty3NMXP63jjr
	 l+mK5jCvTyIMaq/KD++0+iKWDlMgLWHPDU8ASPkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfA2LiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:38:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:54904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729077AbfA2LiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:38:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 148A7214DA;
        Tue, 29 Jan 2019 11:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761893;
        bh=7bj5jtkY5PtTm5DRLbzQex9pitepWEky4hV5g1bQ4q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R8lsbZyP7PQtySyarhQOb6iwdPb2uGWig1fh6rlS8Amfwf+WWBzA8F+ddrKvRJBNL
         sZqxVg8VHTaNmumcB/eAnj1U5BtdTpX/irX2s0wrfFsD8DhINK0KR58yYEfzDazRXF
         vo63tAE2ssqyWLG2121Df2Ka4kpil4hUxpeTtaH8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4.20 038/117] inotify: Fix fd refcount leak in inotify_add_watch().
Date:   Tue, 29 Jan 2019 12:34:49 +0100
Message-Id: <20190129113209.511602872@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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


