Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34965C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0456A20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571541;
	bh=SELms0P1p1dt6jLhOavljk9eCjEl6q0oHrVBkTFYbFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l9kHs6TZtSlLQWYHtowkGv9Od8CiNez0lYzXLwXd+23Es3zAXkKivEJ7CRm2zQbl5
	 Cu4pPEKMnFLWJ7IbT1Y/mGpypj7fx0wHBM9ITgTi2f2rkkr1hxJB+t3krWgo9mgsR9
	 G/GtZylIE4W7dDow11HuJka0hwWE9oMzsZ8ukz/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbfAOQjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:39:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:55774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732368AbfAOQjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:39:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 773FA2054F;
        Tue, 15 Jan 2019 16:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570376;
        bh=SELms0P1p1dt6jLhOavljk9eCjEl6q0oHrVBkTFYbFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=npoi7nXssG5eZsbSXbwxDsFP/TSvsLP58gaZzKtW2wfyCzHVh/D/DcW00u8Hd8XOY
         SpOXuUcFBgnO5+v0qP9JfXFRSuMQIWSs8SMKsLTxAj7IKy3ZSqU0HPToRm/9scLkFO
         yteGka1mWWy/CrWSYQyjWFe9cKC7v3DcEKZ0pH1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Lagerwall <ross.lagerwall@citrix.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.9 03/16] cifs: Fix potential OOB access of lock element array
Date:   Tue, 15 Jan 2019 17:35:46 +0100
Message-Id: <20190115154848.502629068@linuxfoundation.org>
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

From: Ross Lagerwall <ross.lagerwall@citrix.com>

commit b9a74cde94957d82003fb9f7ab4777938ca851cd upstream.

If maxBuf is small but non-zero, it could result in a zero sized lock
element array which we would then try and access OOB.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/file.c     |    8 ++++----
 fs/cifs/smb2file.c |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1118,10 +1118,10 @@ cifs_push_mandatory_locks(struct cifsFil
 
 	/*
 	 * Accessing maxBuf is racy with cifs_reconnect - need to store value
-	 * and check it for zero before using.
+	 * and check it before using.
 	 */
 	max_buf = tcon->ses->server->maxBuf;
-	if (!max_buf) {
+	if (max_buf < (sizeof(struct smb_hdr) + sizeof(LOCKING_ANDX_RANGE))) {
 		free_xid(xid);
 		return -EINVAL;
 	}
@@ -1456,10 +1456,10 @@ cifs_unlock_range(struct cifsFileInfo *c
 
 	/*
 	 * Accessing maxBuf is racy with cifs_reconnect - need to store value
-	 * and check it for zero before using.
+	 * and check it before using.
 	 */
 	max_buf = tcon->ses->server->maxBuf;
-	if (!max_buf)
+	if (max_buf < (sizeof(struct smb_hdr) + sizeof(LOCKING_ANDX_RANGE)))
 		return -EINVAL;
 
 	max_num = (max_buf - sizeof(struct smb_hdr)) /
--- a/fs/cifs/smb2file.c
+++ b/fs/cifs/smb2file.c
@@ -123,10 +123,10 @@ smb2_unlock_range(struct cifsFileInfo *c
 
 	/*
 	 * Accessing maxBuf is racy with cifs_reconnect - need to store value
-	 * and check it for zero before using.
+	 * and check it before using.
 	 */
 	max_buf = tcon->ses->server->maxBuf;
-	if (!max_buf)
+	if (max_buf < sizeof(struct smb2_lock_element))
 		return -EINVAL;
 
 	max_num = max_buf / sizeof(struct smb2_lock_element);


