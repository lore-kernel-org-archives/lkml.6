Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1A6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC62821848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216123;
	bh=zdwY2VuX+lZelimmzqF3jbKBjTmH3CMzaPX4UXxK/Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MgFCylOouT6rC/6rzncrdl4bZNVir04wKO292ELb7Jtfl/ugzv0ptQq8GAfRKFId5
	 7Uc2q4fSlClunAW/3OvzfTyBOdy8Vdl5B27Pi4usp5sZkJnHjz0e3cpQJP2MYz77g5
	 rXLu28WG/GeeX/MV+NP+ZBk3q1rBqbAOF5OENSB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbfAKOPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:15:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733261AbfAKOPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:15:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58145217D6;
        Fri, 11 Jan 2019 14:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216120;
        bh=zdwY2VuX+lZelimmzqF3jbKBjTmH3CMzaPX4UXxK/Jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mXjXbFWt/9sTHmeTwuEl2EP28qIiBzwpZ29YNS0jOH7rl0I9rwYsiR4gtusGqP3Oy
         BpF6Vc8StbhIEYgI9XiB4da/IBGC8Sh+ni5r1sDq2CJBc7+rMM1azEcxhhECGjZ3b+
         +mRsECuoeh/wVHgBVwaKGr6Lhvx6Of8bD5AcA8pQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Georgy A Bystrenin <gkot@altlinux.org>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 3.18 30/47] CIFS: Fix error mapping for SMB2_LOCK command which caused OFD lock problem
Date:   Fri, 11 Jan 2019 15:08:15 +0100
Message-Id: <20190111130959.957921641@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111130956.170952125@linuxfoundation.org>
References: <20190111130956.170952125@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -377,8 +377,8 @@ static const struct status_to_posix_erro
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


