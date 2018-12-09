Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275CDC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7C220661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7C220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeLIWE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:04:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36856 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726559AbeLIWE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:04:57 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73F-0002ie-M1; Sun, 09 Dec 2018 21:55:49 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72c-0003Ma-MU; Sun, 09 Dec 2018 21:55:10 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ronnie Sahlberg" <lsahlber@redhat.com>,
        "Paulo Alcantara" <palcantara@suse.de>,
        "Steve French" <stfrench@microsoft.com>,
        "Pavel Shilovsky" <pshilov@microsoft.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.471332897@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 117/328] cifs: add missing debug entries for kconfig
 options
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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/cifs_debug.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -141,25 +141,41 @@ static int cifs_debug_data_proc_show(str
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

