Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2892DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B2420675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571554;
	bh=cEDnNehdEbI+1Eo1L3mFAnnF843SqOjg6Txo2fEMBwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1nUH+R2q9RkPW5+/D/59FoZ9jOcu/XIvhbiuOb3VVB9ONDDLgljcSq48ZmyjUGM2m
	 2LedbfDIXJTGYDkLPgKVgmPkTUGatqkSL1LCXURCE0z6Y8lkQVc0X/BdmImZ3SHnbI
	 k56KsHJG6aVNgFP9nYct9edMbVhdrl68yoskzujw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388173AbfAOQ7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:59:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729401AbfAOQja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:39:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BD372054F;
        Tue, 15 Jan 2019 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570369;
        bh=cEDnNehdEbI+1Eo1L3mFAnnF843SqOjg6Txo2fEMBwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ii6YyPSc1Dy2x62tM8ls/JVQfbZ92WKPfHcT6bsIn1A+Lt2tVFRQM3V5XkmS7RSfR
         ubgQS7mlHd+6UWQJi+ecO+vjak4PKBbMjJ7lljThhUjA0DfPdKp5zYlWKp2vw4bdTk
         TtP+Bhv2xR2b1ClBygIs4skPwreR+O6B3r68Mzmk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.9 15/16] ext4: avoid kernel warning when writing the superblock to a dead device
Date:   Tue, 15 Jan 2019 17:35:58 +0100
Message-Id: <20190115154850.004102144@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154848.164648613@linuxfoundation.org>
References: <20190115154848.164648613@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit e86807862e6880809f191c4cea7f88a489f0ed34 upstream.

The xfstests generic/475 test switches the underlying device with
dm-error while running a stress test.  This results in a large number
of file system errors, and since we can't lock the buffer head when
marking the superblock dirty in the ext4_grp_locked_error() case, it's
possible the superblock to be !buffer_uptodate() without
buffer_write_io_error() being true.

We need to set buffer_uptodate() before we call mark_buffer_dirty() or
this will trigger a WARN_ON.  It's safe to do this since the
superblock must have been properly read into memory or the mount would
have been successful.  So if buffer_uptodate() is not set, we can
safely assume that this happened due to a failed attempt to write the
superblock.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4679,7 +4679,7 @@ static int ext4_commit_super(struct supe
 	ext4_superblock_csum_set(sb);
 	if (sync)
 		lock_buffer(sbh);
-	if (buffer_write_io_error(sbh)) {
+	if (buffer_write_io_error(sbh) || !buffer_uptodate(sbh)) {
 		/*
 		 * Oh, dear.  A previous attempt to write the
 		 * superblock failed.  This could happen because the


