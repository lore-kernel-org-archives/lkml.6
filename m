Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756145AbeDYSbj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:31:39 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:54044
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754974AbeDYSbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:31:34 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v5] cifs: Allocate validate negotiation request through kmalloc
Date: Wed, 25 Apr 2018 11:30:04 -0700
Message-Id: <20180425183005.9347-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfH6r45S6KjTSZUrWAtpM02/by3TJzKxEsqrexRuX5au4FVonuX5JX6AcbAu9J/Q2TYqQf+rmcvKnSpK1Ih0wM14M7FZipjCUGT3Sj+/j70JMIoDxgBBF
 dwXvg60og191R2aAQUJyJr6ksRxZyl8xDD7VgCYUSu35v5YzfHhx8D4B5IWDbIapIzKZpQpYFkxDk7COQqw+r2YowEP5OjVMqACH0yGaXz153XIfxIpN263p
 Cg8gAR+wLepTFk9pEGWJ5SQmwBlcqQ/Px4QBIjABMxMuzCCbpl+yrP0wU5cz/MgRDdjSbJk/L0W5Q3A/1zo/1rrq9AwVRLJ8PvCQsxVpjX6LcDESYX1i3fJk
 1V3n55L+oWMRXIHxU4UcU42CiY5YO0zJwBNnxRebiXSEpabLN6Xc2R0I+Ex+hBJIfxbuHgu8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

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
---
 fs/cifs/smb2pdu.c | 68 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 0f044c4..66f1a7b 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -729,8 +729,8 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
 
 int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 {
-	int rc = 0;
-	struct validate_negotiate_info_req vneg_inbuf;
+	int rc;
+	struct validate_negotiate_info_req *pneg_inbuf;
 	struct validate_negotiate_info_rsp *pneg_rsp = NULL;
 	u32 rsplen;
 	u32 inbuflen; /* max of 4 dialects */
@@ -764,63 +764,69 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
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
 
 
 	if (strcmp(tcon->ses->server->vals->version_string,
 		SMB3ANY_VERSION_STRING) == 0) {
-		vneg_inbuf.Dialects[0] = cpu_to_le16(SMB30_PROT_ID);
-		vneg_inbuf.Dialects[1] = cpu_to_le16(SMB302_PROT_ID);
-		vneg_inbuf.DialectCount = cpu_to_le16(2);
+		pneg_inbuf->Dialects[0] = cpu_to_le16(SMB30_PROT_ID);
+		pneg_inbuf->Dialects[1] = cpu_to_le16(SMB302_PROT_ID);
+		pneg_inbuf->DialectCount = cpu_to_le16(2);
 		/* structure is big enough for 3 dialects, sending only 2 */
-		inbuflen = sizeof(struct validate_negotiate_info_req) - 2;
+		inbuflen = sizeof(*pneg_inbuf) -
+				sizeof(pneg_inbuf->Dialects[0]);
 	} else if (strcmp(tcon->ses->server->vals->version_string,
 		SMBDEFAULT_VERSION_STRING) == 0) {
-		vneg_inbuf.Dialects[0] = cpu_to_le16(SMB21_PROT_ID);
-		vneg_inbuf.Dialects[1] = cpu_to_le16(SMB30_PROT_ID);
-		vneg_inbuf.Dialects[2] = cpu_to_le16(SMB302_PROT_ID);
-		vneg_inbuf.DialectCount = cpu_to_le16(3);
+		pneg_inbuf->Dialects[0] = cpu_to_le16(SMB21_PROT_ID);
+		pneg_inbuf->Dialects[1] = cpu_to_le16(SMB30_PROT_ID);
+		pneg_inbuf->Dialects[2] = cpu_to_le16(SMB302_PROT_ID);
+		pneg_inbuf->DialectCount = cpu_to_le16(3);
 		/* structure is big enough for 3 dialects */
-		inbuflen = sizeof(struct validate_negotiate_info_req);
+		inbuflen = sizeof(*pneg_inbuf);
 	} else {
 		/* otherwise specific dialect was requested */
-		vneg_inbuf.Dialects[0] =
+		pneg_inbuf->Dialects[0] =
 			cpu_to_le16(tcon->ses->server->vals->protocol_id);
-		vneg_inbuf.DialectCount = cpu_to_le16(1);
+		pneg_inbuf->DialectCount = cpu_to_le16(1);
 		/* structure is big enough for 3 dialects, sending only 1 */
-		inbuflen = sizeof(struct validate_negotiate_info_req) - 4;
+		inbuflen = sizeof(*pneg_inbuf) -
+				sizeof(pneg_inbuf->Dialects[0]) * 2;
 	}
 
 	rc = SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
 		FSCTL_VALIDATE_NEGOTIATE_INFO, true /* is_fsctl */,
-		(char *)&vneg_inbuf, sizeof(struct validate_negotiate_info_req),
-		(char **)&pneg_rsp, &rsplen);
+		(char *)pneg_inbuf, inbuflen, (char **)&pneg_rsp, &rsplen);
 
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
@@ -837,15 +843,17 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
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
 
 enum securityEnum
-- 
2.7.4
