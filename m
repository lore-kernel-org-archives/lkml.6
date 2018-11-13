Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EE4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B596C2082A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zVebQ5V5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B596C2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbeKMQD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:03:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:59872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbeKMPqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:46:19 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87E2622507;
        Tue, 13 Nov 2018 05:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088191;
        bh=mzwDGY25cvtL7/0M3SHkKaRKIfCj0un1keoSROZT13A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zVebQ5V5NiqA4s/pxNkU7P/gQ57kaX/3t3k4EOBxaQf+iWgNTA6GoQaclIo116UlH
         wqtSJ+0g6Dluldqcm7bgP9DY0odeSsnkaAmeQo0Pl1LiGC4lLVdPMrx+EDnWO+LNEx
         BnTG9hIWG1xMy603f/OWZVFaPJYEljTKYZWBTBYs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 03/44] cifs: fix return value for cifs_listxattr
Date:   Tue, 13 Nov 2018 00:49:09 -0500
Message-Id: <20181113054950.77898-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113054950.77898-1-sashal@kernel.org>
References: <20181113054950.77898-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronnie Sahlberg <lsahlber@redhat.com>

[ Upstream commit 0c5d6cb6643f48ad3775322f3ebab6c7eb67484e ]

If the application buffer was too small to fit all the names
we would still count the number of bytes and return this for
listxattr. This would then trigger a BUG in usercopy.c

Fix the computation of the size so that we return -ERANGE
correctly when the buffer is too small.

This fixes the kernel BUG for xfstest generic/377

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 89985a0a6819..812da3e56a22 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -686,6 +686,7 @@ move_smb2_ea_to_cifs(char *dst, size_t dst_size,
 	int rc = 0;
 	unsigned int ea_name_len = ea_name ? strlen(ea_name) : 0;
 	char *name, *value;
+	size_t buf_size = dst_size;
 	size_t name_len, value_len, user_name_len;
 
 	while (src_size > 0) {
@@ -721,9 +722,10 @@ move_smb2_ea_to_cifs(char *dst, size_t dst_size,
 			/* 'user.' plus a terminating null */
 			user_name_len = 5 + 1 + name_len;
 
-			rc += user_name_len;
-
-			if (dst_size >= user_name_len) {
+			if (buf_size == 0) {
+				/* skip copy - calc size only */
+				rc += user_name_len;
+			} else if (dst_size >= user_name_len) {
 				dst_size -= user_name_len;
 				memcpy(dst, "user.", 5);
 				dst += 5;
@@ -731,8 +733,7 @@ move_smb2_ea_to_cifs(char *dst, size_t dst_size,
 				dst += name_len;
 				*dst = 0;
 				++dst;
-			} else if (dst_size == 0) {
-				/* skip copy - calc size only */
+				rc += user_name_len;
 			} else {
 				/* stop before overrun buffer */
 				rc = -ERANGE;
-- 
2.17.1

