Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84071C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E9524ECF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E9524ECF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeFXMWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 08:22:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49987 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeFXMWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 08:22:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5OCLs2R824128
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 24 Jun 2018 05:21:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5OCLsVc824125;
        Sun, 24 Jun 2018 05:21:54 -0700
Date:   Sun, 24 Jun 2018 05:21:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Lukas Wunner <tipbot@zytor.com>
Message-ID: <tip-836557bd58e5e65c05c73af9f6ebed885dbfccfc@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        bhelgaas@google.com, mika.westerberg@linux.intel.com,
        lukas@wunner.de, tglx@linutronix.de
Reply-To: bhelgaas@google.com, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          lukas@wunner.de, mika.westerberg@linux.intel.com
In-Reply-To: <32fc25aa35ecef4b2692f57687bb7fc2a57230e2.1529828292.git.lukas@wunner.de>
References: <32fc25aa35ecef4b2692f57687bb7fc2a57230e2.1529828292.git.lukas@wunner.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Update code comments wrt recycled
 thread_mask
Git-Commit-ID: 836557bd58e5e65c05c73af9f6ebed885dbfccfc
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

Commit-ID:  836557bd58e5e65c05c73af9f6ebed885dbfccfc
Gitweb:     https://git.kernel.org/tip/836557bd58e5e65c05c73af9f6ebed885dbfccfc
Author:     Lukas Wunner <lukas@wunner.de>
AuthorDate: Sun, 24 Jun 2018 10:35:18 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 24 Jun 2018 14:17:26 +0200

genirq: Update code comments wrt recycled thread_mask

Previously a race existed between __free_irq() and __setup_irq() wherein
the thread_mask of a just removed action could be handed out to a newly
added action and the freed irq thread would then tread on the oneshot
mask bit of the newly added irq thread in irq_finalize_oneshot():

time
 |  __free_irq()
 |    raw_spin_lock_irqsave(&desc->lock, flags);
 |    <remove action from linked list>
 |    raw_spin_unlock_irqrestore(&desc->lock, flags);
 |
 |  __setup_irq()
 |    raw_spin_lock_irqsave(&desc->lock, flags);
 |    <traverse linked list to determine oneshot mask bit>
 |    raw_spin_unlock_irqrestore(&desc->lock, flags);
 |
 |  irq_thread() of freed irq (__free_irq() waits in synchronize_irq())
 |    irq_thread_fn()
 |      irq_finalize_oneshot()
 |        raw_spin_lock_irq(&desc->lock);
 |        desc->threads_oneshot &= ~action->thread_mask;
 |        raw_spin_unlock_irq(&desc->lock);
 v

The race was known at least since 2012 when it was documented in a code
comment by commit e04268b0effc ("genirq: Remove paranoid warnons and bogus
fixups"). The race itself is harmless as nothing touches any of the
potentially freed data after synchronize_irq().

In 2017 the race was close by commit 9114014cf4e6 ("genirq: Add mutex to
irq desc to serialize request/free_irq()"), apparently inadvertantly so
because the race is neither mentioned in the commit message nor was the
code comment updated.  Make up for that.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Link: https://lkml.kernel.org/r/32fc25aa35ecef4b2692f57687bb7fc2a57230e2.1529828292.git.lukas@wunner.de

---
 kernel/irq/manage.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 591cfe901162..123a227d3357 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1025,10 +1025,7 @@ static int irq_thread(void *data)
 	 * This is the regular exit path. __free_irq() is stopping the
 	 * thread via kthread_stop() after calling
 	 * synchronize_irq(). So neither IRQTF_RUNTHREAD nor the
-	 * oneshot mask bit can be set. We cannot verify that as we
-	 * cannot touch the oneshot mask at this point anymore as
-	 * __setup_irq() might have given out currents thread_mask
-	 * again.
+	 * oneshot mask bit can be set.
 	 */
 	task_work_cancel(current, irq_thread_dtor);
 	return 0;
@@ -1245,7 +1242,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	/*
 	 * Protects against a concurrent __free_irq() call which might wait
 	 * for synchronize_irq() to complete without holding the optional
-	 * chip bus lock and desc->lock.
+	 * chip bus lock and desc->lock. Also protects against handing out
+	 * a recycled oneshot thread_mask bit while it's still in use by
+	 * its previous owner.
 	 */
 	mutex_lock(&desc->request_mutex);
 
