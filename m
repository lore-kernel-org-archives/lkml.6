Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0193DECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45E320836
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45E320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJSU0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:26:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42722 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeJSU0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:26:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id r17-v6so4851954wrt.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 05:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5UiLIhWujnM+LjJO0qECMbozVNcKb22o+ATWjj/yvtc=;
        b=Gc97IzCrC2bTro8yGWPMlkEnBP3mwjf7fqcta8XdCeRXqsugRc+b3lXloJ3qL1a1Bh
         ponIMyH/cnJimocsz5+j3KQZ/T9KmYFuyuOpv/7r7lcTzcr28uLNqtPE76baQnD4Tj4/
         G8Q1roCWIAIK+ZkqlNgcTtXUZGs+TzaGFO8JTJ2oSM6pq7oCDHd6qNWNy+6GkmuZDtNo
         cRrYQkUNaNb2Xmym4A1Wca9MXdUKD4dHdwTbmK2d24ynMf9pR3u5PXEdvOkkHGmP1TzK
         Xzui+iSeG/N9RZGXvGeLVsfGssQS/MWUA4k6Xq/BAKyl9uyJxPOz8FEPKEX7kWcVT+TP
         HQew==
X-Gm-Message-State: ABuFfoiJGuYqXJUxTOZDVgwJ9ezYW7biT7E7x7T9TclimdQxZkk4JVOk
        doreEF8d/PK15aPRtJmVNUDLHA==
X-Google-Smtp-Source: ACcGV60vRfJhTFPvszF9k3YAhPt12knVsndlCbDqWUIyNi4NZCiunsVkoaENF8uMUI0ln1DGQu/muw==
X-Received: by 2002:adf:e18e:: with SMTP id k14-v6mr34944727wri.36.1539951654307;
        Fri, 19 Oct 2018 05:20:54 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id s10-v6sm1858283wmf.15.2018.10.19.05.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 05:20:53 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH v2 1/5] orangefs: fix request_mask misuse
Date:   Fri, 19 Oct 2018 14:20:45 +0200
Message-Id: <20181019122049.27121-1-mszeredi@redhat.com>
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
Reviewed-by: Martin Brandenburg <martin@omnibond.com>
Cc: Mike Marshall <hubcap@omnibond.com>
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

