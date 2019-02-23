Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F49C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1804120861
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956287;
	bh=xcjKM710L5Wsg1/99zJ3M89B6099QH+dpLi1fhrxv7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GHpf7vtO56GgRRZJvhjlvqgIW0PDhu1FevITFVO+Gt15N7lkJzSeC1T6MrZQrV9w7
	 Bodgesg+tCZ63OJJN8HsiuvVXYdwe8bVP81UustQxjXsYHWxUG3Nhab1k0TfiwrAOK
	 +2BpRnnS21tXjxFh0jkeAXxVNaYIGaod8fHGrksE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfBWVLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:11:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729955AbfBWVLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:11:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB17C2085A;
        Sat, 23 Feb 2019 21:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956277;
        bh=xcjKM710L5Wsg1/99zJ3M89B6099QH+dpLi1fhrxv7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sslzWfwIv40XyuTz2ya2RSe66wg3s1I3eOiZELHdtsz5XVpZOjAH6FnHtk/7Zdw3M
         +n4FWii8E6nPohhQTY/hFbLE3WjksBK2OHaoagmja1IOcd72JSvnHDZpItfMceVunl
         MbT3OmLJXWaif3lBCqpOB5xO9bGa9he/J5J0sRrM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 19/26] cifs: fix computation for MAX_SMB2_HDR_SIZE
Date:   Sat, 23 Feb 2019 16:10:40 -0500
Message-Id: <20190223211047.202725-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223211047.202725-1-sashal@kernel.org>
References: <20190223211047.202725-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronnie Sahlberg <lsahlber@redhat.com>

[ Upstream commit 58d15ed1203f4d858c339ea4d7dafa94bd2a56d3 ]

The size of the fixed part of the create response is 88 bytes not 56.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index aacb15bd56fe9..f087158c5555b 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -82,8 +82,8 @@
 
 #define NUMBER_OF_SMB2_COMMANDS	0x0013
 
-/* 4 len + 52 transform hdr + 64 hdr + 56 create rsp */
-#define MAX_SMB2_HDR_SIZE 0x00b0
+/* 52 transform hdr + 64 hdr + 88 create rsp */
+#define MAX_SMB2_HDR_SIZE 204
 
 #define SMB2_PROTO_NUMBER cpu_to_le32(0x424d53fe)
 
-- 
2.19.1

