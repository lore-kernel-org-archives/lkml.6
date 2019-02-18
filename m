Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75C7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BCE21904
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497688;
	bh=VjxRX1tI0Y4RIHbnZc2KRdUQgYdEGH4fmoKHwmqfEu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IhBcngE4m+g980R1pOCN6BsU6PZpMhXNXeBA6XxNvrBbl5/LkQJxrfvRRqcqSNWRr
	 5tArsMZp5pv9PT+oJH8b32Fs6W3DIjmU9YkOwXqQRfrQRo9LhaPUZSDuq2rrOv6F/1
	 c93Au3E55nRIDuBZYRgegwZI5coFzlkIUXj7I39c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbfBRNsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:48:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731718AbfBRNq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:46:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1D7821900;
        Mon, 18 Feb 2019 13:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497617;
        bh=VjxRX1tI0Y4RIHbnZc2KRdUQgYdEGH4fmoKHwmqfEu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yuuU/x4RJcU1lnGR3YQwx0WwJBqeJ8l9S1nqPwi7Pf86+MivVMxw+7EE22iAz++kP
         YDLP1R7vZRGuy95WUC1tBoOwrGCZzxoSLNG6NrLdn6Yoz4+Xpfk8rvsNj1ac6fsmyF
         LgAdOHYqy1pRlBvOktCtTSm4CwsTdFS93ChTnjDo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 48/92] CIFS: Fix mounts if the client is low on credits
Date:   Mon, 18 Feb 2019 14:42:51 +0100
Message-Id: <20190218133459.197379708@linuxfoundation.org>
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

[ Upstream commit 6a9cbdd1ceca1dc2359ddf082efe61b97c3e752b ]

If the server doesn't grant us at least 3 credits during the mount
we won't be able to complete it because query path info operation
requires 3 credits. Use the cached file handle if possible to allow
the mount to succeed.

Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2inode.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/cifs/smb2inode.c b/fs/cifs/smb2inode.c
index a8999f930b22..057d2034209f 100644
--- a/fs/cifs/smb2inode.c
+++ b/fs/cifs/smb2inode.c
@@ -294,6 +294,8 @@ smb2_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
 	int rc;
 	struct smb2_file_all_info *smb2_data;
 	__u32 create_options = 0;
+	struct cifs_fid fid;
+	bool no_cached_open = tcon->nohandlecache;
 
 	*adjust_tz = false;
 	*symlink = false;
@@ -302,6 +304,21 @@ smb2_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
 			    GFP_KERNEL);
 	if (smb2_data == NULL)
 		return -ENOMEM;
+
+	/* If it is a root and its handle is cached then use it */
+	if (!strlen(full_path) && !no_cached_open) {
+		rc = open_shroot(xid, tcon, &fid);
+		if (rc)
+			goto out;
+		rc = SMB2_query_info(xid, tcon, fid.persistent_fid,
+				     fid.volatile_fid, smb2_data);
+		close_shroot(&tcon->crfid);
+		if (rc)
+			goto out;
+		move_smb2_info_to_cifs(data, smb2_data);
+		goto out;
+	}
+
 	if (backup_cred(cifs_sb))
 		create_options |= CREATE_OPEN_BACKUP_INTENT;
 
-- 
2.19.1



