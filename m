Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB63ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369D9208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQECTnwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369D9208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbeJYWxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729507AbeJYWxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:18 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D533C20873;
        Thu, 25 Oct 2018 14:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477220;
        bh=O87FaVKY7Q/D8ZbEAh2M45CmJlx61mK4FegaOQ7QCeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rQECTnwZHn8bbgBSL0pStrkYugaBkYo81J/sxC3izZdujEAbQTHYiQexRiK88pVTM
         ugbXvX/eMIEYsSPxwICxLBrNwDCefqvoeoTgkZ7z6FsixLSEdSkmxfHNjtXYLNAzey
         VbtQ7ZA1fSdiPHY9+yYmKvB1druq4oFBew3X24vU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yinghai Lu <yinghai@kernel.org>, alnovak@suse.com,
        joro@8bytes.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 56/98] x86/irq: Check for valid irq descriptor in check_irq_vectors_for_cpu_disable()
Date:   Thu, 25 Oct 2018 10:18:11 -0400
Message-Id: <20181025141853.214051-56-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

[ Upstream commit d97eb8966c91f2c9d05f0a22eb89ed5b76d966d1 ]

When an interrupt is migrated away from a cpu it will stay
in its vector_irq array until smp_irq_move_cleanup_interrupt
succeeded. The cfg->move_in_progress flag is cleared already
when the IPI was sent.

When the interrupt is destroyed after migration its 'struct
irq_desc' is freed and the vector_irq arrays are cleaned up.
But since cfg->move_in_progress is already 0 the references
at cpus before the last migration will not be cleared. So
this would leave a reference to an already destroyed irq
alive.

When the cpu is taken down at this point, the
check_irq_vectors_for_cpu_disable() function finds a valid irq
number in the vector_irq array, but gets NULL for its
descriptor and dereferences it, causing a kernel panic.

This has been observed on real systems at shutdown. Add a
check to check_irq_vectors_for_cpu_disable() for a valid
'struct irq_desc' to prevent this issue.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Jiang Liu <jiang.liu@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jan Beulich <JBeulich@suse.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: alnovak@suse.com
Cc: joro@8bytes.org
Link: http://lkml.kernel.org/r/20150204132754.GA10078@suse.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 37907756fc41..1d6e2946a3da 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -302,6 +302,9 @@ int check_irq_vectors_for_cpu_disable(void)
 		irq = __this_cpu_read(vector_irq[vector]);
 		if (irq >= 0) {
 			desc = irq_to_desc(irq);
+			if (!desc)
+				continue;
+
 			data = irq_desc_get_irq_data(desc);
 			cpumask_copy(&affinity_new, data->affinity);
 			cpu_clear(this_cpu, affinity_new);
-- 
2.17.1

