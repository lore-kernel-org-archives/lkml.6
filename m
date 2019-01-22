Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A2CC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AA1217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170642;
	bh=NZUhq9GCdsOMWntFZZESigi5ONHtNTxs26LBW0J4W0Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=YhuVwrovNQxcf5zON+9rAWkrgvOlN0g8vXNflwnb9eGSCa5zrcrHa122+A9H5+Zcf
	 Z8gizbz/SPJg/SldmMDgNeRYB/b5ISaN3NLBMcReicz25lnF3jEY4vGjnVHbLSubv5
	 9CXMlxJvpVkXaxvn3xNqN/I6iUlKm/l/7VzBUdFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfAVPYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:24:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:37412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729954AbfAVPXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:23:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BCA820855;
        Tue, 22 Jan 2019 15:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170634;
        bh=NZUhq9GCdsOMWntFZZESigi5ONHtNTxs26LBW0J4W0Y=;
        h=From:To:Cc:Subject:Date:From;
        b=M91TFZS2QGMbsTxKQqX1wFObO+PgS/JQ5ZvwlM8HNFmkzjl7eldfvlExBW7jkA7E9
         BLfe4pB9FScKS3GKs5aopM34bIcD9gq5UYb/0lqntNxLDfT2oNDSYHHbJlm0hY/0aO
         h/hxZeaAEIi3pbJX1bG5qBFn/2CZ/TRNPiP53ndY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH] irq: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:49 +0100
Message-Id: <20190122152151.16139-50-gregkh@linuxfoundation.org>
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

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/irq/debugfs.c   | 2 --
 kernel/irq/irqdomain.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 6f636136cccc..bbd783a83409 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -256,8 +256,6 @@ static int __init irq_debugfs_init(void)
 	int irq;
 
 	root_dir = debugfs_create_dir("irq", NULL);
-	if (!root_dir)
-		return -ENOMEM;
 
 	irq_domain_debugfs_init(root_dir);
 
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8b0be4bd6565..45c74373c7a4 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1749,8 +1749,6 @@ void __init irq_domain_debugfs_init(struct dentry *root)
 	struct irq_domain *d;
 
 	domain_dir = debugfs_create_dir("domains", root);
-	if (!domain_dir)
-		return;
 
 	debugfs_create_file("default", 0444, domain_dir, NULL,
 			    &irq_domain_debug_fops);
-- 
2.20.1

