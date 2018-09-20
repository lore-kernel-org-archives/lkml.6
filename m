Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8446C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE8621526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE8621526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387640AbeITU4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:56:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34742 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732302AbeITU4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:56:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id t15so1872952wrx.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WtmReosd4GA07GtJdxNb9bOVWt1Zeu6Sxj30CYjenFo=;
        b=emw9GWLiW5/MPz6VewRMvvuUiK8IC/gGQGe831jHfs9HUPbmd1jidnFAvnLA+fecKd
         R8i1gsIhU5FL9ZcRZMD4mihLm5D0i15K6423e6nou9LzASffr5R0aTw9bTLqpy5PB1LR
         a3rfHhYRwP/Dj2pundNDmMRTYDmwlg+opt4QdvRM/J/PEm3AHsC2uURdxIUvn3DML/rq
         novBSnWYMnS9NRqO4QhLsRXDhLRskbje+4SU1+lyvRpEa1Ta0/gfCbiR19aTOmW98OK/
         Qrg4JcEKAs+rADJP7Ft6UqqpPcTIhv1hVsnQGvzuH1M/zVzGDd/AQzHoReotPYSeHDj9
         kdag==
X-Gm-Message-State: APzg51CBuCYQQvo2t0sAEudi+9eCb5AaQz6sLYVkL3nn8c7VMIpIXzLQ
        yNVC2LCwmXUCcQkERYjPWxOtoA==
X-Google-Smtp-Source: ANB0VdbOQNl4gXK+wKNb02yVlcxj9w8JLKEhPgrcq/K7pk1MYzv++Cx+ILmegRfdCJ+matlCv9HOgA==
X-Received: by 2002:adf:8385:: with SMTP id 5-v6mr20455436wre.13.1537456341176;
        Thu, 20 Sep 2018 08:12:21 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id p89-v6sm55286201wrc.97.2018.09.20.08.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 08:12:20 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] selinux: fold superblock_doinit() into only caller
Date:   Thu, 20 Sep 2018 17:12:09 +0200
Message-Id: <20180920151214.15484-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180920151214.15484-1-mszeredi@redhat.com>
References: <20180920151214.15484-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...and remove the unused option parsing part as well.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 security/selinux/hooks.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 99c2c40c5d7a..1069acea2682 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1199,33 +1199,6 @@ static int selinux_parse_opts_str(char *options,
 	kfree(rootcontext);
 	return rc;
 }
-/*
- * string mount options parsing and call set the sbsec
- */
-static int superblock_doinit(struct super_block *sb, void *data)
-{
-	int rc = 0;
-	char *options = data;
-	struct security_mnt_opts opts;
-
-	security_init_mnt_opts(&opts);
-
-	if (!data)
-		goto out;
-
-	BUG_ON(sb->s_type->fs_flags & FS_BINARY_MOUNTDATA);
-
-	rc = selinux_parse_opts_str(options, &opts);
-	if (rc)
-		goto out_err;
-
-out:
-	rc = selinux_set_mnt_opts(sb, &opts, 0, NULL);
-
-out_err:
-	security_free_mnt_opts(&opts);
-	return rc;
-}
 
 static void selinux_write_opts(struct seq_file *m,
 			       struct security_mnt_opts *opts)
@@ -7370,7 +7343,15 @@ static __init int selinux_init(void)
 
 static void delayed_superblock_init(struct super_block *sb, void *unused)
 {
-	superblock_doinit(sb, NULL);
+{
+	int rc;
+	struct security_mnt_opts opts;
+
+	security_init_mnt_opts(&opts);
+	rc = selinux_set_mnt_opts(sb, &opts, 0, NULL);
+	security_free_mnt_opts(&opts);
+
+	return rc;
 }
 
 void selinux_complete_init(void)
-- 
2.14.3

