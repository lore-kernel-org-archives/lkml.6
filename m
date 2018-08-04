Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE9EC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0259A208D5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0259A208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbeHDLDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:03:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48388 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbeHDLDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:03:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 38ED3BBF;
        Sat,  4 Aug 2018 09:03:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, stable@kernel.org
Subject: [PATCH 4.17 18/31] x86/apic: Future-proof the TSC_DEADLINE quirk for SKX
Date:   Sat,  4 Aug 2018 11:00:53 +0200
Message-Id: <20180804082633.669819100@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082632.304529527@linuxfoundation.org>
References: <20180804082632.304529527@linuxfoundation.org>
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

From: Len Brown <len.brown@intel.com>

commit d9e6dbcf28f383bf08e6a3180972f5722e514a54 upstream.

All SKX with stepping higher than 4 support the TSC_DEADLINE,
no matter the microcode version.

Without this patch, upcoming SKX steppings will not be able to use
their TSC_DEADLINE timer.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: <stable@kernel.org> # v4.14+
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 616dd5872e ("x86/apic: Update TSC_DEADLINE quirk with additional SKX stepping")
Link: http://lkml.kernel.org/r/d0c7129e509660be9ec6b233284b8d42d90659e8.1532207856.git.len.brown@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/apic/apic.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -573,6 +573,9 @@ static u32 skx_deadline_rev(void)
 	case 0x04: return 0x02000014;
 	}
 
+	if (boot_cpu_data.x86_stepping > 4)
+		return 0;
+
 	return ~0U;
 }
 


