Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDE9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9A3214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9A3214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbeKLFwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:52:17 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51172 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730716AbeKLFsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:31 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvss-0000oU-4F; Sun, 11 Nov 2018 19:59:02 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsV-0001gX-KZ; Sun, 11 Nov 2018 19:58:39 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Steve French" <smfrench@gmail.com>,
        "Ronnie Sahlberg" <lsahlber@redhat.com>,
        "Pavel Shilovsky" <pshilov@microsoft.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.53717379@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 233/366] cifs: store the leaseKey in the fid on SMB2_open
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ronnie Sahlberg <lsahlber@redhat.com>

commit 96164ab2d880c9539989bea68d4790f6fd619b1f upstream.

In SMB2_open(), if we got a lease we need to store this in the fid structure
or else we will never be able to map a lease break back to which file/fid
it applies to.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <smfrench@gmail.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/cifsglob.h | 2 +-
 fs/cifs/smb2ops.c  | 7 +++++--
 fs/cifs/smb2pdu.c  | 8 +++++---
 3 files changed, 11 insertions(+), 6 deletions(-)

--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -383,7 +383,7 @@ struct smb_version_operations {
 	/* create lease context buffer for CREATE request */
 	char * (*create_lease_buf)(u8 *, u8);
 	/* parse lease context buffer and return oplock/epoch info */
-	__u8 (*parse_lease_buf)(void *, unsigned int *);
+	__u8 (*parse_lease_buf)(void *buf, unsigned int *epoch, char *lkey);
 	int (*clone_range)(const unsigned int, struct cifsFileInfo *src_file,
 			struct cifsFileInfo *target_file, u64 src_off, u64 len,
 			u64 dest_off);
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1118,7 +1118,7 @@ smb3_create_lease_buf(u8 *lease_key, u8
 }
 
 static __u8
-smb2_parse_lease_buf(void *buf, unsigned int *epoch)
+smb2_parse_lease_buf(void *buf, unsigned int *epoch, char *lease_key)
 {
 	struct create_lease *lc = (struct create_lease *)buf;
 
@@ -1129,13 +1129,16 @@ smb2_parse_lease_buf(void *buf, unsigned
 }
 
 static __u8
-smb3_parse_lease_buf(void *buf, unsigned int *epoch)
+smb3_parse_lease_buf(void *buf, unsigned int *epoch, char *lease_key)
 {
 	struct create_lease_v2 *lc = (struct create_lease_v2 *)buf;
 
 	*epoch = le16_to_cpu(lc->lcontext.Epoch);
 	if (lc->lcontext.LeaseFlags & SMB2_LEASE_FLAG_BREAK_IN_PROGRESS)
 		return SMB2_OPLOCK_LEVEL_NOCHANGE;
+	if (lease_key)
+		memcpy(lease_key, &lc->lcontext.LeaseKeyLow,
+		       SMB2_LEASE_KEY_SIZE);
 	return le32_to_cpu(lc->lcontext.LeaseState);
 }
 
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1054,7 +1054,7 @@ create_reconnect_durable_buf(struct cifs
 
 static __u8
 parse_lease_state(struct TCP_Server_Info *server, struct smb2_create_rsp *rsp,
-		  unsigned int *epoch)
+		  unsigned int *epoch, char *lease_key)
 {
 	char *data_offset;
 	struct create_context *cc;
@@ -1069,7 +1069,8 @@ parse_lease_state(struct TCP_Server_Info
 		name = le16_to_cpu(cc->NameOffset) + (char *)cc;
 		if (le16_to_cpu(cc->NameLength) == 4 &&
 		    strncmp(name, "RqLs", 4) == 0)
-			return server->ops->parse_lease_buf(cc, epoch);
+			return server->ops->parse_lease_buf(cc, epoch,
+							    lease_key);
 
 		next = le32_to_cpu(cc->Next);
 		if (!next)
@@ -1262,7 +1263,8 @@ SMB2_open(const unsigned int xid, struct
 	}
 
 	if (rsp->OplockLevel == SMB2_OPLOCK_LEVEL_LEASE)
-		*oplock = parse_lease_state(server, rsp, &oparms->fid->epoch);
+		*oplock = parse_lease_state(server, rsp, &oparms->fid->epoch,
+					    oparms->fid->lease_key);
 	else
 		*oplock = rsp->OplockLevel;
 creat_exit:

