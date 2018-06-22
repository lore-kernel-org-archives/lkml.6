Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B82C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F47C2466B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F47C2466B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754756AbeFVRGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:06:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754633AbeFVRGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:06:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BEDC401C9AA;
        Fri, 22 Jun 2018 17:06:30 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C09061C71B;
        Fri, 22 Jun 2018 17:06:28 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     x86@kernel.org
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH 1/4] x86/hyper-v: implement hv_do_fast_hypercall16
Date:   Fri, 22 Jun 2018 19:06:22 +0200
Message-Id: <20180622170625.30688-2-vkuznets@redhat.com>
In-Reply-To: <20180622170625.30688-1-vkuznets@redhat.com>
References: <20180622170625.30688-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 22 Jun 2018 17:06:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 22 Jun 2018 17:06:30 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement 'Fast' hypercall with two 64-bit input parameter. This is
going to be used for HvCallSendSyntheticClusterIpi hypercall.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/mshyperv.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 3cd14311edfa..da25642940d3 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -193,6 +193,40 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
 		return hv_status;
 }
 
+/* Fast hypercall with 16 bytes of input */
+static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
+{
+	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
+
+#ifdef CONFIG_X86_64
+	{
+		__asm__ __volatile__("mov %4, %%r8\n"
+				     CALL_NOSPEC
+				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
+				       "+c" (control), "+d" (input1)
+				     : "r" (input2),
+				       THUNK_TARGET(hv_hypercall_pg)
+				     : "cc", "r8", "r9", "r10", "r11");
+	}
+#else
+	{
+		u32 input1_hi = upper_32_bits(input1);
+		u32 input1_lo = lower_32_bits(input1);
+		u32 input2_hi = upper_32_bits(input2);
+		u32 input2_lo = lower_32_bits(input2);
+
+		__asm__ __volatile__ (CALL_NOSPEC
+				      : "=A"(hv_status),
+					"+c"(input1_lo), ASM_CALL_CONSTRAINT
+				      :	"A" (control), "b" (input1_hi),
+					"D"(input2_hi), "S"(input2_lo),
+					THUNK_TARGET(hv_hypercall_pg)
+				      : "cc");
+	}
+#endif
+		return hv_status;
+}
+
 /*
  * Rep hypercalls. Callers of this functions are supposed to ensure that
  * rep_count and varhead_size comply with Hyper-V hypercall definition.
-- 
2.14.4

