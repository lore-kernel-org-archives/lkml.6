Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EF1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F164221902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499571;
	bh=/Q7asnHEvtYZbGowDsqMBio6p2qVX/A4QZ4pmzXjQE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aHK2Yp9TRoi32491S08xg7mZ9CQaMTWW1Nn/HwJ5feQ0bzI9TDItYVhlvvkz7JIwH
	 NfEFuq9PRHCYcUX+5gB7iOK9mlXkYnqolL13HkEo8mo2Dme6YbTIMHoxIT0uWlU8eX
	 06L3os8uUPO7lLbUAjxgbBi3rZsWb5QHOJhhWjEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389228AbfBROT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:19:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:51276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390839AbfBROIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:08:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF17521902;
        Mon, 18 Feb 2019 14:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498883;
        bh=/Q7asnHEvtYZbGowDsqMBio6p2qVX/A4QZ4pmzXjQE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QmTtgZifWiiFAAv423D163n0ALGE0VpCW+LbLDdLnVUD2+bYKZ52Mjjxo5A3y49I8
         7qUusP6YXOO1ywo15elN1AcVWZ21BoYjfL8XAwkzfuE2RH9ZcNfvwojVihWkrpaXyk
         tVUzmRe0QhSuSH9v8FFGthIpJzi7QHkPLETKs1Us=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Lagerwall <ross.lagerwall@citrix.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 123/143] cifs: Limit memory used by lock request calls to a page
Date:   Mon, 18 Feb 2019 14:44:11 +0100
Message-Id: <20190218133533.494382891@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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
index 026b399af215..1062e96ee272 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1081,6 +1081,10 @@ cifs_push_mandatory_locks(struct cifsFileInfo *cfile)
 		return -EINVAL;
 	}
 
+	BUILD_BUG_ON(sizeof(struct smb_hdr) + sizeof(LOCKING_ANDX_RANGE) >
+		     PAGE_SIZE);
+	max_buf = min_t(unsigned int, max_buf - sizeof(struct smb_hdr),
+			PAGE_SIZE);
 	max_num = (max_buf - sizeof(struct smb_hdr)) /
 						sizeof(LOCKING_ANDX_RANGE);
 	buf = kcalloc(max_num, sizeof(LOCKING_ANDX_RANGE), GFP_KERNEL);
@@ -1410,6 +1414,10 @@ cifs_unlock_range(struct cifsFileInfo *cfile, struct file_lock *flock,
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



