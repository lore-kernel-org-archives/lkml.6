Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67230C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3681D217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170662;
	bh=osTFfjFH9cbApvli8AfiOV1oemQK3cCtFnsQq73QHJM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LIPkQi1vd/ak7On/r3bJ7B8YfDNYKWSm8bMpBffQn2Fe5cAaJjX+jAqVhCYLj/LA+
	 z8qjVagAXv3X3x5leICQ97CMnJoQOXFinnSxPO/1GAabTRzN5mEJKkCqelK53uLL8k
	 FgOl0Fkh6APDL+gQ3gjhy4ETMdRt8Tnfy4FGspWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfAVPYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:24:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729537AbfAVPYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:24:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D918020855;
        Tue, 22 Jan 2019 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170654;
        bh=osTFfjFH9cbApvli8AfiOV1oemQK3cCtFnsQq73QHJM=;
        h=From:To:Cc:Subject:Date:From;
        b=XdiKNoXzGMwI7Fbw3oqn7tFjZ+4/Q7TogHsx2X+rfwSYOZQGFOZmrHqzNK5jik+NF
         TMt+53Yt+NIEBIOcNrwzcdAxETuNEfMDl0XMN92iaXoN/Gb/PmQh54kTvuPKlgfYsh
         ohC2Getlpjo+GuTKpYntC+fxsvln1S/jfZzvjE44=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: [PATCH] mwifiex: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:37 +0100
Message-Id: <20190122152151.16139-38-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Nishant Sarmukadam <nishants@marvell.com>
Cc: Ganapathi Bhat <gbhat@marvell.com>
Cc: Xinming Hu <huxinming820@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/marvell/mwifiex/debugfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index cbe4493b3266..8ab114cf3467 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -922,9 +922,8 @@ mwifiex_reset_write(struct file *file,
 }
 
 #define MWIFIEX_DFS_ADD_FILE(name) do {                                 \
-	if (!debugfs_create_file(#name, 0644, priv->dfs_dev_dir,        \
-			priv, &mwifiex_dfs_##name##_fops))              \
-		return;                                                 \
+	debugfs_create_file(#name, 0644, priv->dfs_dev_dir, priv,       \
+			    &mwifiex_dfs_##name##_fops);                \
 } while (0);
 
 #define MWIFIEX_DFS_FILE_OPS(name)                                      \
-- 
2.20.1

