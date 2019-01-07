Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33388C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0485620859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864732;
	bh=SU+tvD2ohfF6Eh4ZFbWDwlWnFOnEJGT1g5O6zvQ/aSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vaIYIMOiOSA4M42EFl2ZwEYNeYOmeI/FgjsZGBPibyDDeBDWQeHaOcs02LJqzvEXr
	 X4RQ4owk30wnYY1f4Qdpr/zrpGbkBNbkYy3bKr6s1tCuCNpgwFYi8fYX32qSHrpZeY
	 9RV+v0LgWar1v8UCQj/AjWLGujiefrJ+I7EOZHkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfAGMiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:38:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfAGMit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:38:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85D03206BB;
        Mon,  7 Jan 2019 12:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864728;
        bh=SU+tvD2ohfF6Eh4ZFbWDwlWnFOnEJGT1g5O6zvQ/aSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2i+Bs+gJAkKvWSE7BA+d6FU8HOcHPs+5Oqg4Cr0C1usGXGxIfXRD1Z9id3hDyP/t
         jzunn+AnSqQgFL0U6iDYcY6RfSd7RqzS7RDGM4CMqe89edncavpgLai36jXfq8Hj/V
         c4nBmzODeTVG7qc92QgoePe077nzeHQCY9xCBEPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        =?UTF-8?q?ruippan=20 ?= <ruippan@tencent.com>,
        stable@kernel.org
Subject: [PATCH 4.20 075/145] ext4: fix EXT4_IOC_GROUP_ADD ioctl
Date:   Mon,  7 Jan 2019 13:31:52 +0100
Message-Id: <20190107104447.083544885@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ruippan (潘睿) <ruippan@tencent.com>

commit e647e29196b7f802f8242c39ecb7cc937f5ef217 upstream.

Commit e2b911c53584 ("ext4: clean up feature test macros with
predicate functions") broke the EXT4_IOC_GROUP_ADD ioctl.  This was
not noticed since only very old versions of resize2fs (before
e2fsprogs 1.42) use this ioctl.  However, using a new kernel with an
enterprise Linux userspace will cause attempts to use online resize to
fail with "No reserved GDT blocks".

Fixes: e2b911c53584 ("ext4: clean up feature test macros with predicate...")
Cc: stable@kernel.org # v4.4
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: ruippan (潘睿) <ruippan@tencent.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/resize.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1631,7 +1631,7 @@ int ext4_group_add(struct super_block *s
 	}
 
 	if (reserved_gdb || gdb_off == 0) {
-		if (ext4_has_feature_resize_inode(sb) ||
+		if (!ext4_has_feature_resize_inode(sb) ||
 		    !le16_to_cpu(es->s_reserved_gdt_blocks)) {
 			ext4_warning(sb,
 				     "No reserved GDT blocks, can't resize");


