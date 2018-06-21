Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B1FC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480E6208A4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480E6208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932727AbeFUNz0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:55:26 -0400
Received: from gateway36.websitewelcome.com ([192.185.187.5]:37605 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932341AbeFUNzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:55:25 -0400
X-Greylist: delayed 1198 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jun 2018 09:55:25 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id DB32F400C802B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 07:35:25 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id VzkDfkyo979N3VzkDfCJyP; Thu, 21 Jun 2018 08:35:25 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=52468 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fVzkD-001BBc-2n; Thu, 21 Jun 2018 08:35:25 -0500
Date:   Thu, 21 Jun 2018 08:35:23 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Aurelien Aptel <aaptel@suse.com>, Steve French <sfrench@samba.org>
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] CIFS: fix structurally dead code in smb311_posix_mkdir
Message-ID: <20180621133523.GA30313@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fVzkD-001BBc-2n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:52468
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code at line: 1950: rc = -EIO; is unreachable. Hence, the function
returns rc with a value of zero and, this is not the actual intention
of this particular piece of code.

Fix this by placing the goto instruction just after the update to rc.

Addresses-Coverity-ID: 1470124 ("Structurally dead code")
Fixes: 5539e9b24a38 ("CIFS: fix memory leak and remove dead code")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/cifs/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 062a2a5..c9489b1 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1946,8 +1946,8 @@ int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
 	if (ses && (ses->server))
 		server = ses->server;
 	else {
-		goto err_free_path;
 		rc = -EIO;
+		goto err_free_path;
 	}
 
 	/* resource #2: request */
-- 
2.7.4

