Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72BBECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A562E2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mS3yzy9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A562E2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeKIHdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728702AbeKIHdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:08 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 509A32089F;
        Thu,  8 Nov 2018 21:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714141;
        bh=YKqs72alTGO4afGvKbQwSZ+m+iOzKq8xUbqRGpV/04Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mS3yzy9cDU4B/8rjXJTju4b5jrDiPKt8vSBweROOMaoD4LhkAdjrSsA+RI4tysMNs
         sYcXtWmrEmX4GGHMNDbpKOPhCB/xN/cMTY2qhHYT9EXLwfYJ6mPN2oQxV498xVbGNL
         FXVVzjFwW2t8ZARYFSlYC/WljZeAgN4TKpX0pz3E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 057/144] NFSv4: Remove incorrect check in can_open_delegated()
Date:   Thu,  8 Nov 2018 13:50:28 -0800
Message-Id: <20181108215058.957898298@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
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



