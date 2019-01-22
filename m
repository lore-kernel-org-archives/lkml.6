Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A02C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76AFD217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170533;
	bh=pgfPDiEGyjA54/auXcWXc9FPQo9uEGUkLPWjMRt6uFk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AK80lQ1cSQ9XVOQIXGTK7JRHu9lELUjrsJgw4/JFmSfkTCkC0DnB/ye7Gwr6fTqvZ
	 kZdECpwdmF9WVpdd/V30VE/HGnSiQFhhQFbrQtMAK9vdi7tTe9ovveWJSBZ0CLbWIq
	 6lBLK7EwZKicqE3pLMHvXHEofgM6c3IlKRaBI9zY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfAVPWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:22:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728836AbfAVPWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:22:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 328F2217D8;
        Tue, 22 Jan 2019 15:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170528;
        bh=pgfPDiEGyjA54/auXcWXc9FPQo9uEGUkLPWjMRt6uFk=;
        h=From:To:Cc:Subject:Date:From;
        b=k06AHnOworTYPCPbks5d+WCjj15LNe2a9Wp+zitW0LH7u5I/oRRqVs6Yf12va9wRR
         r9oaCc9leIU8a0rn1hxkP1KNtFzkVjMhsXDpyn+FcnyuxQxuN6rmQiTnMoqzP7YqG/
         KIDvEKvMEbiV3XzRYisURRlklW0xiYMI2IK764f0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-mm@kvack.org
Subject: [PATCH] mm: cleancache: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:11 +0100
Message-Id: <20190122152151.16139-12-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-mm@kvack.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/cleancache.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/cleancache.c b/mm/cleancache.c
index 2bf12da9baa0..082fdda7aaa6 100644
--- a/mm/cleancache.c
+++ b/mm/cleancache.c
@@ -305,8 +305,7 @@ static int __init init_cleancache(void)
 {
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *root = debugfs_create_dir("cleancache", NULL);
-	if (root == NULL)
-		return -ENXIO;
+
 	debugfs_create_u64("succ_gets", 0444, root, &cleancache_succ_gets);
 	debugfs_create_u64("failed_gets", 0444, root, &cleancache_failed_gets);
 	debugfs_create_u64("puts", 0444, root, &cleancache_puts);
-- 
2.20.1

