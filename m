Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E94C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1381F2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865920;
	bh=w/3jC2/4JuIRuaFXZr2aHUCzZZZEV/teArDHE8w22V0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ssEsq+ZRwBMEQ0USWIA1b5MqYTD1wKZpKawiaBI9yX0Ru9mUXDftu8f9F3eqxD9zc
	 VBWAuFoGpNfRLM1wAhy2AySuxX5GBCVp7lxUEvWgWQyX/LKJTjnf72mtPDthhrtqqn
	 qlVd+uv9CLTjvdr0SuU4xUvcQhBqcRMtOsgEg3mI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbfAGM6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:58:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730003AbfAGM6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:58:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23603206BB;
        Mon,  7 Jan 2019 12:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865915;
        bh=w/3jC2/4JuIRuaFXZr2aHUCzZZZEV/teArDHE8w22V0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tf+z8bERFSrx+PgwPwcNJST82JKyt2rDvf55bmdvJaUJ0y2T5NqHj2Lkfylu+3coB
         5jmTGvKZirIO9PxYwW2ezecbfgpqmTLyxct6dVCEk2dJBVCRTKKGGmWC61gkYrqCto
         pPSTItOCfngZbuaIy8lGq+5CByBu/X4SMXSSLluY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Georgy A Bystrenin <gkot@altlinux.org>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.19 157/170] CIFS: Fix error mapping for SMB2_LOCK command which caused OFD lock problem
Date:   Mon,  7 Jan 2019 13:33:04 +0100
Message-Id: <20190107104511.466085660@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Georgy A Bystrenin <gkot@altlinux.org>

commit 9a596f5b39593414c0ec80f71b94a226286f084e upstream.

While resolving a bug with locks on samba shares found a strange behavior.
When a file locked by one node and we trying to lock it from another node
it fail with errno 5 (EIO) but in that case errno must be set to
(EACCES | EAGAIN).
This isn't happening when we try to lock file second time on same node.
In this case it returns EACCES as expected.
Also this issue not reproduces when we use SMB1 protocol (vers=1.0 in
mount options).

Further investigation showed that the mapping from status_to_posix_error
is different for SMB1 and SMB2+ implementations.
For SMB1 mapping is [NT_STATUS_LOCK_NOT_GRANTED to ERRlock]
(See fs/cifs/netmisc.c line 66)
but for SMB2+ mapping is [STATUS_LOCK_NOT_GRANTED to -EIO]
(see fs/cifs/smb2maperror.c line 383)

Quick changes in SMB2+ mapping from EIO to EACCES has fixed issue.

BUG: https://bugzilla.kernel.org/show_bug.cgi?id=201971

Signed-off-by: Georgy A Bystrenin <gkot@altlinux.org>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2maperror.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/cifs/smb2maperror.c
+++ b/fs/cifs/smb2maperror.c
@@ -379,8 +379,8 @@ static const struct status_to_posix_erro
 	{STATUS_NONEXISTENT_EA_ENTRY, -EIO, "STATUS_NONEXISTENT_EA_ENTRY"},
 	{STATUS_NO_EAS_ON_FILE, -ENODATA, "STATUS_NO_EAS_ON_FILE"},
 	{STATUS_EA_CORRUPT_ERROR, -EIO, "STATUS_EA_CORRUPT_ERROR"},
-	{STATUS_FILE_LOCK_CONFLICT, -EIO, "STATUS_FILE_LOCK_CONFLICT"},
-	{STATUS_LOCK_NOT_GRANTED, -EIO, "STATUS_LOCK_NOT_GRANTED"},
+	{STATUS_FILE_LOCK_CONFLICT, -EACCES, "STATUS_FILE_LOCK_CONFLICT"},
+	{STATUS_LOCK_NOT_GRANTED, -EACCES, "STATUS_LOCK_NOT_GRANTED"},
 	{STATUS_DELETE_PENDING, -ENOENT, "STATUS_DELETE_PENDING"},
 	{STATUS_CTL_FILE_NOT_SUPPORTED, -ENOSYS,
 	"STATUS_CTL_FILE_NOT_SUPPORTED"},


