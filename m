Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93102ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBD720883
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRxcD/m5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBD720883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbeJYWyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:54:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731391AbeJYWyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:54:11 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB6D42085B;
        Thu, 25 Oct 2018 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477272;
        bh=LDnqU9y6u5AkUf9DaBOz4xz8IE9//HU2VBkgwDdvbw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRxcD/m5cYPeX9iEU1tXuzuAEaAVBbXO7uB7FxDJaAGhBtFp5tVt1WPMhuKedeou8
         w787Q5vJMNJdyiRezQTmPBJCb2jmeWDWMV4CXHyeKt95WpHfJRJAX/lWJolxpfZ2ih
         AIR5s55rvc7bi5fYYtK4fPIVJkQ30tO5dL+PQ+Kg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 89/98] vfs: Make sendfile(2) killable even better
Date:   Thu, 25 Oct 2018 10:18:44 -0400
Message-Id: <20181025141853.214051-89-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit c725bfce7968009756ed2836a8cd7ba4dc163011 ]

Commit 296291cdd162 (mm: make sendfile(2) killable) fixed an issue where
sendfile(2) was doing a lot of tiny writes into a filesystem and thus
was unkillable for a long time. However sendfile(2) can be (mis)used to
issue lots of writes into arbitrary file descriptor such as evenfd or
similar special file descriptors which never hit the standard filesystem
write path and thus are still unkillable. E.g. the following example
from Dmitry burns CPU for ~16s on my test system without possibility to
be killed:

        int r1 = eventfd(0, 0);
        int r2 = memfd_create("", 0);
        unsigned long n = 1<<30;
        fallocate(r2, 0, 0, n);
        sendfile(r1, r2, 0, n);

There are actually quite a few tests for pending signals in sendfile
code however we data to write is always available none of them seems to
trigger. So fix the problem by adding a test for pending signal into
splice_from_pipe_next() also before the loop waiting for pipe buffers to
be available. This should fix all the lockup issues with sendfile of the
do-ton-of-tiny-writes nature.

CC: stable@vger.kernel.org
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/splice.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index cf0cb768a1a7..852194d3ce4a 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -809,6 +809,13 @@ static int splice_from_pipe_feed(struct pipe_inode_info *pipe, struct splice_des
  */
 static int splice_from_pipe_next(struct pipe_inode_info *pipe, struct splice_desc *sd)
 {
+	/*
+	 * Check for signal early to make process killable when there are
+	 * always buffers available
+	 */
+	if (signal_pending(current))
+		return -ERESTARTSYS;
+
 	while (!pipe->nrbufs) {
 		if (!pipe->writers)
 			return 0;
-- 
2.17.1

