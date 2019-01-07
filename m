Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE365C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63B52089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfAGRPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:15:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46045 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfAGRPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:15:18 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1ggYUe-0001gu-EE; Mon, 07 Jan 2019 17:15:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: fix memory leak of an allocated cifs_ntsd structure
Date:   Mon,  7 Jan 2019 17:15:15 +0000
Message-Id: <20190107171515.4537-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The call to SMB2_queary_acl can allocate memory to pntsd and also
return a failure via a call to SMB2_query_acl (and then query_info).
This occurs when query_info allocates the structure and then in
query_info the call to smb2_validate_and_copy_iov fails. Currently the
failure just returns without kfree'ing pntsd hence causing a memory
leak.  Fix this by kfree'ing pntsd before returning.

Detected by CoverityScan, CID#1457059 ("Resource Leak")

Fixes: 2f1afe25997f ("cifs: Use smb 2 - 3 and cifsacl mount options getacl functions")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/cifs/smb2ops.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index cf7eb891804f..6d71958ad2cb 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2238,8 +2238,10 @@ get_smb2_acl_by_fid(struct cifs_sb_info *cifs_sb,
 	cifs_put_tlink(tlink);
 
 	cifs_dbg(FYI, "%s: rc = %d ACL len %d\n", __func__, rc, *pacllen);
-	if (rc)
+	if (rc) {
+		kfree(pntsd);
 		return ERR_PTR(rc);
+	}
 	return pntsd;
 
 }
-- 
2.19.1

