Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D51FECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2B720836
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2B720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeJSU0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:26:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33512 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbeJSU0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:26:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id u1-v6so1410888wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 05:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QiX6G6Rss/s3Z2ESVsPcwLLseTLtcA8j6G3yIKnw1pw=;
        b=d/8K/OBd3c1cH1A0jdB6wQT4/v56Oe3vWDjkZQFf3nnorignzDk0gxFKBPDrJ5bQip
         7rWRsGQYaRiOvYgKYVEI8f8W5Yjob/jKkd4lrTBDiwV9DSAkx0UNFUam2t2u4SgHUcX7
         da8iwIiIJLNc8M3z7Ob+pLlvUFMq372lpvJA8rhQHj+HSYFFBxn8xjZJUIj9K9P9hzNw
         aD/7yWFJw2fBpla3I0RcAnoA0qwWqKwb1W9Sypzy30iZ9bGz7Bv1yP9A2gqMrQv+1WUw
         7chnrUEjjO3gl1jtAiOCBftIrActXsNKoD4M+oouBxN/nLp6nkBzIUijb2KGhUMZcu1M
         wvpQ==
X-Gm-Message-State: ABuFfoi5zU3Hz2DkmBGlP0TIR31MptLG3niz4WohQAKaRJOMWC5M2FnZ
        Rxe4Rb4C4xiCf2AUydfXd49hBUQRXGY=
X-Google-Smtp-Source: ACcGV613y3NQMF/LiP7aPzM1qIkY2dEkxrAgqAQLzGpz3ks12NHwBpBBZyxI9GumRaL7NkAh2AJtIg==
X-Received: by 2002:adf:a387:: with SMTP id l7-v6mr36446142wrb.1.1539951655714;
        Fri, 19 Oct 2018 05:20:55 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id s10-v6sm1858283wmf.15.2018.10.19.05.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 05:20:55 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 2/5] uapi: deprecate STATX_ALL
Date:   Fri, 19 Oct 2018 14:20:46 +0200
Message-Id: <20181019122049.27121-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181019122049.27121-1-mszeredi@redhat.com>
References: <20181019122049.27121-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constants of the *_ALL type can be actively harmful due to the fact that
developers will usually fail to consider the possible effects of future
changes to the definition.

Deprecate STATX_ALL in the uapi, while no damage has been done yet.

We could keep something like this around in the kernel, but there's
actually no point, since all filesystems should be explicitly checking
flags that they support and not rely on the VFS masking unknown ones out: a
flag could be known to the VFS, yet not known to the filesystem (see
orangefs bug fixed in the previous patch).

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
---
 fs/stat.c                       |  1 -
 include/uapi/linux/stat.h       | 11 ++++++++++-
 samples/statx/test-statx.c      |  2 +-
 tools/include/uapi/linux/stat.h | 11 ++++++++++-
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index f8e6fb2c3657..8d297a279991 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -73,7 +73,6 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 
 	memset(stat, 0, sizeof(*stat));
 	stat->result_mask |= STATX_BASIC_STATS;
-	request_mask &= STATX_ALL;
 	query_flags &= KSTAT_QUERY_FLAGS;
 	if (inode->i_op->getattr)
 		return inode->i_op->getattr(path, stat, request_mask,
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 7b35e98d3c58..ed456ac0f90d 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -148,9 +148,18 @@ struct statx {
 #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
-#define STATX_ALL		0x00000fffU	/* All currently supported flags */
+
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
+#ifndef __KERNEL__
+/*
+ * This is deprecated, and shall remain the same value in the future.  To avoid
+ * confusion please use the equivalent (STATX_BASIC_STATS | STATX_BTIME)
+ * instead.
+ */
+#define STATX_ALL		0x00000fffU
+#endif
+
 /*
  * Attributes to be found in stx_attributes and masked in stx_attributes_mask.
  *
diff --git a/samples/statx/test-statx.c b/samples/statx/test-statx.c
index d4d77b09412c..e354048dea3c 100644
--- a/samples/statx/test-statx.c
+++ b/samples/statx/test-statx.c
@@ -211,7 +211,7 @@ int main(int argc, char **argv)
 	struct statx stx;
 	int ret, raw = 0, atflag = AT_SYMLINK_NOFOLLOW;
 
-	unsigned int mask = STATX_ALL;
+	unsigned int mask = STATX_BASIC_STATS | STATX_BTIME;
 
 	for (argv++; *argv; argv++) {
 		if (strcmp(*argv, "-F") == 0) {
diff --git a/tools/include/uapi/linux/stat.h b/tools/include/uapi/linux/stat.h
index 7b35e98d3c58..ed456ac0f90d 100644
--- a/tools/include/uapi/linux/stat.h
+++ b/tools/include/uapi/linux/stat.h
@@ -148,9 +148,18 @@ struct statx {
 #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
-#define STATX_ALL		0x00000fffU	/* All currently supported flags */
+
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
+#ifndef __KERNEL__
+/*
+ * This is deprecated, and shall remain the same value in the future.  To avoid
+ * confusion please use the equivalent (STATX_BASIC_STATS | STATX_BTIME)
+ * instead.
+ */
+#define STATX_ALL		0x00000fffU
+#endif
+
 /*
  * Attributes to be found in stx_attributes and masked in stx_attributes_mask.
  *
-- 
2.14.3

