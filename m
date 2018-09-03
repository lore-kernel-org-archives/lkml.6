Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E5EC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020E720862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020E720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbeICVUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:20:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38500 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbeICVUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:20:08 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1C779CFB;
        Mon,  3 Sep 2018 16:59:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Stefan Metzmacher <metze@samba.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.4 43/80] smb3: Do not send SMB3 SET_INFO if nothing changed
Date:   Mon,  3 Sep 2018 18:49:21 +0200
Message-Id: <20180903164935.870280645@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164934.171677301@linuxfoundation.org>
References: <20180903164934.171677301@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit fd09b7d3b352105f08b8e02f7afecf7e816380ef upstream.

An earlier commit had a typo which prevented the
optimization from working:

commit 18dd8e1a65dd ("Do not send SMB3 SET_INFO request if nothing is changing")

Thank you to Metze for noticing this.  Also clear a
reserved field in the FILE_BASIC_INFO struct we send
that should be zero (all the other fields in that
struct were set or cleared explicitly already in
cifs_set_file_info).

Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
CC: Stable <stable@vger.kernel.org> # 4.9.x+
Reported-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/inode.c     |    2 ++
 fs/cifs/smb2inode.c |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -1063,6 +1063,8 @@ cifs_set_file_info(struct inode *inode,
 	if (!server->ops->set_file_info)
 		return -ENOSYS;
 
+	info_buf.Pad = 0;
+
 	if (attrs->ia_valid & ATTR_ATIME) {
 		set_time = true;
 		info_buf.LastAccessTime =
--- a/fs/cifs/smb2inode.c
+++ b/fs/cifs/smb2inode.c
@@ -267,7 +267,7 @@ smb2_set_file_info(struct inode *inode,
 	int rc;
 
 	if ((buf->CreationTime == 0) && (buf->LastAccessTime == 0) &&
-	    (buf->LastWriteTime == 0) && (buf->ChangeTime) &&
+	    (buf->LastWriteTime == 0) && (buf->ChangeTime == 0) &&
 	    (buf->Attributes == 0))
 		return 0; /* would be a no op, no sense sending this */
 


