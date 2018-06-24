Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FF7C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6055F21456
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6055F21456
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756188AbeFXPnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:43:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60156 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755444AbeFXPns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:43:48 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 24D9B2C;
        Sun, 24 Jun 2018 15:43:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shirish Pargaonkar <shirishpargaonkar@gmail.com>,
        Noah Morrison <noah.morrison@rubrik.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.17 38/70] cifs: For SMB2 security informaion query, check for minimum sized security descriptor instead of sizeof FileAllInformation class
Date:   Sun, 24 Jun 2018 23:22:30 +0800
Message-Id: <20180624142742.858799064@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shirish Pargaonkar <shirishpargaonkar@gmail.com>

commit ee25c6dd7b05113783ce1f4fab6b30fc00d29b8d upstream.

Validate_buf () function checks for an expected minimum sized response
passed to query_info() function.
For security information, the size of a security descriptor can be
smaller (one subauthority, no ACEs) than the size of the structure
that defines FileInfoClass of FileAllInformation.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199725
Cc: <stable@vger.kernel.org>
Signed-off-by: Shirish Pargaonkar <shirishpargaonkar@gmail.com>
Reviewed-by: Noah Morrison <noah.morrison@rubrik.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifsacl.h |   14 ++++++++++++++
 fs/cifs/smb2pdu.c |    3 +--
 2 files changed, 15 insertions(+), 2 deletions(-)

--- a/fs/cifs/cifsacl.h
+++ b/fs/cifs/cifsacl.h
@@ -98,4 +98,18 @@ struct cifs_ace {
 	struct cifs_sid sid; /* ie UUID of user or group who gets these perms */
 } __attribute__((packed));
 
+/*
+ * Minimum security identifier can be one for system defined Users
+ * and Groups such as NULL SID and World or Built-in accounts such
+ * as Administrator and Guest and consists of
+ * Revision + Num (Sub)Auths + Authority + Domain (one Subauthority)
+ */
+#define MIN_SID_LEN  (1 + 1 + 6 + 4) /* in bytes */
+
+/*
+ * Minimum security descriptor can be one without any SACL and DACL and can
+ * consist of revision, type, and two sids of minimum size for owner and group
+ */
+#define MIN_SEC_DESC_LEN  (sizeof(struct cifs_ntsd) + (2 * MIN_SID_LEN))
+
 #endif /* _CIFSACL_H */
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2378,8 +2378,7 @@ SMB2_query_acl(const unsigned int xid, s
 
 	return query_info(xid, tcon, persistent_fid, volatile_fid,
 			  0, SMB2_O_INFO_SECURITY, additional_info,
-			  SMB2_MAX_BUFFER_SIZE,
-			  sizeof(struct smb2_file_all_info), data, plen);
+			  SMB2_MAX_BUFFER_SIZE, MIN_SEC_DESC_LEN, data, plen);
 }
 
 int


