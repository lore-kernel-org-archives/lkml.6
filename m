Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4F0C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B2920844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="11o4srqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B2920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbeKIHdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbeKIHdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:45 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03E18214DE;
        Thu,  8 Nov 2018 21:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714178;
        bh=lmtMqJarJlFcgFfPaSh+62K8u/B9PoHzEoNJURyp4pw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=11o4srqO1qTHibMAc2Pgg5WcAFsQU3ynNsFKLRvs8pakVE5ZGxC4l9DZOCu6oxt8n
         eoGdqEG4Z3Ef/bFZ9rQQA9UnUKbLvX27SWdWZS8YJznN6NBSqtnjl+r0O+E9uGYPng
         28zoaUBw4UKiPQbcQsQb9HL+S1yWG9gwGNkkpVlE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yinghai Lu <yinghai@kernel.org>, alnovak@suse.com,
        joro@8bytes.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 085/144] x86/irq: Check for valid irq descriptor in check_irq_vectors_for_cpu_disable()
Date:   Thu,  8 Nov 2018 13:50:56 -0800
Message-Id: <20181108215101.560811707@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



