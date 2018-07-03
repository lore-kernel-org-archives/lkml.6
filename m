Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851FBC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495BA24899
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495BA24899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754547AbeGCHGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:06:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37705 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753812AbeGCHD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:03:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6373lAr188316
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 00:03:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6373lCF188313;
        Tue, 3 Jul 2018 00:03:47 -0700
Date:   Tue, 3 Jul 2018 00:03:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vitaly Kuznetsov <tipbot@zytor.com>
Message-ID: <tip-53e52966901a5b14caa2a7c77428a693fe71f734@git.kernel.org>
Cc:     kys@microsoft.com, sthemmin@microsoft.com,
        Tianyu.Lan@microsoft.com, Michael.H.Kelley@microsoft.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        vkuznets@redhat.com, haiyangz@microsoft.com, tglx@linutronix.de
Reply-To: kys@microsoft.com, Tianyu.Lan@microsoft.com,
          sthemmin@microsoft.com, Michael.H.Kelley@microsoft.com,
          mingo@kernel.org, haiyangz@microsoft.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, vkuznets@redhat.com
In-Reply-To: <20180622170625.30688-2-vkuznets@redhat.com>
References: <20180622170625.30688-2-vkuznets@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] x86/hyper-v: Implement hv_do_fast_hypercall16
Git-Commit-ID: 53e52966901a5b14caa2a7c77428a693fe71f734
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

Commit-ID:  53e52966901a5b14caa2a7c77428a693fe71f734
Gitweb:     https://git.kernel.org/tip/53e52966901a5b14caa2a7c77428a693fe71f734
Author:     Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate: Fri, 22 Jun 2018 19:06:22 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 3 Jul 2018 09:00:33 +0200

x86/hyper-v: Implement hv_do_fast_hypercall16

Implement 'Fast' hypercall with two 64-bit input parameter. This is
going to be used for HvCallSendSyntheticClusterIpi hypercall.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: devel@linuxdriverproject.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Link: https://lkml.kernel.org/r/20180622170625.30688-2-vkuznets@redhat.com

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
