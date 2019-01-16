Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95BEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A68620675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfAPQ3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:29:02 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47073 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfAPQ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:29:02 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gjo3n-0003IV-VF; Wed, 16 Jan 2019 16:29:00 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] cifs: fix memory leak of an allocated cifs_ntsd structure
Date:   Wed, 16 Jan 2019 16:28:59 +0000
Message-Id: <20190116162859.8028-1-colin.king@canonical.com>
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
leak.

Currently, *data is allocated if it's not already pointing to a buffer,
so it needs to be kfree'd only if was allocated in query_info, so the
fix adds an allocated flag to track this.  Also set *dlen to zero on
an error just to be safe since *data is kfree'd.

Also set errno to -ENOMEM if the allocation of *data fails.

Signed-off-by: Colin Ian King <colin.king@canonical.com>

---
 fs/cifs/smb2pdu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 50811a7dc0e0..0af87bd0dc49 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2816,6 +2816,7 @@ query_info(const unsigned int xid, struct cifs_tcon *tcon,
 	int resp_buftype = CIFS_NO_BUFFER;
 	struct cifs_ses *ses = tcon->ses;
 	int flags = 0;
+	bool allocated = false;
 
 	cifs_dbg(FYI, "Query Info\n");
 
@@ -2855,14 +2856,21 @@ query_info(const unsigned int xid, struct cifs_tcon *tcon,
 					"Error %d allocating memory for acl\n",
 					rc);
 				*dlen = 0;
+				rc = -ENOMEM;
 				goto qinf_exit;
 			}
+			allocated = true;
 		}
 	}
 
 	rc = smb2_validate_and_copy_iov(le16_to_cpu(rsp->OutputBufferOffset),
 					le32_to_cpu(rsp->OutputBufferLength),
 					&rsp_iov, min_len, *data);
+	if (rc && allocated) {
+		kfree(*data);
+		*data = NULL;
+		*dlen = 0;
+	}
 
 qinf_exit:
 	SMB2_query_info_free(&rqst);
-- 
2.19.1

