Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A9BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967F320665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865775;
	bh=bybX8AhjXKTaaaleifGWXJjuo6xJs6WcMJpuuEUED/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kxmic9o5HVPo8nR3nR5H4fXc4fQcCmFOT22gfPLxaVj+uXbGs/xYSx8EgifGszNQk
	 JK3c6dUEyVPuPWm6X7IBsa52l3RI+CWrP96Qww6bEdLWnOJywMzvCBa6/Yd4K45QrY
	 DxfyYM6UGdq7ZRNfdffE96TriSaFGW+3pBVxVgps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfAGM4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:56:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729709AbfAGMyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:54:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C19DB206BB;
        Mon,  7 Jan 2019 12:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865653;
        bh=bybX8AhjXKTaaaleifGWXJjuo6xJs6WcMJpuuEUED/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vcyPGolDPjCu7FlahkeYwqfqRZuXT5X6l/j0qVYlFmAyAuT3YhSRJhvRuM3e5vwSI
         Qj2hTezHbk1FA1xEl9gdTfH5j8NEGgtLVdaAi4S0CHpFcQjqa2ygEEmyffEu0ji5Np
         KtA1JCyQbZTkL3RDglQohFOYr1bTuABLLX6Qn2RM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        =?UTF-8?q?ruippan=20 ?= <ruippan@tencent.com>,
        stable@kernel.org
Subject: [PATCH 4.19 110/170] ext4: fix EXT4_IOC_GROUP_ADD ioctl
Date:   Mon,  7 Jan 2019 13:32:17 +0100
Message-Id: <20190107104505.923672383@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


