Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D74CC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05E920661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05E920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeLIWGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:06:30 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37072 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727511AbeLIWG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:06:27 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW738-0002iq-GV; Sun, 09 Dec 2018 21:55:43 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72f-0003Sz-9V; Sun, 09 Dec 2018 21:55:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Steve French" <stfrench@microsoft.com>,
        "Ronnie Sahlberg" <lsahlber@redhat.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.387922735@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 183/328] smb3: check for and properly advertise
 directory lease support
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit f801568332321e2b1e7a8bd26c3e4913a312a2ec upstream.

Although servers will typically ignore unsupported features,
we should advertise the support for directory leases (as
Windows e.g. does) in the negotiate protocol capabilities we
pass to the server, and should check for the server capability
(CAP_DIRECTORY_LEASING) before sending a lease request for an
open of a directory.  This will prevent us from accidentally
sending directory leases to SMB2.1 or SMB2 server for example.

Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
[bwh: Backported to 3.16:
 - Drop changes to smb3any_values, smbdefault_values, smb311_values
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1433,7 +1433,7 @@ struct smb_version_values smb21_values =
 struct smb_version_values smb30_values = {
 	.version_string = SMB30_VERSION_STRING,
 	.protocol_id = SMB30_PROT_ID,
-	.req_capabilities = SMB2_GLOBAL_CAP_DFS | SMB2_GLOBAL_CAP_LEASING | SMB2_GLOBAL_CAP_LARGE_MTU,
+	.req_capabilities = SMB2_GLOBAL_CAP_DFS | SMB2_GLOBAL_CAP_LEASING | SMB2_GLOBAL_CAP_LARGE_MTU | SMB2_GLOBAL_CAP_DIRECTORY_LEASING,
 	.large_lock_type = 0,
 	.exclusive_lock_type = SMB2_LOCKFLAG_EXCLUSIVE_LOCK,
 	.shared_lock_type = SMB2_LOCKFLAG_SHARED_LOCK,
@@ -1453,7 +1453,7 @@ struct smb_version_values smb30_values =
 struct smb_version_values smb302_values = {
 	.version_string = SMB302_VERSION_STRING,
 	.protocol_id = SMB302_PROT_ID,
-	.req_capabilities = SMB2_GLOBAL_CAP_DFS | SMB2_GLOBAL_CAP_LEASING | SMB2_GLOBAL_CAP_LARGE_MTU,
+	.req_capabilities = SMB2_GLOBAL_CAP_DFS | SMB2_GLOBAL_CAP_LEASING | SMB2_GLOBAL_CAP_LARGE_MTU | SMB2_GLOBAL_CAP_DIRECTORY_LEASING,
 	.large_lock_type = 0,
 	.exclusive_lock_type = SMB2_LOCKFLAG_EXCLUSIVE_LOCK,
 	.shared_lock_type = SMB2_LOCKFLAG_SHARED_LOCK,
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1211,6 +1211,9 @@ SMB2_open(const unsigned int xid, struct
 	if (!(server->capabilities & SMB2_GLOBAL_CAP_LEASING) ||
 	    *oplock == SMB2_OPLOCK_LEVEL_NONE)
 		req->RequestedOplockLevel = *oplock;
+	else if (!(server->capabilities & SMB2_GLOBAL_CAP_DIRECTORY_LEASING) &&
+		  (oparms->create_options & CREATE_NOT_FILE))
+		req->RequestedOplockLevel = *oplock; /* no srv lease support */
 	else {
 		rc = add_lease_context(server, iov, &num_iovecs,
 				       oparms->fid->lease_key, oplock);

