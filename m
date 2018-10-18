Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9811C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FAC2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FAC2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeJRVMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:12:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33610 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbeJRVMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:12:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id e4-v6so33640645wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 06:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SMDQxmau8DWThpIhYjetUOOGiLigaeZDiZzGJtsaTwY=;
        b=ufzUJhj/ou2PRQcD/aOpTApazhofWUFISDyfgjQbqaBXXQBdBZQ8kw5ScT37t3KZU1
         VFQubz3Y3Z32N1U/Ge9Gr1/f29J7Gb95TICP85M24Rr0mqyenLCBcmwWnns00BDhJmjE
         J+8suVLVtyRvDFPOZfjqa8VElu3/CBBPzPeAIReeyWHmENJP5kwYeIdqJVQhXCtFR6vo
         Cwgt73CkFxP0Ig/NTOkJXOxk01WVooA1a/9F+VXALHSxLpEkuD/9RwSb18vn/RAFJNVg
         778E2NSBl+Ylj1wAysPKPxH+pIHYL4awY+FjSO2Wr/UzSieCQfyCg4fuRmEwClRPQOOT
         LQeg==
X-Gm-Message-State: ABuFfogueZYdhOVNhvcQIUs30OOz7ZrfzRANob22oba/u8CK6HFY6Q2t
        klY+8xrjqUq7MxX7DzclC25e0w==
X-Google-Smtp-Source: ACcGV609Nre9UfohobsKg8Q5C3X6Z5Ukg8Tabur8K3kEugM7t4lw5Dqa/Ff33qF8FDneozpL/VYjXw==
X-Received: by 2002:adf:cc8a:: with SMTP id p10-v6mr7521732wrj.208.1539868290937;
        Thu, 18 Oct 2018 06:11:30 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id u5-v6sm22246965wru.16.2018.10.18.06.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 06:11:29 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 1/3] orangefs: fix request_mask misuse
Date:   Thu, 18 Oct 2018 15:11:23 +0200
Message-Id: <20181018131125.6303-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Orangefs only handles STATX_BASIC_STATS in its getattr implementation, so
mask off all other flags.  Not doing so results in statx(2) forcing a
refresh of cached attributes on any other requested flag (i.e. STATX_BTIME
currently) due to the following test in orangefs_inode_getattr():

  (request_mask & orangefs_inode->getattr_mask) == request_mask

Also clean up gratuitous uses of STATX_ALL.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: Mike Marshall <hubcap@omnibond.com>
Cc: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 31932879b716..bd7f15a831dc 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -256,7 +256,8 @@ int orangefs_getattr(const struct path *path, struct kstat *stat,
 		     "orangefs_getattr: called on %pd\n",
 		     path->dentry);
 
-	ret = orangefs_inode_getattr(inode, 0, 0, request_mask);
+	ret = orangefs_inode_getattr(inode, 0, 0,
+				     request_mask & STATX_BASIC_STATS);
 	if (ret == 0) {
 		generic_fillattr(inode, stat);
 
@@ -408,7 +409,7 @@ struct inode *orangefs_iget(struct super_block *sb,
 	if (!inode || !(inode->i_state & I_NEW))
 		return inode;
 
-	error = orangefs_inode_getattr(inode, 1, 1, STATX_ALL);
+	error = orangefs_inode_getattr(inode, 1, 1, STATX_BASIC_STATS);
 	if (error) {
 		iget_failed(inode);
 		return ERR_PTR(error);
@@ -453,7 +454,7 @@ struct inode *orangefs_new_inode(struct super_block *sb, struct inode *dir,
 	orangefs_set_inode(inode, ref);
 	inode->i_ino = hash;	/* needed for stat etc */
 
-	error = orangefs_inode_getattr(inode, 1, 1, STATX_ALL);
+	error = orangefs_inode_getattr(inode, 1, 1, STATX_BASIC_STATS);
 	if (error)
 		goto out_iput;
 
-- 
2.14.3

