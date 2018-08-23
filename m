Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A77C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614912147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614912147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbeHWMBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:01:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48242 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729390AbeHWMB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:01:29 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B82F48B1;
        Thu, 23 Aug 2018 08:32:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 191/217] kvmclock: fix TSC calibration for nested guests
Date:   Thu, 23 Aug 2018 09:55:04 +0200
Message-Id: <20180823075514.241182583@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Hao <peng.hao2@zte.com.cn>

[ Upstream commit e10f7805032365cc11c739a97f226ebb48aee042 ]

Inside a nested guest, access to hardware can be slow enough that
tsc_read_refs always return ULLONG_MAX, causing tsc_refine_calibration_work
to be called periodically and the nested guest to spend a lot of time
reading the ACPI timer.

However, if the TSC frequency is available from the pvclock page,
we can just set X86_FEATURE_TSC_KNOWN_FREQ and avoid the recalibration.
'refine' operation.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
[Commit message rewritten. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/kvmclock.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -143,6 +143,7 @@ static unsigned long kvm_get_tsc_khz(voi
 	src = &hv_clock[cpu].pvti;
 	tsc_khz = pvclock_tsc_khz(src);
 	put_cpu();
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	return tsc_khz;
 }
 


