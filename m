Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FC5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50272184A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216315;
	bh=NLd8OBmpYioGJGybZKS+60EigDeTAAcXAA2sOI/Tacw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dRs59NeYO9Tsi9G3h64ZOuRAhg9dfAIAMz25fQHe50QRGUPof1RlrSD3uDjM4EcIq
	 HIityGC0/OvHmrUmdwtlq3Mixp4J9SRv/ujHFrKmC89O+vTwuRXP3t272UMieID7gd
	 TrFtIoDi0H38c7PWaUh5YIwHdzEvKHLHqkUBrzLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbfAKOSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:18:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbfAKOS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:18:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 711D62183F;
        Fri, 11 Jan 2019 14:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216306;
        bh=NLd8OBmpYioGJGybZKS+60EigDeTAAcXAA2sOI/Tacw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZAyZOIRTldpl4f9QlcaSpy9YSlhyhuUI6QNJ7FnU1uAnPru8Zb0RWp69IeTICq9v
         jOOjo0n69VY1mjwRN8O0EajshCEB+notb1JjpKxwjMwaiWpV8KWR5i/OyuBFwWB+2s
         UVl3pNeTAJNTlSdgC8gAqZ7WdDQ7iXg/lyO4BjnE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        =?UTF-8?q?ruippan=20 ?= <ruippan@tencent.com>,
        stable@kernel.org
Subject: [PATCH 4.4 44/88] ext4: fix EXT4_IOC_GROUP_ADD ioctl
Date:   Fri, 11 Jan 2019 15:08:13 +0100
Message-Id: <20190111131052.638024535@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1600,7 +1600,7 @@ int ext4_group_add(struct super_block *s
 	}
 
 	if (reserved_gdb || gdb_off == 0) {
-		if (ext4_has_feature_resize_inode(sb) ||
+		if (!ext4_has_feature_resize_inode(sb) ||
 		    !le16_to_cpu(es->s_reserved_gdt_blocks)) {
 			ext4_warning(sb,
 				     "No reserved GDT blocks, can't resize");


