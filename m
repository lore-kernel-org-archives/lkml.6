Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAB4C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754A4214AC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789070;
	bh=tPz/Lk9WECQDRqMvRZG+ZzbEibulPq5dW2SVAXJlVc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nNhFOSdXrSw+zandSDmUoZie3o/w9uXRf8nWDmjGDqrTqtjUs1ESpH3ZKqBNGs8OH
	 CgmgwuaKNVGHaUadSG2KXdd5SueCNN3bc6uq1eWNwrA6aoVCu+LyoiPHmA57tqZRzu
	 pVwznOgnY+uaV44O2rrasHoFp9fG6LKx5OC43G1U=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754A4214AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbeLNME3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:04:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730494AbeLNMEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:04:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 436F72147D;
        Fri, 14 Dec 2018 12:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789062;
        bh=tPz/Lk9WECQDRqMvRZG+ZzbEibulPq5dW2SVAXJlVc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=viySv7EXmPOxBf+9/G24uYHhmhevB9bM+A94T6/ZGrbWMAwaAeDR3WZbqL2qRPgy9
         NGxRGvgzhkg0DsVWRc44F/gWK2zazXf8j9YY8oBh56HiE8dSjEiez47ifgBn9IwX2A
         hCUuaRCS5apkjeJoBhYdGhRlKnLBAjau1KA9BYac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 080/142] exportfs: do not read dentry after free
Date:   Fri, 14 Dec 2018 12:59:25 +0100
Message-Id: <20181214115750.269407342@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 645158dc33f1..63707abcbeb3 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -77,7 +77,7 @@ static bool dentry_connected(struct dentry *dentry)
 		struct dentry *parent = dget_parent(dentry);
 
 		dput(dentry);
-		if (IS_ROOT(dentry)) {
+		if (dentry == parent) {
 			dput(parent);
 			return false;
 		}
-- 
2.19.1



