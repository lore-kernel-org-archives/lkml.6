Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08258C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8642075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8642075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeJ3Omr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 10:42:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbeJ3Omr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 10:42:47 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7908947DD653A;
        Tue, 30 Oct 2018 13:50:41 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 30 Oct
 2018 13:50:34 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Will Deacon" <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <chao@kernel.org>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2] bit_spinlock: introduce smp_cond_load_relaxed
Date:   Tue, 30 Oct 2018 14:04:41 +0800
Message-ID: <20181030060441.16107-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <1539413249-4402-1-git-send-email-hsiangkao@aol.com>
References: <1539413249-4402-1-git-send-email-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to use wrapped smp_cond_load_relaxed
instead of open-coded busy waiting for bit_spinlock.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

change log v2:
 - fix the incorrect expression !(VAL >> (bitnum & (BITS_PER_LONG-1)))
 - the test result is described in the following reply.

Thanks,
Gao Xiang

 include/linux/bit_spinlock.h | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730a6505..d5f922b5ffd9 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -15,22 +15,19 @@
  */
 static inline void bit_spin_lock(int bitnum, unsigned long *addr)
 {
-	/*
-	 * Assuming the lock is uncontended, this never enters
-	 * the body of the outer loop. If it is contended, then
-	 * within the inner loop a non-atomic test is used to
-	 * busywait with less bus contention for a good time to
-	 * attempt to acquire the lock bit.
-	 */
-	preempt_disable();
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	while (unlikely(test_and_set_bit_lock(bitnum, addr))) {
-		preempt_enable();
-		do {
-			cpu_relax();
-		} while (test_bit(bitnum, addr));
+	const unsigned int bitshift = bitnum & (BITS_PER_LONG - 1);
+
+	while (1) {
+		smp_cond_load_relaxed(&addr[BIT_WORD(bitnum)],
+				      !((VAL >> bitshift) & 1));
 		preempt_disable();
+		if (!test_and_set_bit_lock(bitnum, addr))
+			break;
+		preempt_enable();
 	}
+#else
+	preempt_disable();
 #endif
 	__acquire(bitlock);
 }
-- 
2.17.1

