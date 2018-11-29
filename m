Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C91C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D6E2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZdY3Mcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D6E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeK2WNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:13:32 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39057 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbeK2WNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:13:32 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so2973017itl.4;
        Thu, 29 Nov 2018 03:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V12m41CQzLWjUwVDDxkJ+GZnM7a0NiONeidPa/y1C74=;
        b=SZdY3McpSzmXWk2Eowgf56AhEgjkxkp5L2VjkvPxusOwhAwJIluk1QZs+5Y1D2lCGy
         +fpL262m7cVAkPOmWWZ209O71upXL4ipD4ERpQSt3lEFNElCkMHnZA86rKQ7XogVcCN3
         lvaNo8+gzUdSmNNlb6hoE0DC09nbx1Hox8Ntnfls3vrhgzrIfHIhqxTr7FHgy1HyXBMR
         Lsa+rHACoemGIkr8XX3RQfiGPLFK9ZaBOzCIQ3wWnxt6Y7a0Jh0ecTyfprgLSJbr+2lr
         TzLryg81/xzMxIxyUdI3jikMxv6kspqzXgW27thE1NEZ01MRQJVZ0v6uLXfw+60gAd5V
         eU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V12m41CQzLWjUwVDDxkJ+GZnM7a0NiONeidPa/y1C74=;
        b=Hhn3WpFnrytgvDXZAjKD3SO5704Q9Ykm/7HE4dBpaEAnYihD/ZcA39QbUkGn+PpAGD
         h4EuD26MVX6Kxhr4+be4iBqH5BjhhVmqM5a8sXsunZ26zM3Jz606TcqW4LLoitZystSo
         W0LL7srLWqVFLTUNyQYo4QqJq9xLqyd5VaklfbNW0KfNXuwXL/cACRl/xsoOcoAXcepf
         lKeODITK6ofdncqznzD5GWZdLyRZlvDrhAWmZtcAqdLv9Bf4RVRrA7IecuhInp0Ejmwd
         4xVSbCnaEfO7B8OGxQEEfETTQMK2c9fwWVgyAOS1Mj++UxsjmjdnJDuTW64BXYLjkGWG
         kSDA==
X-Gm-Message-State: AA+aEWaPOo3CLsgWzqQRyFrl7168J9IFdQcBbV1tggYtjuzB4k4y/WVn
        rGFVpUDhbJ0enixTxVX4EzM=
X-Google-Smtp-Source: AFSGD/UVmehTtkEldKsx8DDpvE2EP9ts38xq36050MpnHIcuZSS59JvFYh5PYV3Bht+/DwT/DN5v8A==
X-Received: by 2002:a02:3d42:: with SMTP id n63mr817722jan.136.1543489711713;
        Thu, 29 Nov 2018 03:08:31 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id w124-v6sm65867ita.0.2018.11.29.03.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 03:08:31 -0800 (PST)
From:   d17103513@gmail.com
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Davidlohr Bueso <dbueso@suse.de>
Cc:     Cheng Yang <chengyang@xiaomi.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] Security: Handle hidepid option correctly
Date:   Thu, 29 Nov 2018 19:08:21 +0800
Message-Id: <9da18eb4cb3701bd2da933e8e096c1ea6e9a44c1.1543472629.git.chengyang@xiaomi.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1543472629.git.chengyang@xiaomi.com>
References: <cover.1543472629.git.chengyang@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cheng Yang <chengyang@xiaomi.com>

The proc_parse_options() call from proc_mount() runs only once at boot
time.  So on any later mount attempt, any mount options are ignored
because ->s_root is already initialized.
As a consequence, "mount -o <options>" will ignore the options.  The
only way to change mount options is "mount -o remount,<options>".
To fix this, parse the mount options unconditionally.

Signed-off-by: Cheng Yang <chengyang@xiaomi.com>
---
 fs/proc/inode.c | 4 ----
 fs/proc/root.c  | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 5792f9e..ec509d1 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -493,13 +493,9 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 
 int proc_fill_super(struct super_block *s, void *data, int silent)
 {
-	struct pid_namespace *ns = get_pid_ns(s->s_fs_info);
 	struct inode *root_inode;
 	int ret;
 
-	if (!proc_parse_options(data, ns))
-		return -EINVAL;
-
 	/* User space would break if executables or devices appear on proc */
 	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
 	s->s_flags |= SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
diff --git a/fs/proc/root.c b/fs/proc/root.c
index f4b1a9d..f5f3bf3 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -98,6 +98,9 @@ static struct dentry *proc_mount(struct file_system_type *fs_type,
 		ns = task_active_pid_ns(current);
 	}
 
+	if (!proc_parse_options(data, ns))
+		return ERR_PTR(-EINVAL);
+
 	return mount_ns(fs_type, flags, data, ns, ns->user_ns, proc_fill_super);
 }
 
-- 
1.9.1

