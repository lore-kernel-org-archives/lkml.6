Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAFAC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFE020661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFE020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbeLIWHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:07:38 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37228 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727909AbeLIWHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:07:32 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW738-0002ia-EH; Sun, 09 Dec 2018 21:55:43 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72f-0003T4-B5; Sun, 09 Dec 2018 21:55:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Aurelien Aptel" <aaptel@suse.com>,
        "Thomas Werschlein" <thomas.werschlein@geo.uzh.ch>,
        "Tom Talpey" <ttalpey@microsoft.com>,
        "Steve French" <stfrench@microsoft.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.857258219@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 184/328] cifs: connect to servername instead of IP
 for IPC$ share
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

From: Thomas Werschlein <thomas.werschlein@geo.uzh.ch>

commit 395a2076b4064f97d3fce03af15210ff2a7bb7f9 upstream.

This patch is required allows access to a Microsoft fileserver failover
cluster behind a 1:1 NAT firewall.

The change also provides stronger context for authentication and share
connection (see MS-SMB2 3.3.5.7 and MS-SRVS 3.1.6.8) as noted by
Tom Talpey, and addresses comments about the buffer size for the UNC
made by Aurélien Aptel.

Signed-off-by: Thomas Werschlein <thomas.werschlein@geo.uzh.ch>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Tom Talpey <ttalpey@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
[bwh: Backported to 3.16: The IPC$ path is generated in get_dfs_path()
 in a rather fragile way. Rather than replacing all instances of
 ses->serverName here, switch to using kasprintf() so the new code
 is close to that used upstream.]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2829,15 +2829,10 @@ get_dfs_path(const unsigned int xid, str
 	*referrals = NULL;
 
 	if (ses->ipc_tid == 0) {
-		temp_unc = kmalloc(2 /* for slashes */ +
-			strnlen(ses->serverName, SERVER_NAME_LEN_WITH_NULL * 2)
-				+ 1 + 4 /* slash IPC$ */ + 2, GFP_KERNEL);
+		temp_unc = kasprintf(GFP_KERNEL, "\\\\%s\\IPC$",
+				     ses->server->hostname);
 		if (temp_unc == NULL)
 			return -ENOMEM;
-		temp_unc[0] = '\\';
-		temp_unc[1] = '\\';
-		strcpy(temp_unc + 2, ses->serverName);
-		strcpy(temp_unc + 2 + strlen(ses->serverName), "\\IPC$");
 		rc = ses->server->ops->tree_connect(xid, ses, temp_unc, NULL,
 						    nls_codepage);
 		cifs_dbg(FYI, "Tcon rc = %d ipc_tid = %d\n", rc, ses->ipc_tid);

