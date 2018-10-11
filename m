Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CC7C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E6E20652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+c65w6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E6E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbeJKXHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:07:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeJKXHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:07:16 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D59B20652;
        Thu, 11 Oct 2018 15:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272372;
        bh=7AUD/o2vwNYLEdpINF4fQS/uh4nfSrOoBgqHXfW+JCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+c65w6zBSFPGsLBhvgeZ99r1gbuHnOPBCJa6BkkchXQv/JwNVL6MdT9W6/S0w/k3
         ZLbefU2B/f37vz9djtwLTh0EG0LzyGxkeG5ocn7GTvTB548JHuxeWftvAx9th+AsLZ
         +/UEWjDuJxXYUysOQgtM/u/fANJDHsyDEWZh3Nis=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 086/120] fs/cifs: suppress a string overflow warning
Date:   Thu, 11 Oct 2018 17:34:27 +0200
Message-Id: <20181011152553.373014019@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Rothwell <sfr@canb.auug.org.au>

[ Upstream commit bcfb84a996f6fa90b5e6e2954b2accb7a4711097 ]

A powerpc build of cifs with gcc v8.2.0 produces this warning:

fs/cifs/cifssmb.c: In function ‘CIFSSMBNegotiate’:
fs/cifs/cifssmb.c:605:3: warning: ‘strncpy’ writing 16 bytes into a region of size 1 overflows the destination [-Wstringop-overflow=]
   strncpy(pSMB->DialectsArray+count, protocols[i].name, 16);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since we are already doing a strlen() on the source, change the strncpy
to a memcpy().

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/cifssmb.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -577,10 +577,15 @@ CIFSSMBNegotiate(const unsigned int xid,
 	}
 
 	count = 0;
+	/*
+	 * We know that all the name entries in the protocols array
+	 * are short (< 16 bytes anyway) and are NUL terminated.
+	 */
 	for (i = 0; i < CIFS_NUM_PROT; i++) {
-		strncpy(pSMB->DialectsArray+count, protocols[i].name, 16);
-		count += strlen(protocols[i].name) + 1;
-		/* null at end of source and target buffers anyway */
+		size_t len = strlen(protocols[i].name) + 1;
+
+		memcpy(pSMB->DialectsArray+count, protocols[i].name, len);
+		count += len;
 	}
 	inc_rfc1001_len(pSMB, count);
 	pSMB->ByteCount = cpu_to_le16(count);


