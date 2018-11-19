Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCCBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C869C214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQIAEXf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C869C214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404572AbeKTDXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:23:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:35144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403980AbeKTDXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:23:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DE5D2148E;
        Mon, 19 Nov 2018 16:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646737;
        bh=WahMsRuBxL2nAPrJ4ZMmfi3Zbuo215R7x1p6PJeM/dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQIAEXf7HXCBHUOfkQqU/5Hruijzv54TORRb7r3O6Nlu7z7C8xBOPKl0L55weOZfY
         HEmNobmpW2V2bdQsLDVNQqVaVm/8neHBmTFQmUodwcSiiwDh8Du8KTJtnKuA2MO6Se
         6EG6lHPw/08Fn3tP82tlOafzFEeURy8a+v1iB1AI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 4.4 064/160] smb3: do not attempt cifs operation in smb3 query info error path
Date:   Mon, 19 Nov 2018 17:28:23 +0100
Message-Id: <20181119162637.594941192@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -756,7 +756,15 @@ cifs_get_inode_info(struct inode **inode
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


