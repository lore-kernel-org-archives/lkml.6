Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860A4C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455A3224E3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2djH1sh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455A3224E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404966AbeKLIZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:25:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:32830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404940AbeKLIZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:25:11 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0D5921780;
        Sun, 11 Nov 2018 22:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975712;
        bh=mWfZ2vXE6sR4YQH1P4FL7ucoP/imPGUmkGa8gv0UE5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i2djH1shfwIrmQCkMaA/NcJT6hJ/BlnhIOfvBfkwEkbPhV+5dHc4tAEmbnsttS8ot
         BmMMJdUGYehkXvKPytYtTTckzZJN7Unz+pzOB29nYSWnHMg8ikvmnU6s/lG5mK33DT
         +aEzJCdzkIhA3lPkx3L0xHAkNJ8VUxefMGgQzLLU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 4.9 107/141] smb3: do not attempt cifs operation in smb3 query info error path
Date:   Sun, 11 Nov 2018 14:26:06 -0800
Message-Id: <20181111221642.853413254@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit 1e77a8c204c9d1b655c61751b8ad0fde22421dbb upstream.

If backupuid mount option is sent, we can incorrectly retry
(on access denied on query info) with a cifs (FindFirst) operation
on an smb3 mount which causes the server to force the session close.

We set backup intent on open so no need for this fallback.

See kernel bugzilla 201435

Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/inode.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -768,7 +768,15 @@ cifs_get_inode_info(struct inode **inode
 	} else if (rc == -EREMOTE) {
 		cifs_create_dfs_fattr(&fattr, sb);
 		rc = 0;
-	} else if (rc == -EACCES && backup_cred(cifs_sb)) {
+	} else if ((rc == -EACCES) && backup_cred(cifs_sb) &&
+		   (strcmp(server->vals->version_string, SMB1_VERSION_STRING)
+		      == 0)) {
+			/*
+			 * For SMB2 and later the backup intent flag is already
+			 * sent if needed on open and there is no path based
+			 * FindFirst operation to use to retry with
+			 */
+
 			srchinf = kzalloc(sizeof(struct cifs_search_info),
 						GFP_KERNEL);
 			if (srchinf == NULL) {


