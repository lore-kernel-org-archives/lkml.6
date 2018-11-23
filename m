Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDACC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 03:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEB320813
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 03:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ixyZGcQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEB320813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408029AbeKWN6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 08:58:24 -0500
Received: from m12-16.163.com ([220.181.12.16]:34518 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731824AbeKWN6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 08:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Tn2Oijgn7sTTPQfEN5
        ne5ei07j8RpMQ/+5fJD69TwAY=; b=ixyZGcQQ5DTg6DUvUMX2pmGfGQKpwr0gvU
        Hc2Q0ihuE7nGp9jPHzdWyIBAK3+ckUK3PT8k51yxSFGJoDBrBz6Vce4+7Mp9Ye9H
        NnrurnOlReoBmiq2WUMnQqhO9lkhFx6/479sEMEaCBz6OcYInbv/4Fm/Nd3+5QjJ
        fUEsU+/9s=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp12 (Coremail) with SMTP id EMCowABHlQrpcPdbE1evBQ--.20002S3;
        Fri, 23 Nov 2018 11:15:55 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Pan Bian <bianpan2016@163.com>
Subject: [PATCH] exportfs: do not read dentry after free
Date:   Fri, 23 Nov 2018 11:15:53 +0800
Message-Id: <1542942953-93562-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EMCowABHlQrpcPdbE1evBQ--.20002S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw47tw45XFyktFWDWw45Wrg_yoWDJwcEka
        y8Wr48W398CFyxKF48ArWaqr4Sqan8ArWqyr4rJr45Za45CrWxJFZxtw1fXrs5Gw48W3W5
        Cr1DtryUCr1rCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0ByxtUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiQAYIclSIYQ97ggABs2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function dentry_connected calls dput(dentry) to drop the previously
acquired reference to dentry. In this case, dentry can be released.
After that, IS_ROOT(dentry) checks the condition
(dentry == dentry->d_parent), which may result in a use-after-free bug.
This patch directly compares dentry with its parent obtained before
dropping the reference.

Fixes: a056cc8934c("exportfs: stop retrying once we race with
rename/remove")

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 fs/exportfs/expfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 645158d..a69aaf5 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -77,7 +77,7 @@ static bool dentry_connected(struct dentry *dentry)
 		struct dentry *parent = dget_parent(dentry);
 
 		dput(dentry);
-		if (IS_ROOT(dentry)) {
+		if (dentry == parent) { /* is root entry */
 			dput(parent);
 			return false;
 		}
-- 
2.7.4


