Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7647C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E7120821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738263;
	bh=69xwimEh0fPwgOkhqAtuTAZur9+nuswaj4+xP0IA/f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ouGi3bb8O3a+oEtA0dZ5E4pUWjy1ewiHM63uF0dw3/jkxeNZ1qTFkUD3qHbvnegAb
	 vMSLaQI6TcwrsG9Vkz8qaoO/ugSxZq/d6/S46brsVu9y4Np5uoTgpRq89ECdnLK75u
	 T/kILWBKcR2aydZN/kXdDt06JU9lQGQAPq0n48pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfBISvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:51:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbfBISuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:50:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77FD12192C;
        Sat,  9 Feb 2019 18:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738207;
        bh=69xwimEh0fPwgOkhqAtuTAZur9+nuswaj4+xP0IA/f0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/FvpqIZVHOjhv+GZN1RcLkl0bC+haoxqf94ErTA/tF2XszWZzV+B9QQRpMqNt6tH
         Z0FQEaWxD7v2fEwEgsvyh+DBElcM5aL7Xw46BzV0rvxiKhXAgrLa5+itKsOgJZLxnR
         2EorRrAadOM54rGFlC0s2/pkKw1sJ+/i5N+SHIgQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 12/12] cifs: Limit memory used by lock request calls to a page
Date:   Sat,  9 Feb 2019 13:49:52 -0500
Message-Id: <20190209184952.127009-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184952.127009-1-sashal@kernel.org>
References: <20190209184952.127009-1-sashal@kernel.org>
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
index a3046b6523c8..8ec296308729 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1126,6 +1126,10 @@ cifs_push_mandatory_locks(struct cifsFileInfo *cfile)
 		return -EINVAL;
 	}
 
+	BUILD_BUG_ON(sizeof(struct smb_hdr) + sizeof(LOCKING_ANDX_RANGE) >
+		     PAGE_SIZE);
+	max_buf = min_t(unsigned int, max_buf - sizeof(struct smb_hdr),
+			PAGE_SIZE);
 	max_num = (max_buf - sizeof(struct smb_hdr)) /
 						sizeof(LOCKING_ANDX_RANGE);
 	buf = kcalloc(max_num, sizeof(LOCKING_ANDX_RANGE), GFP_KERNEL);
@@ -1462,6 +1466,10 @@ cifs_unlock_range(struct cifsFileInfo *cfile, struct file_lock *flock,
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
index b7885dc0d9bb..dee5250701de 100644
--- a/fs/cifs/smb2file.c
+++ b/fs/cifs/smb2file.c
@@ -129,6 +129,8 @@ smb2_unlock_range(struct cifsFileInfo *cfile, struct file_lock *flock,
 	if (max_buf < sizeof(struct smb2_lock_element))
 		return -EINVAL;
 
+	BUILD_BUG_ON(sizeof(struct smb2_lock_element) > PAGE_SIZE);
+	max_buf = min_t(unsigned int, max_buf, PAGE_SIZE);
 	max_num = max_buf / sizeof(struct smb2_lock_element);
 	buf = kcalloc(max_num, sizeof(struct smb2_lock_element), GFP_KERNEL);
 	if (!buf)
@@ -265,6 +267,8 @@ smb2_push_mandatory_locks(struct cifsFileInfo *cfile)
 		return -EINVAL;
 	}
 
+	BUILD_BUG_ON(sizeof(struct smb2_lock_element) > PAGE_SIZE);
+	max_buf = min_t(unsigned int, max_buf, PAGE_SIZE);
 	max_num = max_buf / sizeof(struct smb2_lock_element);
 	buf = kcalloc(max_num, sizeof(struct smb2_lock_element), GFP_KERNEL);
 	if (!buf) {
-- 
2.19.1

