Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874D1C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B902150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="VIC9C0kQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B902150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732821AbeISWkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:40:52 -0400
Received: from alln-iport-8.cisco.com ([173.37.142.95]:19315 "EHLO
        alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeISWkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:40:52 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Sep 2018 18:40:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1942; q=dns/txt; s=iport;
  t=1537376524; x=1538586124;
  h=from:to:cc:subject:date:message-id;
  bh=9/8phNkboVaUJDEkIyGzhn37duZshtPBy0GdIjVIjYI=;
  b=VIC9C0kQ4XZAC4pbtJmBN8gSIHMq5tKUKuW1Rpnbmg3LI+76svugspOv
   mA9dVgrpdfurSVfx6ibjIWR8MB5on/kPi+WYb1q5E/I0wFPrloNjaOZNl
   Thuo1nChAxtCzo7uJRpjspzzFSGzQHsqhFfhtVr3ZAOUx9RFURQhN7mSZ
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AkAAA7fqJb/4ENJK1cGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYFQggiBZCiMCJcnjWOBeguEbIM9ITQYAQMBAQIBAQJtKIV?=
 =?us-ascii?q?mUoE+ARIbgwaBdQ2mSDOKERSGQ4QWF4FBP4hrIYVuApxZCZAXCxePGQGUSAI?=
 =?us-ascii?q?RFIFCOIFVcBWDJ4IlF44XPzCLFoJMAQE?=
X-IronPort-AV: E=Sophos;i="5.53,394,1531785600"; 
   d="scan'208";a="173406054"
Received: from alln-core-9.cisco.com ([173.36.13.129])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 16:52:50 +0000
Received: from sjc-ads-7132.cisco.com (sjc-ads-7132.cisco.com [10.30.217.207])
        (authenticated bits=0)
        by alln-core-9.cisco.com (8.15.2/8.15.2) with ESMTPSA id w8JGqn6s011483
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NO);
        Wed, 19 Sep 2018 16:52:50 GMT
From:   Taras Kondratiuk <takondra@cisco.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Cc:     selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        xe-linux-external@cisco.com
Subject: [RFC PATCH] selinux: add a fallback to defcontext for native labeling
Date:   Wed, 19 Sep 2018 16:52:48 +0000
Message-Id: <20180919165248.53090-1-takondra@cisco.com>
X-Mailer: git-send-email 2.9.3
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Authenticated-User: takondra@cisco.com
X-Outbound-SMTP-Client: 10.30.217.207, sjc-ads-7132.cisco.com
X-Outbound-Node: alln-core-9.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When files on NFSv4 server are not properly labeled (label doesn't match
a policy on a client) they will end up with unlabeled_t type which is
too generic. We would like to be able to set a default context per
mount. 'defcontext' mount option looks like a nice solution, but it
doesn't seem to be fully implemented for native labeling. Default
context is stored, but is never used.

The patch adds a fallback to a default context if a received context is
invalid. If the inode context is already initialized, then it is left
untouched to preserve a context set locally on a client.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 security/selinux/hooks.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ad9a9b8e9979..f7debe798bf5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6598,7 +6598,30 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
  */
 static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
-	return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
+	struct superblock_security_struct *sbsec;
+	struct inode_security_struct *isec;
+	int rc;
+
+	rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
+
+	/*
+	 * In case of Native labeling with defcontext mount option fall back
+	 * to a default SID if received context is invalid.
+	 */
+	if (rc == -EINVAL) {
+		sbsec = inode->i_sb->s_security;
+		if (sbsec->behavior == SECURITY_FS_USE_NATIVE &&
+		    sbsec->flags & DEFCONTEXT_MNT) {
+			isec = inode->i_security;
+			if (!isec->initialized) {
+				isec->sclass = inode_mode_to_security_class(inode->i_mode);
+				isec->sid = sbsec->def_sid;
+				isec->initialized = 1;
+			}
+			rc = 0;
+		}
+	}
+	return rc;
 }
 
 /*
-- 
2.10.3.dirty

