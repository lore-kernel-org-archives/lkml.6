Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D35C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61852175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="DcsLqm07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbfA1RLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:11:51 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40402 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731968AbfA1RLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:11:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so13640876edr.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 09:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dqkRLJwycOZaBeHT2bTXLK850dqnbWqpyFavVlWZuKE=;
        b=DcsLqm07CZbcVI1hVmgbMfjvoa8E48Uv22C85WcucmXu+dy5r0a0BBBfZrpHC07bSy
         aYUtGoZG6Jv5VfmGTI96kcwSCErmpynwEFYY6y7XVorZaObZuqwVYD7+XOZWDkRjh30c
         jzRItwHjsWdIsN1ElsxMks52JJBRxFDuxJy4i0VYOjmrdrL8o5oToaSPoGH8ukYXEaGj
         SaxkQ+gnHBiGvliLv53wzAe57cpqOyCRqksUoO1ZUECZsOaB941adlGCjukOapOa96fi
         iPrdMrZS9Jbn6eLNKCaK7Cmdl7gGJcorQOVa4MZRyLKQM9D+88axQfusR6UjW/8PyHBR
         2L3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dqkRLJwycOZaBeHT2bTXLK850dqnbWqpyFavVlWZuKE=;
        b=XyJXj6EPPErlxZKvDdZW+10HP3m6qkJvMkcRO/hqkOmsxnJc2RnLfGlTfmkJTmlrEO
         /W1ysIJwqmw6ALpjrju7dpCUSy9w3loViHcRbhXscPrpGCqa4cnfEveatPPyhe80FYjF
         TrvphNTnwErH7rR1Ci2hXqdHTWmF8oBgg1gDcsoksn29Js+thbQdbMSPM79LvlYw78gx
         uFdTWiUEAEKd7VSx93EwNu3Hv318vKPYjTd+0EGylqrRPNXJPgzSbIHJGq33E69HKsZr
         zNMWBZTwAuGX5fwVl8OJLFETY3dpameckddQHHn03Fw12HCd6F6SLPGWY5rfTHoG8KT9
         DuNQ==
X-Gm-Message-State: AJcUukeuRtapxOpBc6BeQS9sSbTLEpa0jLJDyOsJ6T1fK0S71ZHAltRv
        Gac8hfoMKB08abD1JpGEbX1rWZlfrcCKJw==
X-Google-Smtp-Source: ALg8bN58AXRgoam3UUpDoX6Q4zLHNt4RErbLiGABDIqi0h3Xxhx/D43XHhaMtUput7cJXkWTMfTILg==
X-Received: by 2002:a17:906:6d46:: with SMTP id a6mr18631038ejt.203.1548695501432;
        Mon, 28 Jan 2019 09:11:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6bf:f9e4:2130:3a9e:3894:d6a6])
        by smtp.gmail.com with ESMTPSA id l51sm13989804edb.36.2019.01.28.09.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 09:11:40 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, ebiederm@xmission.com,
        ebiggers@google.com, willy@infradead.org, dhowells@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 2/2] devpts: simplify devpts_fill_super()
Date:   Mon, 28 Jan 2019 18:11:33 +0100
Message-Id: <20190128171133.539-2-christian@brauner.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128171133.539-1-christian@brauner.io>
References: <20190128171133.539-1-christian@brauner.io>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When devpts_fill_super() fails deactivate_locked_super() will cleanup
dentries for us so there's no need to do that work in devpts_fill_super()
itself. This allows us to simplify that function quite a bit.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christian Brauner <christian@brauner.io>
---
 fs/devpts/inode.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 8fa1492f9712..59b7625a2110 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -450,19 +450,18 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
 	s->s_op = &devpts_sops;
 	s->s_time_gran = 1;
 
-	error = -ENOMEM;
 	s->s_fs_info = new_pts_fs_info(s);
 	if (!s->s_fs_info)
-		goto fail;
+		return -ENOMEM;
 
 	error = parse_mount_options(data, PARSE_MOUNT, &DEVPTS_SB(s)->mount_opts);
 	if (error)
-		goto fail;
+		return error;
 
-	error = -ENOMEM;
 	inode = new_inode(s);
 	if (!inode)
-		goto fail;
+		return -ENOMEM;
+
 	inode->i_ino = 1;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO | S_IWUSR;
@@ -473,19 +472,10 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
 	s->s_root = d_make_root(inode);
 	if (!s->s_root) {
 		pr_err("get root dentry failed\n");
-		goto fail;
+		return -ENOMEM;
 	}
 
-	error = mknod_ptmx(s);
-	if (error)
-		goto fail_dput;
-
-	return 0;
-fail_dput:
-	dput(s->s_root);
-	s->s_root = NULL;
-fail:
-	return error;
+	return mknod_ptmx(s);
 }
 
 /*
-- 
2.20.1

