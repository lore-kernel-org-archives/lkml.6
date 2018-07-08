Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1FBC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5292C20896
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fwi37R+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5292C20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933608AbeGHVHp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:07:45 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44738 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933324AbeGHVFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:05:42 -0400
Received: by mail-pf0-f193.google.com with SMTP id j3-v6so12135831pfh.11;
        Sun, 08 Jul 2018 14:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a2wznl5oLZXcPz1y+G5D1hGknQD6LHneUq0w1LKB0Wc=;
        b=Fwi37R+ks+FtZeW8z+s+Mqf/fU+N1eCcQ5UpObIxVFToT/CMNej4d7W0p1jYwLllES
         nDF6JVmRUzyu4vYP5BQDK2RldyXSrm2nDEnBKw5zQKUSB+CaCVhuTc5JHPFnh3PKnHem
         ysPrX3E8V7HQCHjvApWKmWU4jStz8b799ugOPlv017IpXjCul3FOFvXW2WksB2uv7+Eu
         Te3JlShS/LXL+4ArH9VHTXLhjUzAbt9F9XLqaTQ7HoE/HsWjIG7tdk4lAGoM7dU4U2mj
         rUMWX4iIvXjq0rbimIOocPOtedbFhYPTdEHhwl9YSqDkrFOPBKb9BsHaCg9J7ucBzJWY
         ixVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a2wznl5oLZXcPz1y+G5D1hGknQD6LHneUq0w1LKB0Wc=;
        b=MxJoxMWRt3JexBm9YJO7vjcM58Om8EAQO/mJIWMZLKQTxY9c5DsV3I+W+PFMie0LGd
         hHFAv5vUJKl2F7G9pJWkFzJ9m9hgOldR0UV/Vvc8TJ/smVYvYgHhiznhZWXg0uqAXS3G
         HGrwhiZmRuNVB2d0yL2PEeegTPMtdL22rvssC+L6vTo+M/6QNsZ0GTa7wB7s+vth+lPu
         6Cn2lzGmzqh+/KL1tRy3URHSJAB0iZkvc6JWFFoaPv9mkwBJa1/GNyUr2DA0reHY2l8m
         17qU/1GHLjR8RlwnaVBu5Alt+R70zgQzs6BRV7EAmZRd3wG3ZumqTBccVpFH56t0PssM
         VCvw==
X-Gm-Message-State: APt69E1ichjjvSnDMuG/pyAs9mGHCUDwtPrTHSN6mhcTnsq2m1d9ZTJX
        4HrhXjFwLc1ImPFwR5iHZwk=
X-Google-Smtp-Source: AAOMgpcNwJCd7dlpYxvJoznrtKZ8YprIJ+WmPgG3vKz71YnkYNEhV5IDkcN1gJOcAFVuTA+6VR2azg==
X-Received: by 2002:a62:fc5:: with SMTP id 66-v6mr14096610pfp.237.1531083942034;
        Sun, 08 Jul 2018 14:05:42 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x68-v6sm23355681pfb.138.2018.07.08.14.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:05:41 -0700 (PDT)
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 11/18] fspick: fix path leak
Date:   Sun,  8 Jul 2018 14:01:47 -0700
Message-Id: <20180708210154.10423-12-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708210154.10423-1-ebiggers3@gmail.com>
References: <20180708210154.10423-1-ebiggers3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Fixes: 99f8421020ac ("vfs: Implement fspick() to select a superblock for reconfiguration")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/fsopen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 8d6fa4ba8fb55..3e439299ddf79 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -301,7 +301,7 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
 
 	ret = -EOPNOTSUPP;
 	if (!target.dentry->d_sb->s_op->reconfigure)
-		goto err;
+		goto err_path;
 
 	fc = vfs_new_fs_context(target.dentry->d_sb->s_type, target.dentry,
 				0, FS_CONTEXT_FOR_RECONFIGURE);
-- 
2.18.0

