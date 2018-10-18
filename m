Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FF2ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BFB208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kzmpBCY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BFB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbeJSC6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:58:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45213 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbeJSC6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:58:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id s3-v6so1388019pga.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 11:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2pe3nNn7B9N+Ei+MFKikyclkE9Grlfg7U7x9Uj6mdS4=;
        b=kzmpBCY4pKk0W0I84IvKGc65g6FPHz1qC+qx0OiAaCWWqETc4K+KLdEY8MrKjVl7tj
         Iyp5kTbdJCuxKbOBMLhtHp3Je3tD9JtvPc0dyaPsmlgNtOxflQ/UaRVvEfl4dzwp+zZJ
         w2Xfa6EEuaLN3WWWPfhRBNwqXzHumBsO7JQVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2pe3nNn7B9N+Ei+MFKikyclkE9Grlfg7U7x9Uj6mdS4=;
        b=Nnvvs3Em8aVgy824YZOcRQyqr+eWaL37axh3rZZ1Cf61l/9Gddj96JmSx3+YxDps34
         B1ng+P9SxeU0NQo8sgHYU3kkQ3HyVVo9oksAbzVFaQAorPQbqY1kgNx3O4EVlf1jOhqt
         Dp6Ic/lWfcz1C5EI4iuOwMEki0tvypUQVisP4wABJExdg2WTYGJ0aqyZreOVZtaMS+Q1
         7owseddK9y2dUTBmwD8QmWlsDZzik/Z8UQILWEZI72LabTF/rb6Xv4ZzhYplNCZ4T0OZ
         ryjEp16OePy6QmfVlUvPdDADR6TWC43KTuycYRhiO86yF4pS77q1hM3/5VeJXyw/1KTc
         8/WQ==
X-Gm-Message-State: ABuFfohSQxUI/vmgRhSB3orR2ONRr2hf1DkhPVjje4VJ3UrE1dxxL2uQ
        r8lNvmhe/TU49lzbm98rHB0Mew==
X-Google-Smtp-Source: ACcGV60fVakS3r6dgzVHhI3FZDjmfUZFhRtA9+3AeJVxm0HY+/NbzlKsm6GcPfXhnxJSyMe4xD1mPw==
X-Received: by 2002:a62:7501:: with SMTP id q1-v6mr31324020pfc.225.1539888985221;
        Thu, 18 Oct 2018 11:56:25 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id c24-v6sm31980937pgn.60.2018.10.18.11.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 11:56:19 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH pstore-next v2 1/4] pstore: Centralize init/exit routines
Date:   Thu, 18 Oct 2018 11:56:13 -0700
Message-Id: <20181018185616.14768-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018185616.14768-1-keescook@chromium.org>
References: <20181018185616.14768-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for having additional actions during init/exit, this moves
the init/exit into platform.c, centralizing the logic to make call outs
to the fs init/exit.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/inode.c    | 11 ++---------
 fs/pstore/internal.h |  5 +++--
 fs/pstore/platform.c | 23 +++++++++++++++++++++++
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 5fcb845b9fec..8cf2218b46a7 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -482,12 +482,10 @@ static struct file_system_type pstore_fs_type = {
 	.kill_sb	= pstore_kill_sb,
 };
 
-static int __init init_pstore_fs(void)
+int __init pstore_init_fs(void)
 {
 	int err;
 
-	pstore_choose_compression();
-
 	/* Create a convenient mount point for people to access pstore */
 	err = sysfs_create_mount_point(fs_kobj, "pstore");
 	if (err)
@@ -500,14 +498,9 @@ static int __init init_pstore_fs(void)
 out:
 	return err;
 }
-module_init(init_pstore_fs)
 
-static void __exit exit_pstore_fs(void)
+void __exit pstore_exit_fs(void)
 {
 	unregister_filesystem(&pstore_fs_type);
 	sysfs_remove_mount_point(fs_kobj, "pstore");
 }
-module_exit(exit_pstore_fs)
-
-MODULE_AUTHOR("Tony Luck <tony.luck@intel.com>");
-MODULE_LICENSE("GPL");
diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
index fb767e28aeb2..98bb4fa6e6a7 100644
--- a/fs/pstore/internal.h
+++ b/fs/pstore/internal.h
@@ -37,7 +37,8 @@ extern bool	pstore_is_mounted(void);
 extern void	pstore_record_init(struct pstore_record *record,
 				   struct pstore_info *psi);
 
-/* Called during module_init() */
-extern void __init pstore_choose_compression(void);
+/* Called during pstore init/exit. */
+int __init	pstore_init_fs(void);
+void __init	pstore_exit_fs(void);
 
 #endif
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 15e99d5a681d..d61e26812af6 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -780,8 +780,31 @@ void __init pstore_choose_compression(void)
 	}
 }
 
+static int __init pstore_init(void)
+{
+	int ret;
+
+	pstore_choose_compression();
+
+	ret = pstore_init_fs();
+	if (ret)
+		return ret;
+
+	return 0;
+}
+module_init(pstore_init)
+
+static void __exit pstore_exit(void)
+{
+	pstore_exit_fs();
+}
+module_exit(pstore_exit)
+
 module_param(compress, charp, 0444);
 MODULE_PARM_DESC(compress, "Pstore compression to use");
 
 module_param(backend, charp, 0444);
 MODULE_PARM_DESC(backend, "Pstore backend to use");
+
+MODULE_AUTHOR("Tony Luck <tony.luck@intel.com>");
+MODULE_LICENSE("GPL");
-- 
2.17.1

