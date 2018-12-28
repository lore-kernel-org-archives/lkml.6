Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886A5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF2920675
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999698;
	bh=zAuV90xVVdb/PjeGmfGcj0CX2EH4v4NgJBPu+IfcDBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lvx5pBFFGMQf8qH8eXpeBx5r6FR1V8aEIKXi8jcvpNbSg0jB2L6jnymaur5t9nzml
	 Z9RqMmVG2aLhfTOjRSpEw36XC5fg/DK2l33KwDQUzO8CRnBy/He88VJe3BZe08oI1F
	 d+vWiwwP4bYqToJpLFm/IYrrNNkWmcj5eidk++ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbeL1MVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:21:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732572AbeL1MP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:15:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AB9B2087F;
        Fri, 28 Dec 2018 12:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999357;
        bh=zAuV90xVVdb/PjeGmfGcj0CX2EH4v4NgJBPu+IfcDBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7Z6vSN+A+wBwtqxYquXlDhz43nevJ5r/u23ZOjCGp+ykQeKihuIsnZlG2T1z9E+Q
         ATI1Yb3MM4XlTAIzhLIKRGQtwErBGnrepI0XWRjzh7oLes9zVr8LRll7dnXUk6zlPi
         kVJPFf8scTq9fXc1FBPH+ZR7kJHd1qdjtmLJtbdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 07/36] cifs: integer overflow in in SMB2_ioctl()
Date:   Fri, 28 Dec 2018 12:52:23 +0100
Message-Id: <20181228113127.007159491@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
References: <20181228113126.526729877@linuxfoundation.org>
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

commit 2d204ee9d671327915260071c19350d84344e096 upstream

The "le32_to_cpu(rsp->OutputOffset) + *plen" addition can overflow and
wrap around to a smaller value which looks like it would lead to an
information leak.

Fixes: 4a72dafa19ba ("SMB2 FSCTL and IOCTL worker function")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 69309538ffb8..1581e8668b09 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2020,14 +2020,14 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
 	/* We check for obvious errors in the output buffer length and offset */
 	if (*plen == 0)
 		goto ioctl_exit; /* server returned no data */
-	else if (*plen > 0xFF00) {
+	else if (*plen > rsp_iov.iov_len || *plen > 0xFF00) {
 		cifs_dbg(VFS, "srv returned invalid ioctl length: %d\n", *plen);
 		*plen = 0;
 		rc = -EIO;
 		goto ioctl_exit;
 	}
 
-	if (get_rfc1002_length(rsp) < le32_to_cpu(rsp->OutputOffset) + *plen) {
+	if (get_rfc1002_length(rsp) - *plen < le32_to_cpu(rsp->OutputOffset)) {
 		cifs_dbg(VFS, "Malformed ioctl resp: len %d offset %d\n", *plen,
 			le32_to_cpu(rsp->OutputOffset));
 		*plen = 0;
-- 
2.19.1



