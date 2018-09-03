Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9920DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF0E20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF0E20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbeICVyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:54:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47674 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbeICVyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:54:46 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0D937D16;
        Mon,  3 Sep 2018 17:33:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aurelien Aptel <aaptel@suse.com>,
        Paulo Alcantara <palcantara@suse.com>,
        Xiaoli Feng <xifeng@redhat.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.18 007/123] CIFS: fix uninitialized ptr deref in smb2 signing
Date:   Mon,  3 Sep 2018 18:55:51 +0200
Message-Id: <20180903165719.800171246@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aurelien Aptel <aaptel@suse.com>

commit a5c62f4833c2c8e6e0f35367b99b717b78f5c029 upstream.

server->secmech.sdeschmacsha256 is not properly initialized before
smb2_shash_allocate(), set shash after that call.

also fix typo in error message

Fixes: 8de8c4608fe9 ("cifs: Fix validation of signed data in smb2")

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
Reviewed-by: Paulo Alcantara <palcantara@suse.com>
Reported-by: Xiaoli Feng <xifeng@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2transport.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/cifs/smb2transport.c
+++ b/fs/cifs/smb2transport.c
@@ -173,7 +173,7 @@ smb2_calc_signature(struct smb_rqst *rqs
 	struct kvec *iov = rqst->rq_iov;
 	struct smb2_sync_hdr *shdr = (struct smb2_sync_hdr *)iov[0].iov_base;
 	struct cifs_ses *ses;
-	struct shash_desc *shash = &server->secmech.sdeschmacsha256->shash;
+	struct shash_desc *shash;
 	struct smb_rqst drqst;
 
 	ses = smb2_find_smb_ses(server, shdr->SessionId);
@@ -187,7 +187,7 @@ smb2_calc_signature(struct smb_rqst *rqs
 
 	rc = smb2_crypto_shash_allocate(server);
 	if (rc) {
-		cifs_dbg(VFS, "%s: shah256 alloc failed\n", __func__);
+		cifs_dbg(VFS, "%s: sha256 alloc failed\n", __func__);
 		return rc;
 	}
 
@@ -198,6 +198,7 @@ smb2_calc_signature(struct smb_rqst *rqs
 		return rc;
 	}
 
+	shash = &server->secmech.sdeschmacsha256->shash;
 	rc = crypto_shash_init(shash);
 	if (rc) {
 		cifs_dbg(VFS, "%s: Could not init sha256", __func__);


