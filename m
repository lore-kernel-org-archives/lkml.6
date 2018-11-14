Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E43C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3DE2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMpyZJtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3DE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbeKOIrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:47:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728780AbeKOI1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:22 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D95082252A;
        Wed, 14 Nov 2018 22:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234138;
        bh=1LpCHfmrvSasWtRLwoH0j+BZ/0fFXfEt7fQM2byFWYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PMpyZJtQeJlPZ5FJzXDlK52JVHJRWYf4CG10w5ZzdxebmCKkGYy8FH8PExhrW0ilq
         uu3pO9/EYHvvK57tkoHzdkrMxaVrqWTaoj6uXW7zVQ8rWliG4+24UK3VhToQRzEzDD
         dyASmcDS5iaHFylgQdyfzEvGmrxTUj6KQzWy9oLY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Luis Henriques <lhenriques@suse.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 45/73] ceph: quota: fix null pointer dereference in quota check
Date:   Wed, 14 Nov 2018 17:21:39 -0500
Message-Id: <20181114222207.98701-45-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Henriques <lhenriques@suse.com>

[ Upstream commit 71f2cc64d027d712f29bf8d09d3e123302d5f245 ]

This patch fixes a possible null pointer dereference in
check_quota_exceeded, detected by the static checker smatch, with the
following warning:

   fs/ceph/quota.c:240 check_quota_exceeded()
    error: we previously assumed 'realm' could be null (see line 188)

Fixes: b7a2921765cf ("ceph: quota: support for ceph.quota.max_files")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Luis Henriques <lhenriques@suse.com>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/quota.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 32d4f13784ba..03f4d24db8fe 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -237,7 +237,8 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 		ceph_put_snap_realm(mdsc, realm);
 		realm = next;
 	}
-	ceph_put_snap_realm(mdsc, realm);
+	if (realm)
+		ceph_put_snap_realm(mdsc, realm);
 	up_read(&mdsc->snap_rwsem);
 
 	return exceeded;
-- 
2.17.1

