Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D9BC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E9923DAF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E9923DAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754117AbeGFPf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:35:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36388 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753915AbeGFPfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:35:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so4603027wro.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 08:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JLffXw2ge01HDBy9zI+ZF9fw489JARQSa16hJXlbYv4=;
        b=uZsMtc5tokGx8qDpT6Q41a2Gntwo4MOPpa8kPgrnRDlieq4sdewzlQR2itOxlksU8T
         8BM39HUK4BdnB/7Fmiw6jo6xCLblmk1yP9Nuk5hgiwjH97VBFg2G7QiXhx+vpOt9913v
         pjAkmZ1EDcbi0a9Jz7lwSel82w2KZbC15nr4naTaZ5VuOL53hjx483pjwkTpRFHUVptW
         wx7Jdx3hsA9KZuGe/lUihsmim9Xezvry9WTf97l6qn6jOJbU6I/hzU9HC7qICeaRk8Pb
         WnRDGpPGEzilTGor5cDhcS7EktI5JiFSlfVpAWgiHBrwvycGW003XM+7guJYAG8oFCa7
         9kuQ==
X-Gm-Message-State: AOUpUlFz6pIS4LEJJkZBgNWjUB4kf9nSLGrqwsQ6yrsOVaoKguwSPTAS
        yCDhpIwmnCzTS0O/ic7dswXOHyf39+k=
X-Google-Smtp-Source: AAOMgpfhssxFVPE0fJr00slbvKZGoNncJ422WH9HSdjvlU/ug25ZovjrKb/28AudCcik7KYQgJZPZQ==
X-Received: by 2002:a5d:494c:: with SMTP id r12-v6mr313779wrs.66.1530891354485;
        Fri, 06 Jul 2018 08:35:54 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 189-v6sm11700012wmd.17.2018.07.06.08.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 08:35:53 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH (v4.18 regression fix)] vfs: don't evict uninitialized inode
Date:   Fri,  6 Jul 2018 17:35:48 +0200
Message-Id: <20180706153548.23287-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iput() ends up calling ->evict() on new inode, which is not yet initialized
by owning fs.  So use destroy_inode() instead.

Add to sb->s_inodes list only after the inode has been inserted into the
hash.  The exact point at which the inode is added onto the sb list
shouldn't matter as long as it is done while the inode is in the I_NEW
state.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: 80ea09a002bf ("vfs: factor out inode_insert5()")
---
 fs/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 2c300e981796..2f6b411b904f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1094,12 +1094,14 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
 	struct inode *inode = ilookup5(sb, hashval, test, data);
 
 	if (!inode) {
-		struct inode *new = new_inode(sb);
+		struct inode *new = new_inode_pseudo(sb);
 
 		if (new) {
 			inode = inode_insert5(new, hashval, test, set, data);
 			if (unlikely(inode != new))
-				iput(new);
+				destroy_inode(new);
+			else
+				inode_sb_list_add(inode);
 		}
 	}
 	return inode;
-- 
2.14.3

