Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A89BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A8921736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867338;
	bh=aXcTOBp8bNgdxJsVsJ1yU7POIrdQzO84nrQ0ZDLsP0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1XV6H/rmem/JHfHVJWhGNn7FyS47d9Q9qoKsrGvx2QjkjETzkQp/aw18J8oyG693v
	 GePTJ/0QAMBOETrv4Nyi02q+LxxTVjOlEGZ/14CWa6ufAL5glQ8xGe1ymh3i41Q9dg
	 HQOJHaHoDsWImx9HLjtKjay3WyOXvmsJ08ugLWLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfAGMoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:44:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbfAGMoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:44:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8178020449;
        Mon,  7 Jan 2019 12:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865054;
        bh=aXcTOBp8bNgdxJsVsJ1yU7POIrdQzO84nrQ0ZDLsP0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y4R3byLngk9KAVBUU+JB/KKhvO3U1TqyCSSZ7JKyhb2/H8Wm3mkmEEy5y2KS3p+BW
         P/dNbR6y17QYPjnQwSD3buVPhsGM5tLEy8VTs1VkO3yUJthmPJlB4diKD4wvjDDEzJ
         USLCVFaZzB+rVffEjZCg0vV/IOOV12MYAV0PSVxA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Long Li <longli@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH 4.20 130/145] CIFS: use the correct length when pinning memory for direct I/O for write
Date:   Mon,  7 Jan 2019 13:32:47 +0100
Message-Id: <20190107104454.179028436@linuxfoundation.org>
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

From: Long Li <longli@microsoft.com>

commit b6bc8a7b993e62f82415a5e3e4a6469e80fea19c upstream.

The current code attempts to pin memory using the largest possible wsize
based on the currect SMB credits. This doesn't cause kernel oops but this
is not optimal as we may pin more pages then actually needed.

Fix this by only pinning what are needed for doing this write I/O.

Signed-off-by: Long Li <longli@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/file.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2617,11 +2617,13 @@ cifs_write_from_iter(loff_t offset, size
 		if (rc)
 			break;
 
+		cur_len = min_t(const size_t, len, wsize);
+
 		if (ctx->direct_io) {
 			ssize_t result;
 
 			result = iov_iter_get_pages_alloc(
-				from, &pagevec, wsize, &start);
+				from, &pagevec, cur_len, &start);
 			if (result < 0) {
 				cifs_dbg(VFS,
 					"direct_writev couldn't get user pages "


