Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EC5C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327BB206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbeLPXSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 18:18:16 -0500
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:56128
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730911AbeLPXSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 18:18:15 -0500
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id YfesghRTUse9VYfesgsUNi; Sun, 16 Dec 2018 16:17:14 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1gYfes-0004N1-BI; Sun, 16 Dec 2018 16:17:14 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>, stable@vger.kernel.org
Subject: [PATCH] CIFS: use the correct length when pinning memory for direct I/O for write
Date:   Sun, 16 Dec 2018 23:17:04 +0000
Message-Id: <20181216231704.16761-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Reply-To: longli@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGn50yF0YsEmJGgTR0bJMjMMe42gCNFOtx6XwYFW+BOmbfQX/TjRVZLrWCIy/pJhbs/GHkGWp1V7zXNECmtXsNlmTrG/lruIgaMaD/auMaVhfqOwRw1r
 6YL98WADIw3wtC9QKGhS2jpIwVDK1BBy6Qnljd/DVPmUQCcLOMFdpibu1umOyniVYPqKaHnNVBjsBwA5HEgXzAW/0QCJtDfyufiiwtNMDsUkcdjdFbBJ+Unf
 +Pyy6CEWcW9x1I6BRi1B34Gj/GwOFh9RGtErz4JbxihuK5Py+ryUJols/W1P4Ykdwb/kBuqLJ3tjppBFcBUVEcsrbEVVw7GepHRu2hkKPWY1xpINznT/wUbT
 kKTCZshls9cssJHO+2SixDpu3vrJ3zz785oF/8D5LRCffyvmkn6pGLrDs51RwfiiNmvvOvd7n7n8IvHgvrpOIZoJ6IqwrPbdHPN0MEigRH6yeBoxQws=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

The current code attempts to pin memory using the largest possible wsize
based on the currect SMB credits. This doesn't cause kernel oops but this is
not optimal as we may pin more pages then actually needed.

Fix this by only pinning what are needed for doing this write I/O.

Signed-off-by: Long Li <longli@microsoft.com>
Cc: stable@vger.kernel.org
---
 fs/cifs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 3467351..c23bf9d 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2617,11 +2617,13 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
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
-- 
2.7.4

