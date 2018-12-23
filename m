Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9B7C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 14:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA30121783
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 14:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="I1uVFrUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeLWOmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 09:42:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32994 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeLWOmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 09:42:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so17636050wmh.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 06:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uHmgLw8FTyHNTT3FmZXPxlIQoUgBhbRFCHwRaw5fkgg=;
        b=I1uVFrUnieQN3vMdWBzAE3aUu94P8nZRk46dQB3/v6q78YJmjnFOJjm5EZvKSQJTDH
         z+aSW8svzLXubm9UnXXGjIVPoGSVK5nyFamklQkn1vNZKR4teuM4OTsXV/dp7paV+OoS
         dnb8s9BfNVwvXrGMqnoS05ZMNz8T0vmWI4RJZaYok6Rgs6Yi3SXXfwOHjVWX167gbrob
         n0ycIfDuGEQ5pnJhNPCHOkmEuXt6z576cMAYrUhkNfq62hGYQCp/RiiMZLeZDfl7QOWk
         OL8h1SpZFhL2W/GPpSapH2rFK4DV+5peN5NX4b8zlIBalFWeXl1jXx2GbfmZML2nEn+E
         U88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uHmgLw8FTyHNTT3FmZXPxlIQoUgBhbRFCHwRaw5fkgg=;
        b=CbZoFQhRZBTypb6IJvYwSSuMpjb8t/zvo0uIEY6A9QsoAcf+33OSX9qZG/qxzlK9OO
         fvy+EUWTCapucGBlFyklbC5iRnSGfHJHL4TvYPlrcrrPcj5u/anz+W2jGIUXUxxrKMWm
         Z8ptDxJTqH/6ywqIw05+PtQwsv6nyc3A3iX5llghdVvRm8SJ/ZCRi4aSctSdmlgHqKGD
         rwqlMvJkzfGulJZZcTT/Mnoat3ZJkwFOSxyeTY3UL3Ew/MuAqf7VzezBZ8VKwG+vLLx+
         NtWM16mSZxY3j0MLUNEBy8UAtzl31HGbon/QNJlFdiOGUTk7+gRyoF8b9V02BvsztEBU
         Q1WQ==
X-Gm-Message-State: AJcUukfeEiBsfdJpO20mU0uKLkChOPRsHGI5P+MAOGyeID5yusArHVHv
        EpV+IvwWG/8T8QB3UF3b5ITBhw==
X-Google-Smtp-Source: ALg8bN4zhxDVZzCIcWYBQh3HCmCLopVW4BNWhJBiKfiq5Qw3ZpM9TnpLXprN9HL9wAdeE/HLeA7zuA==
X-Received: by 2002:a1c:f71a:: with SMTP id v26mr8895666wmh.131.1545575765818;
        Sun, 23 Dec 2018 06:36:05 -0800 (PST)
Received: from localhost.localdomain (p5B12DA88.dip0.t-ipconnect.de. [91.18.218.136])
        by smtp.gmail.com with ESMTPSA id k23sm11646782wmj.32.2018.12.23.06.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 06:36:05 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        Christian Brauner <christian@brauner.io>,
        Todd Kjos <tkjos@google.com>
Subject: [PATCH v1 2/2] binderfs: reserve devices for initial mount
Date:   Sun, 23 Dec 2018 15:35:50 +0100
Message-Id: <20181223143550.10672-2-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181223143550.10672-1-christian@brauner.io>
References: <20181223143550.10672-1-christian@brauner.io>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binderfs instance in the initial ipc namespace will always have a
reserve of 4 binder devices unless explicitly capped by specifying a lower
value via the "max" mount option.
This ensures when binder devices are removed (on accident or on purpose)
they can always be recreated without risking that all minor numbers have
already been used up.

Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
v1:
- patch introduced
v0:
- patch not present
---
 drivers/android/binderfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 873adda064ac..aa635c7ea727 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -40,6 +40,8 @@
 #define INODE_OFFSET 3
 #define INTSTRLEN 21
 #define BINDERFS_MAX_MINOR (1U << MINORBITS)
+/* Ensure that the initial ipc namespace always has a devices available. */
+#define BINDERFS_MAX_MINOR_CAPPED (BINDERFS_MAX_MINOR - 4)
 
 static struct vfsmount *binderfs_mnt;
 
@@ -129,11 +131,14 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	struct inode *inode = NULL;
 	struct super_block *sb = ref_inode->i_sb;
 	struct binderfs_info *info = sb->s_fs_info;
+	bool use_reserve = (info->ipc_ns == &init_ipc_ns);
 
 	/* Reserve new minor number for the new device. */
 	mutex_lock(&binderfs_minors_mutex);
 	if (++info->device_count <= info->mount_opts.max)
-		minor = ida_alloc_max(&binderfs_minors, BINDERFS_MAX_MINOR,
+		minor = ida_alloc_max(&binderfs_minors,
+				      use_reserve ? BINDERFS_MAX_MINOR :
+						    BINDERFS_MAX_MINOR_CAPPED,
 				      GFP_KERNEL);
 	else
 		minor = -ENOSPC;
-- 
2.19.1

