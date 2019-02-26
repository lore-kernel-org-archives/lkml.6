Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940BCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FBB2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="UHeb8zm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfBZJRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:17:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34504 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfBZJRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:17:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id u9so5946667pfn.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 01:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ztscVq4z5BTPInE2tWkxuPW/sMvih/UYrxwJECBL7lg=;
        b=UHeb8zm8QrNsExz9A/mnZwDKwmvj0xFLZHIQi2xe9knsk2TOAgw9A4w+1KQEvEu9Sc
         eUkmfl+TotqS6RnltyJLMfsYAPLhE8ZNs+m/V6IeJ4CNK+slA/PGVUj4NWfw/v6QyldH
         2y3ceoa/Lp9qZK2lxdxdCJjCT3aNG45ZDgayp7aHEEHa98twnaoeCqSDoxhRE/emyRv+
         Vfsf2hWfTri7M2x/sT/JdbdCqZQeqlCd+zr18seQNJV/4fOr67gsqDnjUVGvvtCe8N+b
         TrG0MMYl5SfWa4IVgNyLtanlw+KYdSfifWhX2NXb2jqkJ3pnjFtTKt1LK8Ye/YHaYERP
         UW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ztscVq4z5BTPInE2tWkxuPW/sMvih/UYrxwJECBL7lg=;
        b=b3deBL89rbBwKJFhlo7BAT1+ROihPD+4lFI2I9UWTKY7KRFH5V8efa08tmi6sVGrMZ
         flws4M4R4mYYAEYbpFv0GdZeG6Ag2S2ykD6dG2moNa3aL6uBrveLQJodO/X54vCB+q1W
         CmvLl97jtpvFbVVR/q3OSs96YRIQ7R1SBWJQV+Q/kO2FWxUaPp9FcKpBHmQUwCtPegzb
         lZALejm2duqbPzEZgdyPjnGirpdnumyRr57J9ECrfGQmtcWPBiCNHijd6ZZTwk0D9LmB
         G3ePknZxncwhQtYtEAvrYYnPMn5e4TOioBX1iY5SL3q0TwCpXEQ5C21b8Y591ipVh1I2
         GFCg==
X-Gm-Message-State: AHQUAuZn/ZztUFMXdkUJXswrZe3I49836wF1rRg9Jk4hyhhomVveDOLL
        UOuOIDTla87ypSrTZLcZQ2gsGw==
X-Google-Smtp-Source: AHgI3IYLXbNX6UKfXmg8BHgfTraw7/RBWIVCtQagj6Y0Crb4yFLzqi5adGrfDn3O3Zo8SXy8+BuOsA==
X-Received: by 2002:a65:5c01:: with SMTP id u1mr19921763pgr.197.1551172625534;
        Tue, 26 Feb 2019 01:17:05 -0800 (PST)
Received: from localhost ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id h126sm12934430pfc.135.2019.02.26.01.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 01:17:04 -0800 (PST)
From:   Fam Zheng <zhengfeiran@bytedance.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     fam@euphon.net, linux-kernel@vger.kernel.org (open list),
        duanxiongchun@bytedance.com, viro@zeniv.linux.org.uk
Subject: [PATCH] devpts: Use simple_dentry_operations
Date:   Tue, 26 Feb 2019 17:17:02 +0800
Message-Id: <20190226091702.7104-1-zhengfeiran@bytedance.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this, the pty dentry is dropped once we d_delete it. This makes
sense since in devpts_pty_new we always create a new dentry with
d_alloc_name().  Previously, without providing a .op_delete, we would
end up leaving garbage in dentry_hashtable.

As a matter of fact, the d_hash of the garbage are likely to collide
because pty numebers are allocated as mall integers. Therefore, a few
chains in the hashtable get polluted more easily and path lookups
hitting them get slowed down.  In a long running system which has an
application that frequently creates and destroys ptys, those chains can
get very long (thousands or millions of unused dentry), which seriously
hurts d_alloc_parallel() in which there is a seq based retry logic.
Specifically, we have seen a system that has accumulated 7 million pty
dentries (for /dev/pts/5) in a single chain, in dentry_hashtable. Some
other system monitoring progresses keep scanning /proc to get process
information, and occasionally a certain /proc/$pid path lookup made by
tem hits that long chain, making d_alloc_parallel stalled. In this case,
soft lockups are observed.

To emulate such a workload, do this:

        while echo > /dev/ptmx; true; done

In a few minutes the system will have a very unbalanced
dentry_hashtable.

This patch fixes the above issue.

Signed-off-by: Fam Zheng <zhengfeiran@bytedance.com>
---
 fs/devpts/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index c53814539070..ce43301f1219 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -456,6 +456,7 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
 	s->s_magic = DEVPTS_SUPER_MAGIC;
 	s->s_op = &devpts_sops;
 	s->s_time_gran = 1;
+	s->s_d_op = &simple_dentry_operations;
 
 	error = -ENOMEM;
 	s->s_fs_info = new_pts_fs_info(s);
-- 
2.11.0

