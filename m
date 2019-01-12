Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D05C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D06B20872
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="TCxMNO3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfALAGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 19:06:10 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36170 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfALAGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 19:06:10 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so14428311edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 16:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9AfzvQk3cau2FMwrTkOsbY6w/WgfEJAi6VA5sZXF5lk=;
        b=TCxMNO3/6/ud5HyRGvhxgdChtZeYhOGx8nE48jWz8xlZtjXV1Opt9/HCNrwHKq+ci1
         NhhWJ7XPJu04i3zsGbg8ZRM2wZx51KXhA8iYr3GFB9Z3Cy+P3YMEq1G4PaffJ0vs05xi
         XsCzLz6yJrHfZqVab8eBtGrgAQ5DLNPIubaN21oUJFbCOq+qGADdboPMKT6n5zYp68DJ
         uenVtewWy0feSYJ0QMbw9Gd9skzNceaYBBEbFENfWcVKG21cPh0HWOwFk2tB4YHqVYAy
         aapd5jAOdYrjtheIyKXgY8+T8TrG569DZJtmVarkTEmWlBPRZrOTyWAjHWJogDDvNlU9
         Uyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9AfzvQk3cau2FMwrTkOsbY6w/WgfEJAi6VA5sZXF5lk=;
        b=gAbJ6zQDGe2yCBCMA1rloUrCZeTTsPZFCgwHAzCEnKziNCE/KPiK60gO75v85HDwyS
         RP3JGIrI3NGSjC4dC4bROTP1PYUhEY6WNK33svQcS3UL1WbLZXWI+NxwFkTU18K+ZX/Y
         2It6PoV1Rl1iNYHY19Ibih8AzW+e+XAEOc9eV4etmhp3K37hNef9HsFIWTLmm+drQDaH
         H+xMvxXBSwXiYYxlmnIquCbUGUrH1EOT9QCS/KIXGJcBkDFXtgHmi4rhzUQb0gyXpEFk
         z19otmD9FjzVFTnuI9YrRpXmXWNSvgyPc5vbAYCIpjy0fGVTLjFSQZPjsMzdWvfHJ/K2
         Ksvg==
X-Gm-Message-State: AJcUukcqzakd2dY/VAU8fIe667qvveneQnjZ9CDG5dPXeyckWfg6F0+X
        5vGioVJE14cobUuaCpN4hGfbsQ==
X-Google-Smtp-Source: ALg8bN6myAG797idZV2EbzVOaeMJdbCcyPpVmlzAlcURH7MPCcx1XgTb5KQlvSQF+NutaLdbJXwI9w==
X-Received: by 2002:a17:906:340a:: with SMTP id c10-v6mr13368057ejb.130.1547251568300;
        Fri, 11 Jan 2019 16:06:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6c0:d6c:2520:8b:922b:4c43])
        by smtp.gmail.com with ESMTPSA id b11-v6sm1614562ejd.16.2019.01.11.16.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 16:06:07 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH] binderfs: handle !CONFIG_IPC_NS builds
Date:   Sat, 12 Jan 2019 01:06:03 +0100
Message-Id: <20190112000603.17925-1-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild reported a build faile in [1]. This is triggered when CONFIG_IPC_NS
is not set. So let's make the use of init_ipc_ns conditional on
CONFIG_IPC_NS being set.

[1]: https://lists.01.org/pipermail/kbuild-all/2019-January/056903.html

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 drivers/android/binderfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index ad3ad2f7f9f4..9518e2e7da05 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -129,7 +129,11 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	struct inode *inode = NULL;
 	struct super_block *sb = ref_inode->i_sb;
 	struct binderfs_info *info = sb->s_fs_info;
+#if defined(CONFIG_IPC_NS)
 	bool use_reserve = (info->ipc_ns == &init_ipc_ns);
+#else
+	bool use_reserve = true;
+#endif
 
 	/* Reserve new minor number for the new device. */
 	mutex_lock(&binderfs_minors_mutex);
-- 
2.19.1

