Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F41C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A04920834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBZ52s8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A04920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbeJYWut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729259AbeJYWut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:49 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D1FA20869;
        Thu, 25 Oct 2018 14:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477071;
        bh=d2XrnhCyMz7eHbpy1A3LnEWhQDMaeehqu7Zu9RoMSCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JBZ52s8PhB5LH0TCBUUBLPL89Pti87Wo8NRK83CUL9fizPZJUPsUOHC8kmdABfBVo
         GWufz543FrhMVZQ4VXq245Meq6hC4nSk0Rz6EGfdcpLx7s4s67uc1bUSiABBavW5m+
         wq1zDz9VYWCULg3DoSbniIwwgpVWqR196HKwivEI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Syms <mark.syms@citrix.com>,
        Steve French <smfrench@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 26/65] CIFS: handle guest access errors to Windows shares
Date:   Thu, 25 Oct 2018 10:16:26 -0400
Message-Id: <20181025141705.213937-26-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Syms <mark.syms@citrix.com>

[ Upstream commit 40920c2bb119fd49ba03e2f97a172171781be442 ]

Commit 1a967d6c9b39c226be1b45f13acd4d8a5ab3dc44 ("correctly to
anonymous authentication for the NTLM(v2) authentication") introduces
a regression in handling errors related to attempting a guest
connection to a Windows share which requires authentication. This
should result in a permission denied error but actually causes the
kernel module to enter a never-ending loop trying to follow a DFS
referal which doesn't exist.

The base cause of this is the failure now occurs later in the process
during tree connect and not at the session setup setup and all errors
in tree connect are interpreted as needing to follow the DFS paths
which isn't in this case correct. So, check the returned error against
EACCES and fail if this is returned error.

Feedback from Aurelien:

  PS> net user guest /activate:no
    PS> mkdir C:\guestshare
      PS> icacls C:\guestshare /grant 'Everyone:(OI)(CI)F'
        PS> new-smbshare -name guestshare -path C:\guestshare -fullaccess Everyone

        I've tested v3.10, v4.4, master, master+your patch using default options
        (empty or no user "NU") and user=abc (U).

        NT_LOGON_FAILURE in session setup: LF
        This is what you seem to have in 3.10.

        NT_ACCESS_DENIED in tree connect to the share: AD
        This is what you get before your infinite loop.

                     |   NU       U
                     --------------------------------
                     3.10         |   LF       LF
                     4.4          |   LF       LF
                     master       |   AD       LF
                     master+patch |   AD       LF

                     No infinite DFS loop :(
                     All these issues result in mount failing very fast with permission denied.

                     I guess it could be from either the Windows version or the share/folder
                     ACL. A deeper analysis of the packets might reveal more.

                     In any case I did not notice any issues for on a basic DFS setup with
                     the patch so I don't think it introduced any regressions, which is
                     probably all that matters. It still bothers me a little I couldn't hit
                     the bug.

                     I've included kernel output w/ debugging output and network capture of
                     my tests if anyone want to have a look at it. (master+patch = ml-guestfix).

Signed-off-by: Mark Syms <mark.syms@citrix.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Tested-by: Aurelien Aptel <aaptel@suse.com>
Acked-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 077ad3a06c9a..1eeb4780c3ed 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -3674,6 +3674,9 @@ cifs_mount(struct cifs_sb_info *cifs_sb, struct smb_vol *volume_info)
 	if (IS_ERR(tcon)) {
 		rc = PTR_ERR(tcon);
 		tcon = NULL;
+		if (rc == -EACCES)
+			goto mount_fail_check;
+
 		goto remote_path_check;
 	}
 
-- 
2.17.1

