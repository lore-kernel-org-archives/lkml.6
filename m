Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE461C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB31205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB31205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeJARFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:05:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33673 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbeJARFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:05:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w91ASUPh1527961
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 1 Oct 2018 03:28:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w91ASTp61527958;
        Mon, 1 Oct 2018 03:28:30 -0700
Date:   Mon, 1 Oct 2018 03:28:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Marc Zyngier <tipbot@zytor.com>
Message-ID: <tip-94967b55ebf3b603f2fe750ecedd896042585a1c@git.kernel.org>
Cc:     hpa@zytor.com, marc.zyngier@arm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, hpa@zytor.com, marc.zyngier@arm.com
In-Reply-To: <20181001100522.180054-3-marc.zyngier@arm.com>
References: <20181001100522.180054-3-marc.zyngier@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/debugfs: Reinstate full OF path for domain
 name
Git-Commit-ID: 94967b55ebf3b603f2fe750ecedd896042585a1c
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

Commit-ID:  94967b55ebf3b603f2fe750ecedd896042585a1c
Gitweb:     https://git.kernel.org/tip/94967b55ebf3b603f2fe750ecedd896042585a1c
Author:     Marc Zyngier <marc.zyngier@arm.com>
AuthorDate: Mon, 1 Oct 2018 11:05:22 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 1 Oct 2018 12:24:53 +0200

genirq/debugfs: Reinstate full OF path for domain name

On a DT based system, we use the of_node full name to name the
corresponding irq domain. We expect that name to be unique, so so that
domains with the same base name won't clash (this happens on multi-node
topologies, for example).

Since a7e4cfb0a7ca ("of/fdt: only store the device node basename in
full_name"), of_node_full_name() lies and only returns the basename. This
breaks the above requirement, and we end-up with only a subset of the
domains in /sys/kernel/debug/irq/domains.

Let's reinstate the feature by using the fancy new %pOF format specifier,
which happens to do the right thing.

Fixes: a7e4cfb0a7ca ("of/fdt: only store the device node basename in full_name")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20181001100522.180054-3-marc.zyngier@arm.com

---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 95a0acbdd4e6..3b30a4aeb0db 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -183,7 +183,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 		 * unhappy about. Replace them with ':', which does
 		 * the trick and is not as offensive as '\'...
 		 */
-		name = kstrdup(of_node_full_name(of_node), GFP_KERNEL);
+		name = kasprintf(GFP_KERNEL, "%pOF", of_node);
 		if (!name) {
 			kfree(domain);
 			return NULL;
