Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E47DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4704820844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfA2THH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:07:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46601 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfA2THH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:07:07 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0TJ6uiP2060426
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 29 Jan 2019 11:06:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0TJ6uUl2060423;
        Tue, 29 Jan 2019 11:06:56 -0800
Date:   Tue, 29 Jan 2019 11:06:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Greg Kroah-Hartman <tipbot@zytor.com>
Message-ID: <tip-434537bbd50fefc89c1e29170bf4030ae3ec445a@git.kernel.org>
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        marc.zyngier@arm.com
Reply-To: hpa@zytor.com, gregkh@linuxfoundation.org, marc.zyngier@arm.com,
          mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190122152151.16139-50-gregkh@linuxfoundation.org>
References: <20190122152151.16139-50-gregkh@linuxfoundation.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/debugfs: No need to check return value of
 debugfs_create functions
Git-Commit-ID: 434537bbd50fefc89c1e29170bf4030ae3ec445a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  434537bbd50fefc89c1e29170bf4030ae3ec445a
Gitweb:     https://git.kernel.org/tip/434537bbd50fefc89c1e29170bf4030ae3ec445a
Author:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
AuthorDate: Tue, 22 Jan 2019 16:21:49 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 29 Jan 2019 20:04:21 +0100

genirq/debugfs: No need to check return value of debugfs_create functions

When calling debugfs functions, there is no need to ever check the return
value.  The function can work or not, but the code logic should never do
something different based on this.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Link: https://lkml.kernel.org/r/20190122152151.16139-50-gregkh@linuxfoundation.org

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
