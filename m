Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D39C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930F820645
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930F820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeJRVMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:12:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43000 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbeJRVMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:12:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id r17-v6so1277355wrt.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 06:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YyfqgKkjEhHK1doopwRy4hxgyNxsDM7seik12mtBO10=;
        b=MmaiSqGGVgJsHzwzk6RQNBumVTJbLE52SjOkbVzk1SHQzlSmp2Is/hVfYJTrPLWbvZ
         24pd/DPNedGl5BwEdraUIPvWifFocsaU8w2Dg1nRPE2srTSnTjaxbpPL+d+KRCM8+WB7
         YIFkNDS5dMNPMZMT6ubcdEaBTZOGUPzq+65cXIpYUS+PGgtIZiW0OJLBj/F6pOtxuPdk
         Jm+qtPXcjReh7cdIG6m1sFybtAt2X7KanE6YuclfKrGn7z9cAmIs+1Soyy9UL2h4MsjI
         KxQITH/oJ1BuVEBjJ4K1CUMmibJZUSh4oSVoIvbYm/exwKK3Tke+gua5WazqUyBjIrcU
         eNIQ==
X-Gm-Message-State: ABuFfojUEbaHA0BuMmMyvUBGImKds0uXAT9BoqFfP8AiomHEPzbePJ4J
        azUa89NdcxHkwEpEvTzJGlMFpBDc5x4=
X-Google-Smtp-Source: ACcGV62Ck2kCpd5V0KcC6yZ5th3yCp8Otnv65wjw0hASAeUmEZ54XyvW8HgOcwuzuEXuFLlxAPoJdg==
X-Received: by 2002:adf:f404:: with SMTP id g4-v6mr7773386wro.198.1539868292412;
        Thu, 18 Oct 2018 06:11:32 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id u5-v6sm22246965wru.16.2018.10.18.06.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 06:11:31 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 2/3] uapi: get rid of STATX_ALL
Date:   Thu, 18 Oct 2018 15:11:24 +0200
Message-Id: <20181018131125.6303-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181018131125.6303-1-mszeredi@redhat.com>
References: <20181018131125.6303-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constants of the *_ALL type can be actively harmful due to the fact that
developers will usually fail to consider the possible effects of future
changes to the definition.

Remove STATX_ALL from the uapi, while no damage has been done yet.

We could keep something like this around in the kernel, but there's
actually no point, since all filesystems should be explicitly checking
flags that they support and not rely on the VFS masking unknown ones out: a
flag could be known to the VFS, yet not known to the filesystem (see
orangefs bug fixed in the previous patch).

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
---
 fs/stat.c                       | 1 -
 include/uapi/linux/stat.h       | 2 +-
 samples/statx/test-statx.c      | 2 +-
 tools/include/uapi/linux/stat.h | 2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)

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
index 7b35e98d3c58..370f09d92fa6 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -148,7 +148,7 @@ struct statx {
 #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
-#define STATX_ALL		0x00000fffU	/* All currently supported flags */
+
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
 /*
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
index 7b35e98d3c58..370f09d92fa6 100644
--- a/tools/include/uapi/linux/stat.h
+++ b/tools/include/uapi/linux/stat.h
@@ -148,7 +148,7 @@ struct statx {
 #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
-#define STATX_ALL		0x00000fffU	/* All currently supported flags */
+
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
 /*
-- 
2.14.3

