Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3290C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C6F2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Z8hzzGK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbfAKKTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:19:47 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33840 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfAKKTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:19:47 -0500
Received: by mail-ed1-f68.google.com with SMTP id b3so12719380ede.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 02:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1aiFYtlXsGKUTLUc1FiPVDEYdBGNe9p7+yDu+R7Bs9U=;
        b=Z8hzzGK4K3t652iairly7LoPVHnen0ZVVCU705jHzOPe7VzRkPDY9uUAoQIHpBBvax
         hBML9bNGoCswZUoqdMt+xpeDy6iU91Ygar8bRSbi/WVHEhLU1l6/rltbGK9OgnhbGcL7
         yi7jOxd14yO6x61TAmfNS6SYs2wAFIGAhjtlYQs08CB8SVcQ5UwAZ7QFMxre13qwzKW3
         nO7oMYCQp4CQh4xrdpZAEcQYLPvd9/GJizMNerV0q6Sq0VelNn2JHoqQb+FYm8Ojw80l
         m/dYTcOa5O9PO8Sa2l4qfpO/9Tz10EvevPy7Q3ujDGXBUD8j7TZjNEGakcbw8GyC6nPD
         Sdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1aiFYtlXsGKUTLUc1FiPVDEYdBGNe9p7+yDu+R7Bs9U=;
        b=jVkattuHsOBEbnqc5idwsS7nAgP4vO73W2lf34iSvsZZUr1Aa3AybI40qIDbwC1ZI/
         OsrR2FQKoJvWJMCBY0Unm1oZCcfGUb120JssTd46DykFwnmYkcX2lsoYRJdh53g17usL
         ZrS6XTIKU4JEsAqFJnYYIJVyRlBDWCIgkWnLrMUliTnlnulHpMC33YV+c0KQ1uzCOHIz
         B/bFYt+iwSOdROPk0jtTlPAizJ4YYJhPIOQZoE5Crnjb5HL1bIDl9/o/El86CDd4I6Ov
         wnc3WDBm3iLZywyoQoRPyZkPwrJck3qQ+wWFWLjGD9ZhvVRKt2d/0bS+zZrXbJOu4fmW
         /r5A==
X-Gm-Message-State: AJcUukerW/P1U1/obPlgbEdEXRAXu4Z/bSREsjH5eYkOvavHLMticR3B
        /jUtyhuZpDjddbNzoT7gAM8w2Q==
X-Google-Smtp-Source: ALg8bN7JvdMa39id5HGUDc+oTAeT3ZzvDWrgrAhQuh5J0aOcB+YNKJHomjSucRhNP9sQk70tX4IXEQ==
X-Received: by 2002:a17:906:f20b:: with SMTP id gt11-v6mr11506678ejb.144.1547201985419;
        Fri, 11 Jan 2019 02:19:45 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6c0:d6c:c571:88:8aee:976c])
        by smtp.gmail.com with ESMTPSA id e7-v6sm1447285ejt.23.2019.01.11.02.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 02:19:44 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, Christian Brauner <christian@brauner.io>
Subject: [RESEND PATCH] binderfs: reserve devices for initial mount
Date:   Fri, 11 Jan 2019 11:19:40 +0100
Message-Id: <20190111101940.24965-1-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
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
v2:
- patch unchanged
v1:
- patch introduced
v0:
- patch not present
---
 drivers/android/binderfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index f6341893b5ba..ad3ad2f7f9f4 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -40,6 +40,8 @@
 #define INODE_OFFSET 3
 #define INTSTRLEN 21
 #define BINDERFS_MAX_MINOR (1U << MINORBITS)
+/* Ensure that the initial ipc namespace always has devices available. */
+#define BINDERFS_MAX_MINOR_CAPPED (BINDERFS_MAX_MINOR - 4)
 
 static dev_t binderfs_dev;
 static DEFINE_MUTEX(binderfs_minors_mutex);
@@ -127,11 +129,14 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
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

