Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1182DC10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79BA2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499294;
	bh=qoUKfB3V24vAQ+ZJW377BeMsnuBMFCcuEAR6nuaf54s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xWVrnhVTma19VwUEbSC30mK9K6Y3tKNYEyhqgggJ67TAgQ1I4cr2Oc/3rVlIid/o7
	 rZdHFv5dl7KAlXMIqnLn5JM4HQwWPE7coconw1aoYDKg4dje6E2G44D9wASKwYT7+l
	 4pEy7+j5LSOOGpTH2QIVAtZG64bSLjcV4p+ubNmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391196AbfBROMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:12:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:57314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392055AbfBROMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:12:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8323721901;
        Mon, 18 Feb 2019 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499160;
        bh=qoUKfB3V24vAQ+ZJW377BeMsnuBMFCcuEAR6nuaf54s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m7YNG4s6ESDpFseepVolVXEkxGG1950YV2OFEQShbka59xZRZ/mvmAMsWydq/d0NI
         WdA3th7U7LCM1jwkaRUy0wcdVfhwnqWfYd984AxABj0IHmrNgDOY269cJk0jMouiht
         2cwgBv0F6fLmAmKCoLtu5FEQY7fI/1Mu5Z736hlU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Lagerwall <ross.lagerwall@citrix.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 095/108] cifs: Limit memory used by lock request calls to a page
Date:   Mon, 18 Feb 2019 14:44:31 +0100
Message-Id: <20190218133524.053341401@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 92a8109e4d3a34fb6b115c9098b51767dc933444 ]

The code tries to allocate a contiguous buffer with a size supplied by
the server (maxBuf). This could fail if memory is fragmented since it
results in high order allocations for commonly used server
implementations. It is also wasteful since there are probably
few locks in the usual case. Limit the buffer to be no larger than a
page to avoid memory allocation failures due to fragmentation.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/file.c     |    8 ++++++++
 fs/cifs/smb2file.c |    4 ++++
 2 files changed, 12 insertions(+)

--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1075,6 +1075,10 @@ cifs_push_mandatory_locks(struct cifsFil
 		return -EINVAL;
 	}
 
+	BUILD_BUG_ON(sizeof(struct smb_hdr) + sizeof(LOCKING_ANDX_RANGE) >
+		     PAGE_SIZE);
+	max_buf = min_t(unsigned int, max_buf - sizeof(struct smb_hdr),
+			PAGE_SIZE);
 	max_num = (max_buf - sizeof(struct smb_hdr)) /
 						sizeof(LOCKING_ANDX_RANGE);
 	buf = kzalloc(max_num * sizeof(LOCKING_ANDX_RANGE), GFP_KERNEL);
@@ -1410,6 +1414,10 @@ cifs_unlock_range(struct cifsFileInfo *c
 	if (max_buf < (sizeof(struct smb_hdr) + sizeof(LOCKING_ANDX_RANGE)))
 		return -EINVAL;
 
+	BUILD_BUG_ON(sizeof(struct smb_hdr) + sizeof(LOCKING_ANDX_RANGE) >
+		     PAGE_SIZE);
+	max_buf = min_t(unsigned int, max_buf - sizeof(struct smb_hdr),
+			PAGE_SIZE);
 	max_num = (max_buf - sizeof(struct smb_hdr)) /
 						sizeof(LOCKING_ANDX_RANGE);
 	buf = kzalloc(max_num * sizeof(LOCKING_ANDX_RANGE), GFP_KERNEL);
--- a/fs/cifs/smb2file.c
+++ b/fs/cifs/smb2file.c
@@ -110,6 +110,8 @@ smb2_unlock_range(struct cifsFileInfo *c
 	if (max_buf < sizeof(struct smb2_lock_element))
 		return -EINVAL;
 
+	BUILD_BUG_ON(sizeof(struct smb2_lock_element) > PAGE_SIZE);
+	max_buf = min_t(unsigned int, max_buf, PAGE_SIZE);
 	max_num = max_buf / sizeof(struct smb2_lock_element);
 	buf = kzalloc(max_num * sizeof(struct smb2_lock_element), GFP_KERNEL);
 	if (!buf)
@@ -246,6 +248,8 @@ smb2_push_mandatory_locks(struct cifsFil
 		return -EINVAL;
 	}
 
+	BUILD_BUG_ON(sizeof(struct smb2_lock_element) > PAGE_SIZE);
+	max_buf = min_t(unsigned int, max_buf, PAGE_SIZE);
 	max_num = max_buf / sizeof(struct smb2_lock_element);
 	buf = kzalloc(max_num * sizeof(struct smb2_lock_element), GFP_KERNEL);
 	if (!buf) {


