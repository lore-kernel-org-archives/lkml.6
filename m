Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947A1ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E2920883
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2wq5Gde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E2920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbeJYWwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730602AbeJYWwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:33 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECA862086D;
        Thu, 25 Oct 2018 14:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477175;
        bh=T7sPpB8pf8Wh7F9UBSvshsMAujrfQnTTt3k70AoubrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o2wq5Gde0+5Eq3o+B5MLGmSvNXmpaPXxYnEZWA36rNHY/9zymIeS9bHpu0BXbl8nR
         CsXasm0JHbpSagcRlEUQIVgLATcr5bYxsbZipLWuSjSYF2ZacbIxleux4Y3BYOWwnF
         lq89IODddn5eDANxXCuTTSe6GLwRKseRbJgnjQTo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 27/98] NFSv4: Remove incorrect check in can_open_delegated()
Date:   Thu, 25 Oct 2018 10:17:42 -0400
Message-Id: <20181025141853.214051-27-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@primarydata.com>

[ Upstream commit 4e379d36c050b0117b5d10048be63a44f5036115 ]

Remove an incorrect check for NFS_DELEGATION_NEED_RECLAIM in
can_open_delegated(). We are allowed to cache opens even in
a situation where we're doing reboot recovery.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index db8456b4ecb8..21906d2a13cc 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1117,8 +1117,6 @@ static int can_open_delegated(struct nfs_delegation *delegation, fmode_t fmode)
 		return 0;
 	if ((delegation->type & fmode) != fmode)
 		return 0;
-	if (test_bit(NFS_DELEGATION_NEED_RECLAIM, &delegation->flags))
-		return 0;
 	if (test_bit(NFS_DELEGATION_RETURNING, &delegation->flags))
 		return 0;
 	nfs_mark_delegation_referenced(delegation);
-- 
2.17.1

