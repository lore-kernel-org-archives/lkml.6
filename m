Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC55C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75D720864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75D720864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968167AbeFRIgw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:36:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36482 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968157AbeFRIgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:36:49 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7AF66C5C;
        Mon, 18 Jun 2018 08:36:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paulo Alcantara <palcantara@suse.de>,
        Aurelien Aptel <aaptel@suse.com>,
        Steve French <smfrench@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 135/189] cifs: smb2ops: Fix listxattr() when there are no EAs
Date:   Mon, 18 Jun 2018 10:13:51 +0200
Message-Id: <20180618081214.652597658@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
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

From: Paulo Alcantara <palcantara@suse.de>

[ Upstream commit ae2cd7fb478b8da707906ee1706ae1379968a8f9 ]

As per listxattr(2):

       On success, a nonnegative number is returned indicating the size
       of the extended attribute name list.  On failure, -1 is returned
       and errno  is set appropriately.

In SMB1, when the server returns an empty EA list through a listxattr(),
it will correctly return 0 as there are no EAs for the given file.

However, in SMB2+, it returns -ENODATA in listxattr() which is wrong since
the request and response were sent successfully, although there's no actual
EA for the given file.

This patch fixes listxattr() for SMB2+ by returning 0 in cifs_listxattr()
when the server returns an empty list of EAs.

Signed-off-by: Paulo Alcantara <palcantara@suse.de>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/smb2ops.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -570,9 +570,15 @@ smb2_query_eas(const unsigned int xid, s
 
 	SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 
+	/*
+	 * If ea_name is NULL (listxattr) and there are no EAs, return 0 as it's
+	 * not an error. Otherwise, the specified ea_name was not found.
+	 */
 	if (!rc)
 		rc = move_smb2_ea_to_cifs(ea_data, buf_size, smb2_data,
 					  SMB2_MAX_EA_BUF, ea_name);
+	else if (!ea_name && rc == -ENODATA)
+		rc = 0;
 
 	kfree(smb2_data);
 	return rc;


