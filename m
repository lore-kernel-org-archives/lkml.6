Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4C7C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCB02086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCB02086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbeICVnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:43:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45292 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbeICVnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:43:31 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 71C92D00;
        Mon,  3 Sep 2018 17:22:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Paulo Alcantara <palcantara@suse.de>
Subject: [PATCH 4.14 084/165] cifs: add missing debug entries for kconfig options
Date:   Mon,  3 Sep 2018 18:56:10 +0200
Message-Id: <20180903165659.295783631@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit 950132afd59385caf6e2b84e5235d069fa10681d upstream.

/proc/fs/cifs/DebugData displays the features (Kconfig options)
used to build cifs.ko but it was missing some, and needed comma
separator.  These can be useful in debugging certain problems
so we know which optional features were enabled in the user's build.
Also clarify them, by making them more closely match the
corresponding CONFIG_CIFS_* parm.

Old format:
Features: dfs fscache posix spnego xattr acl

New format:
Features: DFS,FSCACHE,SMB_DIRECT,STATS,DEBUG2,ALLOW_INSECURE_LEGACY,CIFS_POSIX,UPCALL(SPNEGO),XATTR,ACL

Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Reviewed-by: Paulo Alcantara <palcantara@suse.de>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifs_debug.c |   30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -123,25 +123,41 @@ static int cifs_debug_data_proc_show(str
 	seq_printf(m, "CIFS Version %s\n", CIFS_VERSION);
 	seq_printf(m, "Features:");
 #ifdef CONFIG_CIFS_DFS_UPCALL
-	seq_printf(m, " dfs");
+	seq_printf(m, " DFS");
 #endif
 #ifdef CONFIG_CIFS_FSCACHE
-	seq_printf(m, " fscache");
+	seq_printf(m, ",FSCACHE");
+#endif
+#ifdef CONFIG_CIFS_SMB_DIRECT
+	seq_printf(m, ",SMB_DIRECT");
+#endif
+#ifdef CONFIG_CIFS_STATS2
+	seq_printf(m, ",STATS2");
+#elif defined(CONFIG_CIFS_STATS)
+	seq_printf(m, ",STATS");
+#endif
+#ifdef CONFIG_CIFS_DEBUG2
+	seq_printf(m, ",DEBUG2");
+#elif defined(CONFIG_CIFS_DEBUG)
+	seq_printf(m, ",DEBUG");
+#endif
+#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
+	seq_printf(m, ",ALLOW_INSECURE_LEGACY");
 #endif
 #ifdef CONFIG_CIFS_WEAK_PW_HASH
-	seq_printf(m, " lanman");
+	seq_printf(m, ",WEAK_PW_HASH");
 #endif
 #ifdef CONFIG_CIFS_POSIX
-	seq_printf(m, " posix");
+	seq_printf(m, ",CIFS_POSIX");
 #endif
 #ifdef CONFIG_CIFS_UPCALL
-	seq_printf(m, " spnego");
+	seq_printf(m, ",UPCALL(SPNEGO)");
 #endif
 #ifdef CONFIG_CIFS_XATTR
-	seq_printf(m, " xattr");
+	seq_printf(m, ",XATTR");
 #endif
 #ifdef CONFIG_CIFS_ACL
-	seq_printf(m, " acl");
+	seq_printf(m, ",ACL");
 #endif
 	seq_putc(m, '\n');
 	seq_printf(m, "Active VFS Requests: %d\n", GlobalTotalActiveXid);


