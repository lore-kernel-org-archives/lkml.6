Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FFCC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DB8208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eLjlOtoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DB8208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeHYBbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 21:31:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37755 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbeHYBbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 21:31:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id h69-v6so5116478pfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 14:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=VNEkxXkidzEHAxkFpWfrQAsxp/W61/akgxbHxyGhhmQ=;
        b=eLjlOtoelXrkCSQuQb5parmbEJFJf6zD7OFGPfXpRVl2LYemyl6hL+lHBaETMFk2zV
         KxbsL3apHX8Wzmayla7ijBIMgdeOYK1C+QIOypsguFEciJHdvreNrrPrN5VaVGslxVev
         kOT6afOX/QyAT6kShNvqvq6bstmyKaDKeyYOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=VNEkxXkidzEHAxkFpWfrQAsxp/W61/akgxbHxyGhhmQ=;
        b=A9o9bAC4VpiXtDQwJiIxDTJkKEYZWlaGLFLUW57lyUHyDC4qfCbIVXWDoOXbeLcBKS
         ucDu6MOIAO+01SqALLtm5qZtRN7knz5YHHBfOQzffyIq9FSY9zQHBPxjtBq7zUNlFasi
         O9bzWKi1w6WKZ+urDwyB4HJXnmzhdBrEf0H9tKQN3QHbP/veUccxs0uUr0j4HXaWHM4z
         URa6/IobGNVx9ahodpBXeszpVE/iO9ZEfh/nIfR5n71Pe73PgOG6T9/XrbJWQSRQ+Eck
         lWYhubIvtc826aCVerbdaaWvVArzKUSJ7C9c6y8Wxmz/hHAZ7sx9zvR+CupWLmlaS5Rz
         rDIw==
X-Gm-Message-State: APzg51A/NTSsUqilMTkJ/N+ucSxIShr75JP8B2keBZkUvxjMysKWLv62
        96NmeaqkHiwBsy3r2YUCMx9nkQ==
X-Google-Smtp-Source: ANB0VdaaftOGg0oyNtb8eyC6mf0rDodShDSgUfbXZisv2mPrc+AtISL222i8C55vUxClBInLC1KcwA==
X-Received: by 2002:a62:6547:: with SMTP id z68-v6mr3717201pfb.20.1535147681439;
        Fri, 24 Aug 2018 14:54:41 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id t14-v6sm9023166pgu.0.2018.08.24.14.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 14:54:40 -0700 (PDT)
Date:   Fri, 24 Aug 2018 14:54:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andreas Christoforou <andreaschristofo@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipc/mqueue: Only perform resource calculation if user valid
Message-ID: <20180824215439.GA46785@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Christoforou reported:

UBSAN: Undefined behaviour in ipc/mqueue.c:414:49 signed integer overflow:
9 * 2305843009213693951 cannot be represented in type 'long int'
...
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x11b/0x1fe lib/dump_stack.c:113
 ubsan_epilogue+0xe/0x81 lib/ubsan.c:159
 handle_overflow+0x193/0x218 lib/ubsan.c:190
 mqueue_evict_inode+0x8e7/0xa10 ipc/mqueue.c:414
 evict+0x472/0x8c0 fs/inode.c:558
 iput_final fs/inode.c:1547 [inline]
 iput+0x51d/0x8c0 fs/inode.c:1573
 mqueue_get_inode+0x8eb/0x1070 ipc/mqueue.c:320
 mqueue_create_attr+0x198/0x440 ipc/mqueue.c:459
 vfs_mkobj+0x39e/0x580 fs/namei.c:2892
 prepare_open ipc/mqueue.c:731 [inline]
 do_mq_open+0x6da/0x8e0 ipc/mqueue.c:771
...

Which could be triggered by:

        struct mq_attr attr = {
                .mq_flags = 0,
                .mq_maxmsg = 9,
                .mq_msgsize = 0x1fffffffffffffff,
                .mq_curmsgs = 0,
        };

        if (mq_open("/testing", 0x40, 3, &attr) == (mqd_t) -1)
                perror("mq_open");

mqueue_get_inode() was correctly rejecting the giant mq_msgsize,
and preparing to return -EINVAL. During the cleanup, it calls
mqueue_evict_inode() which performed resource usage tracking math for
updating "user", before checking if there was a valid "user" at all
(which would indicate that the calculations would be sane). Instead,
delay this check to after seeing a valid "user".

The overflow was real, but the results went unused, so while the flaw
is harmless, it's noisy for kernel fuzzers, and the fix makes things
technically more efficient.

Reported-by: Andreas Christoforou <andreaschristofo@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 ipc/mqueue.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index c0d58f390c3b..f31e334e3635 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -389,7 +389,6 @@ static void mqueue_evict_inode(struct inode *inode)
 {
 	struct mqueue_inode_info *info;
 	struct user_struct *user;
-	unsigned long mq_bytes, mq_treesize;
 	struct ipc_namespace *ipc_ns;
 	struct msg_msg *msg;
 
@@ -406,16 +405,18 @@ static void mqueue_evict_inode(struct inode *inode)
 	kfree(info->node_cache);
 	spin_unlock(&info->lock);
 
-	/* Total amount of bytes accounted for the mqueue */
-	mq_treesize = info->attr.mq_maxmsg * sizeof(struct msg_msg) +
-		min_t(unsigned int, info->attr.mq_maxmsg, MQ_PRIO_MAX) *
-		sizeof(struct posix_msg_tree_node);
-
-	mq_bytes = mq_treesize + (info->attr.mq_maxmsg *
-				  info->attr.mq_msgsize);
-
 	user = info->user;
 	if (user) {
+		unsigned long mq_bytes, mq_treesize;
+
+		/* Total amount of bytes accounted for the mqueue */
+		mq_treesize = info->attr.mq_maxmsg * sizeof(struct msg_msg) +
+			min_t(unsigned int, info->attr.mq_maxmsg, MQ_PRIO_MAX) *
+			sizeof(struct posix_msg_tree_node);
+
+		mq_bytes = mq_treesize + (info->attr.mq_maxmsg *
+					  info->attr.mq_msgsize);
+
 		spin_lock(&mq_lock);
 		user->mq_bytes -= mq_bytes;
 		/*
-- 
2.17.1


-- 
Kees Cook
Pixel Security
