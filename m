Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC00C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089F920859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570287;
	bh=9Jcs2Orod+NAcX38gv/xoyWZf331I8PcFb1Yq0LuZHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HyTxa4WZzi44sNGESTUASAosgQWZ9082ADaMRMylKP33MLSGXw6ibIvQV3QhrMb82
	 Y/P2f6O98Bj57G0hHv+lblsG06bI3rOjxqH/tQSLpDrDvkJteIrTWLY0Wh0+6W7sSo
	 URc4hZgyy8skkpm2+WLRwy+pvxYwxSZqIzUQ3ui8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbfAOQiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:38:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731979AbfAOQh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:37:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7474A2054F;
        Tue, 15 Jan 2019 16:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570278;
        bh=9Jcs2Orod+NAcX38gv/xoyWZf331I8PcFb1Yq0LuZHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W3ixRwPP90coAA4Ac9qT2OHxcjLqt2q0vcK3JGUnMxWIENf7iGEpU2YsFOpXWll1m
         5AaKC1c4zsJTHtqnKGSdXEVKwKQPpwo47t2GviOP9IFmNhXAACTVY5GF84fZ/HoM8p
         XazfW/OzE/JVeWiQD9fIe6Ucugsvg03FcUhAaQjM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Lagerwall <ross.lagerwall@citrix.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.4 34/51] cifs: Fix potential OOB access of lock element array
Date:   Tue, 15 Jan 2019 17:35:30 +0100
Message-Id: <20190115154851.581036928@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
References: <20190115154846.928796000@linuxfoundation.org>
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
@@ -1073,10 +1073,10 @@ cifs_push_mandatory_locks(struct cifsFil
 
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
@@ -1404,10 +1404,10 @@ cifs_unlock_range(struct cifsFileInfo *c
 
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


