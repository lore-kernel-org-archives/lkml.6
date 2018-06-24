Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5110C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DD82500F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DD82500F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755468AbeFXPgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:36:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59550 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755129AbeFXPgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:36:41 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C067192F;
        Sun, 24 Jun 2018 15:36:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Song Liu <liu.song.a23@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Song Liu <songliubraving@fb.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Travis <mike.travis@hpe.com>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH 4.16 48/64] x86/apic/vector: Prevent hlist corruption and leaks
Date:   Sun, 24 Jun 2018 23:22:29 +0800
Message-Id: <20180624142746.713587355@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142743.613370789@linuxfoundation.org>
References: <20180624142743.613370789@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 80ae7b1a918e78b0bae88b0c0ad413d3fdced968 upstream.

Several people observed the WARN_ON() in irq_matrix_free() which triggers
when the caller tries to free an vector which is not in the allocation
range. Song provided the trace information which allowed to decode the root
cause.

The rework of the vector allocation mechanism failed to preserve a sanity
check, which prevents setting a new target vector/CPU when the previous
affinity change has not fully completed.

As a result a half finished affinity change can be overwritten, which can
cause the leak of a irq descriptor pointer on the previous target CPU and
double enqueue of the hlist head into the cleanup lists of two or more
CPUs. After one CPU cleaned up its vector the next CPU will invoke the
cleanup handler with vector 0, which triggers the out of range warning in
the matrix allocator.

Prevent this by checking the apic_data of the interrupt whether the
move_in_progress flag is false and the hlist node is not hashed. Return
-EBUSY if not.

This prevents the damage and restores the behaviour before the vector
allocation rework, but due to other changes in that area it also widens the
chance that user space can observe -EBUSY. In theory this should be fine,
but actually not all user space tools handle -EBUSY correctly. Addressing
that is not part of this fix, but will be addressed in follow up patches.

Fixes: 69cde0004a4b ("x86/vector: Use matrix allocator for vector assignment")
Reported-by: Dmitry Safonov <0x7f454c46@gmail.com>
Reported-by: Tariq Toukan <tariqt@mellanox.com>
Reported-by: Song Liu <liu.song.a23@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Song Liu <songliubraving@fb.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/20180604162224.303870257@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/apic/vector.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -235,6 +235,15 @@ static int allocate_vector(struct irq_da
 	if (vector && cpu_online(cpu) && cpumask_test_cpu(cpu, dest))
 		return 0;
 
+	/*
+	 * Careful here. @apicd might either have move_in_progress set or
+	 * be enqueued for cleanup. Assigning a new vector would either
+	 * leave a stale vector on some CPU around or in case of a pending
+	 * cleanup corrupt the hlist.
+	 */
+	if (apicd->move_in_progress || !hlist_unhashed(&apicd->clist))
+		return -EBUSY;
+
 	vector = irq_matrix_alloc(vector_matrix, dest, resvd, &cpu);
 	if (vector > 0)
 		apic_update_vector(irqd, vector, cpu);


