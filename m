Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F26C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F447214C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJRoZxyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F447214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbeJIB4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:56:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730165AbeJIB4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:56:47 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86031214C2;
        Mon,  8 Oct 2018 18:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024222;
        bh=N2w4ABvkO++hvMN2G68Dkt6hAWw5Ksr+hgROQtbwjBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJRoZxycshGsot+ERkuNbBhA3A8QI/2HzVtqnmdeceIczFGjVBS0a9j45LkSSTlSb
         b+eIDsKPakBobpuhnuX79nUiezZ2JSvqOAZk3AzEQR0eTmBFPJG+LHZge06nkatlbZ
         1u6hSJ+hFivqSMgYO1xXND4T5GlcwgJvELv+2mo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 62/94] fs/cifs: suppress a string overflow warning
Date:   Mon,  8 Oct 2018 20:31:43 +0200
Message-Id: <20181008175609.361522977@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -589,10 +589,15 @@ CIFSSMBNegotiate(const unsigned int xid,
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


