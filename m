Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C76FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A59F206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956001;
	bh=Qwleg3e0+E8sSrXfHSHco/o7JDUK2pFrFo7Bhz4hdjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W8FKC3DAt1yDx2LeIW6Whg2j8v61su7bL8kc4hXzj+ak2DHQ5X1VwD6nZZpPeW+ts
	 Yyxo+ZwB5epZjOyJ5aj7U/n4YS8nfTKJyDyKQFqon58LRTyKvakc9s3duf9rLGXuds
	 Rr+kGUItI/0FgJMysiKcxUU2oTdfQXj64o5H7ZNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfBWVGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:06:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728728AbfBWVGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:06:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C66F206B6;
        Sat, 23 Feb 2019 21:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955994;
        bh=Qwleg3e0+E8sSrXfHSHco/o7JDUK2pFrFo7Bhz4hdjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E2KUX0QJWq8w1JQ5xD1eKf3VjkJmW5hWiaApU4yloeDozxaUAkivu1yFP3JSUvGJP
         d5dpRiLMlyWRuAjWxxR/qql3vyxYl8HyFRG/Q1bOisDyf13sjDs8fuNAkxZVnhqTbJ
         rWTufWLp7w64+Lr7HxOyswF0HqJGoXdbew/jAHvk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 69/72] lib/test_kmod.c: potential double free in error handling
Date:   Sat, 23 Feb 2019 16:04:19 -0500
Message-Id: <20190223210422.199966-69-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit db7ddeab3ce5d64c9696e70d61f45ea9909cd196 ]

There is a copy and paste bug so we set "config->test_driver" to NULL
twice instead of setting "config->test_fs".  Smatch complains that it
leads to a double free:

  lib/test_kmod.c:840 __kmod_config_init() warn: 'config->test_fs' double freed

Link: http://lkml.kernel.org/r/20190121140011.GA14283@kadam
Fixes: d9c6a72d6fa2 ("kmod: add test driver to stress test the module loader")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_kmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index d82d022111e0e..9cf77628fc913 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -632,7 +632,7 @@ static void __kmod_config_free(struct test_config *config)
 	config->test_driver = NULL;
 
 	kfree_const(config->test_fs);
-	config->test_driver = NULL;
+	config->test_fs = NULL;
 }
 
 static void kmod_config_free(struct kmod_test_device *test_dev)
-- 
2.19.1

