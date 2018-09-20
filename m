Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF86BECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FCB21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FCB21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbeITU4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:56:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39352 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733198AbeITU4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:56:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so9776600wrw.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1noejrIq0y1SALjSjxufjZflcUxpMLy32j0L3bEsGuM=;
        b=PgW6BZjXm4eqbALdVoTfm71ME4By5CekXNtYlHxS6+r3A6u2M1a3OumqdCJ3B/zQsT
         59DKFYrV5coC/P3fDgPfsYih0VL7lkK1nlUZyS5mb+1qx1dL95pDn0O5bMXaI/E0MnvP
         LH+J8s9WyqxBHu9BSPF9Nxp9i30FVdst4Q7E7xD6LnIFQ5MlrPWjn1FRqqwKVagAH/pd
         +zCwOrGLNTioCrq1l89y3ya8TbWV0t6Fc7lw8aR+jnFa1KO6DZlIXuNRAqXd7qa/qu5n
         lDSZkl/buIQ9QAAg/4ElEsxYiiqbnI9mWL3Y1IqGM7KNkr3gYFMXY2fA4FsN8L1wKU7v
         BJAw==
X-Gm-Message-State: ABuFfog4Mp2zLql2H30NyQ3a65ycWDfiioHlwvkSLjSntjc/DkjA8JRT
        UPF4YBL6Bamz+LcC8VmS0LSQbA==
X-Google-Smtp-Source: ACcGV621PbIi5/hsdxOfuRVMoo+XMyRk8rWjyobAaqfwxQQzcmZ4WPv+2Lf0pZxrLzC7fXna6i0wHg==
X-Received: by 2002:a5d:4143:: with SMTP id c3-v6mr4474134wrq.61.1537456342725;
        Thu, 20 Sep 2018 08:12:22 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id p89-v6sm55286201wrc.97.2018.09.20.08.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 08:12:21 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] vfs_submount: use SB_SUBMOUNT instead of MS_SUBMOUNT
Date:   Thu, 20 Sep 2018 17:12:10 +0200
Message-Id: <20180920151214.15484-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180920151214.15484-1-mszeredi@redhat.com>
References: <20180920151214.15484-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latter is for the legacy userspace API only and should not be used
internally.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a28b713164bf..865b6f2c5e7d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3297,7 +3297,7 @@ vfs_submount(const struct dentry *mountpoint, struct file_system_type *type,
 	if (mountpoint->d_sb->s_user_ns != &init_user_ns)
 		return ERR_PTR(-EPERM);
 
-	return vfs_kern_mount(type, MS_SUBMOUNT, name, data, data_size);
+	return vfs_kern_mount(type, SB_SUBMOUNT, name, data, data_size);
 }
 EXPORT_SYMBOL_GPL(vfs_submount);
 
-- 
2.14.3

