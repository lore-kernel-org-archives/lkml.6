Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30EEC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A9C217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170761;
	bh=UgFdE/28zUYcD+pvmTGjHV58/a6MidScMZkcvO2bYic=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=172MYcfGNa7MvrOR4qHKWxtp2yydtIiMdfhVcq+Jts6XQEglc9kE04G6VA1Fc3mXZ
	 ITEX0Cn+O1jz0pni8jDge62QJDRCogjjQMx086fuNW/3uG1+6xREQpkgZd6duVE19S
	 lSbC0+7CLAJAp6fARaIKpeVZ/KHNQGuQpBR06wDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfAVPZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:25:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbfAVPXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:23:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03629217D4;
        Tue, 22 Jan 2019 15:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170601;
        bh=UgFdE/28zUYcD+pvmTGjHV58/a6MidScMZkcvO2bYic=;
        h=From:To:Cc:Subject:Date:From;
        b=UAP1p59slyM3EvNUqs1zTQ0f6zFHKYC3c5EhxMzKKgXjLzYbq5TNb1PDD0nZB5glv
         5SBD5pbzmaI+Rszx9vfpoTrUS+/7aNP9UBHEIvFAPqxvM/DIOj9mwEY6LGzm8NqFfw
         ACPw78H0DmV3wrNel1QrnnlNuHcMcFoh2dwGEvlU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>, linux-mm@kvack.org
Subject: [PATCH] zswap: ignore debugfs_create_dir() return value
Date:   Tue, 22 Jan 2019 16:21:08 +0100
Message-Id: <20190122152151.16139-9-gregkh@linuxfoundation.org>
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

Cc: Seth Jennings <sjenning@redhat.com>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: linux-mm@kvack.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/zswap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index a4e4d36ec085..f583d08f6e24 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1262,8 +1262,6 @@ static int __init zswap_debugfs_init(void)
 		return -ENODEV;
 
 	zswap_debugfs_root = debugfs_create_dir("zswap", NULL);
-	if (!zswap_debugfs_root)
-		return -ENOMEM;
 
 	debugfs_create_u64("pool_limit_hit", 0444,
 			   zswap_debugfs_root, &zswap_pool_limit_hit);
-- 
2.20.1

