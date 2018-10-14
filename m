Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A83C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A8920835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A8920835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbeJNXMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:12:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36202 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728031AbeJNXMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:01 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLo-0004cg-9w; Sun, 14 Oct 2018 16:30:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLX-0000Z3-Rg; Sun, 14 Oct 2018 16:30:23 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Steve French" <stfrench@microsoft.com>,
        "Long Li" <longli@microsoft.com>,
        "Tom Talpey" <ttalpey@microsoft.com>,
        "Ronnie Sahlberg" <lsahlber@redhat.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.662745668@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 275/366] cifs: Allocate validate negotiation request
 through kmalloc
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <longli@microsoft.com>

commit 2796d303e3c5ec213c578ed3a66872205c126eb8 upstream.

The data buffer allocated on the stack can't be DMA'ed, ib_dma_map_page will
return an invalid DMA address for a buffer on stack. Even worse, this
incorrect address can't be detected by ib_dma_mapping_error. Sending data
from this address to hardware will not fail, but the remote peer will get
junk data.

Fix this by allocating the request on the heap in smb3_validate_negotiate.

Changes in v2:
Removed duplicated code on freeing buffers on function exit.
(Thanks to Parav Pandit <parav@mellanox.com>)
Fixed typo in the patch title.

Changes in v3:
Added "Fixes" to the patch.
Changed several sizeof() to use *pointer in place of struct.

Changes in v4:
Added detailed comments on the failure through RDMA.
Allocate request buffer using GPF_NOFS.
Fixed possible memory leak.

Changes in v5:
Removed variable ret for checking return value.
Changed to use pneg_inbuf->Dialects[0] to calculate unused space in pneg_inbuf.

Fixes: ff1c038addc4 ("Check SMB3 dialects against downgrade attacks")
Signed-off-by: Long Li <longli@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Tom Talpey <ttalpey@microsoft.com>
[bwh: Backported to 3.16: We only ever pass one dialect]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/smb2pdu.c | 68 ++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -477,8 +477,8 @@ neg_exit:
 
 int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 {
-	int rc = 0;
-	struct validate_negotiate_info_req vneg_inbuf;
+	int rc;
+	struct validate_negotiate_info_req *pneg_inbuf;
 	struct validate_negotiate_info_rsp *pneg_rsp = NULL;
 	u32 rsplen;
 
@@ -502,42 +502,47 @@ int smb3_validate_negotiate(const unsign
 	if (tcon->ses->session_flags & SMB2_SESSION_FLAG_IS_NULL)
 		cifs_dbg(VFS, "Unexpected null user (anonymous) auth flag sent by server\n");
 
-	vneg_inbuf.Capabilities =
+	pneg_inbuf = kmalloc(sizeof(*pneg_inbuf), GFP_NOFS);
+	if (!pneg_inbuf)
+		return -ENOMEM;
+
+	pneg_inbuf->Capabilities =
 			cpu_to_le32(tcon->ses->server->vals->req_capabilities);
-	memcpy(vneg_inbuf.Guid, tcon->ses->server->client_guid,
+	memcpy(pneg_inbuf->Guid, tcon->ses->server->client_guid,
 					SMB2_CLIENT_GUID_SIZE);
 
 	if (tcon->ses->sign)
-		vneg_inbuf.SecurityMode =
+		pneg_inbuf->SecurityMode =
 			cpu_to_le16(SMB2_NEGOTIATE_SIGNING_REQUIRED);
 	else if (global_secflags & CIFSSEC_MAY_SIGN)
-		vneg_inbuf.SecurityMode =
+		pneg_inbuf->SecurityMode =
 			cpu_to_le16(SMB2_NEGOTIATE_SIGNING_ENABLED);
 	else
-		vneg_inbuf.SecurityMode = 0;
+		pneg_inbuf->SecurityMode = 0;
 
-	vneg_inbuf.DialectCount = cpu_to_le16(1);
-	vneg_inbuf.Dialects[0] =
+	pneg_inbuf->DialectCount = cpu_to_le16(1);
+	pneg_inbuf->Dialects[0] =
 		cpu_to_le16(tcon->ses->server->vals->protocol_id);
 
 	rc = SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
 		FSCTL_VALIDATE_NEGOTIATE_INFO, true /* is_fsctl */,
-		(char *)&vneg_inbuf, sizeof(struct validate_negotiate_info_req),
+		(char *)pneg_inbuf, sizeof(struct validate_negotiate_info_req),
 		(char **)&pneg_rsp, &rsplen);
 
 	if (rc != 0) {
 		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
-		return -EIO;
+		rc = -EIO;
+		goto out_free_inbuf;
 	}
 
-	if (rsplen != sizeof(struct validate_negotiate_info_rsp)) {
+	rc = -EIO;
+	if (rsplen != sizeof(*pneg_rsp)) {
 		cifs_dbg(VFS, "invalid protocol negotiate response size: %d\n",
 			 rsplen);
 
 		/* relax check since Mac returns max bufsize allowed on ioctl */
-		if ((rsplen > CIFSMaxBufSize)
-		     || (rsplen < sizeof(struct validate_negotiate_info_rsp)))
-			goto err_rsp_free;
+		if (rsplen > CIFSMaxBufSize || rsplen < sizeof(*pneg_rsp))
+			goto out_free_rsp;
 	}
 
 	/* check validate negotiate info response matches what we got earlier */
@@ -554,15 +559,17 @@ int smb3_validate_negotiate(const unsign
 		goto vneg_out;
 
 	/* validate negotiate successful */
+	rc = 0;
 	cifs_dbg(FYI, "validate negotiate info successful\n");
-	kfree(pneg_rsp);
-	return 0;
+	goto out_free_rsp;
 
 vneg_out:
 	cifs_dbg(VFS, "protocol revalidation - security settings mismatch\n");
-err_rsp_free:
+out_free_rsp:
 	kfree(pneg_rsp);
-	return -EIO;
+out_free_inbuf:
+	kfree(pneg_inbuf);
+	return rc;
 }
 
 int

