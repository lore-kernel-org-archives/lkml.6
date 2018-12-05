Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C5BC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B7B214C1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tF+R+Eqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B7B214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbeLEJt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:49:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728452AbeLEJt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:49:57 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F9792133F;
        Wed,  5 Dec 2018 09:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003397;
        bh=Z0XsMpCBym0QwU9vaxF3AqZe6uSNiCLBFAbPIz2vv1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tF+R+Eqhu5mZ7cTpuKFOAjMx58+BXV7dRXlKfkNbQZmxw/RkI1mVtq6Fn+JNIbjcv
         t/tYkxTSDwYnlej7cnMi8vSaSBdrlWrJkMUD0m8c54530F+5pk4x2GvfI54FjGqePs
         YF/rIVX09/1uMyVzdAxpj4T1TYtfTIQu0BCzKjN4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pan Bian <bianpan2016@163.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 19/45] exportfs: do not read dentry after free
Date:   Wed,  5 Dec 2018 04:46:40 -0500
Message-Id: <20181205094706.7225-19-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094706.7225-1-sashal@kernel.org>
References: <20181205094706.7225-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 2084ac6c505a58f7efdec13eba633c6aaa085ca5 ]

The function dentry_connected calls dput(dentry) to drop the previously
acquired reference to dentry. In this case, dentry can be released.
After that, IS_ROOT(dentry) checks the condition
(dentry == dentry->d_parent), which may result in a use-after-free bug.
This patch directly compares dentry with its parent obtained before
dropping the reference.

Fixes: a056cc8934c("exportfs: stop retrying once we race with
rename/remove")

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exportfs/expfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index a4b531be9168..7a7bba7c2328 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -76,7 +76,7 @@ static bool dentry_connected(struct dentry *dentry)
 		struct dentry *parent = dget_parent(dentry);
 
 		dput(dentry);
-		if (IS_ROOT(dentry)) {
+		if (dentry == parent) {
 			dput(parent);
 			return false;
 		}
-- 
2.17.1

