Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC657ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC52B2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC52B2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeJSU0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:26:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53973 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeJSU0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:26:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id y11-v6so3431301wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 05:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qE3Rs28MEBDxBAAHmciCMpu1FI8X4EuBPjRL/1BPcXM=;
        b=FpMFHVhQKrxszzRH9AtMdnwWxkcAkG3UdiKj0/fZABl2YH0qFBz9FdZGpNolaW4kCJ
         9vHLmkruJ7M+CW8D8BqwZGrhfP6uDFLVDfKDb/RSGWjiNtf8g4kQzuU1j/qm6i5g2wZL
         8/Ggq6EIXXq6iaI88MQSGVQSZYAUgRn0mNv+btX/aTvGQlN7CqvaFaZeB8RGmCFhF8kM
         Scb0SYUdldodJdFPDafJvCFZtr6iEmQhX/RTUqQI6nSW52V2FuRrbRfFtvB5EoCTPxfd
         T/gCiR3Bu3Tncb3bmS+ciycCu6Gq6kKoYsMuLlelJ+Akc3zXetb9uqEw/a4e7ixNX5Tz
         KDYw==
X-Gm-Message-State: ABuFfohX2xVLImDAfoU8BqchVEdQGP8Cf8BPch9RACyrvepYiM9FFqMx
        LQyRGg5NFoQPN2v09w6madItUw==
X-Google-Smtp-Source: ACcGV61JyOlB7Yq+Dwrp0lv4vqfDXCTk8IG9UEfYUoQDYpYyzQwE5HBISNweTrOIuW7U7+JW+jMPJQ==
X-Received: by 2002:a1c:1b84:: with SMTP id b126-v6mr4763334wmb.121.1539951659662;
        Fri, 19 Oct 2018 05:20:59 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id s10-v6sm1858283wmf.15.2018.10.19.05.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 05:20:59 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH v2 5/5] nfs: don't clear STATX_ATIME from result_mask
Date:   Fri, 19 Oct 2018 14:20:49 +0200
Message-Id: <20181019122049.27121-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181019122049.27121-1-mszeredi@redhat.com>
References: <20181019122049.27121-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per statx(2) man page only clear out flags that are unsupported by the
fs or have an unrepresentable value.  Atime is supported by NFS as long as
it's supported on the server.

So the STATX_ATIME flag should not be cleared in the result_mask if the
operation was requested on a MNT_NOATIME or MNT_NODIRATIME mount.

This patch doesn't change the revalidation algorithm in any way, just the
clearing of flags in stat->result_mask.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: 9ccee940bd5b ("Support statx() mask and query flags parameters")
Cc: Trond Myklebust <trond.myklebust@primarydata.com>
---
 fs/nfs/inode.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b65aee481d13..34bb3e591709 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -811,7 +811,7 @@ int nfs_getattr(const struct path *path, struct kstat *stat,
 	if (!(request_mask & (STATX_MODE|STATX_NLINK|STATX_ATIME|STATX_CTIME|
 					STATX_MTIME|STATX_UID|STATX_GID|
 					STATX_SIZE|STATX_BLOCKS)))
-		goto out_no_revalidate;
+		goto out_no_update;
 
 	/* Check whether the cached attributes are stale */
 	do_update |= force_sync || nfs_attribute_cache_expired(inode);
@@ -833,9 +833,6 @@ int nfs_getattr(const struct path *path, struct kstat *stat,
 			goto out;
 	} else
 		nfs_readdirplus_parent_cache_hit(path->dentry);
-out_no_revalidate:
-	/* Only return attributes that were revalidated. */
-	stat->result_mask &= request_mask;
 out_no_update:
 	generic_fillattr(inode, stat);
 	stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));
-- 
2.14.3

