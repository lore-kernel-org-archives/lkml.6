Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1198C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910BC217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170084;
	bh=OcCJCJe5ytmFwd4tSUjrcn1s8QsLE07MJEyeEBuLv1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ixhNdmZ0sn6R3miacAvDhZoGse3oCsPVK33p+5XqUs238ngmIed2J8vIp09TII+mt
	 dHpQSiFmbCziyCvRYCQBvsoa8BGPnyntRWilAVAC1VxQXNucdsX8nrUQAKPF7TceN9
	 aq58HszncnXbClhvQT92jn0v1K2K58KZNSycT9yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfAVPOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:14:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729052AbfAVPOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:14:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9BBF20879;
        Tue, 22 Jan 2019 15:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170081;
        bh=OcCJCJe5ytmFwd4tSUjrcn1s8QsLE07MJEyeEBuLv1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yq4lADgYHa7g0/RLh8qYkIXE54BK6+kPTUh38UBzYhD69b9HkHynSIYOY1SDSq57U
         iiMp59vLlzaSan2hsleZ7hFCaBdDYfOJSdytkD6LrPicU1BWtP42vIzmj+KMVemmXM
         T0NvZCYn6pHhDhqLuIqHm8QbCOo9RtwLhLD+5UlE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>, linux-arm-kernel@axis.com
Subject: [PATCH 3/7] crypto: axis: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:14:18 +0100
Message-Id: <20190122151422.14204-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122151422.14204-1-gregkh@linuxfoundation.org>
References: <20190122151422.14204-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Lars Persson <lars.persson@axis.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-kernel@axis.com
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/axis/artpec6_crypto.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index f3442c2bdbdc..1a1858cea979 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -2984,12 +2984,6 @@ static void artpec6_crypto_init_debugfs(void)
 {
 	dbgfs_root = debugfs_create_dir("artpec6_crypto", NULL);
 
-	if (!dbgfs_root || IS_ERR(dbgfs_root)) {
-		dbgfs_root = NULL;
-		pr_err("%s: Could not initialise debugfs!\n", MODULE_NAME);
-		return;
-	}
-
 #ifdef CONFIG_FAULT_INJECTION
 	fault_create_debugfs_attr("fail_status_read", dbgfs_root,
 				  &artpec6_crypto_fail_status_read);
@@ -3001,9 +2995,6 @@ static void artpec6_crypto_init_debugfs(void)
 
 static void artpec6_crypto_free_debugfs(void)
 {
-	if (!dbgfs_root)
-		return;
-
 	debugfs_remove_recursive(dbgfs_root);
 	dbgfs_root = NULL;
 }
-- 
2.20.1

