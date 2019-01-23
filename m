Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F78C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390A220861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="CL5NTQRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfAWLlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:41:49 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43628 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfAWLlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:41:49 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so1418747eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 03:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cAiYx/pAi9Lqvi5F+UHv3V9OQbed1sf28jn2kM8TlCY=;
        b=CL5NTQRWKcWueRBQalDTafluBBTAmU1+ffGe8UlWjZZpIzJQMrRJKJkwm9N4TR7scC
         yDmtqv2stltFdXgrpAltSOFV9e/YvhSV3QHMp59uQWcIFsqck+dHTl7fDvCURjYpJgF0
         tC/y2ZuJAOVuNomXNps3yu+QX/Ow/64H0jYiKtJ2gHRwHdk/pBeZJQv/5+QFoBMPEShN
         Kb08V/ftuLA99yRARpWVrrTdO4eABZz6+e0V7l6JgG3LPx1PGZRqlpUHtVpJCJtDWMBj
         hiRqvrwCjGPRDi/OCNuo/7AVGNVzYNisEfjiFl2uVS3s2vkBGmyrDikIqmCM2Sos8Q+R
         i6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cAiYx/pAi9Lqvi5F+UHv3V9OQbed1sf28jn2kM8TlCY=;
        b=EvZEj+YTDYjw8U3khdgw7K3qC/79mIqlaHQkLhsccg0ZRIU7/wHJ3R1Ib2qCF/Lvs2
         WVQLOe4ypVso3AwdJOy+U2MMF3f2QvRc2SG966/MBXAN9//pQqpr+JqYm5TSrtM223mW
         0n97vIkxllsxaywaQ9goVsLkatf4pCH8AeV0S0vt1niGS8M9Bcq/8V4ogKrferS7AqSP
         hX5O+MCvjEYxejK59vqV7IfUuFk3j9P5jRTfTJuv4K981UMnQfGAybrEBEk+vYqFa/Cy
         lK8mkL3GH2YF+TxorZRB8nEFOjiIa3CGK9cMc99RFcRqgkOtxB72950pHda5EuTmwUob
         bbWA==
X-Gm-Message-State: AJcUukcSmRd8kpApdMgL+cngcaPQ1KKDMS9dWoUZQ7LwvZt0al6BLHGe
        0ATqX8pzIUnqEn6mKsg67QRV8w==
X-Google-Smtp-Source: ALg8bN5EoUs8gMC9qPRow/lPzhuZSBgu4scnYsXaY4clwTkJ7tc0zQanXN5/WZp2hgKVon3sI+yJKg==
X-Received: by 2002:a17:906:914a:: with SMTP id y10mr2243689ejw.124.1548243707469;
        Wed, 23 Jan 2019 03:41:47 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6bf:f9e4:9473:6b39:afaf:14d4])
        by smtp.gmail.com with ESMTPSA id l17sm66100ejz.18.2019.01.23.03.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 03:41:46 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH 1/2] binderfs: respect limit on binder control creation
Date:   Wed, 23 Jan 2019 12:41:15 +0100
Message-Id: <20190123114116.5251-1-christian@brauner.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently adhere to the reserved devices limit when creating new
binderfs devices in binderfs instances not located in the inital ipc
namespace. But it is still possible to rob the host instances of their 4
reserved devices by creating the maximum allowed number of devices in a
single binderfs instance located in a non-initial ipc namespace and then
mounting 4 separate binderfs instances in non-initial ipc namespaces. That
happens because the limit is currently not respected for the creation of
the initial binder-control device node. Block this nonsense by performing
the same check in binderfs_binder_ctl_create() that we perform in
binderfs_binder_device_create().

Fixes: 36bdf3cae09d ("binderfs: reserve devices for initial mount")
Signed-off-by: Christian Brauner <christian@brauner.io>
---
 drivers/android/binderfs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 6a2185eb66c5..7a550104a722 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -395,6 +395,11 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
 	struct inode *inode = NULL;
 	struct dentry *root = sb->s_root;
 	struct binderfs_info *info = sb->s_fs_info;
+#if defined(CONFIG_IPC_NS)
+	bool use_reserve = (info->ipc_ns == &init_ipc_ns);
+#else
+	bool use_reserve = true;
+#endif
 
 	device = kzalloc(sizeof(*device), GFP_KERNEL);
 	if (!device)
@@ -413,7 +418,10 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
 
 	/* Reserve a new minor number for the new device. */
 	mutex_lock(&binderfs_minors_mutex);
-	minor = ida_alloc_max(&binderfs_minors, BINDERFS_MAX_MINOR, GFP_KERNEL);
+	minor = ida_alloc_max(&binderfs_minors,
+			      use_reserve ? BINDERFS_MAX_MINOR :
+					    BINDERFS_MAX_MINOR_CAPPED,
+			      GFP_KERNEL);
 	mutex_unlock(&binderfs_minors_mutex);
 	if (minor < 0) {
 		ret = minor;
-- 
2.20.1

