Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F86C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5C32081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5C32081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeKASGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:06:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59493 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeKASGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:06:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA193q2T2750023
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 1 Nov 2018 02:03:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA193qXc2750020;
        Thu, 1 Nov 2018 02:03:52 -0700
Date:   Thu, 1 Nov 2018 02:03:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Michael Kelley <tipbot@zytor.com>
Message-ID: <tip-57f01796f14fecf00d330fe39c8d2477ced9cd79@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, kys@microsoft.com,
        mikelley@microsoft.com, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, kys@microsoft.com, hpa@zytor.com,
          mikelley@microsoft.com, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <1541032428-10392-1-git-send-email-mikelley@microsoft.com>
References: <1541032428-10392-1-git-send-email-mikelley@microsoft.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] irq/matrix: Fix memory overallocation
Git-Commit-ID: 57f01796f14fecf00d330fe39c8d2477ced9cd79
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

Commit-ID:  57f01796f14fecf00d330fe39c8d2477ced9cd79
Gitweb:     https://git.kernel.org/tip/57f01796f14fecf00d330fe39c8d2477ced9cd79
Author:     Michael Kelley <mikelley@microsoft.com>
AuthorDate: Thu, 1 Nov 2018 00:35:05 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Nov 2018 10:00:38 +0100

irq/matrix: Fix memory overallocation

IRQ_MATRIX_SIZE is the number of longs needed for a bitmap, multiplied by
the size of a long, yielding a byte count. But it is used to size an array
of longs, which is way more memory than is needed.

Change IRQ_MATRIX_SIZE so it is just the number of longs needed and the
arrays come out the correct size.

Fixes: 2f75d9e1c905 ("genirq: Implement bitmap matrix allocator")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: KY Srinivasan <kys@microsoft.com>
Link: https://lkml.kernel.org/r/1541032428-10392-1-git-send-email-mikelley@microsoft.com

---
 kernel/irq/matrix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 6e6d467f3dec..1f0985adf193 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -8,7 +8,7 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
 
-#define IRQ_MATRIX_SIZE	(BITS_TO_LONGS(IRQ_MATRIX_BITS) * sizeof(unsigned long))
+#define IRQ_MATRIX_SIZE	(BITS_TO_LONGS(IRQ_MATRIX_BITS))
 
 struct cpumap {
 	unsigned int		available;
