Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A45FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE68F217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497647;
	bh=zHKRGemVqvcZi2+NoR3AImf85XUtOiLFTm3dc3/RK4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=unfb6ItMpW8SJr5ZnAn6bpD7iiHlpl3hjFvunBv4ArOqjy4+R7go/6Pzu3dqVPKJ8
	 ju7799Eh5Q4g5le3SM5xFiidwp+CikyKtbkAObWoXX+0MapHFodg8fo+SZmAgZ/kX6
	 kG3OENdJ8ooacGT26sxKx9eMrrd6SrGIDlmu5evA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfBRNrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:47:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:53984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730945AbfBRNrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:47:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C46B2218FC;
        Mon, 18 Feb 2019 13:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497642;
        bh=zHKRGemVqvcZi2+NoR3AImf85XUtOiLFTm3dc3/RK4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gOFVQdbwqTdhsGZoe/z0ASEeIX1hCQuM9THsUsFA4+VQG/2GtvVzxPSF64W6VZ0if
         ZphwCzL0fUPWgZXGIQFthkUQt1tj1hxkh+52/m9CMDudui7m0hWo9+YRWrqrG9ZaxS
         gF716oNaKVC7R2KNWU5NcwwP2PMG8PzQI043BRHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Lagerwall <ross.lagerwall@citrix.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 41/92] cifs: Limit memory used by lock request calls to a page
Date:   Mon, 18 Feb 2019 14:42:44 +0100
Message-Id: <20190218133458.550361264@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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
index 8431854b129f..116f8af0384f 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1139,6 +1139,10 @@ cifs_push_mandatory_locks(struct cifsFileInfo *cfile)
 		return -EINVAL;
 	}
 
+	BUILD_BUG_ON(sizeof(struct smb_hdr) + sizeof(LOCKING_ANDX_RANGE) >
+		     PAGE_SIZE);
+	max_buf = min_t(unsigned int, max_buf - sizeof(struct smb_hdr),
+			PAGE_SIZE);
 	max_num = (max_buf - sizeof(struct smb_hdr)) /
 						sizeof(LOCKING_ANDX_RANGE);
 	buf = kcalloc(max_num, sizeof(LOCKING_ANDX_RANGE), GFP_KERNEL);
@@ -1477,6 +1481,10 @@ cifs_unlock_range(struct cifsFileInfo *cfile, struct file_lock *flock,
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



