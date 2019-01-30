Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913C4C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7E720882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pg4apTw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbfA3J3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:29:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44671 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfA3J3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:29:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id e11so10783651plt.11;
        Wed, 30 Jan 2019 01:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oisTo5WwG62CitH/9mqgqPQKoCIvGihvEMrDqTnIPOw=;
        b=pg4apTw4aMMGNHSGYlSU6iw5MSLtjU4/oFF5+jRx43nmgkD3rY4gfgUwmzOzGRGqyt
         OSrF26j7LUojzMPZFnX5VjTuC/moB99kIfRhkTuarIatJIu/gL1w5T1Cnh4L8nhFVX0W
         fjxootx66zwk/nGBbMzefdfj2fmNKiZ0hmJypfo5nsSCVwUdqvP/KDkSP6ia2aVCz8oY
         bhi5StTKwAhjjS2UgVgOLakcI97zUjOCX2dj2ZneHcNQC1X+KdVJr3FFKQqWQgMaYgLs
         IVXXXUGpn75dMPFnX9YTIy6iaSe+oLFROVSkCo15zud+rzl69BjkwWY3Q93H4Kpzrcsn
         +39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oisTo5WwG62CitH/9mqgqPQKoCIvGihvEMrDqTnIPOw=;
        b=mBF2dBMt24OYBHmlKkchWJz4sdpJh0NQizxbtB6KnnbA9jGleqHBtygxay3VUWiEqf
         9YEY/yfZEdJucs23yOgmvwIsJL6q2SbjDmt5obkQ7fjEkbeLZITQtBHqdGegDdkYqsMd
         i3IIUO5Xg3SYRUeZxqIv3WeCKp89Lywc1b9/+pO/J1WLXicQ7cbK1kJ+yde2RbjbD72x
         UKUwIlPp5Z5VEluoAAp4WiioSL3niWuYtpKCXVCMKsJpX8CSJF3mYDErsg8N92ZYgBqj
         gsnaNuWAw57c+C3SSJ/0QKmxv32P2bPcUQNn3x7Q2Dz92TX19wx6XaBRLhaMKOWWLoq8
         z6Uw==
X-Gm-Message-State: AJcUukckNenYWtItTxjj8WzmxNKy0Kvf3DRhvykNckf8UA45rM4t+WaA
        xaL7/A7VwQwxirzvhbrc22s=
X-Google-Smtp-Source: ALg8bN5tZWAZHG1+mj2sEFpODYWqEdE5cHNnjXSYAMFM+tHHzuUIYiKOHDspbi+9foqIJHeXQWZHgg==
X-Received: by 2002:a17:902:8306:: with SMTP id bd6mr29824581plb.217.1548840584813;
        Wed, 30 Jan 2019 01:29:44 -0800 (PST)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id d13sm1990348pfd.58.2019.01.30.01.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 01:29:44 -0800 (PST)
From:   Geliang Tang <geliangtang@gmail.com>
To:     Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Geliang Tang <geliangtang@gmail.com>, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bcache: use kmemdup_nul for CACHED_LABEL buffer
Date:   Wed, 30 Jan 2019 17:29:18 +0800
Message-Id: <04ff7c6d5cdd8b389d471989704c2f9dc3def554.1548840161.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses kmemdup_nul to create a NUL-terminated string from
dc->sb.label. This is better than open coding it.

With this, we can move env[2] initialization into env[] array to make
code more elegant.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/md/bcache/super.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 4dee119c3664..84ab241c8516 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -906,21 +906,18 @@ static int cached_dev_status_update(void *arg)
 void bch_cached_dev_run(struct cached_dev *dc)
 {
 	struct bcache_device *d = &dc->disk;
-	char buf[SB_LABEL_SIZE + 1];
+	char *buf = kmemdup_nul(dc->sb.label, SB_LABEL_SIZE, GFP_KERNEL);
 	char *env[] = {
 		"DRIVER=bcache",
 		kasprintf(GFP_KERNEL, "CACHED_UUID=%pU", dc->sb.uuid),
-		NULL,
+		kasprintf(GFP_KERNEL, "CACHED_LABEL=%s", buf ? : ""),
 		NULL,
 	};
 
-	memcpy(buf, dc->sb.label, SB_LABEL_SIZE);
-	buf[SB_LABEL_SIZE] = '\0';
-	env[2] = kasprintf(GFP_KERNEL, "CACHED_LABEL=%s", buf);
-
 	if (atomic_xchg(&dc->running, 1)) {
 		kfree(env[1]);
 		kfree(env[2]);
+		kfree(buf);
 		return;
 	}
 
@@ -944,6 +941,7 @@ void bch_cached_dev_run(struct cached_dev *dc)
 	kobject_uevent_env(&disk_to_dev(d->disk)->kobj, KOBJ_CHANGE, env);
 	kfree(env[1]);
 	kfree(env[2]);
+	kfree(buf);
 
 	if (sysfs_create_link(&d->kobj, &disk_to_dev(d->disk)->kobj, "dev") ||
 	    sysfs_create_link(&disk_to_dev(d->disk)->kobj, &d->kobj, "bcache"))
-- 
2.17.1

