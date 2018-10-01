Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D7AC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94641205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94641205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbeJARFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:05:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40269 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728923AbeJARFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:05:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w91ARs831527882
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 1 Oct 2018 03:27:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w91ARsw21527879;
        Mon, 1 Oct 2018 03:27:54 -0700
Date:   Mon, 1 Oct 2018 03:27:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Marc Zyngier <tipbot@zytor.com>
Message-ID: <tip-513145ea66af95f1a5c744d7b5a4f4a97625e669@git.kernel.org>
Cc:     marc.zyngier@arm.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          marc.zyngier@arm.com, tglx@linutronix.de
In-Reply-To: <20181001100522.180054-2-marc.zyngier@arm.com>
References: <20181001100522.180054-2-marc.zyngier@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/debugfs: Reset domain debugfs_file on removal
 of the debugfs file
Git-Commit-ID: 513145ea66af95f1a5c744d7b5a4f4a97625e669
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

Commit-ID:  513145ea66af95f1a5c744d7b5a4f4a97625e669
Gitweb:     https://git.kernel.org/tip/513145ea66af95f1a5c744d7b5a4f4a97625e669
Author:     Marc Zyngier <marc.zyngier@arm.com>
AuthorDate: Mon, 1 Oct 2018 11:05:21 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 1 Oct 2018 12:24:53 +0200

genirq/debugfs: Reset domain debugfs_file on removal of the debugfs file

When removing a debugfs file for a given irq domain, we fail to clear the
corresponding field, meaning that the corresponding domain won't be created
again if we need to do so.

It turns out that this is exactly what irq_domain_update_bus_token does
(delete old file, update domain name, recreate file).

This doesn't have any impact other than making debug more difficult, but we
do value ease of debugging... So clear the debugfs_file field.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20181001100522.180054-2-marc.zyngier@arm.com

---
 kernel/irq/irqdomain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 5d9fc01b60a6..95a0acbdd4e6 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1741,6 +1741,7 @@ static void debugfs_add_domain_dir(struct irq_domain *d)
 static void debugfs_remove_domain_dir(struct irq_domain *d)
 {
 	debugfs_remove(d->debugfs_file);
+	d->debugfs_file = NULL;
 }
 
 void __init irq_domain_debugfs_init(struct dentry *root)
