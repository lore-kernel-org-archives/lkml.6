Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E958EC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF14250A8
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF14250A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933635AbeFXPqQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:46:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60424 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932144AbeFXPqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:46:14 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 320B892F;
        Sun, 24 Jun 2018 15:46:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Song Liu <songliubraving@fb.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <liu.song.a23@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Mike Travis <mike.travis@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        Tariq Toukan <tariqt@mellanox.com>
Subject: [PATCH 4.17 58/70] genirq/affinity: Defer affinity setting if irq chip is busy
Date:   Sun, 24 Jun 2018 23:22:50 +0800
Message-Id: <20180624142744.079864256@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 12f47073a40f6aa75119d8f5df4077b7f334cced upstream.

The case that interrupt affinity setting fails with -EBUSY can be handled
in the kernel completely by using the already available generic pending
infrastructure.

If a irq_chip::set_affinity() fails with -EBUSY, handle it like the
interrupts for which irq_chip::set_affinity() can only be invoked from
interrupt context. Copy the new affinity mask to irq_desc::pending_mask and
set the affinity pending bit. The next raised interrupt for the affected
irq will check the pending bit and try to set the new affinity from the
handler. This avoids that -EBUSY is returned when an affinity change is
requested from user space and the previous change has not been cleaned
up. The new affinity will take effect when the next interrupt is raised
from the device.

Fixes: dccfe3147b42 ("x86/vector: Simplify vector move cleanup")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Song Liu <songliubraving@fb.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <liu.song.a23@gmail.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: stable@vger.kernel.org
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tariq Toukan <tariqt@mellanox.com>
Link: https://lkml.kernel.org/r/20180604162224.819273597@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/manage.c |   37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -204,6 +204,39 @@ int irq_do_set_affinity(struct irq_data
 	return ret;
 }
 
+#ifdef CONFIG_GENERIC_PENDING_IRQ
+static inline int irq_set_affinity_pending(struct irq_data *data,
+					   const struct cpumask *dest)
+{
+	struct irq_desc *desc = irq_data_to_desc(data);
+
+	irqd_set_move_pending(data);
+	irq_copy_pending(desc, dest);
+	return 0;
+}
+#else
+static inline int irq_set_affinity_pending(struct irq_data *data,
+					   const struct cpumask *dest)
+{
+	return -EBUSY;
+}
+#endif
+
+static int irq_try_set_affinity(struct irq_data *data,
+				const struct cpumask *dest, bool force)
+{
+	int ret = irq_do_set_affinity(data, dest, force);
+
+	/*
+	 * In case that the underlying vector management is busy and the
+	 * architecture supports the generic pending mechanism then utilize
+	 * this to avoid returning an error to user space.
+	 */
+	if (ret == -EBUSY && !force)
+		ret = irq_set_affinity_pending(data, dest);
+	return ret;
+}
+
 int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 			    bool force)
 {
@@ -214,8 +247,8 @@ int irq_set_affinity_locked(struct irq_d
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
 
-	if (irq_can_move_pcntxt(data)) {
-		ret = irq_do_set_affinity(data, mask, force);
+	if (irq_can_move_pcntxt(data) && !irqd_is_setaffinity_pending(data)) {
+		ret = irq_try_set_affinity(data, mask, force);
 	} else {
 		irqd_set_move_pending(data);
 		irq_copy_pending(desc, mask);


