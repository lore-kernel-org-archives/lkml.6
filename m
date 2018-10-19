Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8609BECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C7220836
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C7220836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeJSU0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:26:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39105 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbeJSU0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:26:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id 61-v6so37208925wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 05:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DI3eyO7hOOE8k7ziSgipDwQ5lk17cCZDpBqUZ5GEV1w=;
        b=ANpmYx+iUQ8iIzKPZzwHaGfFx3eYv7AM/srvGQ1n3BZ3yZXleUwUPbmxNfTKSzA6nz
         LfT7fZuBWj7J2a5SdOzG6ZfXvNHzUH+c7qHmvwBsf+mpymcdTkwcOlUh1hjRSJH3ke0X
         FKqoDWFIeK4DtppKKxGsxHm1qJ+OaXuXBNGy9fv4L0oqU2hWVzPYzFTklw1EOAwdCfDK
         JM29dDAiq8/b+Li7hIIjW2o7oXD9xX6hvwhixH2x5xutTL9Y7D8HFYg4Z8XEndScciRl
         0HJ/9M65wtTkCRTenZvYOvEXxCzjJYzHsQ5IxwCixVtz3AiUhdPd0o41+QYix/JtrD2X
         b5Ng==
X-Gm-Message-State: ABuFfohpCtj+FomikZd3Rutb/T62NfVN+kY/kWuF9IXM0eqoWqD68c/2
        +wZwKxydHHRqvpJXx7Br9p99R+BaQhk=
X-Google-Smtp-Source: ACcGV634JBN7TrHiFqPsGayChQBFFmQa8RGgGFJh/Kxux8CHobnJ/MYVFEkq4LZWmC3pv7dqWNsz7Q==
X-Received: by 2002:adf:ef90:: with SMTP id d16-v6mr28773996wro.204.1539951658316;
        Fri, 19 Oct 2018 05:20:58 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id s10-v6sm1858283wmf.15.2018.10.19.05.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 05:20:57 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 4/5] statx: don't clear STATX_ATIME on SB_RDONLY
Date:   Fri, 19 Oct 2018 14:20:48 +0200
Message-Id: <20181019122049.27121-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181019122049.27121-1-mszeredi@redhat.com>
References: <20181019122049.27121-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IS_NOATIME(inode) is defined as __IS_FLG(inode, SB_RDONLY|SB_NOATIME), so
generic_fillattr() will clear STATX_ATIME from the result_mask if the super
block is marked read only.

This was probably not the intention, so fix to only clear STATX_ATIME if
the fs doesn't support atime at all.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: David Howells <dhowells@redhat.com>
---
 fs/stat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index 8d297a279991..b46583df70d4 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -46,7 +46,8 @@ void generic_fillattr(struct inode *inode, struct kstat *stat)
 	stat->blksize = i_blocksize(inode);
 	stat->blocks = inode->i_blocks;
 
-	if (IS_NOATIME(inode))
+	/* SB_NOATIME means filesystem supplies dummy atime value */
+	if (inode->i_sb->s_flags & SB_NOATIME)
 		stat->result_mask &= ~STATX_ATIME;
 	if (IS_AUTOMOUNT(inode))
 		stat->attributes |= STATX_ATTR_AUTOMOUNT;
-- 
2.14.3

