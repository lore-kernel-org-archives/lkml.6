Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5F2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B267B20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B267B20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeKGSpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:45:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38862 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeKGSpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:45:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id d10-v6so16555744wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 01:15:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yv1JoQ5Q4u6JnukSJ8B/qDrM60Pa9+B8dF5FUaO3fAg=;
        b=B+Jqdg2kOGb1W+yMed/YRfe6DmPSqr8ixFI50ppPVjj3kjvaxI4VwEH3625xy8PU+J
         KjBHWI/lReMFo6l6aovkqDoy1M7iNbf/A5clz7Z43RBx8zUS5QHkieUgH9kk+1pKW2/B
         LHxVNM68x2Gb4N7p/1W9qlav17EzE3Nd+WbBypGypVQ9MN2U2WgGvI8tP/OZbWX1XXuh
         SANQohD5MfUmiLw+mpAgEdrbPBDiBD+75nj2v5mIon3LpcG2Eh/HP3vhfOI7iGsNp2iY
         cIdMatepaxqq47iSModfE3n6Xc0qcpmvj50ws5WGndVQlb0iG8N0NTMcyeGdYMdBDVA3
         RdVg==
X-Gm-Message-State: AGRZ1gI7J+9OvDSdSCqhemcPJSHhKHeYC+qaREKKsrNHBwl67bIEgh37
        VG6C0K6EOtJxY5CCYWfOSg8ogHxlcnk=
X-Google-Smtp-Source: AJdET5f/WaJGI5i4Ec06++vQYUVoc2XViMeE2PA8B8DUuTIL1aSYovHqF29CZqQE+PPVZyQQ4YgbrQ==
X-Received: by 2002:adf:fdc8:: with SMTP id i8-v6mr1147367wrs.276.1541582155417;
        Wed, 07 Nov 2018 01:15:55 -0800 (PST)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id j203-v6sm329969wmd.46.2018.11.07.01.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 01:15:54 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] utimensat: AT_EMPTY_PATH support
Date:   Wed,  7 Nov 2018 10:15:52 +0100
Message-Id: <20181107091552.17100-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it possible to use utimensat on an O_PATH file (including
symlinks).

It supersedes the nonstandard utimensat(fd, NULL, ...) form.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/utimes.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/utimes.c b/fs/utimes.c
index bdcf2daf39c1..f9c7ebad19d7 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -97,13 +97,13 @@ long do_utimes(int dfd, const char __user *filename, struct timespec64 *times,
 		goto out;
 	}
 
-	if (flags & ~AT_SYMLINK_NOFOLLOW)
+	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH))
 		goto out;
 
 	if (filename == NULL && dfd != AT_FDCWD) {
 		struct fd f;
 
-		if (flags & AT_SYMLINK_NOFOLLOW)
+		if (flags)
 			goto out;
 
 		f = fdget(dfd);
@@ -119,6 +119,8 @@ long do_utimes(int dfd, const char __user *filename, struct timespec64 *times,
 
 		if (!(flags & AT_SYMLINK_NOFOLLOW))
 			lookup_flags |= LOOKUP_FOLLOW;
+		if (flags & AT_EMPTY_PATH)
+			lookup_flags |= LOOKUP_EMPTY;
 retry:
 		error = user_path_at(dfd, filename, lookup_flags, &path);
 		if (error)
-- 
2.14.3

