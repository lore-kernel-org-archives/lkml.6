Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C03C282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179AB218D2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360122;
	bh=cP3gkezbefZhNA/3UtrbMix/AK4MZZ+fMGb8hSxtvXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NgwJKyEJIoixEcxg5KPEaWi0nB1FI436hJYjWCA3QffgFwF/R/tGVn1npFBBIROEm
	 oNRhH0ZmjnUVb/V8QqY7t+U3mRXBHGQLNST0v7zYUkZnHdD8H7stsmwYR/zIrsk4Fw
	 tj7EF9qXoFpjAvO4+x/juWV2VJnolj1liOulHAXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbfAXTd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:33:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731988AbfAXTdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:33:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06A9E218FC;
        Thu, 24 Jan 2019 19:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358402;
        bh=cP3gkezbefZhNA/3UtrbMix/AK4MZZ+fMGb8hSxtvXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ArpgqUwEqyJ+Tw/ITcsCghFzHT2ErsOgADM11WWQipQBM3kU/VQb6GqzuVG0/kuek
         TJYskhofPJYuYq9kuZXfcdWUslWw18zt5eM1aqmlMT0ypkAl4D5rXv7yy9VZzmLsbs
         UhP9AlSREf+V0VHO0PCi9z/VvQKK3tgW5kgQ4FpY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>,
        Jeremy Allison <jra@samba.org>,
        Alakesh Haloi <alakeshh@amazon.com>
Subject: [PATCH 4.14 60/63] cifs: allow disabling insecure dialects in the config
Date:   Thu, 24 Jan 2019 20:20:49 +0100
Message-Id: <20190124190202.290264171@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190155.176570028@linuxfoundation.org>
References: <20190124190155.176570028@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
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

commit 7420451f6a109f7f8f1bf283f34d08eba3259fb3 upstream.

allow disabling cifs (SMB1 ie vers=1.0) and vers=2.0 in the
config for the build of cifs.ko if want to always prevent mounting
with these less secure dialects.

Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Reviewed-by: Jeremy Allison <jra@samba.org>
Cc: Alakesh Haloi <alakeshh@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/Kconfig   |   17 ++++++++++++++++-
 fs/cifs/connect.c |    9 +++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

--- a/fs/cifs/Kconfig
+++ b/fs/cifs/Kconfig
@@ -66,9 +66,24 @@ config CIFS_STATS2
 	  Unless you are a developer or are doing network performance analysis
 	  or tuning, say N.
 
+config CIFS_ALLOW_INSECURE_LEGACY
+	bool "Support legacy servers which use less secure dialects"
+	depends on CIFS
+	default y
+	help
+	  Modern dialects, SMB2.1 and later (including SMB3 and 3.1.1), have
+	  additional security features, including protection against
+	  man-in-the-middle attacks and stronger crypto hashes, so the use
+	  of legacy dialects (SMB1/CIFS and SMB2.0) is discouraged.
+
+	  Disabling this option prevents users from using vers=1.0 or vers=2.0
+	  on mounts with cifs.ko
+
+	  If unsure, say Y.
+
 config CIFS_WEAK_PW_HASH
 	bool "Support legacy servers which use weaker LANMAN security"
-	depends on CIFS
+	depends on CIFS && CIFS_ALLOW_INSECURE_LEGACY
 	help
 	  Modern CIFS servers including Samba and most Windows versions
 	  (since 1997) support stronger NTLM (and even NTLMv2 and Kerberos)
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1130,6 +1130,7 @@ cifs_parse_smb_version(char *value, stru
 	substring_t args[MAX_OPT_ARGS];
 
 	switch (match_token(value, cifs_smb_version_tokens, args)) {
+#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 	case Smb_1:
 		vol->ops = &smb1_operations;
 		vol->vals = &smb1_values;
@@ -1138,6 +1139,14 @@ cifs_parse_smb_version(char *value, stru
 		vol->ops = &smb20_operations;
 		vol->vals = &smb20_values;
 		break;
+#else
+	case Smb_1:
+		cifs_dbg(VFS, "vers=1.0 (cifs) mount not permitted when legacy dialects disabled\n");
+		return 1;
+	case Smb_20:
+		cifs_dbg(VFS, "vers=2.0 mount not permitted when legacy dialects disabled\n");
+		return 1;
+#endif /* CIFS_ALLOW_INSECURE_LEGACY */
 	case Smb_21:
 		vol->ops = &smb21_operations;
 		vol->vals = &smb21_values;


