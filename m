Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8C0C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4418020879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790167;
	bh=Ejgt2V9/hAck2JFzpuI+RIWSsf1uZJdWJt1fE4q8E/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=loa+k/l7fNabU7+T+pGjbhH7JwrB9tWO1TcY6xW1hB+vanjGPhZI4Oyi4eW1KaY9d
	 LSI9+QlYvd5wYJXofUifuEOl12LGDWDG5+WIL1jUhY9UeDAnRP+ZRFYMoS6C6c6kU7
	 H1hkGZW3YQg6i8ZZEXhnb8lV0OWestWmmKnbuacM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4418020879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbeLNMWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:22:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732243AbeLNMOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:14:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A315214DE;
        Fri, 14 Dec 2018 12:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789641;
        bh=Ejgt2V9/hAck2JFzpuI+RIWSsf1uZJdWJt1fE4q8E/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UAOqauAjogkkGbxqxE+itHWumpyEfBeQR7WZgd57EdwX4ApNFHzWJgp3D1OlXFiyT
         EfA6/grIezHqt9uhLR1KZZce+LRsUVaoi5sQECVWd8lzypg1soAhSc5jmDHHO/K0f2
         SU5CD4NyRdh16fHrP0F0Rpo0fMsF4+BjSca5VI+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 20/88] exportfs: do not read dentry after free
Date:   Fri, 14 Dec 2018 12:59:54 +0100
Message-Id: <20181214115703.775074180@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 714cd37a6ba3..6599c6124552 100644
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
2.19.1



