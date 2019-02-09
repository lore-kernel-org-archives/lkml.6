Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E6DC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9468421939
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738170;
	bh=kcuWM7av6LF/Rcy68oUYXEixEUBdpIVj4lLsPCHBA20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X6xUZm+ukUHAVmSvZCl4aY/0ypJHnDnAORPG8eJiNz+z1ycRZxsWBcVKNGa17RxLN
	 svI4Oob59RnRecf2FPjd/v0Rkg6QILrcQuy/u+OFazkhZ4wrgP3OWJi+/0IfhvhpAf
	 CUz8CCfrwVi1UH8FcFWUGegHnoov5QtMy2Yk4umA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfBISt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:49:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727476AbfBISt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:49:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21D7421939;
        Sat,  9 Feb 2019 18:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738165;
        bh=kcuWM7av6LF/Rcy68oUYXEixEUBdpIVj4lLsPCHBA20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qqZvQL6G6o7Lpqf0zmQFLhp6/NkhG+kWYOWcvKnIuTvVYGMC/7UVCd9L4TltrS3xS
         2fs7/RizTL90cIfrfKOSEGn0kzIxaXzV/gbxL58+tMnrr//CxFFk6G6htdD2M+JOxk
         kzI4rWwrqv1rjkNoHUjic5Pawb8KQLB5cnSf2nEk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 27/28] cifs: Limit memory used by lock request calls to a page
Date:   Sat,  9 Feb 2019 13:48:35 -0500
Message-Id: <20190209184840.126418-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184840.126418-1-sashal@kernel.org>
References: <20190209184840.126418-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit 92a8109e4d3a34fb6b115c9098b51767dc933444 ]

The code tries to allocate a contiguous buffer with a size supplied by
the server (maxBuf). This could fail if memory is fragmented since it
results in high order allocations for commonly used server
implementations. It is also wasteful since there are probably
few locks in the usual case. Limit the buffer to be no larger than a
page to avoid memory allocation failures due to fragmentation.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/file.c     | 8 ++++++++
 fs/cifs/smb2file.c | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 7b637fc27990..23db881daab5 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1128,6 +1128,10 @@ cifs_push_mandatory_locks(struct cifsFileInfo *cfile)
 		return -EINVAL;
 	}
 
+	BUILD_BUG_ON(sizeof(struct smb_hdr) + sizeof(LOCKING_ANDX_RANGE) >
+		     PAGE_SIZE);
+	max_buf = min_t(unsigned int, max_buf - sizeof(struct smb_hdr),
+			PAGE_SIZE);
 	max_num = (max_buf - sizeof(struct smb_hdr)) /
 						sizeof(LOCKING_ANDX_RANGE);
 	buf = kcalloc(max_num, sizeof(LOCKING_ANDX_RANGE), GFP_KERNEL);
@@ -1466,6 +1470,10 @@ cifs_unlock_range(struct cifsFileInfo *cfile, struct file_lock *flock,
 	if (max_buf < (sizeof(struct smb_hdr) + sizeof(LOCKING_ANDX_RANGE)))
 		return -EINVAL;
 
+	BUILD_BUG_ON(sizeof(struct smb_hdr) + sizeof(LOCKING_ANDX_RANGE) >
+		     PAGE_SIZE);
+	max_buf = min_t(unsigned int, max_buf - sizeof(struct smb_hdr),
+			PAGE_SIZE);
 	max_num = (max_buf - sizeof(struct smb_hdr)) /
 						sizeof(LOCKING_ANDX_RANGE);
 	buf = kcalloc(max_num, sizeof(LOCKING_ANDX_RANGE), GFP_KERNEL);
diff --git a/fs/cifs/smb2file.c b/fs/cifs/smb2file.c
index 2fc3d31967ee..b204e84b87fb 100644
--- a/fs/cifs/smb2file.c
+++ b/fs/cifs/smb2file.c
@@ -128,6 +128,8 @@ smb2_unlock_range(struct cifsFileInfo *cfile, struct file_lock *flock,
 	if (max_buf < sizeof(struct smb2_lock_element))
 		return -EINVAL;
 
+	BUILD_BUG_ON(sizeof(struct smb2_lock_element) > PAGE_SIZE);
+	max_buf = min_t(unsigned int, max_buf, PAGE_SIZE);
 	max_num = max_buf / sizeof(struct smb2_lock_element);
 	buf = kcalloc(max_num, sizeof(struct smb2_lock_element), GFP_KERNEL);
 	if (!buf)
@@ -264,6 +266,8 @@ smb2_push_mandatory_locks(struct cifsFileInfo *cfile)
 		return -EINVAL;
 	}
 
+	BUILD_BUG_ON(sizeof(struct smb2_lock_element) > PAGE_SIZE);
+	max_buf = min_t(unsigned int, max_buf, PAGE_SIZE);
 	max_num = max_buf / sizeof(struct smb2_lock_element);
 	buf = kcalloc(max_num, sizeof(struct smb2_lock_element), GFP_KERNEL);
 	if (!buf) {
-- 
2.19.1

