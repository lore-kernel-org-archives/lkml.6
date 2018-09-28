Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622A0C004D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B5020896
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B5020896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbeI1WHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:07:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39260 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbeI1WHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:07:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so6888807wrw.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WA8a1eE6/xDrpYjrzRivExvWBCE8QoKwcHcAGlCFyCU=;
        b=n/X1WvGnCW5cpl7sCz3xNRNt5hUSt2GDcy9JdGenuev2ZHUl/fPVG2D/IkTnMAkjOj
         Lj7gj34TgiqjIe8wxCYN71aoxPVeZ0uWQtp+EI+j6CYhpDBUq0pRYp/OFUyXX0UhNFCy
         YGVEJWVAcmeg+ClDkjX5B0NY2ugXoZ5dB+ZqUT81XywvxtZC5j7jhpHJuDyW/e3F5GXp
         wtwOuVIytPxAfZGxCAm3AM/yhJ7X+3MN/i4RAtBI5rwtWuEcy77h4+QX734Dtbl54QLj
         JdTZHkJeA06Aq3PJWuYTQqkFFY0fcYoYn/NCYNmu7a4dMfBwT8jniZN9Q6fa3Su5QpGi
         oamA==
X-Gm-Message-State: ABuFfohpKhzzBqC4BFeVMxyrTNEP1iQgHy3dZs13wfIEH1ptgQbIO95b
        123QH5/EgS1R4LQPeD5BnA+UZw==
X-Google-Smtp-Source: ACcGV60aceeiePRbu8+zVhfncFCDGSg15mTdm2ToFXU5DavPNpBlCdIis5OO8cWIiovxmnzftI+PeA==
X-Received: by 2002:adf:9af5:: with SMTP id a108-v6mr13192775wrc.125.1538149364116;
        Fri, 28 Sep 2018 08:42:44 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v2-v6sm2009877wme.36.2018.09.28.08.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 08:42:43 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] fuse: extract fuse_emit() helper
Date:   Fri, 28 Sep 2018 17:42:28 +0200
Message-Id: <20180928154234.19270-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180928154234.19270-1-mszeredi@redhat.com>
References: <20180928154234.19270-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for cache filling by introducing a helper for emitting a single
directory entry.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/readdir.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 3e100e00e21e..65336c93c1f4 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -26,6 +26,13 @@ static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
 	return false;
 }
 
+static bool fuse_emit(struct file *file, struct dir_context *ctx,
+		      struct fuse_dirent *dirent)
+{
+	return dir_emit(ctx, dirent->name, dirent->namelen, dirent->ino,
+			dirent->type);
+}
+
 static int parse_dirfile(char *buf, size_t nbytes, struct file *file,
 			 struct dir_context *ctx)
 {
@@ -39,8 +46,7 @@ static int parse_dirfile(char *buf, size_t nbytes, struct file *file,
 		if (memchr(dirent->name, '/', dirent->namelen) != NULL)
 			return -EIO;
 
-		if (!dir_emit(ctx, dirent->name, dirent->namelen,
-			       dirent->ino, dirent->type))
+		if (!fuse_emit(file, ctx, dirent))
 			break;
 
 		buf += reclen;
@@ -183,8 +189,7 @@ static int parse_dirplusfile(char *buf, size_t nbytes, struct file *file,
 			   we need to send a FORGET for each of those
 			   which we did not link.
 			*/
-			over = !dir_emit(ctx, dirent->name, dirent->namelen,
-				       dirent->ino, dirent->type);
+			over = !fuse_emit(file, ctx, dirent);
 			if (!over)
 				ctx->pos = dirent->off;
 		}
-- 
2.14.3

