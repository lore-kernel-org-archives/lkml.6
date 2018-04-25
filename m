Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756085AbeDYSba (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:31:30 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:46822
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752902AbeDYSb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:31:27 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH rebased] cifs: smbd: Enable signing with smbdirect
Date: Wed, 25 Apr 2018 11:30:05 -0700
Message-Id: <20180425183005.9347-2-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180425183005.9347-1-longli@linuxonhyperv.com>
References: <20180425183005.9347-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfNg/tOEB4jYckg5T6oRTexEvnwYHZJlFHXSnUVgYWUNhtpiJYrmG8N0YWmwTYm1HGPrBvdOly3N1GAg/qX/q383RlgdCCXbIsa4t9WNOUCtMWAM+cTVX
 5o6BJ9MmFGq/C3d0OxHtUy8NqHjm8XZziQAOilSZOpDhV1ZdZCcqDGb2+K8XgGjdVF2CFDEYmiJtvUs72M9L65DRC49PUxBIhJavwKq5j2LakQfa/NLLz+VM
 65pC8JsGwTOCNOp3Vi7nd3jowclr0HEMeLKmMZXHpKVI263+mx1df7whltiaF4YeHCHTvOs+3FLrJiTj7XrHBEJ01aEdG4TeKlOMSi1QEZtGAQcnyMSOZgO3
 sTTaRqyb8YA9hweC2Y9vhlCAbF12/ohZuqKCiPH7eioCPI8zdfe8oy+zlUrqDJqWSaaQz3s3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

Now signing is supported with RDMA transport.

Remove the code that disabled it.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/connect.c | 8 --------
 fs/cifs/smb2pdu.c | 5 -----
 2 files changed, 13 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index e8830f0..deef270 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1977,14 +1977,6 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 		goto cifs_parse_mount_err;
 	}
 
-#ifdef CONFIG_CIFS_SMB_DIRECT
-	if (vol->rdma && vol->sign) {
-		cifs_dbg(VFS, "Currently SMB direct doesn't support signing."
-			" This is being fixed\n");
-		goto cifs_parse_mount_err;
-	}
-#endif
-
 #ifndef CONFIG_KEYS
 	/* Muliuser mounts require CONFIG_KEYS support */
 	if (vol->multiuser) {
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 8472f32..b16f953 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -737,11 +737,6 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 
 	cifs_dbg(FYI, "validate negotiate\n");
 
-#ifdef CONFIG_CIFS_SMB_DIRECT
-	if (tcon->ses->server->rdma)
-		return 0;
-#endif
-
 	/* In SMB3.11 preauth integrity supersedes validate negotiate */
 	if (tcon->ses->server->dialect == SMB311_PROT_ID)
 		return 0;
-- 
2.7.4
