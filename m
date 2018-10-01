Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98987C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6652E2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6652E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbeJAQmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:42:44 -0400
Received: from foss.arm.com ([217.140.101.70]:46148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729092AbeJAQme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:42:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 394691596;
        Mon,  1 Oct 2018 03:05:33 -0700 (PDT)
Received: from filthy-habits.Emea.Arm.com (filthy-habits.emea.arm.com [10.4.13.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FF353F5B3;
        Mon,  1 Oct 2018 03:05:32 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/2] genirq/debugfs: Reset domain debugfs_file on removal of the debugfs file
Date:   Mon,  1 Oct 2018 11:05:21 +0100
Message-Id: <20181001100522.180054-2-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001100522.180054-1-marc.zyngier@arm.com>
References: <20181001100522.180054-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When removing a debugfs file for a given irq domain, we fail
to clear the corresponding field, meaning that the corresponding
domain won't be created again if we need to do so.

It turns out that this is exactly what irq_domain_update_bus_token
does (delete old file, update domain name, recreate file).

This doesn't have any impact other than making debug more
difficult, but we do value ease of debugging... So let's
clear the debugfs_file field.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
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
-- 
2.19.0

