Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B381C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451B4208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqDzAVis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451B4208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbeKTDFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:05:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732502AbeKTDF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:05:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C23E52147D;
        Mon, 19 Nov 2018 16:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645679;
        bh=zVn+godcIX4KLYKR3jOSq917vwDofMoATu/FdzMhf/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oqDzAVisCWOcRj59csupuMpzFwAQTwOqx4QOQaYLi5oLE0d4ap3yweUmTs/RfEjvO
         ib6z6yJOrEi4+30ZcUXtrImAo6IxsUO8zYurdWl2dXqivVLc6bFPEBxvM398KgISbb
         BwDmmRhus+5e2fuB2Osz8y0jWzGZoXnUgzF9WxBw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+3ef5c0d1a5cb0b21e6be@syzkaller.appspotmail.com,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.18 049/171] ovl: fix recursive oi->lock in ovl_link()
Date:   Mon, 19 Nov 2018 17:27:25 +0100
Message-Id: <20181119162627.747388652@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
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

commit 6cd078702f2f33cb6b19a682de3e9184112f1a46 upstream.

linking a non-copied-up file into a non-copied-up parent results in a
nested call to mutex_lock_interruptible(&oi->lock). Fix this by copying up
target parent before ovl_nlink_start(), same as done in ovl_rename().

~/unionmount-testsuite$ ./run --ov -s
~/unionmount-testsuite$ ln /mnt/a/foo100 /mnt/a/dir100/

 WARNING: possible recursive locking detected
 --------------------------------------------
 ln/1545 is trying to acquire lock:
 00000000bcce7c4c (&ovl_i_lock_key[depth]){+.+.}, at:
     ovl_copy_up_start+0x28/0x7d
 but task is already holding lock:
 0000000026d73d5b (&ovl_i_lock_key[depth]){+.+.}, at:
     ovl_nlink_start+0x3c/0xc1

[SzM: this seems to be a false positive, but doing the copy-up first is
harmless and removes the lockdep splat]

Reported-by: syzbot+3ef5c0d1a5cb0b21e6be@syzkaller.appspotmail.com
Fixes: 5f8415d6b87e ("ovl: persistent overlay inode nlink for...")
Cc: <stable@vger.kernel.org> # v4.13
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
[amir: backport to v4.18]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/dir.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -665,6 +665,11 @@ static int ovl_link(struct dentry *old,
 	if (err)
 		goto out_drop_write;
 
+	err = ovl_copy_up(new->d_parent);
+	if (err)
+		goto out_drop_write;
+
+
 	err = ovl_nlink_start(old, &locked);
 	if (err)
 		goto out_drop_write;


