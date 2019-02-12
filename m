Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3FFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFE521773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSdMmufz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfBLOy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:54:57 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:43110 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfBLOy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:54:56 -0500
Received: by mail-yb1-f195.google.com with SMTP id s76so1112034ybs.10;
        Tue, 12 Feb 2019 06:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xFA+Mm5utO4rafbneyRLgd2Qn/kfya7WxVy+rmH3IzA=;
        b=gSdMmufz4PgD5cdwmNLSShkKS6pB2JH8Tz1iF2KnOSjSWiJ0scu1npmGGbKzeSUqiI
         A/EBpzGBYaSGBSB3fpV3owSBDx/K5uM5ZDWxW3Z0cvs2PHlU50nYBTRniFRrX2lmfxXf
         s1XElZ4haCSJJW5zsPHdeLBdRC7cXV8gp/QPTIiwEy2j5+3SJO6MaM4Vxf4SW1I3VLfp
         cs5UoXriJiaxXnB+GgwVFefK55qtoXuj+UlKZRSN0PdNAo7iOBC+1Zp7abG4hjnldwBY
         9vArwq2ku7qRz5T+op9fLnShwWY740crtfEnRDq/BvwxXS5l3JmncXPAo25V3emv9bZq
         go3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xFA+Mm5utO4rafbneyRLgd2Qn/kfya7WxVy+rmH3IzA=;
        b=fmnkNtjnYsSqghJtefBkEbrOc5e9CMERqR3XQ73vb129HdabHC4hA1xLyPROJeDsfp
         0dkm1GeeI4xodL3TBSkYVZ5X7lBIGCY1D+ebSLalYifIB1Mag/Ro51Fsp8ldPg4AK6yt
         OAIsGZEtbjBR4XtkbHBJTLeNA3o8XMDb4Ahf4ooRqR0LoTq7iz/vc+UCkKhzEXpYCqAS
         O2qRZphlW2QxmjDKkSjYFX56HBMhCRFE3vXuVE4Tnm1leA1diN2Z/XjmDh9LYlH+sbRC
         xOFGeQkF8Wfdw3haqSGOuYMrRijtpySGxkv5IwB9RmUdSlsBs2IlMa5vSRxdtmeEvMrh
         v8+w==
X-Gm-Message-State: AHQUAuZDyaeDJQHV6VM6gqhv7GfzKIn+2xSn+/S0gafcdbO3HeG+S1ej
        75K5EUiUp2iDykujepdNBm7qqAM0R0tOvQ==
X-Google-Smtp-Source: AHgI3IZSyfMJZ2OTG5LqGDRhl0do4Eq9/xLoYli2JiiJbu3atrG8U77+YfrjcznNVGz+3RTc3vMirw==
X-Received: by 2002:a5b:9c2:: with SMTP id y2mr3349083ybq.319.1549983295667;
        Tue, 12 Feb 2019 06:54:55 -0800 (PST)
Received: from localhost.localdomain (c-73-120-18-128.hsd1.tn.comcast.net. [73.120.18.128])
        by smtp.gmail.com with ESMTPSA id v134sm4987967ywv.90.2019.02.12.06.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 06:54:54 -0800 (PST)
From:   demiobenour@gmail.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        "Demi M. Obenour" <demiobenour@gmail.com>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] Add path resolution flag LOOKUP_NEVER_FOLLOW
Date:   Tue, 12 Feb 2019 09:54:44 -0500
Message-Id: <20190212145450.2200-1-demiobenour@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Demi M. Obenour" <demiobenour@gmail.com>

This adds the flag LOOKUP_NEVER_FOLLOW to path resolution, which tells
the code in fs/namei.c to never follow symlinks.  This flag overrides
LOOKUP_FOLLOW, since this makes internal APIs simpler: code can set the
flag without needing to also clear LOOKUP_FOLLOW, which is often set by
default.

This is a prerequisite to adding O_PATHSTATIC, but is also useful for
kernel-internal use.
---
 fs/namei.c            | 4 +++-
 include/linux/namei.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 914178cdbe94..54fbd2c7ba82 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1720,7 +1720,9 @@ static int pick_link(struct nameidata *nd, struct path *link,
 {
 	int error;
 	struct saved *last;
-	if (unlikely(nd->total_link_count++ >= MAXSYMLINKS)) {
+	const int max_symlinks = (nd->flags & LOOKUP_NEVER_FOLLOW) ?
+		0 : MAXSYMLINKS;
+	if (unlikely(nd->total_link_count++ >= max_symlinks)) {
 		path_to_nameidata(link, nd);
 		return -ELOOP;
 	}
diff --git a/include/linux/namei.h b/include/linux/namei.h
index a78606e8e3df..f065502a653d 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -24,10 +24,12 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
  *  - internal "there are more path components" flag
  *  - dentry cache is untrusted; force a real lookup
  *  - suppress terminal automount
+ *  - never follow symbolic links, even internally
  */
 #define LOOKUP_FOLLOW		0x0001
 #define LOOKUP_DIRECTORY	0x0002
 #define LOOKUP_AUTOMOUNT	0x0004
+#define LOOKUP_NEVER_FOLLOW	0x0008
 
 #define LOOKUP_PARENT		0x0010
 #define LOOKUP_REVAL		0x0020
-- 
2.20.1

