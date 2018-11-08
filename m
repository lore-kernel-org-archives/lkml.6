Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F7FECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07272089F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7+x2r63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07272089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbeKIHeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:34:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727288AbeKIHeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:34:07 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33D282089A;
        Thu,  8 Nov 2018 21:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714200;
        bh=sOUaosSNVoNZRtmj/nixT3YkIAmdOLTJ/DZlUHQoxcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U7+x2r63sYx+x7MkeeMjNxV6kuUeRg9jy9egUQFEzTtuYfqLPt1dFZrPW/4mnDG5g
         pjky4XuM95yMqf2cb+c/9B5wW9egyHZj3e2SpDMSMrjJAqlhsNI6harVBe1ixhZfSv
         0YUzOYaUllK0uhgFTqrTLShuQbNZ+7GbSoyyEQes=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 117/144] vfs: Make sendfile(2) killable even better
Date:   Thu,  8 Nov 2018 13:51:28 -0800
Message-Id: <20181108215106.469181271@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



