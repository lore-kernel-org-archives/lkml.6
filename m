Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862B1ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492AB20685
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492AB20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbeIREaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:30:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48156 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbeIREaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:30:21 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7570DC03;
        Mon, 17 Sep 2018 23:00:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 4.14 009/126] smb3: check for and properly advertise directory lease support
Date:   Tue, 18 Sep 2018 00:40:57 +0200
Message-Id: <20180917211704.948657682@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
CC: Stable <stable@vger.kernel.org>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2ops.c |   10 +++++-----
 fs/cifs/smb2pdu.c |    3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3215,7 +3215,7 @@ struct smb_version_values smb21_values =
 struct smb_version_values smb3any_values = {
 	.version_string = SMB3ANY_VERSION_STRING,
 	.protocol_id = SMB302_PROT_ID, /* doesn't matter, send protocol array */
-	.req_capabilities = SMB2_GLOBAL_CAP_DFS | SMB2_GLOBAL_CAP_LEASING | SMB2_GLOBAL_CAP_LARGE_MTU | SMB2_GLOBAL_CAP_PERSISTENT_HANDLES | SMB2_GLOBAL_CAP_ENCRYPTION,
+	.req_capabilities = SMB2_GLOBAL_CAP_DFS | SMB2_GLOBAL_CAP_LEASING | SMB2_GLOBAL_CAP_LARGE_MTU | SMB2_GLOBAL_CAP_PERSISTENT_HANDLES | SMB2_GLOBAL_CAP_ENCRYPTION | SMB2_GLOBAL_CAP_DIRECTORY_LEASING,
 	.large_lock_type = 0,
 	.exclusive_lock_type = SMB2_LOCKFLAG_EXCLUSIVE_LOCK,
 	.shared_lock_type = SMB2_LOCKFLAG_SHARED_LOCK,
@@ -3235,7 +3235,7 @@ struct smb_version_values smb3any_values
 struct smb_version_values smbdefault_values = {
 	.version_string = SMBDEFAULT_VERSION_STRING,
 	.protocol_id = SMB302_PROT_ID, /* doesn't matter, send protocol array */
-	.req_capabilities = SMB2_GLOBAL_CAP_DFS | SMB2_GLOBAL_CAP_LEASING | SMB2_GLOBAL_CAP_LARGE_MTU | SMB2_GLOBAL_CAP_PERSISTENT_HANDLES | SMB2_GLOBAL_CAP_ENCRYPTION,
+	.req_capabilities = SMB2_GLOBAL_CAP_DFS | SMB2_GLOBAL_CAP_LEASING | SMB2_GLOBAL_CAP_LARGE_MTU | SMB2_GLOBAL_CAP_PERSISTENT_HANDLES | SMB2_GLOBAL_CAP_ENCRYPTION | SMB2_GLOBAL_CAP_DIRECTORY_LEASING,
 	.large_lock_type = 0,
 	.exclusive_lock_type = SMB2_LOCKFLAG_EXCLUSIVE_LOCK,
 	.shared_lock_type = SMB2_LOCKFLAG_SHARED_LOCK,
@@ -3255,7 +3255,7 @@ struct smb_version_values smbdefault_val
 struct smb_version_values smb30_values = {
 	.version_string = SMB30_VERSION_STRING,
 	.protocol_id = SMB30_PROT_ID,
-	.req_capabilities = SMB2_GLOBAL_CAP_DFS | SMB2_GLOBAL_CAP_LEASING | SMB2_GLOBAL_CAP_LARGE_MTU | SMB2_GLOBAL_CAP_PERSISTENT_HANDLES | SMB2_GLOBAL_CAP_ENCRYPTION,
+	.req_capabilities = SMB2_GLOBAL_CAP_DFS | SMB2_GLOBAL_CAP_LEASING | SMB2_GLOBAL_CAP_LARGE_MTU | SMB2_GLOBAL_CAP_PERSISTENT_HANDLES | SMB2_GLOBAL_CAP_ENCRYPTION | SMB2_GLOBAL_CAP_DIRECTORY_LEASING,
 	.large_lock_type = 0,
 	.exclusive_lock_type = SMB2_LOCKFLAG_EXCLUSIVE_LOCK,
 	.shared_lock_type = SMB2_LOCKFLAG_SHARED_LOCK,
@@ -3275,7 +3275,7 @@ struct smb_version_values smb30_values =
 struct smb_version_values smb302_values = {
 	.version_string = SMB302_VERSION_STRING,
 	.protocol_id = SMB302_PROT_ID,
-	.req_capabilities = SMB2_GLOBAL_CAP_DFS | SMB2_GLOBAL_CAP_LEASING | SMB2_GLOBAL_CAP_LARGE_MTU | SMB2_GLOBAL_CAP_PERSISTENT_HANDLES | SMB2_GLOBAL_CAP_ENCRYPTION,
+	.req_capabilities = SMB2_GLOBAL_CAP_DFS | SMB2_GLOBAL_CAP_LEASING | SMB2_GLOBAL_CAP_LARGE_MTU | SMB2_GLOBAL_CAP_PERSISTENT_HANDLES | SMB2_GLOBAL_CAP_ENCRYPTION | SMB2_GLOBAL_CAP_DIRECTORY_LEASING,
 	.large_lock_type = 0,
 	.exclusive_lock_type = SMB2_LOCKFLAG_EXCLUSIVE_LOCK,
 	.shared_lock_type = SMB2_LOCKFLAG_SHARED_LOCK,
@@ -3296,7 +3296,7 @@ struct smb_version_values smb302_values
 struct smb_version_values smb311_values = {
 	.version_string = SMB311_VERSION_STRING,
 	.protocol_id = SMB311_PROT_ID,
-	.req_capabilities = SMB2_GLOBAL_CAP_DFS | SMB2_GLOBAL_CAP_LEASING | SMB2_GLOBAL_CAP_LARGE_MTU | SMB2_GLOBAL_CAP_PERSISTENT_HANDLES | SMB2_GLOBAL_CAP_ENCRYPTION,
+	.req_capabilities = SMB2_GLOBAL_CAP_DFS | SMB2_GLOBAL_CAP_LEASING | SMB2_GLOBAL_CAP_LARGE_MTU | SMB2_GLOBAL_CAP_PERSISTENT_HANDLES | SMB2_GLOBAL_CAP_ENCRYPTION | SMB2_GLOBAL_CAP_DIRECTORY_LEASING,
 	.large_lock_type = 0,
 	.exclusive_lock_type = SMB2_LOCKFLAG_EXCLUSIVE_LOCK,
 	.shared_lock_type = SMB2_LOCKFLAG_SHARED_LOCK,
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1816,6 +1816,9 @@ SMB2_open(const unsigned int xid, struct
 	if (!(server->capabilities & SMB2_GLOBAL_CAP_LEASING) ||
 	    *oplock == SMB2_OPLOCK_LEVEL_NONE)
 		req->RequestedOplockLevel = *oplock;
+	else if (!(server->capabilities & SMB2_GLOBAL_CAP_DIRECTORY_LEASING) &&
+		  (oparms->create_options & CREATE_NOT_FILE))
+		req->RequestedOplockLevel = *oplock; /* no srv lease support */
 	else {
 		rc = add_lease_context(server, iov, &n_iov, oplock);
 		if (rc) {


