Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B84C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF8120645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3dD7Fs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF8120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbeJICF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbeJICFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:05:54 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91437204FD;
        Mon,  8 Oct 2018 18:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024766;
        bh=Je1ablLGKzEcNPpJgK25BJ9jYBkeBP6HwFyBZOLAJcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q3dD7Fs4CkGDtF3jSK+XRaAdM3MqIYGCiIHzV4xTPXBfpcXQCQ/bMuKT3tBIzFaat
         1RN8ISkeDEun1K8rVrZCd/uEd/9DZ9hEnPe3gVAmxAoX3AWUDqbG8j+3cKMlbKi5Se
         WKt9JRmTWqvVOFwe5ob7ZTd+7dczQuf//DL6K3w8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+376cea2b0ef340db3dd4@syzkaller.appspotmail.com,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.18 147/168] ovl: fix access beyond unterminated strings
Date:   Mon,  8 Oct 2018 20:32:07 +0200
Message-Id: <20181008175625.617911409@linuxfoundation.org>
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

From: Amir Goldstein <amir73il@gmail.com>

commit 601350ff58d5415a001769532f6b8333820e5786 upstream.

KASAN detected slab-out-of-bounds access in printk from overlayfs,
because string format used %*s instead of %.*s.

> BUG: KASAN: slab-out-of-bounds in string+0x298/0x2d0 lib/vsprintf.c:604
> Read of size 1 at addr ffff8801c36c66ba by task syz-executor2/27811
>
> CPU: 0 PID: 27811 Comm: syz-executor2 Not tainted 4.19.0-rc5+ #36
...
>  printk+0xa7/0xcf kernel/printk/printk.c:1996
>  ovl_lookup_index.cold.15+0xe8/0x1f8 fs/overlayfs/namei.c:689

Reported-by: syzbot+376cea2b0ef340db3dd4@syzkaller.appspotmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: 359f392ca53e ("ovl: lookup index entry for copy up origin")
Cc: <stable@vger.kernel.org> # v4.13
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/namei.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -705,7 +705,7 @@ struct dentry *ovl_lookup_index(struct o
 			index = NULL;
 			goto out;
 		}
-		pr_warn_ratelimited("overlayfs: failed inode index lookup (ino=%lu, key=%*s, err=%i);\n"
+		pr_warn_ratelimited("overlayfs: failed inode index lookup (ino=%lu, key=%.*s, err=%i);\n"
 				    "overlayfs: mount with '-o index=off' to disable inodes index.\n",
 				    d_inode(origin)->i_ino, name.len, name.name,
 				    err);


