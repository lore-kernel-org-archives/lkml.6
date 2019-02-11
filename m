Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EF5C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75892218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900413;
	bh=E8xfGsJuPtt/9/J/WgB9uCyaXhkDXxHGjH8F0jV3js4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dSSLk78RhAOEdM+bMftmrRHPnCKBimm1eNumsoB8YFpbF/R58Zxyj2uhdGVRXWM5T
	 wmXfl26SNttEWHl1YLT8WbfNR9sbO81f2X8UtqSl1TWyC8hcQDaGfvOxoZ9O3Jmbt8
	 jNTSsepssqrLdD8r1L9r/09IL/piIlgNkjOI8qZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfBKPxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:53:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:45566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731249AbfBKOg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:36:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FD4E2080F;
        Mon, 11 Feb 2019 14:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895787;
        bh=E8xfGsJuPtt/9/J/WgB9uCyaXhkDXxHGjH8F0jV3js4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hDWZ3Z3Zqk3M/ZURUlzGXpKWXLhvycK6QX7Y/SjcbRWAcpAZEPDmfgZoRTlKVhWOq
         Ybaah4Rku8oYg2Gloi7IEazIARNamFLzPTv/xXahbmc4AGtVdUXXAwAj7VmRDm1r8W
         N/Jn0RkVLFa3uJkBAu/E0MCMClkBbdZltbbLGlqo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Steinmetz <ast@domdv.de>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.20 323/352] cuse: fix ioctl
Date:   Mon, 11 Feb 2019 15:19:10 +0100
Message-Id: <20190211141907.390871565@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

From: Miklos Szeredi <mszeredi@redhat.com>

commit 8a3177db59cd644fde05ba9efee29392dfdec8aa upstream.

cuse_process_init_reply() doesn't initialize fc->max_pages and thus all
cuse bases ioctls fail with ENOMEM.

Reported-by: Andreas Steinmetz <ast@domdv.de>
Fixes: 5da784cce430 ("fuse: add max_pages to init_out")
Cc: <stable@vger.kernel.org> # v4.20
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -628,6 +628,7 @@ void fuse_conn_init(struct fuse_conn *fc
 	get_random_bytes(&fc->scramble_key, sizeof(fc->scramble_key));
 	fc->pid_ns = get_pid_ns(task_active_pid_ns(current));
 	fc->user_ns = get_user_ns(user_ns);
+	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
 
@@ -1162,7 +1163,6 @@ static int fuse_fill_super(struct super_
 	fc->user_id = d.user_id;
 	fc->group_id = d.group_id;
 	fc->max_read = max_t(unsigned, 4096, d.max_read);
-	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 
 	/* Used by get_root_inode() */
 	sb->s_fs_info = fc;


