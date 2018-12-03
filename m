Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785DDC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB792087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh59UhBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB792087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeLCQkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:40:23 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:46739 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeLCQkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:40:23 -0500
Received: by mail-wr1-f45.google.com with SMTP id l9so12880614wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 08:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Rvv85QdVKxXGyI641PsDtzvo6kkGOs1L4PDQmCbv/oI=;
        b=eh59UhBKbMXqLDvo9804PoBhRY0csaV+xIz4d8oqv5mnSrvfZ8tnlObVYGXCoJkSwm
         Tb7IGkQSY4NzY/sClyJEteII099nfQOIC5nfIEno/Gl5nKv4AIBjQBlfT4f+jXZpRtx1
         QeJ/NwpJXnRpjDp1L5B0bj95DKX6AXiRmwv9oWaJ6tewvBZT6jZ07N00YJQOWFIQJ8UZ
         K9sBNTfkUHl+NrrF0WYVyXQcsObD3f4EfRgJ9XNyWTI+zw0+DDy0PWjab8N+UkMErd+s
         YOHyEgl/TZ8K0ZbSZMEMXAnnf9H40cL702cX7EVzR7dpOm0iW9o+6ZtGFp+jTB731N01
         6bKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Rvv85QdVKxXGyI641PsDtzvo6kkGOs1L4PDQmCbv/oI=;
        b=rKoC2BFk8QWbdtvSqPRVSc60QpXPEQi+O+kBbPSQDstLfmr5Ew6A2a9HbSsQcin8wC
         XdV5+ss2UVbRgZm1tBnUsZjlNozN1CUY+UsHeotACg0nbyIkiG5HojQAVX+OnrOGK4Mp
         R0dS3dVvi3lCUDbQLyFF468OyzSRr44PO4rAMu/CrNkQPWRjIxKhn8XfK0W6w+HFk8zH
         40xxwHa7VHIHa4UFqfOkGLfeR6M8QP+Tcz7C8y5rEW/gGDLNBDui3cQXKALV8Ckaz9XV
         xHzx9XwkMI8/No+crtzKa0j+q33inzUtnIcyWImYhTryXnoRW11ywBT5XusswU5o2cg5
         +yvg==
X-Gm-Message-State: AA+aEWYwmVbLT/92VAAIDcX2TkQv4eUHqRswJNducO4RYCkIj78xkHzb
        NcOvBjzhNx67zxE1mKPn3CurBNU=
X-Google-Smtp-Source: AFSGD/WAS0NhZODkcWC5frAahy2tMQFX2umLwvx7OS/7Eo7/KIiI70Ic2Y+2Nqb/gkFaTLALmhpVxA==
X-Received: by 2002:adf:f58f:: with SMTP id f15mr15888513wro.231.1543855217844;
        Mon, 03 Dec 2018 08:40:17 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id 4sm13788422wra.73.2018.12.03.08.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 08:40:17 -0800 (PST)
Date:   Mon, 3 Dec 2018 19:40:15 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: delete unnecessary variable in proc_alloc_inode()
Message-ID: <20181203164015.GA6904@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/inode.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -59,7 +59,6 @@ static struct kmem_cache *pde_opener_cache __ro_after_init;
 static struct inode *proc_alloc_inode(struct super_block *sb)
 {
 	struct proc_inode *ei;
-	struct inode *inode;
 
 	ei = kmem_cache_alloc(proc_inode_cachep, GFP_KERNEL);
 	if (!ei)
@@ -71,8 +70,7 @@ static struct inode *proc_alloc_inode(struct super_block *sb)
 	ei->sysctl = NULL;
 	ei->sysctl_entry = NULL;
 	ei->ns_ops = NULL;
-	inode = &ei->vfs_inode;
-	return inode;
+	return &ei->vfs_inode;
 }
 
 static void proc_i_callback(struct rcu_head *head)
