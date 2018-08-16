Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9840DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552BB2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552BB2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbeHPVs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:48:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57704 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbeHPVsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:48:52 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A26E8D29;
        Thu, 16 Aug 2018 18:48:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        devel@linuxdriverproject.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 4.18 03/22] x86/hyper-v: Check for VP_INVAL in hyperv_flush_tlb_others()
Date:   Thu, 16 Aug 2018 20:45:19 +0200
Message-Id: <20180816171556.628980028@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171556.502583508@linuxfoundation.org>
References: <20180816171556.502583508@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Kuznetsov <vkuznets@redhat.com>

commit 110d2a7fc39725d2c29d2fede4f34a35a4f98882 upstream.

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Cc: devel@linuxdriverproject.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180709174012.17429-3-vkuznets@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/hyperv/mmu.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -95,6 +95,11 @@ static void hyperv_flush_tlb_others(cons
 	} else {
 		for_each_cpu(cpu, cpus) {
 			vcpu = hv_cpu_number_to_vp_number(cpu);
+			if (vcpu == VP_INVAL) {
+				local_irq_restore(flags);
+				goto do_native;
+			}
+
 			if (vcpu >= 64)
 				goto do_native;
 


