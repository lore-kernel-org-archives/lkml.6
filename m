Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D6BC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E082070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546533962;
	bh=MUkG8lx7WG71msV7qWWuDuPNRWeryiP0dzLzoKmcGqE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=jmpD/9qmucwnJjTrIZ4jCF6k9vhLoNe3YwjgThWUJnVt1lSY493pzUgN+1/cKYc5O
	 wjbXTNEk70kFhGs2T5kti7DsH2ZnaAD+X5tNM3kKgO344O/0nUnFDNJF6Auixo0KQm
	 t7lWxA404zCk6MhVWcdpH+lKx4qMkt4pj9xYQJA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbfACQqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:46:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730629AbfACQqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:46:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3C402070D;
        Thu,  3 Jan 2019 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546533960;
        bh=MUkG8lx7WG71msV7qWWuDuPNRWeryiP0dzLzoKmcGqE=;
        h=Date:From:To:Cc:Subject:From;
        b=vFroVv7pC1uX1Wp2267GUXeaD4dklwnnb3qjX5yGMeIFYWU9/e6dZUHb4UqoKImG3
         hQrPELM18PPWRm9PjzGJ54GYCq3jJP9V5WZkoOFsthkXR9+BK9C4Mtpq93EA8N7NxW
         ooo1J129+3VDurFGpgOYM6kV3au0+KVJ/EoIE31g=
Date:   Thu, 3 Jan 2019 17:45:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Simek <monstr@monstr.eu>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] microblaze: no need to check return value of debugfs_create
 functions
Message-ID: <20190103164558.GA14675@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Michal Simek <monstr@monstr.eu>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/microblaze/kernel/setup.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index bbd6968ce55b..522a0c5d9c59 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -192,23 +192,14 @@ struct dentry *of_debugfs_root;
 static int microblaze_debugfs_init(void)
 {
 	of_debugfs_root = debugfs_create_dir("microblaze", NULL);
-
-	return of_debugfs_root == NULL;
+	return 0;
 }
 arch_initcall(microblaze_debugfs_init);
 
 # ifdef CONFIG_MMU
 static int __init debugfs_tlb(void)
 {
-	struct dentry *d;
-
-	if (!of_debugfs_root)
-		return -ENODEV;
-
-	d = debugfs_create_u32("tlb_skip", S_IRUGO, of_debugfs_root, &tlb_skip);
-	if (!d)
-		return -ENOMEM;
-
+	debugfs_create_u32("tlb_skip", S_IRUGO, of_debugfs_root, &tlb_skip);
 	return 0;
 }
 device_initcall(debugfs_tlb);
-- 
2.20.1

