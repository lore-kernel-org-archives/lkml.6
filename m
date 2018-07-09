Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90106C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BE0208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BE0208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934006AbeGIRkv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:40:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933795AbeGIRkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:40:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A762A40201C9;
        Mon,  9 Jul 2018 17:40:19 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17A682156892;
        Mon,  9 Jul 2018 17:40:17 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     x86@kernel.org
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        devel@linuxdriverproject.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/hyper-v: check for VP_INVAL in hyperv_flush_tlb_others()
Date:   Mon,  9 Jul 2018 19:40:12 +0200
Message-Id: <20180709174012.17429-3-vkuznets@redhat.com>
In-Reply-To: <20180709174012.17429-1-vkuznets@redhat.com>
References: <20180709174012.17429-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 09 Jul 2018 17:40:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 09 Jul 2018 17:40:19 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1268ed0c474a ("x86/hyper-v: Fix the circular dependency in IPI
 enlightenment") pre-filled hv_vp_index with VP_INVAL so it is now
(theoretically) possible to observe hv_cpu_number_to_vp_number()
returning VP_INVAL. We need to check for that in hyperv_flush_tlb_others().

Not checking for VP_INVAL on the first call site where we do

 if (hv_cpu_number_to_vp_number(cpumask_last(cpus)) >= 64)
                        goto do_ex_hypercall;

is OK, in case we're eligible for non-ex hypercall we'll catch the
issue later in for_each_cpu() cycle and in case we'll be doing ex-
hypercall cpumask_to_vpset() will fail.

It would be nice to change hv_cpu_number_to_vp_number() return
value's type to 'u32' but this will likely be a bigger change as
all call sites need to be checked first.

Fixes: 1268ed0c474a ("x86/hyper-v: Fix the circular dependency in IPI enlightenment")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 453d2355cd61..1147e1fed7ff 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -111,6 +111,11 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 
 		for_each_cpu(cpu, cpus) {
 			vcpu = hv_cpu_number_to_vp_number(cpu);
+			if (vcpu == VP_INVAL) {
+				local_irq_restore(flags);
+				goto do_native;
+			}
+
 			if (vcpu >= 64)
 				goto do_ex_hypercall;
 
-- 
2.14.4

